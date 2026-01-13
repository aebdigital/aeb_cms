import { useState, useEffect } from 'react'
import { PlusIcon, PencilIcon, TrashIcon, XMarkIcon, PhotoIcon } from '@heroicons/react/24/outline'
import { useAuth } from '../contexts/AuthContext'
import {
    getProgramEvents,
    createProgramEvent,
    updateProgramEvent,
    deleteProgramEvent,
    generateSlug,
    PROGRAM_CATEGORIES,
    PROGRAM_STATUSES,
    getDayNameFromDate,
    getMonthFromDate
} from '../api/programEvents'
import { uploadProgramImage, getProgramImagePublicUrl, deleteProgramImageFromStorage } from '../api/programStorage'
import { compressImage } from '../lib/fileUtils'

const initialForm = {
    title: '',
    slug: '',
    category: 'skola-ludus',
    event_date: new Date().toISOString().split('T')[0],
    time: '18:00',
    venue: 'Divadlo Ludus',
    status: 'available',
    price: '',
    info_text: '',
    color: '#ffffff',
    description: '',
    duration: '',
    age_info: '',
    age_badge: '',
    premiere: '',
    author: '',
    subtitle: '',
    published: true,
    image_path: null,
    cast_members: [],
    team_members: []
}

export default function LudusProgram() {
    const { currentSite, loading: authLoading } = useAuth()
    const [events, setEvents] = useState([])
    const [loading, setLoading] = useState(false)
    const [initialLoad, setInitialLoad] = useState(true)
    const [error, setError] = useState(null)
    const [activeCategory, setActiveCategory] = useState(PROGRAM_CATEGORIES[0].value)

    // Modal state
    const [showModal, setShowModal] = useState(false)
    const [isEditMode, setIsEditMode] = useState(false)
    const [editingId, setEditingId] = useState(null)
    const [formData, setFormData] = useState(initialForm)
    const [activeTab, setActiveTab] = useState('basic')
    const [submitting, setSubmitting] = useState(false)

    // Image upload state
    const [uploadingImage, setUploadingImage] = useState(false)
    const [uploadProgress, setUploadProgress] = useState('')

    // Load events
    useEffect(() => {
        if (authLoading || !currentSite?.id) {
            if (!authLoading && !currentSite?.id) setInitialLoad(false)
            return
        }

        let cancelled = false

        async function loadData() {
            setLoading(true)
            setError(null)
            try {
                const data = await getProgramEvents(currentSite.id)
                if (!cancelled) setEvents(data)
            } catch (err) {
                console.error('Error loading events:', err)
                if (!cancelled) setError('Chyba pri načítavaní programu')
            } finally {
                if (!cancelled) {
                    setLoading(false)
                    setInitialLoad(false)
                }
            }
        }

        loadData()
        return () => { cancelled = true }
    }, [currentSite?.id, authLoading])

    const filteredEvents = events.filter(e => e.category === activeCategory)

    // Handlers
    const handleOpenAdd = () => {
        setFormData(initialForm)
        setIsEditMode(false)
        setEditingId(null)
        setActiveTab('basic')
        setShowModal(true)
    }

    const handleOpenEdit = (event) => {
        setFormData({
            ...event,
            // Ensure arrays are initialized
            cast_members: event.cast_members || [],
            team_members: event.team_members || []
        })
        setIsEditMode(true)
        setEditingId(event.id)
        setActiveTab('basic')
        setShowModal(true)
    }

    const handleDelete = async (event) => {
        if (!confirm(`Naozaj chcete vymazať podujatie "${event.title}"?`)) return

        try {
            if (event.image_path) {
                try {
                    await deleteProgramImageFromStorage(event.image_path)
                } catch (e) {
                    console.warn('Could not delete image', e)
                }
            }

            await deleteProgramEvent(event.id)
            setEvents(prev => prev.filter(e => e.id !== event.id))
        } catch (err) {
            console.error('Delete error:', err)
            setError('Chyba pri mazaní')
        }
    }

    const handleImageUpload = async (e) => {
        const file = e.target.files?.[0]
        if (!file) return

        setUploadingImage(true)
        setUploadProgress('Komprimujem...')

        try {
            const compressed = await compressImage(file)
            setUploadProgress('Nahrávam...')

            const { path } = await uploadProgramImage({
                file: compressed,
                siteSlug: currentSite.slug,
                category: formData.category
            })

            setFormData(prev => ({ ...prev, image_path: path }))
        } catch (err) {
            console.error('Upload error:', err)
            alert('Chyba pri nahrávaní obrázka')
        } finally {
            setUploadingImage(false)
            setUploadProgress('')
        }
    }

    const handleRemoveImage = async () => {
        if (!confirm('Naozaj odstranit obrazok?')) return
        setFormData(prev => ({ ...prev, image_path: null }))
    }

    // Slug generation on title change (only new items)
    const handleTitleChange = (e) => {
        const title = e.target.value
        setFormData(prev => ({
            ...prev,
            title,
            slug: !isEditMode ? generateSlug(title, prev.event_date) : prev.slug
        }))
    }

    const handleDateChange = (e) => {
        const date = e.target.value
        setFormData(prev => ({
            ...prev,
            event_date: date,
            day_name: getDayNameFromDate(date),
            month: getMonthFromDate(date),
            // update slug if new
            slug: !isEditMode ? generateSlug(prev.title, date) : prev.slug
        }))
    }

    // Array handlers
    const handleAddCast = () => {
        const name = prompt('Meno účinkujúceho:')
        if (name) {
            setFormData(prev => ({
                ...prev,
                cast_members: [...prev.cast_members, name]
            }))
        }
    }

    const handleRemoveCast = (index) => {
        setFormData(prev => ({
            ...prev,
            cast_members: prev.cast_members.filter((_, i) => i !== index)
        }))
    }

    const handleAddTeam = () => {
        // Simple prompt for now, could be better UI
        const role = prompt('Rola (napr. Réžia):')
        if (!role) return
        const name = prompt('Meno:')
        if (!name) return

        setFormData(prev => ({
            ...prev,
            team_members: [...prev.team_members, { role, name }]
        }))
    }

    const handleRemoveTeam = (index) => {
        setFormData(prev => ({
            ...prev,
            team_members: prev.team_members.filter((_, i) => i !== index)
        }))
    }

    const handleSubmit = async (e) => {
        e.preventDefault()
        if (!formData.title || !formData.slug) return alert('Vyplňte názov a slug')

        setSubmitting(true)
        setError(null)

        try {
            const dataToSave = {
                ...formData,
                day_name: getDayNameFromDate(formData.event_date),
                month: getMonthFromDate(formData.event_date),
                site_id: currentSite.id
            }

            if (isEditMode) {
                const updated = await updateProgramEvent(editingId, dataToSave)
                setEvents(prev => prev.map(e => e.id === editingId ? updated : e))
            } else {
                const created = await createProgramEvent(dataToSave)
                setEvents(prev => [...prev, created])
            }
            setShowModal(false)
        } catch (err) {
            console.error('Save error:', err)
            setError('Chyba pri ukladaní')
        } finally {
            setSubmitting(false)
        }
    }

    if (initialLoad || authLoading) return <div className="p-8 text-center">Načítavam...</div>
    if (!currentSite) return <div className="p-8 text-center">Vyberte stránku</div>

    return (
        <div className="p-6">
            <div className="flex justify-between items-center mb-6">
                <h1 className="text-2xl font-bold text-gray-800">Program</h1>
                <button
                    onClick={handleOpenAdd}
                    className="flex items-center gap-2 bg-purple-600 hover:bg-purple-700 text-white px-4 py-2 rounded-lg font-semibold transition-colors"
                >
                    <PlusIcon className="w-5 h-5" />
                    Pridať podujatie
                </button>
            </div>

            {error && (
                <div className="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-6 flex justify-between">
                    {error}
                    <button onClick={() => setError(null)}>&times;</button>
                </div>
            )}

            {/* Categories */}
            <div className="flex gap-2 mb-6">
                {PROGRAM_CATEGORIES.map(cat => (
                    <button
                        key={cat.value}
                        onClick={() => setActiveCategory(cat.value)}
                        className={`px-4 py-2 rounded-lg font-medium transition-colors ${activeCategory === cat.value
                                ? 'bg-purple-600 text-white'
                                : 'bg-gray-100 text-gray-700 hover:bg-gray-200'
                            }`}
                    >
                        {cat.label}
                    </button>
                ))}
            </div>

            {/* List */}
            <div className="bg-white rounded-xl shadow overflow-hidden">
                <table className="w-full">
                    <thead className="bg-gray-50 border-b">
                        <tr>
                            <th className="text-left px-4 py-3 text-gray-600 font-medium">Dátum</th>
                            <th className="text-left px-4 py-3 text-gray-600 font-medium">Názov</th>
                            <th className="text-left px-4 py-3 text-gray-600 font-medium">Miesto</th>
                            <th className="text-center px-4 py-3 text-gray-600 font-medium">Status</th>
                            <th className="text-right px-4 py-3 text-gray-600 font-medium">Akcie</th>
                        </tr>
                    </thead>
                    <tbody className="divide-y divide-gray-100">
                        {filteredEvents.length === 0 ? (
                            <tr>
                                <td colSpan="5" className="px-4 py-8 text-center text-gray-500">
                                    Žiadne podujatia v tejto kategórii
                                </td>
                            </tr>
                        ) : (
                            filteredEvents.map(event => (
                                <tr key={event.id} className="hover:bg-gray-50">
                                    <td className="px-4 py-3">
                                        <div className="font-medium text-gray-900">
                                            {new Date(event.event_date).toLocaleDateString('sk-SK')}
                                        </div>
                                        <div className="text-xs text-gray-500">{event.time}</div>
                                    </td>
                                    <td className="px-4 py-3">
                                        <div className="flex items-center gap-3">
                                            <div className="w-3 h-3 rounded-full" style={{ backgroundColor: event.color }} title="Farba podujatia"></div>
                                            <div>
                                                <div className="font-medium">{event.title}</div>
                                                {event.subtitle && <div className="text-xs text-gray-500">{event.subtitle}</div>}
                                            </div>
                                        </div>
                                    </td>
                                    <td className="px-4 py-3 text-sm text-gray-600">{event.venue}</td>
                                    <td className="px-4 py-3 text-center">
                                        <span className={`inline-flex px-2 py-1 rounded text-xs font-medium ${event.status === 'available' ? 'bg-green-100 text-green-800' :
                                                event.status === 'vypredane' ? 'bg-red-100 text-red-800' :
                                                    'bg-blue-100 text-blue-800'
                                            }`}>
                                            {PROGRAM_STATUSES.find(s => s.value === event.status)?.label || event.status}
                                        </span>
                                    </td>
                                    <td className="px-4 py-3 text-right">
                                        <div className="flex items-center justify-end gap-2">
                                            <button onClick={() => handleOpenEdit(event)} className="p-1 text-gray-500 hover:text-purple-600">
                                                <PencilIcon className="w-5 h-5" />
                                            </button>
                                            <button onClick={() => handleDelete(event)} className="p-1 text-gray-500 hover:text-red-600">
                                                <TrashIcon className="w-5 h-5" />
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                            ))
                        )}
                    </tbody>
                </table>
            </div>

            {/* Modal */}
            {showModal && (
                <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 p-4">
                    <div className="bg-white rounded-xl shadow-xl max-w-4xl w-full max-h-[90vh] overflow-hidden flex flex-col">
                        <div className="flex justify-between items-center p-4 border-b">
                            <h2 className="text-lg font-semibold">{isEditMode ? 'Upraviť podujatie' : 'Nové podujatie'}</h2>
                            <button onClick={() => setShowModal(false)}>
                                <XMarkIcon className="w-6 h-6 text-gray-500 hover:text-gray-700" />
                            </button>
                        </div>

                        <div className="flex border-b">
                            {['Basic', 'Schedule', 'Status', 'Detail', 'Team'].map(tab => (
                                <button
                                    key={tab}
                                    onClick={() => setActiveTab(tab.toLowerCase())}
                                    className={`flex-1 py-3 text-sm font-medium border-b-2 transition-colors ${activeTab === tab.toLowerCase()
                                            ? 'border-purple-600 text-purple-600 bg-purple-50'
                                            : 'border-transparent text-gray-500 hover:text-gray-700'
                                        }`}
                                >
                                    {tab}
                                </button>
                            ))}
                        </div>

                        <div className="flex-1 overflow-y-auto p-6">
                            <form id="program-form" onSubmit={handleSubmit} className="space-y-6">
                                {/* BASIC TAB */}
                                {activeTab === 'basic' && (
                                    <div className="space-y-4">
                                        <div className="grid grid-cols-2 gap-4">
                                            <div>
                                                <label className="block text-sm font-medium text-gray-700 mb-1">Názov *</label>
                                                <input
                                                    type="text"
                                                    value={formData.title}
                                                    onChange={handleTitleChange}
                                                    required
                                                    className="w-full border rounded-lg px-3 py-2"
                                                />
                                            </div>
                                            <div>
                                                <label className="block text-sm font-medium text-gray-700 mb-1">Slug *</label>
                                                <input
                                                    type="text"
                                                    value={formData.slug}
                                                    onChange={e => setFormData(p => ({ ...p, slug: e.target.value }))}
                                                    required
                                                    className="w-full border rounded-lg px-3 py-2 bg-gray-50"
                                                />
                                            </div>
                                        </div>

                                        <div>
                                            <label className="block text-sm font-medium text-gray-700 mb-1">Kategória</label>
                                            <select
                                                value={formData.category}
                                                onChange={e => setFormData(p => ({ ...p, category: e.target.value }))}
                                                className="w-full border rounded-lg px-3 py-2"
                                            >
                                                {PROGRAM_CATEGORIES.map(c => <option key={c.value} value={c.value}>{c.label}</option>)}
                                            </select>
                                        </div>

                                        <div>
                                            <label className="block text-sm font-medium text-gray-700 mb-1">Podnadpis</label>
                                            <input
                                                type="text"
                                                value={formData.subtitle || ''}
                                                onChange={e => setFormData(p => ({ ...p, subtitle: e.target.value }))}
                                                className="w-full border rounded-lg px-3 py-2"
                                            />
                                        </div>

                                        <div>
                                            <label className="block text-sm font-medium text-gray-700 mb-1">Autor</label>
                                            <input
                                                type="text"
                                                value={formData.author || ''}
                                                onChange={e => setFormData(p => ({ ...p, author: e.target.value }))}
                                                className="w-full border rounded-lg px-3 py-2"
                                            />
                                        </div>
                                    </div>
                                )}

                                {/* SCHEDULE TAB */}
                                {activeTab === 'schedule' && (
                                    <div className="space-y-4">
                                        <div className="grid grid-cols-2 gap-4">
                                            <div>
                                                <label className="block text-sm font-medium text-gray-700 mb-1">Dátum *</label>
                                                <input
                                                    type="date"
                                                    value={formData.event_date}
                                                    onChange={handleDateChange}
                                                    required
                                                    className="w-full border rounded-lg px-3 py-2"
                                                />
                                            </div>
                                            <div>
                                                <label className="block text-sm font-medium text-gray-700 mb-1">Čas *</label>
                                                <input
                                                    type="time"
                                                    value={formData.time}
                                                    onChange={e => setFormData(p => ({ ...p, time: e.target.value }))}
                                                    required
                                                    className="w-full border rounded-lg px-3 py-2"
                                                />
                                            </div>
                                        </div>

                                        <div>
                                            <label className="block text-sm font-medium text-gray-700 mb-1">Miesto (Venue) *</label>
                                            <input
                                                type="text"
                                                value={formData.venue}
                                                onChange={e => setFormData(p => ({ ...p, venue: e.target.value }))}
                                                required
                                                className="w-full border rounded-lg px-3 py-2"
                                            />
                                        </div>

                                        <div className="grid grid-cols-2 gap-4 text-sm text-gray-500 bg-gray-50 p-4 rounded-lg">
                                            <div>Automaticky: {formData.day_name || '-'}</div>
                                            <div>Automaticky: {formData.month || '-'}</div>
                                        </div>
                                    </div>
                                )}

                                {/* STATUS TAB */}
                                {activeTab === 'status' && (
                                    <div className="space-y-4">
                                        <div>
                                            <label className="block text-sm font-medium text-gray-700 mb-1">Status</label>
                                            <select
                                                value={formData.status}
                                                onChange={e => setFormData(p => ({ ...p, status: e.target.value }))}
                                                className="w-full border rounded-lg px-3 py-2"
                                            >
                                                {PROGRAM_STATUSES.map(s => <option key={s.value} value={s.value}>{s.label}</option>)}
                                            </select>
                                        </div>

                                        <div>
                                            <label className="block text-sm font-medium text-gray-700 mb-1">Cena</label>
                                            <input
                                                type="text"
                                                value={formData.price || ''}
                                                onChange={e => setFormData(p => ({ ...p, price: e.target.value }))}
                                                className="w-full border rounded-lg px-3 py-2"
                                                placeholder="napr. 10 €"
                                            />
                                        </div>

                                        <div>
                                            <label className="block text-sm font-medium text-gray-700 mb-1">Info text (napr. Link na lístky)</label>
                                            <input
                                                type="text"
                                                value={formData.info_text || ''}
                                                onChange={e => setFormData(p => ({ ...p, info_text: e.target.value }))}
                                                className="w-full border rounded-lg px-3 py-2"
                                            />
                                        </div>

                                        <div>
                                            <label className="block text-sm font-medium text-gray-700 mb-1">Farba (pre pozadie/badge)</label>
                                            <div className="flex gap-2 items-center">
                                                <input
                                                    type="color"
                                                    value={formData.color}
                                                    onChange={e => setFormData(p => ({ ...p, color: e.target.value }))}
                                                    className="h-10 w-20 rounded border cursor-pointer"
                                                />
                                                <span className="text-gray-500 text-sm">{formData.color}</span>
                                            </div>
                                        </div>

                                        <div className="flex items-center mt-4">
                                            <input
                                                type="checkbox"
                                                id="published"
                                                checked={formData.published}
                                                onChange={e => setFormData(p => ({ ...p, published: e.target.checked }))}
                                                className="h-4 w-4 text-purple-600 rounded"
                                            />
                                            <label htmlFor="published" className="ml-2 text-sm text-gray-700">Publikované (zobraziť na webe)</label>
                                        </div>
                                    </div>
                                )}

                                {/* DETAIL TAB */}
                                {activeTab === 'detail' && (
                                    <div className="space-y-4">
                                        <div>
                                            <label className="block text-sm font-medium text-gray-700 mb-1">Popis (Rich Text podporovaný neskôr)</label>
                                            <textarea
                                                rows={5}
                                                value={formData.description || ''}
                                                onChange={e => setFormData(p => ({ ...p, description: e.target.value }))}
                                                className="w-full border rounded-lg px-3 py-2"
                                            />
                                        </div>

                                        <div className="grid grid-cols-2 gap-4">
                                            <div>
                                                <label className="block text-sm font-medium text-gray-700 mb-1">Dĺžka</label>
                                                <input
                                                    type="text"
                                                    value={formData.duration || ''}
                                                    onChange={e => setFormData(p => ({ ...p, duration: e.target.value }))}
                                                    placeholder="napr. 90 min"
                                                    className="w-full border rounded-lg px-3 py-2"
                                                />
                                            </div>
                                            <div>
                                                <label className="block text-sm font-medium text-gray-700 mb-1">Premiéra</label>
                                                <input
                                                    type="text"
                                                    value={formData.premiere || ''}
                                                    onChange={e => setFormData(p => ({ ...p, premiere: e.target.value }))}
                                                    className="w-full border rounded-lg px-3 py-2"
                                                />
                                            </div>
                                        </div>

                                        <div className="grid grid-cols-2 gap-4">
                                            <div>
                                                <label className="block text-sm font-medium text-gray-700 mb-1">Vek od (badge)</label>
                                                <input
                                                    type="text"
                                                    value={formData.age_badge || ''}
                                                    onChange={e => setFormData(p => ({ ...p, age_badge: e.target.value }))}
                                                    placeholder="napr. 12+"
                                                    className="w-full border rounded-lg px-3 py-2"
                                                />
                                            </div>
                                            <div>
                                                <label className="block text-sm font-medium text-gray-700 mb-1">Vek info</label>
                                                <input
                                                    type="text"
                                                    value={formData.age_info || ''}
                                                    onChange={e => setFormData(p => ({ ...p, age_info: e.target.value }))}
                                                    placeholder="pre deti od..."
                                                    className="w-full border rounded-lg px-3 py-2"
                                                />
                                            </div>
                                        </div>

                                        <div>
                                            <label className="block text-sm font-medium text-gray-700 mb-1">Obrázok</label>
                                            {formData.image_path ? (
                                                <div className="relative inline-block">
                                                    <img src={getProgramImagePublicUrl(formData.image_path)} alt="Preview" className="h-40 w-auto rounded-lg object-cover" />
                                                    <button
                                                        type="button"
                                                        onClick={handleRemoveImage}
                                                        className="absolute top-2 right-2 p-1 bg-red-600 text-white rounded-full hover:bg-red-700"
                                                    >
                                                        <TrashIcon className="w-4 h-4" />
                                                    </button>
                                                </div>
                                            ) : (
                                                <div className="border-2 border-dashed border-gray-300 rounded-lg p-6 text-center">
                                                    {uploadingImage ? (
                                                        <p className="text-purple-600">{uploadProgress}</p>
                                                    ) : (
                                                        <>
                                                            <PhotoIcon className="mx-auto h-12 w-12 text-gray-400" />
                                                            <label className="cursor-pointer text-purple-600 hover:text-purple-700 block mt-2">
                                                                <span>Nahrať obrázok</span>
                                                                <input type="file" className="hidden" accept="image/*" onChange={handleImageUpload} />
                                                            </label>
                                                        </>
                                                    )}
                                                </div>
                                            )}
                                        </div>
                                    </div>
                                )}

                                {/* TEAM TAB */}
                                {activeTab === 'team' && (
                                    <div className="space-y-6">
                                        {/* CAST */}
                                        <div>
                                            <div className="flex justify-between items-center mb-2">
                                                <label className="block text-sm font-medium text-gray-700">Obsadenie (Cast)</label>
                                                <button type="button" onClick={handleAddCast} className="text-sm text-purple-600 hover:text-purple-700 font-medium">
                                                    + Pridať
                                                </button>
                                            </div>
                                            <div className="space-y-2">
                                                {formData.cast_members && formData.cast_members.length > 0 ? (
                                                    formData.cast_members.map((member, idx) => (
                                                        <div key={idx} className="flex justify-between bg-gray-50 px-3 py-2 rounded">
                                                            <span>{member}</span>
                                                            <button type="button" onClick={() => handleRemoveCast(idx)} className="text-red-500 hover:text-red-700">
                                                                <XMarkIcon className="w-4 h-4" />
                                                            </button>
                                                        </div>
                                                    ))
                                                ) : <p className="text-gray-400 text-sm italic">Žiadne obsadenie</p>}
                                            </div>
                                        </div>

                                        {/* TEAM */}
                                        <div>
                                            <div className="flex justify-between items-center mb-2">
                                                <label className="block text-sm font-medium text-gray-700">Tím (Réžia atď.)</label>
                                                <button type="button" onClick={handleAddTeam} className="text-sm text-purple-600 hover:text-purple-700 font-medium">
                                                    + Pridať
                                                </button>
                                            </div>
                                            <div className="space-y-2">
                                                {formData.team_members && formData.team_members.length > 0 ? (
                                                    formData.team_members.map((member, idx) => (
                                                        <div key={idx} className="flex justify-between items-center bg-gray-50 px-3 py-2 rounded">
                                                            <div>
                                                                <span className="font-medium text-gray-900">{member.role}: </span>
                                                                <span className="text-gray-700">{member.name}</span>
                                                            </div>
                                                            <button type="button" onClick={() => handleRemoveTeam(idx)} className="text-red-500 hover:text-red-700">
                                                                <XMarkIcon className="w-4 h-4" />
                                                            </button>
                                                        </div>
                                                    ))
                                                ) : <p className="text-gray-400 text-sm italic">Žiadny členovia tímu</p>}
                                            </div>
                                        </div>
                                    </div>
                                )}
                            </form>
                        </div>

                        <div className="border-t p-4 flex justify-end gap-2 bg-gray-50">
                            <button
                                type="button"
                                onClick={() => setShowModal(false)}
                                className="px-4 py-2 border rounded-lg hover:bg-gray-100"
                                disabled={submitting}
                            >
                                Zrušiť
                            </button>
                            <button
                                type="submit"
                                form="program-form"
                                className="px-4 py-2 bg-purple-600 text-white rounded-lg hover:bg-purple-700 disabled:bg-purple-400"
                                disabled={submitting}
                            >
                                {submitting ? 'Ukladám...' : (isEditMode ? 'Uložiť zmeny' : 'Vytvoriť podujatie')}
                            </button>
                        </div>
                    </div>
                </div>
            )}
        </div>
    )
}
