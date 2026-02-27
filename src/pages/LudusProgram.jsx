import { useState, useEffect } from 'react'
import { PlusIcon, PencilIcon, TrashIcon, XMarkIcon, PhotoIcon } from '@heroicons/react/24/outline'
import { useAuth } from '../contexts/AuthContext'
import {
    getProgramEvents,
    getProgramEventsbyTitle,
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
    team_members: [],
    has_school_reservation: false,
    has_ticket_reservation: false,
    buy_ticket_link: '',
    gallery_paths: [],
    description_images: []
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

    // Instances state for multi-date support
    const [instances, setInstances] = useState([])
    const [loadingInstances, setLoadingInstances] = useState(false)
    const [deletedIds, setDeletedIds] = useState([])

    // Image upload state
    const [uploadingImage, setUploadingImage] = useState(false)
    const [uploadProgress, setUploadProgress] = useState('')

    // Gallery drag state
    const [dragIndex, setDragIndex] = useState(null)
    const [dragOverIndex, setDragOverIndex] = useState(null)

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
        setFormData({ ...initialForm, category: activeCategory })
        setInstances([{
            _tempId: Date.now(),
            event_date: initialForm.event_date,
            time: initialForm.time,
            venue: initialForm.venue,
            price: initialForm.price,
            status: initialForm.status,
            has_school_reservation: initialForm.has_school_reservation,
            has_ticket_reservation: initialForm.has_ticket_reservation,
            buy_ticket_link: initialForm.buy_ticket_link
        }])
        setIsEditMode(false)
        setEditingId(null)
        setActiveTab('basic')
        setShowModal(true)
    }

    const handleOpenEdit = async (event) => {
        setFormData({
            ...event,
            // Ensure arrays are initialized
            cast_members: event.cast_members || [],
            team_members: event.team_members || [],
            gallery_paths: event.gallery_paths || [],
            description_images: event.description_images || []
        })
        setIsEditMode(true)
        setEditingId(event.id)
        setActiveTab('basic')
        setShowModal(true)

        setLoadingInstances(true)
        try {
            const related = await getProgramEventsbyTitle(currentSite.id, event.title)
            setInstances(related && related.length > 0 ? related : [event])
        } catch (e) {
            console.error("Error loading instances", e)
            setInstances([event])
        } finally {
            setLoadingInstances(false)
        }
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

    const handleGalleryUpload = async (e) => {
        const files = Array.from(e.target.files || [])
        if (files.length === 0) return

        setUploadingImage(true) // Reuse state for simplicity
        setUploadProgress('Nahrávam galériu...')

        try {
            const newPaths = []
            for (const file of files) {
                const compressed = await compressImage(file)
                const { path } = await uploadProgramImage({
                    file: compressed,
                    siteSlug: currentSite.slug,
                    category: formData.category
                })
                newPaths.push(path)
            }

            setFormData(prev => ({
                ...prev,
                gallery_paths: [...(prev.gallery_paths || []), ...newPaths]
            }))
        } catch (err) {
            console.error('Gallery upload error:', err)
            alert('Chyba pri nahrávaní do galérie')
        } finally {
            setUploadingImage(false)
            setUploadProgress('')
        }
    }

    const handleRemoveGalleryImage = (index) => {
        if (!confirm('Odstrániť fotku z galérie?')) return
        setFormData(prev => ({
            ...prev,
            gallery_paths: prev.gallery_paths.filter((_, i) => i !== index)
        }))
    }

    const handleGalleryDrop = (fromIndex, toIndex) => {
        if (fromIndex === toIndex) return
        setFormData(prev => {
            const paths = [...(prev.gallery_paths || [])]
            const [moved] = paths.splice(fromIndex, 1)
            paths.splice(toIndex, 0, moved)
            return { ...prev, gallery_paths: paths }
        })
        setDragIndex(null)
        setDragOverIndex(null)
    }

    const handleDescriptionImagesUpload = async (e) => {
        const files = Array.from(e.target.files || [])
        if (files.length === 0) return

        setUploadingImage(true)
        setUploadProgress('Nahrávam fotky k popisu...')

        try {
            const newPaths = []
            for (const file of files) {
                const compressed = await compressImage(file)
                const { path } = await uploadProgramImage({
                    file: compressed,
                    siteSlug: currentSite.slug,
                    category: formData.category
                })
                newPaths.push(path)
            }

            setFormData(prev => ({
                ...prev,
                description_images: [...(prev.description_images || []), ...newPaths]
            }))
        } catch (err) {
            console.error('Description images upload error:', err)
            alert('Chyba pri nahrávaní fotiek')
        } finally {
            setUploadingImage(false)
            setUploadProgress('')
        }
    }

    const handleRemoveDescriptionImage = (index) => {
        if (!confirm('Odstrániť fotku?')) return
        setFormData(prev => ({
            ...prev,
            description_images: prev.description_images.filter((_, i) => i !== index)
        }))
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

    const handleUpdateCast = (index, value) => {
        setFormData(prev => {
            const newCast = [...prev.cast_members]
            newCast[index] = value
            return { ...prev, cast_members: newCast }
        })
    }

    const handleAddTeam = () => {
        setFormData(prev => ({
            ...prev,
            team_members: [...prev.team_members, { role: '', name: '' }]
        }))
    }

    const handleRemoveTeam = (index) => {
        setFormData(prev => ({
            ...prev,
            team_members: prev.team_members.filter((_, i) => i !== index)
        }))
    }

    const handleUpdateTeam = (index, field, value) => {
        setFormData(prev => {
            const newTeam = [...prev.team_members]
            newTeam[index] = { ...newTeam[index], [field]: value }
            return { ...prev, team_members: newTeam }
        })
    }

    const handleAddInstance = () => {
        setInstances(prev => [...prev, {
            _tempId: Date.now(),
            event_date: new Date().toISOString().split('T')[0],
            time: '18:00',
            venue: 'Divadlo Ludus',
            price: '',
            status: 'available',
            has_school_reservation: false,
            has_ticket_reservation: false,
            buy_ticket_link: ''
        }])
    }

    const handleRemoveInstance = (index) => {
        const inst = instances[index]
        if (inst.id) {
            setDeletedIds(prev => [...prev, inst.id])
        }
        setInstances(prev => prev.filter((_, i) => i !== index))
    }

    const handleUpdateInstance = (index, field, value) => {
        setInstances(prev => {
            const copy = [...prev]
            copy[index] = { ...copy[index], [field]: value }
            return copy
        })
    }

    const handleSubmit = async (e) => {
        e.preventDefault()
        if (!formData.title || !formData.slug) return alert('Vyplňte názov a slug')
        if (instances.length === 0) return alert('Musíte pridať aspoň jeden termín.')

        setSubmitting(true)
        setError(null)

        try {
            // 1. Process deletions
            if (deletedIds.length > 0) {
                await Promise.all(deletedIds.map(id => deleteProgramEvent(id)))
            }

            // 2. Process Upserts
            // Strip ID from formData to prevent PK violations
            const { id: _strippedId, ...cleanFormData } = formData;

            for (const instance of instances) {
                // Unique slug if needed (append time)
                const uniqueSlug = instance.id
                    ? instance.slug
                    : `${generateSlug(formData.title, instance.event_date)}-${instance.time.replace(':', '')}`;

                const dataToSave = {
                    ...cleanFormData,
                    event_date: instance.event_date,
                    time: instance.time,
                    venue: instance.venue,
                    price: instance.price,
                    status: instance.status,
                    has_school_reservation: instance.has_school_reservation,
                    has_ticket_reservation: instance.has_ticket_reservation,
                    buy_ticket_link: instance.buy_ticket_link,

                    day_name: getDayNameFromDate(instance.event_date),
                    month: getMonthFromDate(instance.event_date),
                    site_id: currentSite.id,
                    image_path: (formData.gallery_paths && formData.gallery_paths.length > 0)
                        ? formData.gallery_paths[0]
                        : formData.image_path,

                    slug: uniqueSlug
                }

                if (instance.id) {
                    await updateProgramEvent(instance.id, dataToSave)
                } else {
                    const { id, _tempId, ...createPayload } = dataToSave
                    // Remove temp properties
                    delete createPayload.id
                    delete createPayload._tempId

                    await createProgramEvent(createPayload)
                }
            }

            // Reload all
            const allData = await getProgramEvents(currentSite.id)
            setEvents(allData)
            // Switch to the saved category tab so user sees the event
            setActiveCategory(formData.category)
            setShowModal(false)

        } catch (err) {
            console.error('Save error:', err)
            setError('Chyba pri ukladaní: ' + err.message)
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
                    <div className="bg-white rounded-xl shadow-xl max-w-7xl w-full max-h-[90vh] overflow-hidden flex flex-col">
                        <div className="flex justify-between items-center p-4 border-b">
                            <h2 className="text-lg font-semibold">{isEditMode ? 'Upraviť podujatie' : 'Nové podujatie'}</h2>
                            <button onClick={() => setShowModal(false)}>
                                <XMarkIcon className="w-6 h-6 text-gray-500 hover:text-gray-700" />
                            </button>
                        </div>

                        <div className="flex-1 overflow-y-auto p-6">
                            <form id="program-form" onSubmit={handleSubmit} className="space-y-8">
                                {/* SECTION: MAIN 2-COL GRID */}
                                <div className="grid grid-cols-1 lg:grid-cols-2 gap-8">
                                    {/* Left Col: Basic Info + Details */}
                                    <div className="space-y-8">
                                        {/* Basic Info Group */}
                                        <div className="space-y-4">
                                            <h3 className="tex-lg font-bold border-b pb-2 mb-4 text-gray-800">Základné informácie</h3>

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

                                            <div className="grid grid-cols-2 gap-4">
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
                                                    <label className="block text-sm font-medium text-gray-700 mb-1">Autor</label>
                                                    <input
                                                        type="text"
                                                        value={formData.author || ''}
                                                        onChange={e => setFormData(p => ({ ...p, author: e.target.value }))}
                                                        className="w-full border rounded-lg px-3 py-2"
                                                    />
                                                </div>
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
                                                <label className="block text-sm font-medium text-gray-700 mb-1">Popis</label>
                                                <textarea
                                                    rows={5}
                                                    value={formData.description || ''}
                                                    onChange={e => setFormData(p => ({ ...p, description: e.target.value }))}
                                                    className="w-full border rounded-lg px-3 py-2"
                                                />
                                            </div>

                                            <div>
                                                <label className="block text-sm font-medium text-gray-700 mb-1">Fotky k popisu</label>
                                                <div className="grid grid-cols-4 gap-2 mb-3">
                                                    {formData.description_images && formData.description_images.map((path, idx) => (
                                                        <div key={idx} className="relative group aspect-square">
                                                            <img
                                                                src={getProgramImagePublicUrl(path)}
                                                                alt={`Popis ${idx + 1}`}
                                                                className="w-full h-full object-cover rounded-lg border"
                                                            />
                                                            <button
                                                                type="button"
                                                                onClick={() => handleRemoveDescriptionImage(idx)}
                                                                className="absolute top-1 right-1 p-1 bg-red-600 text-white rounded-full opacity-0 group-hover:opacity-100 transition-opacity"
                                                            >
                                                                <TrashIcon className="w-4 h-4" />
                                                            </button>
                                                        </div>
                                                    ))}
                                                </div>
                                                <label className="cursor-pointer bg-gray-50 text-gray-700 px-4 py-2 rounded-lg font-medium hover:bg-gray-100 flex items-center justify-center gap-2 border border-dashed border-gray-300">
                                                    <PhotoIcon className="w-5 h-5" />
                                                    <span>Pridať fotky k popisu</span>
                                                    <input
                                                        type="file"
                                                        multiple
                                                        className="hidden"
                                                        accept="image/*"
                                                        onChange={handleDescriptionImagesUpload}
                                                    />
                                                </label>
                                            </div>
                                        </div>

                                        {/* Details Group (Moved here) */}
                                        <div className="space-y-4">
                                            <h3 className="tex-lg font-bold border-b pb-2 mb-4 text-gray-800">Detaily</h3>

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
                                        </div>
                                    </div>

                                    {/* Right Col: Schedule & Status + Image */}
                                    <div className="space-y-8">
                                        <div className="space-y-4">
                                            <div className="flex justify-between items-center border-b pb-2 mb-4">
                                                <h3 className="text-lg font-bold text-gray-800">Termíny ({instances.length})</h3>
                                                {loadingInstances && <span className="text-xs text-gray-400">Načítavam...</span>}
                                            </div>

                                            <div className="space-y-6 max-h-[600px] overflow-y-auto pr-2">
                                                {instances.map((inst, idx) => (
                                                    <div key={inst.id || inst._tempId} className="bg-gray-50 p-4 rounded-lg relative border border-gray-200">
                                                        <button
                                                            type="button"
                                                            onClick={() => handleRemoveInstance(idx)}
                                                            className="absolute top-2 right-2 text-gray-400 hover:text-red-500"
                                                            title="Odstrániť termín"
                                                        >
                                                            <TrashIcon className="w-5 h-5" />
                                                        </button>

                                                        <div className="grid grid-cols-1 md:grid-cols-3 gap-4 mb-4 pr-8">
                                                            <div>
                                                                <label className="block text-xs font-medium text-gray-600 mb-1">Dátum</label>
                                                                <input
                                                                    type="date"
                                                                    value={inst.event_date}
                                                                    onChange={e => handleUpdateInstance(idx, 'event_date', e.target.value)}
                                                                    className="w-full border rounded px-2 py-1"
                                                                    required
                                                                />
                                                            </div>
                                                            <div>
                                                                <label className="block text-xs font-medium text-gray-600 mb-1">Čas</label>
                                                                <input
                                                                    type="time"
                                                                    value={inst.time}
                                                                    onChange={e => handleUpdateInstance(idx, 'time', e.target.value)}
                                                                    className="w-full border rounded px-2 py-1"
                                                                    required
                                                                />
                                                            </div>
                                                            <div>
                                                                <label className="block text-xs font-medium text-gray-600 mb-1">Miesto</label>
                                                                <input
                                                                    type="text"
                                                                    value={inst.venue}
                                                                    onChange={e => handleUpdateInstance(idx, 'venue', e.target.value)}
                                                                    className="w-full border rounded px-2 py-1"
                                                                    required
                                                                />
                                                            </div>
                                                        </div>

                                                        <div className="grid grid-cols-1 md:grid-cols-3 gap-4 mb-4">
                                                            <div>
                                                                <label className="block text-xs font-medium text-gray-600 mb-1">Status</label>
                                                                <select
                                                                    value={inst.status}
                                                                    onChange={e => handleUpdateInstance(idx, 'status', e.target.value)}
                                                                    className="w-full border rounded px-2 py-1"
                                                                >
                                                                    {PROGRAM_STATUSES.map(s => <option key={s.value} value={s.value}>{s.label}</option>)}
                                                                </select>
                                                            </div>
                                                            <div>
                                                                <label className="block text-xs font-medium text-gray-600 mb-1">Cena</label>
                                                                <input
                                                                    type="text"
                                                                    value={inst.price}
                                                                    onChange={e => handleUpdateInstance(idx, 'price', e.target.value)}
                                                                    className="w-full border rounded px-2 py-1"
                                                                    placeholder="10 €"
                                                                />
                                                            </div>
                                                        </div>

                                                        <div className="bg-white p-3 rounded border border-gray-100">
                                                            <h4 className="text-xs font-bold text-gray-500 uppercase mb-2">Tlačidlá</h4>
                                                            <div className="space-y-2">
                                                                <label className="flex items-center gap-2">
                                                                    <input
                                                                        type="checkbox"
                                                                        checked={inst.has_school_reservation || false}
                                                                        onChange={e => handleUpdateInstance(idx, 'has_school_reservation', e.target.checked)}
                                                                        className="rounded text-purple-600"
                                                                    />
                                                                    <span className="text-sm">Rezervácia pre školy</span>
                                                                </label>
                                                                <label className="flex items-center gap-2">
                                                                    <input
                                                                        type="checkbox"
                                                                        checked={inst.has_ticket_reservation || false}
                                                                        onChange={e => handleUpdateInstance(idx, 'has_ticket_reservation', e.target.checked)}
                                                                        className="rounded text-purple-600"
                                                                    />
                                                                    <span className="text-sm">Rezervácia lístka (Formulár)</span>
                                                                </label>
                                                            </div>
                                                            <div className="mt-2">
                                                                <input
                                                                    type="text"
                                                                    value={inst.buy_ticket_link || ''}
                                                                    onChange={e => handleUpdateInstance(idx, 'buy_ticket_link', e.target.value)}
                                                                    className="w-full border rounded px-2 py-1 text-sm"
                                                                    placeholder="Externý link na lístky"
                                                                />
                                                            </div>
                                                        </div>
                                                    </div>
                                                ))}

                                                <button
                                                    type="button"
                                                    onClick={handleAddInstance}
                                                    className="w-full py-2 border-2 border-dashed border-gray-300 rounded-lg text-gray-500 hover:border-purple-500 hover:text-purple-600 font-medium transition-colors"
                                                >
                                                    + Pridať ďalší termín
                                                </button>
                                            </div>

                                            <div className="flex justify-between items-center pt-2">
                                                <div>
                                                    <label className="block text-sm font-medium text-gray-700 mb-1">Farba</label>
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

                                                <div className="flex items-center">
                                                    <input
                                                        type="checkbox"
                                                        id="published"
                                                        checked={formData.published}
                                                        onChange={e => setFormData(p => ({ ...p, published: e.target.checked }))}
                                                        className="h-5 w-5 text-purple-600 rounded"
                                                    />
                                                    <label htmlFor="published" className="ml-2 text-sm font-medium text-gray-700">Publikované</label>
                                                </div>
                                            </div>
                                        </div>

                                        <div className="space-y-4">
                                            <h3 className="tex-lg font-bold border-b pb-2 mb-4 text-gray-800">Galéria</h3>

                                            <div className="pt-2">
                                                <div className="grid grid-cols-4 gap-2 mb-4">
                                                    {formData.gallery_paths && formData.gallery_paths.map((path, idx) => (
                                                        <div
                                                            key={path}
                                                            draggable
                                                            onDragStart={() => setDragIndex(idx)}
                                                            onDragOver={e => { e.preventDefault(); setDragOverIndex(idx) }}
                                                            onDragEnd={() => { setDragIndex(null); setDragOverIndex(null) }}
                                                            onDrop={e => { e.preventDefault(); handleGalleryDrop(dragIndex, idx) }}
                                                            className={`relative group aspect-square cursor-grab active:cursor-grabbing transition-all ${dragIndex === idx ? 'opacity-40 scale-95' : ''} ${dragOverIndex === idx && dragIndex !== idx ? 'ring-2 ring-purple-500 ring-offset-2 rounded-lg' : ''}`}
                                                        >
                                                            <img
                                                                src={getProgramImagePublicUrl(path)}
                                                                alt={`Gallery ${idx}`}
                                                                className="w-full h-full object-cover rounded-lg border pointer-events-none"
                                                            />
                                                            <div className="absolute top-1 left-1 bg-black/60 text-white text-xs w-5 h-5 flex items-center justify-center rounded-full font-bold">
                                                                {idx + 1}
                                                            </div>
                                                            <button
                                                                type="button"
                                                                onClick={() => handleRemoveGalleryImage(idx)}
                                                                className="absolute top-1 right-1 p-1 bg-red-600 text-white rounded-full opacity-0 group-hover:opacity-100 transition-opacity"
                                                            >
                                                                <TrashIcon className="w-4 h-4" />
                                                            </button>
                                                        </div>
                                                    ))}
                                                </div>
                                                <label className="cursor-pointer bg-purple-50 text-purple-700 px-4 py-2 rounded-lg font-medium hover:bg-purple-100 flex items-center justify-center gap-2">
                                                    <PhotoIcon className="w-5 h-5" />
                                                    <span>Pridať fotky</span>
                                                    <input
                                                        type="file"
                                                        multiple
                                                        className="hidden"
                                                        accept="image/*"
                                                        onChange={handleGalleryUpload}
                                                    />
                                                </label>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <hr className="border-gray-200" />

                                {/* SECTION: TEAM (Full width) */}
                                <div>
                                    <div className="grid grid-cols-1 lg:grid-cols-2 gap-8">
                                        {/* CAST */}
                                        <div className="bg-gray-50 p-4 rounded-xl">
                                            <div className="flex justify-between items-center mb-4">
                                                <label className="block font-bold text-gray-700">Obsadenie</label>
                                                <button type="button" onClick={handleAddCast} className="text-sm bg-purple-100 text-purple-700 px-3 py-1 rounded-full hover:bg-purple-200 font-medium">
                                                    + Pridať herca
                                                </button>
                                            </div>
                                            <div className="space-y-2 max-h-60 overflow-y-auto pr-2">
                                                {formData.cast_members && formData.cast_members.length > 0 ? (
                                                    formData.cast_members.map((member, idx) => (
                                                        <div key={idx} className="flex gap-2 items-center">
                                                            <input
                                                                type="text"
                                                                value={member}
                                                                onChange={(e) => handleUpdateCast(idx, e.target.value)}
                                                                className="flex-1 border rounded px-3 py-2 text-sm"
                                                                placeholder="Meno herca"
                                                            />
                                                            <button type="button" onClick={() => handleRemoveCast(idx)} className="text-gray-400 hover:text-red-500 p-2">
                                                                <XMarkIcon className="w-5 h-5" />
                                                            </button>
                                                        </div>
                                                    ))
                                                ) : <p className="text-gray-400 text-center py-4 italic">Zatiaľ žiadne obsadenie</p>}
                                            </div>
                                        </div>

                                        {/* TEAM */}
                                        <div className="bg-gray-50 p-4 rounded-xl">
                                            <div className="flex justify-between items-center mb-4">
                                                <label className="block font-bold text-gray-700">Inscenačný tím</label>
                                                <button type="button" onClick={handleAddTeam} className="text-sm bg-purple-100 text-purple-700 px-3 py-1 rounded-full hover:bg-purple-200 font-medium">
                                                    + Pridať člena
                                                </button>
                                            </div>
                                            <div className="space-y-2 max-h-60 overflow-y-auto pr-2">
                                                {formData.team_members && formData.team_members.length > 0 ? (
                                                    formData.team_members.map((member, idx) => (
                                                        <div key={idx} className="flex gap-2 items-center bg-white p-2 rounded border border-gray-100">
                                                            <div className="flex-1 flex gap-2">
                                                                <input
                                                                    type="text"
                                                                    value={member.role}
                                                                    onChange={(e) => handleUpdateTeam(idx, 'role', e.target.value)}
                                                                    className="flex-1 border rounded px-2 py-1 text-sm text-gray-600 bg-gray-50"
                                                                    placeholder="Rola"
                                                                />
                                                                <input
                                                                    type="text"
                                                                    value={member.name}
                                                                    onChange={(e) => handleUpdateTeam(idx, 'name', e.target.value)}
                                                                    className="flex-1 border rounded px-2 py-1 text-sm font-medium"
                                                                    placeholder="Meno"
                                                                />
                                                            </div>
                                                            <button type="button" onClick={() => handleRemoveTeam(idx)} className="text-gray-400 hover:text-red-500 p-1">
                                                                <XMarkIcon className="w-5 h-5" />
                                                            </button>
                                                        </div>
                                                    ))
                                                ) : <p className="text-gray-400 text-center py-4 italic">Zatiaľ žiadny členovia tímu</p>}
                                            </div>
                                        </div>
                                    </div>
                                </div>
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
                                {submitting ? (
                                    <div className="flex items-center gap-2">
                                        <svg className="animate-spin h-5 w-5 text-white" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                                            <circle className="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="4"></circle>
                                            <path className="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
                                        </svg>
                                        Ukladám...
                                    </div>
                                ) : (isEditMode ? 'Uložiť zmeny' : 'Vytvoriť podujatie')}
                            </button>
                        </div>
                    </div>
                </div>
            )}
        </div>
    )
}
