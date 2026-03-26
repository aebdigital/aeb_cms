import { useState, useEffect, useRef } from 'react'
import { useAuth } from '../contexts/AuthContext'
import { supabase } from '../lib/supabaseClient'
import { useNotification } from '../contexts/NotificationContext'

const VIKTORIJA_EMAIL = 'alexander.hidveghy@gmail.com'

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
  const { user, loading: authLoading } = useAuth()
  const { showNotification } = useNotification()
  const [slots, setSlots] = useState([])
  const [loading, setLoading] = useState(true)
  const [expandedSlotId, setExpandedSlotId] = useState(null)
  const [selectedDate, setSelectedDate] = useState(new Date())
  const scrollRef = useRef(null)

  // New slot form — only time + duration, date comes from day picker
  const [newTime, setNewTime] = useState('')
  const [newDuration, setNewDuration] = useState(60)
  const [addingSlot, setAddingSlot] = useState(false)

  // Day slider days
  const days = generateDays(new Date(), 60)

  // Access gate
  if (!authLoading && user?.email !== VIKTORIJA_EMAIL) {
    return (
      <div className="flex items-center justify-center h-64">
        <p className="text-gray-500">Nemáte prístup k tejto stránke.</p>
      </div>
    )
  }

  useEffect(() => {
    if (authLoading || user?.email !== VIKTORIJA_EMAIL) return
    loadData()
  }, [authLoading, user])

  // Scroll to today on mount
  useEffect(() => {
    if (scrollRef.current) {
      const todayEl = scrollRef.current.querySelector('[data-today="true"]')
      if (todayEl) {
        todayEl.scrollIntoView({ inline: 'center', behavior: 'instant' })
      }
    }
  }, [loading])

  async function loadData() {
    setLoading(true)
    try {
      const { data } = await supabase
        .from('viktorija_time_slots')
        .select('*, viktorija_bookings(id, client_name, client_phone, message, status, created_at)')
        .order('date', { ascending: true })
        .order('time', { ascending: true })
      setSlots(data || [])
    } catch (err) {
      console.error('Load error:', err)
    } finally {
      setLoading(false)
    }
  }

  const selectedDateStr = formatDateStr(selectedDate)
  const slotsForDay = slots.filter(s => s.date === selectedDateStr)

  // Count slots per day for indicators
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

  if (authLoading) {
    return (
      <div className="flex items-center justify-center h-64">
        <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-purple-600"></div>
      </div>
    )
  }

  const todayStr = formatDateStr(new Date())
  const pendingCount = slots.reduce((sum, s) => sum + (s.viktorija_bookings?.filter(b => b.status === 'pending').length || 0), 0)

  return (
    <div className="p-6">
      <div className="flex justify-between items-center mb-4">
        <div>
          <h1 className="text-2xl font-bold text-gray-800">Viktória — Správa termínov</h1>
          <p className="text-gray-500 text-sm mt-1">
            Vyberte deň a pridajte voľné termíny
            {pendingCount > 0 && (
              <span className="ml-2 inline-flex px-2 py-0.5 rounded-full text-xs font-medium bg-yellow-100 text-yellow-800">
                {pendingCount} čaká na schválenie
              </span>
            )}
          </p>
        </div>
      </div>

      {/* Day slider */}
      <div className="bg-white rounded-xl shadow-lg mb-6 overflow-hidden">
        <div
          ref={scrollRef}
          className="flex overflow-x-auto scrollbar-hide py-3 px-2 gap-1"
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
                className={`flex-shrink-0 flex flex-col items-center w-14 py-2 rounded-xl transition-all relative ${
                  isSelected
                    ? 'bg-purple-600 text-white shadow-lg scale-105'
                    : isPast
                      ? 'text-gray-300 hover:bg-gray-50'
                      : 'text-gray-600 hover:bg-gray-100'
                } ${isToday && !isSelected ? 'ring-2 ring-purple-300' : ''}`}
              >
                <span className="text-[10px] font-medium uppercase">{DAY_NAMES[day.getDay()]}</span>
                <span className={`text-lg font-bold ${isSelected ? 'text-white' : ''}`}>{day.getDate()}</span>
                <span className="text-[10px]">{MONTH_NAMES[day.getMonth()]}</span>
                {/* Indicators */}
                <div className="flex gap-0.5 mt-1 h-1.5">
                  {hasSlots && (
                    <div className={`w-1.5 h-1.5 rounded-full ${isSelected ? 'bg-white/60' : 'bg-purple-400'}`} />
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
      <div className="bg-white rounded-xl shadow-lg p-5 mb-4">
        <div className="flex items-center justify-between mb-4">
          <h2 className="text-lg font-semibold text-gray-800">
            {selectedDate.toLocaleDateString('sk', { weekday: 'long', day: 'numeric', month: 'long', year: 'numeric' })}
          </h2>
          <span className="text-sm text-gray-400">{slotsForDay.length} termín{slotsForDay.length !== 1 ? 'ov' : ''}</span>
        </div>
        <form onSubmit={handleAddSlot} className="flex flex-wrap gap-3 items-end">
          <div>
            <label className="block text-xs text-gray-500 mb-1">Čas</label>
            <input
              type="time"
              value={newTime}
              onChange={e => setNewTime(e.target.value)}
              className="border border-gray-300 rounded-lg px-3 py-2 text-sm"
              required
            />
          </div>
          <div>
            <label className="block text-xs text-gray-500 mb-1">Trvanie (min)</label>
            <input
              type="number"
              value={newDuration}
              onChange={e => setNewDuration(parseInt(e.target.value))}
              className="border border-gray-300 rounded-lg px-3 py-2 text-sm w-20"
            />
          </div>
          <button
            type="submit"
            disabled={addingSlot}
            className="bg-purple-600 hover:bg-purple-700 disabled:bg-purple-400 text-white px-4 py-2 rounded-lg text-sm font-medium transition-colors"
          >
            {addingSlot ? 'Pridávam...' : '+ Pridať termín'}
          </button>
        </form>
      </div>

      {/* Slots for selected day */}
      {loading ? (
        <div className="flex items-center justify-center h-32">
          <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-purple-600"></div>
        </div>
      ) : (
        <div className="space-y-2">
          {slotsForDay.map(slot => {
            const bookings = slot.viktorija_bookings || []
            const pendingBookings = bookings.filter(b => b.status === 'pending')
            const confirmedBooking = bookings.find(b => b.status === 'confirmed')
            const isExpanded = expandedSlotId === slot.id
            const hasPending = pendingBookings.length > 0

            return (
              <div key={slot.id} className="bg-white rounded-xl shadow overflow-hidden">
                <button
                  onClick={() => setExpandedSlotId(isExpanded ? null : slot.id)}
                  className={`w-full flex items-center justify-between px-5 py-4 text-left transition-colors hover:bg-gray-50 ${
                    !slot.is_available ? 'opacity-60' : ''
                  }`}
                >
                  <div className="flex items-center gap-4">
                    <div className={`w-2 h-2 rounded-full ${slot.is_available ? 'bg-green-500' : 'bg-red-400'}`} />
                    <span className={`font-medium text-sm ${!slot.is_available ? 'line-through text-gray-400' : 'text-gray-800'}`}>
                      {slot.time?.slice(0, 5)}
                    </span>
                    <span className="text-xs text-gray-400">{slot.duration_minutes} min</span>
                  </div>
                  <div className="flex items-center gap-3">
                    {confirmedBooking && (
                      <span className="text-xs px-2 py-0.5 rounded-full bg-green-100 text-green-800 font-medium">
                        Potvrdená: {confirmedBooking.client_name}
                      </span>
                    )}
                    {hasPending && (
                      <span className="text-xs px-2 py-0.5 rounded-full bg-yellow-100 text-yellow-800 font-medium animate-pulse">
                        {pendingBookings.length} žiadosť{pendingBookings.length > 1 ? 'i' : ''}
                      </span>
                    )}
                    <svg className={`w-4 h-4 text-gray-400 transition-transform ${isExpanded ? 'rotate-180' : ''}`} fill="none" viewBox="0 0 24 24" stroke="currentColor">
                      <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 9l-7 7-7-7" />
                    </svg>
                  </div>
                </button>

                {isExpanded && (
                  <div className="border-t border-gray-100 bg-gray-50 px-5 py-4">
                    {bookings.length === 0 ? (
                      <p className="text-sm text-gray-400 text-center py-4">Žiadne žiadosti o tento termín</p>
                    ) : (
                      <div className="space-y-3">
                        {bookings.map(b => {
                          const statusLabel = b.status === 'pending' ? 'Čaká' : b.status === 'confirmed' ? 'Potvrdená' : 'Zamietnutá'
                          const statusColor = b.status === 'pending' ? 'bg-yellow-100 text-yellow-800' : b.status === 'confirmed' ? 'bg-green-100 text-green-800' : 'bg-red-100 text-red-800'
                          return (
                            <div key={b.id} className={`bg-white rounded-lg p-4 border ${b.status === 'pending' ? 'border-yellow-200' : 'border-gray-200'}`}>
                              <div className="flex items-start justify-between">
                                <div>
                                  <div className="flex items-center gap-2">
                                    <p className="text-sm font-medium text-gray-800">{b.client_name}</p>
                                    <span className={`text-xs px-2 py-0.5 rounded-full font-medium ${statusColor}`}>{statusLabel}</span>
                                  </div>
                                  <a href={`tel:${b.client_phone}`} className="text-xs text-blue-600 hover:underline mt-1 inline-block">{b.client_phone}</a>
                                  {b.message && <p className="text-sm text-gray-600 mt-2">{b.message}</p>}
                                  <p className="text-xs text-gray-400 mt-2">{new Date(b.created_at).toLocaleString('sk')}</p>
                                </div>
                                {b.status === 'pending' && (
                                  <div className="flex gap-2 ml-4">
                                    <button
                                      onClick={() => handleAcceptBooking(b.id, slot.id)}
                                      className="px-3 py-1.5 bg-green-600 hover:bg-green-700 text-white text-xs rounded-lg font-medium transition-colors"
                                    >
                                      Potvrdiť
                                    </button>
                                    <button
                                      onClick={() => handleRejectBooking(b.id)}
                                      className="px-3 py-1.5 bg-red-100 hover:bg-red-200 text-red-700 text-xs rounded-lg font-medium transition-colors"
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

                    <div className="flex gap-3 mt-4 pt-3 border-t border-gray-200">
                      <button
                        onClick={() => handleDeleteSlot(slot.id)}
                        className="text-xs text-red-600 hover:text-red-800 font-medium"
                      >
                        Vymazať termín
                      </button>
                    </div>
                  </div>
                )}
              </div>
            )
          })}
          {slotsForDay.length === 0 && (
            <div className="text-center py-12 text-gray-400 bg-white rounded-xl shadow">
              Žiadne termíny pre tento deň — pridajte nový termín vyššie
            </div>
          )}
        </div>
      )}
    </div>
  )
}
