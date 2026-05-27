import { useState, useEffect, useRef } from 'react'
import { useAuth } from '../contexts/AuthContext'
import { supabase } from '../lib/supabaseClient'
import { useNotification } from '../contexts/NotificationContext'

const DAY_NAMES = ['Ne', 'Po', 'Ut', 'St', 'Št', 'Pi', 'So']
const MONTH_NAMES = ['Jan', 'Feb', 'Mar', 'Apr', 'Máj', 'Jún', 'Júl', 'Aug', 'Sep', 'Okt', 'Nov', 'Dec']

function formatDateStr(date) {
  const y = date.getFullYear()
  const m = String(date.getMonth() + 1).padStart(2, '0')
  const d = String(date.getDate()).padStart(2, '0')
  return `${y}-${m}-${d}`
}

function generateDays(centerDate, range = 30) {
  const days = []
  for (let i = -range; i <= range; i++) {
    const d = new Date(centerDate)
    d.setDate(d.getDate() + i)
    days.push(new Date(d))
  }
  return days
}

export default function ViktorijaBookings() {
  const { user, currentSite, loading: authLoading } = useAuth()
  const { showNotification } = useNotification()
  
  // Tabs state: 'appointments' | 'applications' | 'messages'
  const [activeTab, setActiveTab] = useState('appointments')
  const [searchTerm, setSearchTerm] = useState('')

  // Data states
  const [slots, setSlots] = useState([])
  const [applications, setApplications] = useState([])
  const [messages, setMessages] = useState([])
  const [loading, setLoading] = useState(true)
  
  // Appointments states
  const [expandedSlotId, setExpandedSlotId] = useState(null)
  const [selectedDate, setSelectedDate] = useState(new Date())
  const scrollRef = useRef(null)
  const [newTime, setNewTime] = useState('')
  const [newDuration, setNewDuration] = useState(60)
  const [addingSlot, setAddingSlot] = useState(false)

  // Course applications states
  const [expandedAppId, setExpandedAppId] = useState(null)

  // Day slider days
  const days = generateDays(new Date(), 60)

  // Access gate
  const isAuthorized = currentSite?.slug === 'viktorija' || user?.email === 'alexander.hidveghy@gmail.com'

  useEffect(() => {
    if (authLoading || !isAuthorized) return
    loadData()
  }, [authLoading, isAuthorized])

  // Scroll to today on mount (when appointments tab is active)
  useEffect(() => {
    if (activeTab === 'appointments' && scrollRef.current) {
      const todayEl = scrollRef.current.querySelector('[data-today="true"]')
      if (todayEl) {
        todayEl.scrollIntoView({ inline: 'center', behavior: 'instant' })
      }
    }
  }, [loading, activeTab])

  async function loadData() {
    setLoading(true)
    try {
      // 1. Fetch time slots and bookings
      const { data: slotData, error: slotErr } = await supabase
        .from('viktorija_time_slots')
        .select('*, viktorija_bookings(id, client_name, client_phone, message, status, created_at)')
        .order('date', { ascending: true })
        .order('time', { ascending: true })
      if (slotErr) throw slotErr
      setSlots(slotData || [])

      // 2. Fetch course applications
      const { data: appData, error: appErr } = await supabase
        .from('viktorija_course_applications')
        .select('*')
        .order('created_at', { ascending: false })
      if (appErr) throw appErr
      setApplications(appData || [])

      // 3. Fetch contact messages
      const { data: msgData, error: msgErr } = await supabase
        .from('viktorija_contact_messages')
        .select('*')
        .order('created_at', { ascending: false })
      if (msgErr) throw msgErr
      setMessages(msgData || [])
    } catch (err) {
      console.error('Load error:', err)
      showNotification('Chyba pri načítavaní údajov', 'error')
    } finally {
      setLoading(false)
    }
  }

  // --- Appointments Logic ---
  const selectedDateStr = formatDateStr(selectedDate)
  const slotsForDay = slots.filter(s => s.date === selectedDateStr)

  const slotCountByDay = {}
  const pendingByDay = {}
  slots.forEach(s => {
    slotCountByDay[s.date] = (slotCountByDay[s.date] || 0) + 1
    const pending = (s.viktorija_bookings || []).filter(b => b.status === 'pending').length
    if (pending > 0) pendingByDay[s.date] = (pendingByDay[s.date] || 0) + pending
  })

  async function handleAddSlot(e) {
    e.preventDefault()
    if (!newTime) {
      showNotification('Vyplňte čas', 'error')
      return
    }
    setAddingSlot(true)
    const { error } = await supabase
      .from('viktorija_time_slots')
      .insert({
        date: selectedDateStr,
        time: newTime,
        duration_minutes: newDuration,
        is_available: true,
      })
    if (error) {
      showNotification('Chyba pri pridávaní termínu', 'error')
    } else {
      showNotification('Termín pridaný', 'success')
      setNewTime('')
      setNewDuration(60)
      loadData()
    }
    setAddingSlot(false)
  }

  async function handleDeleteSlot(id) {
    if (!confirm('Naozaj chcete vymazať tento termín?')) return
    const { error } = await supabase.from('viktorija_time_slots').delete().eq('id', id)
    if (error) {
      showNotification('Chyba pri mazaní', 'error')
    } else {
      showNotification('Termín vymazaný', 'success')
      if (expandedSlotId === id) setExpandedSlotId(null)
      loadData()
    }
  }

  async function handleAcceptBooking(bookingId, slotId) {
    await supabase.from('viktorija_bookings').update({ status: 'confirmed' }).eq('id', bookingId)
    await supabase.from('viktorija_time_slots').update({ is_available: false }).eq('id', slotId)
    showNotification('Rezervácia potvrdená — termín je teraz obsadený', 'success')
    loadData()
  }

  async function handleRejectBooking(bookingId) {
    await supabase.from('viktorija_bookings').update({ status: 'cancelled' }).eq('id', bookingId)
    showNotification('Rezervácia zamietnutá', 'success')
    loadData()
  }

  // --- Course Applications Logic ---
  async function handleUpdateAppStatus(appId, newStatus) {
    const { error } = await supabase
      .from('viktorija_course_applications')
      .update({ status: newStatus })
      .eq('id', appId)
    
    if (error) {
      showNotification('Chyba pri aktualizácii stavu', 'error')
    } else {
      showNotification('Stav prihlášky aktualizovaný', 'success')
      loadData()
    }
  }

  async function handleDeleteApp(appId) {
    if (!confirm('Naozaj chcete vymazať túto prihlášku?')) return
    const { error } = await supabase
      .from('viktorija_course_applications')
      .delete()
      .eq('id', appId)
    
    if (error) {
      showNotification('Chyba pri mazaní prihlášky', 'error')
    } else {
      showNotification('Prihláška vymazaná', 'success')
      if (expandedAppId === appId) setExpandedAppId(null)
      loadData()
    }
  }

  function parseApplicationMessage(msg) {
    try {
      if (!msg) return null
      const parsed = JSON.parse(msg)
      if (parsed && typeof parsed === 'object') {
        return parsed
      }
    } catch (e) {
      // Fall through to return null if not JSON
    }
    return null
  }

  // --- Contact Messages Logic ---
  async function handleDeleteMessage(msgId) {
    if (!confirm('Naozaj chcete vymazať túto správu?')) return
    const { error } = await supabase
      .from('viktorija_contact_messages')
      .delete()
      .eq('id', msgId)
    
    if (error) {
      showNotification('Chyba pri mazaní správy', 'error')
    } else {
      showNotification('Správa vymazaná', 'success')
      loadData()
    }
  }

  // Filtering data for search
  const filteredApps = applications.filter(app => 
    app.client_name?.toLowerCase().includes(searchTerm.toLowerCase()) ||
    app.course_name?.toLowerCase().includes(searchTerm.toLowerCase()) ||
    app.client_email?.toLowerCase().includes(searchTerm.toLowerCase()) ||
    app.client_phone?.toLowerCase().includes(searchTerm.toLowerCase())
  )

  const filteredMessages = messages.filter(msg =>
    msg.name?.toLowerCase().includes(searchTerm.toLowerCase()) ||
    msg.phone?.toLowerCase().includes(searchTerm.toLowerCase()) ||
    msg.email?.toLowerCase().includes(searchTerm.toLowerCase()) ||
    msg.message?.toLowerCase().includes(searchTerm.toLowerCase())
  )

  if (authLoading) {
    return (
      <div className="flex items-center justify-center h-64">
        <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-purple-600"></div>
      </div>
    )
  }

  if (!isAuthorized) {
    return (
      <div className="flex items-center justify-center h-64">
        <p className="text-gray-500 font-light">Nemáte prístup k tejto stránke.</p>
      </div>
    )
  }

  const todayStr = formatDateStr(new Date())
  const pendingCount = slots.reduce((sum, s) => sum + (s.viktorija_bookings?.filter(b => b.status === 'pending').length || 0), 0)
  const newAppsCount = applications.filter(app => app.status === 'new').length

  return (
    <div className="p-1 sm:p-6 max-w-7xl mx-auto">
      {/* Title section */}
      <div className="flex flex-col md:flex-row md:items-center md:justify-between gap-4 mb-8">
        <div>
          <h1 className="text-3xl font-extrabold text-slate-900 tracking-tight bg-gradient-to-r from-slate-900 via-purple-900 to-slate-950 bg-clip-text text-transparent">
            Salón Viktória — Administrácia
          </h1>
          <p className="text-slate-500 text-sm mt-1 font-light">
            Kompletná správa termínov, kurzov a klientskych správ pre salonviktoria.sk
          </p>
        </div>
        <button
          onClick={loadData}
          disabled={loading}
          className="inline-flex items-center gap-2 self-start px-4 py-2 bg-white hover:bg-slate-50 border border-slate-200 text-slate-700 text-sm font-medium rounded-xl shadow-sm transition-all duration-200 active:scale-95 disabled:opacity-50"
        >
          <svg className={`w-4 h-4 text-slate-500 ${loading ? 'animate-spin' : ''}`} fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M4 4v5h.582m15.356 2A8.001 8.001 0 1121.21 4.89M9 11l3 3L22 4" />
          </svg>
          Obnoviť dáta
        </button>
      </div>

      {/* Modern Capsule Tab Bar */}
      <div className="bg-slate-100 p-1.5 rounded-2xl flex flex-wrap gap-1 mb-8 shadow-inner max-w-lg">
        <button
          onClick={() => { setActiveTab('appointments'); setSearchTerm(''); }}
          className={`flex-1 flex items-center justify-center gap-2 py-3 px-4 rounded-xl text-sm font-medium transition-all duration-300 ${
            activeTab === 'appointments'
              ? 'bg-white text-purple-700 shadow-md font-semibold'
              : 'text-slate-600 hover:text-slate-900 hover:bg-white/50'
          }`}
        >
          <svg className="w-4 h-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z" />
          </svg>
          Rezervácie
          {pendingCount > 0 && (
            <span className="inline-flex items-center justify-center px-2 py-0.5 ml-1 rounded-full text-xs font-bold bg-yellow-400 text-yellow-950 animate-pulse">
              {pendingCount}
            </span>
          )}
        </button>
        <button
          onClick={() => { setActiveTab('applications'); setSearchTerm(''); }}
          className={`flex-1 flex items-center justify-center gap-2 py-3 px-4 rounded-xl text-sm font-medium transition-all duration-300 ${
            activeTab === 'applications'
              ? 'bg-white text-purple-700 shadow-md font-semibold'
              : 'text-slate-600 hover:text-slate-900 hover:bg-white/50'
          }`}
        >
          <svg className="w-4 h-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 6.253v13m0-13C10.832 5.477 9.246 5 7.5 5S4.168 5.477 3 6.253v13C4.168 18.477 5.754 18 7.5 18s3.332.477 4.5 1.253m0-13C13.168 5.477 14.754 5 16.5 5c1.747 0 3.332.477 4.5 1.253v13C19.832 18.477 18.247 18 16.5 18c-1.746 0-3.332.477-4.5 1.253" />
          </svg>
          Prihlášky
          {newAppsCount > 0 && (
            <span className="inline-flex items-center justify-center px-2 py-0.5 ml-1 rounded-full text-xs font-bold bg-purple-600 text-white">
              {newAppsCount}
            </span>
          )}
        </button>
        <button
          onClick={() => { setActiveTab('messages'); setSearchTerm(''); }}
          className={`flex-1 flex items-center justify-center gap-2 py-3 px-4 rounded-xl text-sm font-medium transition-all duration-300 ${
            activeTab === 'messages'
              ? 'bg-white text-purple-700 shadow-md font-semibold'
              : 'text-slate-600 hover:text-slate-900 hover:bg-white/50'
          }`}
        >
          <svg className="w-4 h-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M8 12h.01M12 12h.01M16 12h.01M21 12c0 4.418-4.03 8-9 8a9.863 9.863 0 01-4.255-.949L3 20l1.395-3.72C3.512 15.042 3 13.574 3 12c0-4.418 4.03-8 9-8s9 3.582 9 8z" />
          </svg>
          Správy
          {messages.length > 0 && (
            <span className="inline-flex items-center justify-center px-2 py-0.5 ml-1 rounded-full text-xs font-medium bg-slate-200 text-slate-800">
              {messages.length}
            </span>
          )}
        </button>
      </div>

      {/* --- APPOINTMENTS TAB --- */}
      {activeTab === 'appointments' && (
        <div className="space-y-6">
          {/* Day slider */}
          <div className="bg-white rounded-2xl border border-slate-200 shadow-sm overflow-hidden">
            <div
              ref={scrollRef}
              className="flex overflow-x-auto scrollbar-hide py-4 px-3 gap-2"
              style={{ scrollbarWidth: 'none', msOverflowStyle: 'none' }}
            >
              {days.map(day => {
                const dayStr = formatDateStr(day)
                const isSelected = dayStr === selectedDateStr
                const isToday = dayStr === todayStr
                const hasSlots = slotCountByDay[dayStr] > 0
                const hasPending = pendingByDay[dayStr] > 0
                const isPast = day < new Date(new Date().setHours(0, 0, 0, 0))

                return (
                  <button
                    key={dayStr}
                    data-today={isToday ? 'true' : undefined}
                    onClick={() => { setSelectedDate(new Date(day)); setExpandedSlotId(null) }}
                    className={`flex-shrink-0 flex flex-col items-center w-16 py-3 rounded-2xl transition-all relative ${
                      isSelected
                        ? 'bg-purple-600 text-white shadow-md shadow-purple-200 scale-105 border border-purple-600'
                        : isPast
                          ? 'text-slate-300 hover:bg-slate-50 border border-transparent'
                          : 'text-slate-600 hover:bg-slate-100 border border-transparent'
                    } ${isToday && !isSelected ? 'ring-2 ring-purple-400 ring-offset-1' : ''}`}
                  >
                    <span className="text-[10px] font-medium uppercase tracking-wider">{DAY_NAMES[day.getDay()]}</span>
                    <span className={`text-xl font-bold my-0.5 ${isSelected ? 'text-white' : 'text-slate-800'}`}>{day.getDate()}</span>
                    <span className="text-[10px] opacity-80">{MONTH_NAMES[day.getMonth()]}</span>
                    
                    {/* Indicators */}
                    <div className="flex gap-1 mt-1.5 h-1.5 items-center">
                      {hasSlots && (
                        <div className={`w-1.5 h-1.5 rounded-full ${isSelected ? 'bg-white' : 'bg-purple-500'}`} />
                      )}
                      {hasPending && (
                        <div className={`w-1.5 h-1.5 rounded-full ${isSelected ? 'bg-yellow-300' : 'bg-yellow-500'} animate-pulse`} />
                      )}
                    </div>
                  </button>
                )
              })}
            </div>
          </div>

          {/* Selected day header + add form */}
          <div className="bg-white rounded-2xl border border-slate-200 shadow-sm p-6">
            <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4 mb-6 border-b border-slate-100 pb-4">
              <h2 className="text-xl font-semibold text-slate-800">
                {selectedDate.toLocaleDateString('sk', { weekday: 'long', day: 'numeric', month: 'long', year: 'numeric' })}
              </h2>
              <span className="inline-flex items-center px-3 py-1 rounded-full text-xs font-semibold bg-purple-50 text-purple-700 border border-purple-100">
                {slotsForDay.length} {slotsForDay.length === 1 ? 'termín' : slotsForDay.length >= 2 && slotsForDay.length <= 4 ? 'termíny' : 'termínov'}
              </span>
            </div>

            <form onSubmit={handleAddSlot} className="flex flex-wrap gap-4 items-end bg-slate-50 p-4 rounded-xl border border-slate-100">
              <div className="flex-1 min-w-[120px]">
                <label className="block text-xs font-medium text-slate-500 mb-1.5">Čas termínu</label>
                <input
                  type="time"
                  value={newTime}
                  onChange={e => setNewTime(e.target.value)}
                  className="w-full bg-white border border-slate-200 rounded-xl px-4 py-2.5 text-sm focus:outline-none focus:ring-2 focus:ring-purple-500/20 focus:border-purple-600 transition-all text-slate-800 font-medium"
                  required
                />
              </div>
              <div className="w-32">
                <label className="block text-xs font-medium text-slate-500 mb-1.5">Trvanie (min)</label>
                <input
                  type="number"
                  value={newDuration}
                  onChange={e => setNewDuration(parseInt(e.target.value))}
                  className="w-full bg-white border border-slate-200 rounded-xl px-4 py-2.5 text-sm focus:outline-none focus:ring-2 focus:ring-purple-500/20 focus:border-purple-600 transition-all text-slate-800 font-medium"
                />
              </div>
              <button
                type="submit"
                disabled={addingSlot}
                className="px-6 py-2.5 bg-purple-600 hover:bg-purple-700 active:scale-95 disabled:bg-purple-400 text-white rounded-xl text-sm font-semibold shadow-md shadow-purple-200 transition-all duration-200"
              >
                {addingSlot ? 'Pridávam...' : '+ Pridať termín'}
              </button>
            </form>
          </div>

          {/* Slots for selected day */}
          {loading ? (
            <div className="flex justify-center py-12">
              <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-purple-600"></div>
            </div>
          ) : (
            <div className="grid grid-cols-1 gap-3">
              {slotsForDay.map(slot => {
                const bookings = slot.viktorija_bookings || []
                const pendingBookings = bookings.filter(b => b.status === 'pending')
                const confirmedBooking = bookings.find(b => b.status === 'confirmed')
                const isExpanded = expandedSlotId === slot.id
                const hasPending = pendingBookings.length > 0

                return (
                  <div key={slot.id} className="bg-white rounded-2xl border border-slate-200 shadow-sm overflow-hidden transition-all duration-200 hover:border-slate-300">
                    <button
                      onClick={() => setExpandedSlotId(isExpanded ? null : slot.id)}
                      className={`w-full flex items-center justify-between px-6 py-4.5 text-left transition-colors hover:bg-slate-50/50 ${
                        !slot.is_available ? 'bg-slate-50/40 opacity-75' : ''
                      }`}
                    >
                      <div className="flex items-center gap-4">
                        <div className={`w-3 h-3 rounded-full border-2 border-white shadow-sm ${slot.is_available ? 'bg-emerald-500' : 'bg-rose-500'}`} />
                        <span className={`text-base font-bold tracking-tight ${!slot.is_available ? 'line-through text-slate-400' : 'text-slate-800'}`}>
                          {slot.time?.slice(0, 5)}
                        </span>
                        <span className="text-xs bg-slate-100 text-slate-600 font-semibold px-2 py-0.5 rounded-md">{slot.duration_minutes} min</span>
                      </div>
                      <div className="flex items-center gap-3">
                        {confirmedBooking && (
                          <span className="text-xs px-2.5 py-1 rounded-full bg-emerald-50 text-emerald-700 font-semibold border border-emerald-100 flex items-center gap-1.5">
                            <span className="w-1.5 h-1.5 bg-emerald-500 rounded-full" />
                            Obsadené: {confirmedBooking.client_name}
                          </span>
                        )}
                        {hasPending && (
                          <span className="text-xs px-2.5 py-1 rounded-full bg-amber-50 text-amber-700 font-semibold border border-amber-100 animate-pulse flex items-center gap-1.5">
                            <span className="w-1.5 h-1.5 bg-amber-500 rounded-full" />
                            {pendingBookings.length} {pendingBookings.length === 1 ? 'žiadosť' : pendingBookings.length >= 2 && pendingBookings.length <= 4 ? 'žiadosti' : 'žiadostí'}
                          </span>
                        )}
                        <svg className={`w-5 h-5 text-slate-400 transition-transform duration-300 ${isExpanded ? 'rotate-180' : ''}`} fill="none" viewBox="0 0 24 24" stroke="currentColor">
                          <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 9l-7 7-7-7" />
                        </svg>
                      </div>
                    </button>

                    {isExpanded && (
                      <div className="border-t border-slate-100 bg-slate-50/50 px-6 py-5">
                        {bookings.length === 0 ? (
                          <div className="text-center py-6">
                            <svg className="w-8 h-8 text-slate-300 mx-auto mb-2" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={1.5} d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z" />
                            </svg>
                            <p className="text-sm text-slate-400 font-light">Žiadne rezervácie na tento termín</p>
                          </div>
                        ) : (
                          <div className="space-y-4">
                            {bookings.map(b => {
                              const isPending = b.status === 'pending'
                              const isConfirmed = b.status === 'confirmed'
                              return (
                                <div key={b.id} className={`bg-white rounded-xl p-5 border shadow-sm transition-all duration-200 ${isPending ? 'border-amber-200 bg-amber-50/10' : 'border-slate-200'}`}>
                                  <div className="flex flex-col sm:flex-row sm:items-start justify-between gap-4">
                                    <div className="space-y-2">
                                      <div className="flex items-center gap-3">
                                        <p className="text-base font-bold text-slate-800">{b.client_name}</p>
                                        <span className={`text-xs px-2.5 py-0.5 rounded-full font-bold uppercase tracking-wider ${
                                          isPending
                                            ? 'bg-amber-100 text-amber-800'
                                            : isConfirmed
                                              ? 'bg-emerald-100 text-emerald-800'
                                              : 'bg-rose-100 text-rose-800'
                                        }`}>
                                          {isPending ? 'Čaká na schválenie' : isConfirmed ? 'Schválené' : 'Zamietnuté'}
                                        </span>
                                      </div>
                                      
                                      <div className="flex flex-wrap items-center gap-x-4 gap-y-1 text-sm text-slate-500 font-light">
                                        <a href={`tel:${b.client_phone}`} className="flex items-center gap-1.5 text-purple-600 hover:text-purple-700 font-medium hover:underline">
                                          <svg className="w-4 h-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M3 5a2 2 0 012-2h3.28a1 1 0 01.94.725l.548 2.2a1 1 0 01-.321.988l-1.305.98a10.582 10.582 0 004.872 4.872l.98-1.305a1 1 0 01.988-.321l2.2.548a1 1 0 01.725.94V19a2 2 0 01-2 2h-1C9.716 21 3 14.284 3 6V5z" />
                                          </svg>
                                          {b.client_phone}
                                        </a>
                                        <span className="text-slate-300">|</span>
                                        <span className="flex items-center gap-1.5">
                                          <svg className="w-4 h-4 text-slate-400" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z" />
                                          </svg>
                                          {new Date(b.created_at).toLocaleString('sk', { dateStyle: 'short', timeStyle: 'short' })}
                                        </span>
                                      </div>

                                      {b.message && (
                                        <div className="bg-slate-50 rounded-xl p-3 border border-slate-100 text-sm text-slate-700 font-light mt-3">
                                          <span className="block text-[10px] font-semibold text-slate-400 uppercase tracking-wider mb-1">Správa od klienta</span>
                                          {b.message}
                                        </div>
                                      )}
                                    </div>
                                    
                                    {isPending && (
                                      <div className="flex gap-2 self-end sm:self-start">
                                        <button
                                          onClick={() => handleAcceptBooking(b.id, slot.id)}
                                          className="px-4 py-2 bg-emerald-600 hover:bg-emerald-700 text-white text-xs font-bold rounded-lg shadow-sm transition-all active:scale-95"
                                        >
                                          Potvrdiť
                                        </button>
                                        <button
                                          onClick={() => handleRejectBooking(b.id)}
                                          className="px-4 py-2 bg-rose-50 hover:bg-rose-100 text-rose-700 text-xs font-bold rounded-lg transition-all active:scale-95"
                                        >
                                          Zamietnuť
                                        </button>
                                      </div>
                                    )}
                                  </div>
                                </div>
                              )
                            })}
                          </div>
                        )}

                        <div className="flex justify-between items-center mt-5 pt-3 border-t border-slate-200/60">
                          <button
                            onClick={() => handleDeleteSlot(slot.id)}
                            className="inline-flex items-center gap-1.5 text-xs text-rose-600 hover:text-rose-700 font-semibold hover:underline"
                          >
                            <svg className="w-4 h-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16" />
                            </svg>
                            Odstrániť tento termín
                          </button>
                        </div>
                      </div>
                    )}
                  </div>
                )
              })}
              {slotsForDay.length === 0 && (
                <div className="text-center py-16 bg-white rounded-2xl border border-slate-200 shadow-sm">
                  <svg className="w-12 h-12 text-slate-300 mx-auto mb-3" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={1.5} d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z" />
                  </svg>
                  <p className="text-slate-400 font-light text-base">Na tento deň nie sú vytvorené žiadne termíny.</p>
                  <p className="text-slate-500 font-light text-xs mt-1">Pridajte termín pomocou formulára vyššie.</p>
                </div>
              )}
            </div>
          )}
        </div>
      )}

      {/* --- COURSE APPLICATIONS TAB --- */}
      {activeTab === 'applications' && (
        <div className="space-y-6">
          {/* Search bar */}
          <div className="bg-white rounded-2xl border border-slate-200 shadow-sm p-4 flex items-center gap-3">
            <svg className="w-5 h-5 text-slate-400 flex-shrink-0" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
            </svg>
            <input
              type="text"
              placeholder="Vyhľadať prihlášky podľa mena, kurzu, mobilu..."
              value={searchTerm}
              onChange={e => setSearchTerm(e.target.value)}
              className="w-full bg-transparent text-sm focus:outline-none text-slate-800 font-light"
            />
            {searchTerm && (
              <button onClick={() => setSearchTerm('')} className="text-slate-400 hover:text-slate-600">
                <svg className="w-4 h-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M6 18L18 6M6 6l12 12" />
                </svg>
              </button>
            )}
          </div>

          {/* List of Applications */}
          {loading ? (
            <div className="flex justify-center py-12">
              <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-purple-600"></div>
            </div>
          ) : (
            <div className="grid grid-cols-1 gap-4">
              {filteredApps.map(app => {
                const isExpanded = expandedAppId === app.id
                const isNew = app.status === 'new'
                const isConfirmed = app.status === 'confirmed'
                const isRejected = app.status === 'rejected'
                
                // Parse message to get rich fields
                const extraData = parseApplicationMessage(app.message)

                return (
                  <div key={app.id} className={`bg-white rounded-2xl border shadow-sm transition-all duration-200 ${
                    isNew ? 'border-purple-200 ring-1 ring-purple-100' : 'border-slate-200'
                  }`}>
                    {/* Header info */}
                    <div className="p-6 flex flex-col sm:flex-row sm:items-start justify-between gap-4">
                      <div className="space-y-1.5">
                        <div className="flex flex-wrap items-center gap-3">
                          <h3 className="text-lg font-bold text-slate-800">{app.client_name}</h3>
                          <span className={`text-xs px-2.5 py-0.5 rounded-full font-bold uppercase tracking-wider ${
                            isNew
                              ? 'bg-purple-100 text-purple-800'
                              : isConfirmed
                                ? 'bg-emerald-100 text-emerald-800'
                                : 'bg-rose-100 text-rose-800'
                          }`}>
                            {isNew ? 'Nový' : isConfirmed ? 'Schválený' : 'Zamietnutý'}
                          </span>
                        </div>
                        <p className="text-sm font-semibold text-purple-800">{app.course_name}</p>
                        <p className="text-xs text-slate-500 font-light">Termín: <span className="font-semibold text-slate-700">{app.selected_term}</span></p>
                      </div>

                      <div className="flex flex-wrap gap-2 items-center">
                        <button
                          onClick={() => setExpandedAppId(isExpanded ? null : app.id)}
                          className="px-4 py-2 bg-slate-50 hover:bg-slate-100 text-slate-700 text-xs font-semibold rounded-lg border border-slate-200 flex items-center gap-1.5 transition-colors"
                        >
                          {isExpanded ? 'Skryť detaily' : 'Zobraziť detaily'}
                          <svg className={`w-4 h-4 text-slate-500 transition-transform ${isExpanded ? 'rotate-180' : ''}`} fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 9l-7 7-7-7" />
                          </svg>
                        </button>
                      </div>
                    </div>

                    {/* Detailed info */}
                    {isExpanded && (
                      <div className="bg-slate-50/50 border-t border-slate-100 p-6 space-y-6">
                        <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
                          {/* Column 1: Contact */}
                          <div className="space-y-4">
                            <h4 className="text-xs font-bold text-slate-400 uppercase tracking-wider">Kontaktné údaje</h4>
                            <div className="space-y-3 bg-white p-4 rounded-xl border border-slate-100">
                              <div className="flex items-center gap-3 text-sm">
                                <span className="w-20 text-slate-400 font-light">Mobil:</span>
                                <a href={`tel:${app.client_phone}`} className="text-purple-600 hover:underline font-semibold flex items-center gap-1">
                                  {app.client_phone}
                                </a>
                              </div>
                              <div className="flex items-center gap-3 text-sm">
                                <span className="w-20 text-slate-400 font-light">Email:</span>
                                <a href={`mailto:${app.client_email}`} className="text-purple-600 hover:underline font-semibold flex items-center gap-1">
                                  {app.client_email}
                                </a>
                              </div>
                              {extraData?.instagram && (
                                <div className="flex items-center gap-3 text-sm">
                                  <span className="w-20 text-slate-400 font-light">Instagram:</span>
                                  <a
                                    href={`https://instagram.com/${extraData.instagram.replace('@', '')}`}
                                    target="_blank"
                                    rel="noopener noreferrer"
                                    className="text-pink-600 hover:underline font-semibold flex items-center gap-1"
                                  >
                                    {extraData.instagram}
                                  </a>
                                </div>
                              )}
                              {extraData?.facebook && (
                                <div className="flex items-center gap-3 text-sm">
                                  <span className="w-20 text-slate-400 font-light">Facebook:</span>
                                  <span className="text-slate-700 font-medium">{extraData.facebook}</span>
                                </div>
                              )}
                            </div>
                          </div>

                          {/* Column 2: Professional Profile */}
                          <div className="space-y-4">
                            <h4 className="text-xs font-bold text-slate-400 uppercase tracking-wider">Odborný profil</h4>
                            <div className="space-y-3 bg-white p-4 rounded-xl border border-slate-100">
                              <div className="flex items-center gap-3 text-sm">
                                <span className="w-28 text-slate-400 font-light">Úroveň zručnosti:</span>
                                <span className="text-slate-700 font-semibold uppercase tracking-wider text-xs">
                                  {extraData?.experience_level === 'beginner' && 'Začiatočník'}
                                  {extraData?.experience_level === 'intermediate' && 'Mierne pokročilá'}
                                  {extraData?.experience_level === 'advanced' && 'Pokročilá'}
                                  {!extraData?.experience_level && 'Neuvedené'}
                                </span>
                              </div>
                              {extraData?.practice_scope && (
                                <div className="flex items-start gap-3 text-sm">
                                  <span className="w-28 text-slate-400 font-light flex-shrink-0">Rozsah praxe:</span>
                                  <span className="text-slate-700 font-medium">{extraData.practice_scope}</span>
                                </div>
                              )}
                              <div className="flex items-center gap-3 text-sm">
                                <span className="w-28 text-slate-400 font-light">Práca v beauty:</span>
                                <span className={`text-xs font-bold px-2 py-0.5 rounded-full ${extraData?.works_in_beauty ? 'bg-emerald-50 text-emerald-700 border border-emerald-100' : 'bg-slate-100 text-slate-600'}`}>
                                  {extraData?.works_in_beauty === true ? 'Áno' : extraData?.works_in_beauty === false ? 'Nie' : 'Neuvedené'}
                                </span>
                              </div>
                              {extraData?.beauty_field && (
                                <div className="flex items-center gap-3 text-sm">
                                  <span className="w-28 text-slate-400 font-light">Oblasť pôsobenia:</span>
                                  <span className="text-slate-700 font-medium">{extraData.beauty_field}</span>
                                </div>
                              )}
                            </div>
                          </div>
                        </div>

                        {/* Plain text message if it exists and wasn't parseable as JSON */}
                        {app.message && !extraData && (
                          <div className="space-y-2">
                            <h4 className="text-xs font-bold text-slate-400 uppercase tracking-wider">Správa od uchádzača</h4>
                            <div className="bg-white p-4 rounded-xl border border-slate-100 text-sm text-slate-700 font-light">
                              {app.message}
                            </div>
                          </div>
                        )}

                        {/* Date submitted & action buttons */}
                        <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4 pt-4 border-t border-slate-200/60">
                          <span className="text-xs text-slate-400 font-light">
                            Odoslané: {new Date(app.created_at).toLocaleString('sk', { dateStyle: 'long', timeStyle: 'short' })}
                          </span>

                          <div className="flex gap-2">
                            {isNew && (
                              <>
                                <button
                                  onClick={() => handleUpdateAppStatus(app.id, 'confirmed')}
                                  className="px-4 py-2 bg-emerald-600 hover:bg-emerald-700 text-white text-xs font-bold rounded-lg shadow-sm transition-all active:scale-95"
                                >
                                  Schváliť prihlášku
                                </button>
                                <button
                                  onClick={() => handleUpdateAppStatus(app.id, 'rejected')}
                                  className="px-4 py-2 bg-rose-50 hover:bg-rose-100 text-rose-700 text-xs font-bold rounded-lg transition-all active:scale-95"
                                >
                                  Zamietnuť
                                </button>
                              </>
                            )}
                            {!isNew && (
                              <button
                                onClick={() => handleUpdateAppStatus(app.id, 'new')}
                                className="px-4 py-2 bg-slate-100 hover:bg-slate-200 text-slate-700 text-xs font-bold rounded-lg transition-all active:scale-95"
                              >
                                Vrátiť medzi nové
                              </button>
                            )}
                            <button
                              onClick={() => handleDeleteApp(app.id)}
                              className="px-4 py-2 bg-white hover:bg-rose-50 text-rose-600 hover:text-rose-700 border border-slate-200 hover:border-rose-100 text-xs font-bold rounded-lg transition-all active:scale-95 ml-2"
                            >
                              Vymazať
                            </button>
                          </div>
                        </div>
                      </div>
                    )}
                  </div>
                )
              })}

              {filteredApps.length === 0 && (
                <div className="text-center py-16 bg-white rounded-2xl border border-slate-200 shadow-sm">
                  <svg className="w-12 h-12 text-slate-300 mx-auto mb-3" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={1.5} d="M12 6.253v13m0-13C10.832 5.477 9.246 5 7.5 5S4.168 5.477 3 6.253v13C4.168 18.477 5.754 18 7.5 18s3.332.477 4.5 1.253m0-13C13.168 5.477 14.754 5 16.5 5c1.747 0 3.332.477 4.5 1.253v13C19.832 18.477 18.247 18 16.5 18c-1.746 0-3.332.477-4.5 1.253" />
                  </svg>
                  <p className="text-slate-400 font-light text-base">Nenašli sa žiadne prihlášky na kurzy.</p>
                </div>
              )}
            </div>
          )}
        </div>
      )}

      {/* --- CONTACT MESSAGES TAB --- */}
      {activeTab === 'messages' && (
        <div className="space-y-6">
          {/* Search bar */}
          <div className="bg-white rounded-2xl border border-slate-200 shadow-sm p-4 flex items-center gap-3">
            <svg className="w-5 h-5 text-slate-400 flex-shrink-0" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
            </svg>
            <input
              type="text"
              placeholder="Vyhľadať správy podľa odosielateľa, textu..."
              value={searchTerm}
              onChange={e => setSearchTerm(e.target.value)}
              className="w-full bg-transparent text-sm focus:outline-none text-slate-800 font-light"
            />
            {searchTerm && (
              <button onClick={() => setSearchTerm('')} className="text-slate-400 hover:text-slate-600">
                <svg className="w-4 h-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M6 18L18 6M6 6l12 12" />
                </svg>
              </button>
            )}
          </div>

          {/* List of Messages */}
          {loading ? (
            <div className="flex justify-center py-12">
              <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-purple-600"></div>
            </div>
          ) : (
            <div className="grid grid-cols-1 gap-4">
              {filteredMessages.map(msg => (
                <div key={msg.id} className="bg-white rounded-2xl border border-slate-200 shadow-sm p-6 space-y-4 hover:border-slate-300 transition-all duration-200">
                  <div className="flex flex-col sm:flex-row sm:items-start justify-between gap-4 border-b border-slate-100 pb-3">
                    <div>
                      <h3 className="text-lg font-bold text-slate-800">{msg.name}</h3>
                      <div className="flex flex-wrap items-center gap-x-3 gap-y-1 text-xs text-slate-400 mt-1 font-light">
                        {msg.phone && (
                          <a href={`tel:${msg.phone}`} className="text-purple-600 hover:underline font-semibold flex items-center gap-1">
                            {msg.phone}
                          </a>
                        )}
                        {msg.phone && msg.email && <span>•</span>}
                        {msg.email && (
                          <a href={`mailto:${msg.email}`} className="text-purple-600 hover:underline font-semibold flex items-center gap-1">
                            {msg.email}
                          </a>
                        )}
                      </div>
                    </div>
                    <span className="text-xs text-slate-400 font-light self-start">
                      {new Date(msg.created_at).toLocaleString('sk', { dateStyle: 'medium', timeStyle: 'short' })}
                    </span>
                  </div>

                  <div className="bg-slate-50/50 rounded-xl p-4 border border-slate-100 text-slate-700 text-sm font-light leading-relaxed whitespace-pre-wrap">
                    {msg.message}
                  </div>

                  <div className="flex justify-end pt-2">
                    <button
                      onClick={() => handleDeleteMessage(msg.id)}
                      className="inline-flex items-center gap-1 text-xs text-rose-600 hover:text-rose-700 font-semibold hover:underline border border-transparent hover:border-rose-100 rounded-lg px-3 py-1.5 hover:bg-rose-50/30 transition-all"
                    >
                      <svg className="w-4 h-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16" />
                      </svg>
                      Vymazať správu
                    </button>
                  </div>
                </div>
              ))}

              {filteredMessages.length === 0 && (
                <div className="text-center py-16 bg-white rounded-2xl border border-slate-200 shadow-sm">
                  <svg className="w-12 h-12 text-slate-300 mx-auto mb-3" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={1.5} d="M8 12h.01M12 12h.01M16 12h.01M21 12c0 4.418-4.03 8-9 8a9.863 9.863 0 01-4.255-.949L3 20l1.395-3.72C3.512 15.042 3 13.574 3 12c0-4.418 4.03-8 9-8s9 3.582 9 8z" />
                  </svg>
                  <p className="text-slate-400 font-light text-base">Nenašli sa žiadne kontaktné správy.</p>
                </div>
              )}
            </div>
          )}
        </div>
      )}
    </div>
  )
}
