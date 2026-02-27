import { useState, useEffect } from 'react'
import { PlusIcon, TrashIcon, XMarkIcon, PencilIcon, PhotoIcon } from '@heroicons/react/24/outline'
import { useAuth } from '../contexts/AuthContext'
import { getRepertoarItems, createRepertoarItem, updateRepertoarItem, deleteRepertoarItem } from '../api/repertoar'
import { getProgramEvents } from '../api/programEvents'
import { uploadProgramImage, getProgramImagePublicUrl } from '../api/programStorage'
import { compressImage } from '../lib/fileUtils'

export default function LudusRepertoar() {
    const { currentSite, loading: authLoading } = useAuth()
    const [items, setItems] = useState([])
    const [loading, setLoading] = useState(false)
    const [initialLoad, setInitialLoad] = useState(true)
    const [error, setError] = useState(null)

    // Add modal
    const [showAddModal, setShowAddModal] = useState(false)
    const [availablePrograms, setAvailablePrograms] = useState([])
    const [selectedProgram, setSelectedProgram] = useState(null)
    const [yearOverride, setYearOverride] = useState('')
    const [venueOverride, setVenueOverride] = useState('')
    const [submitting, setSubmitting] = useState(false)

    // Edit modal
    const [showEditModal, setShowEditModal] = useState(false)
    const [editingItem, setEditingItem] = useState(null)
    const [editForm, setEditForm] = useState({})
    const [uploadingImage, setUploadingImage] = useState(false)

    // Drag state
    const [dragIndex, setDragIndex] = useState(null)
    const [dragOverIndex, setDragOverIndex] = useState(null)

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
                const data = await getRepertoarItems(currentSite.id)
                if (!cancelled) setItems(data)
            } catch (err) {
                if (!cancelled) setError(err.message)
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

    // --- ADD ---
    const handleOpenAdd = async () => {
        setError(null)
        try {
            const allEvents = await getProgramEvents(currentSite.id)
            const seen = new Map()
            for (const evt of allEvents) {
                if (!seen.has(evt.title)) seen.set(evt.title, evt)
            }

            const existingTitles = new Set(items.map(i => i.program_title))
            const available = Array.from(seen.values()).filter(p => !existingTitles.has(p.title))

            setAvailablePrograms(available)
            setSelectedProgram(null)
            setYearOverride('')
            setVenueOverride('')
            setShowAddModal(true)
        } catch (err) {
            setError('Chyba pri načítaní programov: ' + err.message)
        }
    }

    const handleSelectProgram = (program) => {
        setSelectedProgram(program)
        setVenueOverride(program.venue || '')
        const dateStr = program.premiere || program.event_date
        if (dateStr) {
            const year = new Date(dateStr).getFullYear()
            if (!isNaN(year)) setYearOverride(String(year))
        }
    }

    const handleAdd = async () => {
        if (!selectedProgram) return
        setSubmitting(true)
        setError(null)

        try {
            const maxOrder = items.length > 0 ? Math.max(...items.map(i => i.display_order)) : -1

            await createRepertoarItem({
                site_id: currentSite.id,
                program_title: selectedProgram.title,
                slug: selectedProgram.slug,
                subtitle: selectedProgram.subtitle || null,
                category: selectedProgram.category || null,
                year: yearOverride || null,
                venue: venueOverride || null,
                image_path: selectedProgram.image_path || null,
                gallery_paths: selectedProgram.gallery_paths || [],
                display_order: maxOrder + 1,
            })

            const data = await getRepertoarItems(currentSite.id)
            setItems(data)
            setShowAddModal(false)
        } catch (err) {
            setError('Chyba pri pridávaní: ' + err.message)
        } finally {
            setSubmitting(false)
        }
    }

    // --- EDIT ---
    const handleOpenEdit = (item) => {
        setEditingItem(item)
        setEditForm({
            program_title: item.program_title,
            subtitle: item.subtitle || '',
            year: item.year || '',
            venue: item.venue || '',
            slug: item.slug || '',
            category: item.category || '',
            image_path: item.image_path || null,
            gallery_paths: item.gallery_paths || [],
        })
        setShowEditModal(true)
    }

    const handleEditGalleryUpload = async (e) => {
        const files = Array.from(e.target.files || [])
        if (files.length === 0) return

        setUploadingImage(true)
        try {
            const newPaths = []
            for (const file of files) {
                const compressed = await compressImage(file)
                const { path } = await uploadProgramImage({
                    file: compressed,
                    siteSlug: currentSite.slug,
                    category: editForm.category || 'divadlo-ludus'
                })
                newPaths.push(path)
            }
            setEditForm(prev => ({
                ...prev,
                gallery_paths: [...(prev.gallery_paths || []), ...newPaths]
            }))
        } catch (err) {
            alert('Chyba pri nahrávaní: ' + err.message)
        } finally {
            setUploadingImage(false)
        }
    }

    const handleEditRemoveGalleryImage = (index) => {
        setEditForm(prev => ({
            ...prev,
            gallery_paths: prev.gallery_paths.filter((_, i) => i !== index)
        }))
    }

    const handleEditSave = async () => {
        if (!editingItem) return
        setSubmitting(true)
        setError(null)

        try {
            await updateRepertoarItem(editingItem.id, {
                program_title: editForm.program_title,
                subtitle: editForm.subtitle || null,
                year: editForm.year || null,
                venue: editForm.venue || null,
                slug: editForm.slug || editingItem.slug,
                image_path: (editForm.gallery_paths && editForm.gallery_paths.length > 0)
                    ? editForm.gallery_paths[0]
                    : editForm.image_path,
                gallery_paths: editForm.gallery_paths || [],
            })

            const data = await getRepertoarItems(currentSite.id)
            setItems(data)
            setShowEditModal(false)
            setEditingItem(null)
        } catch (err) {
            setError('Chyba pri ukladaní: ' + err.message)
        } finally {
            setSubmitting(false)
        }
    }

    // --- DELETE ---
    const handleDelete = async (e, id) => {
        e.stopPropagation()
        if (!confirm('Odstrániť z repertoáru?')) return
        try {
            await deleteRepertoarItem(id)
            setItems(prev => prev.filter(i => i.id !== id))
        } catch (err) {
            setError('Chyba pri mazaní: ' + err.message)
        }
    }

    // --- DRAG ---
    const handleDrop = async (fromIndex, toIndex) => {
        if (fromIndex === toIndex) return
        const updated = [...items]
        const [moved] = updated.splice(fromIndex, 1)
        updated.splice(toIndex, 0, moved)

        const reordered = updated.map((item, i) => ({ ...item, display_order: i }))
        setItems(reordered)
        setDragIndex(null)
        setDragOverIndex(null)

        try {
            await Promise.all(
                reordered.map((item, i) =>
                    updateRepertoarItem(item.id, { display_order: i })
                )
            )
        } catch (err) {
            console.error('Reorder error:', err)
        }
    }

    // --- Gallery drag in edit modal ---
    const [editDragIndex, setEditDragIndex] = useState(null)
    const [editDragOverIndex, setEditDragOverIndex] = useState(null)

    const handleEditGalleryDrop = (fromIndex, toIndex) => {
        if (fromIndex === toIndex) return
        setEditForm(prev => {
            const paths = [...(prev.gallery_paths || [])]
            const [moved] = paths.splice(fromIndex, 1)
            paths.splice(toIndex, 0, moved)
            return { ...prev, gallery_paths: paths }
        })
        setEditDragIndex(null)
        setEditDragOverIndex(null)
    }

    const categoryLabels = {
        'divadlo-ludus': 'Divadlo Ludus',
        'skola-ludus': 'Škola Ludus',
        'ludus-academy': 'Ludus Academy',
    }

    if (initialLoad || authLoading) return <div className="p-8 text-center">Načítavam...</div>
    if (!currentSite) return <div className="p-8 text-center">Vyberte stránku</div>

    return (
        <div className="p-6">
            <div className="flex justify-between items-center mb-6">
                <h1 className="text-2xl font-bold text-gray-800">Repertoár</h1>
                <button
                    onClick={handleOpenAdd}
                    className="bg-purple-600 text-white px-4 py-2 rounded-lg flex items-center gap-2 hover:bg-purple-700 transition-colors font-medium"
                >
                    <PlusIcon className="w-5 h-5" />
                    Pridať do repertoáru
                </button>
            </div>

            {error && (
                <div className="bg-red-50 text-red-700 p-3 rounded-lg mb-4 text-sm">{error}</div>
            )}

            {loading ? (
                <div className="text-center py-12 text-gray-500">Načítavam...</div>
            ) : items.length === 0 ? (
                <div className="text-center py-20 text-gray-400">
                    <p className="text-lg mb-2">Zatiaľ žiadne položky v repertoári</p>
                    <p className="text-sm">Kliknite na &quot;Pridať do repertoáru&quot; a vyberte z existujúcich programov</p>
                </div>
            ) : (
                <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
                    {items.map((item, idx) => (
                        <div
                            key={item.id}
                            draggable
                            onDragStart={() => setDragIndex(idx)}
                            onDragOver={e => { e.preventDefault(); setDragOverIndex(idx) }}
                            onDragEnd={() => { setDragIndex(null); setDragOverIndex(null) }}
                            onDrop={e => { e.preventDefault(); handleDrop(dragIndex, idx) }}
                            onClick={() => handleOpenEdit(item)}
                            className={`bg-white rounded-xl border overflow-hidden cursor-grab active:cursor-grabbing transition-all group hover:shadow-lg ${
                                dragIndex === idx ? 'opacity-40 scale-95' : ''
                            } ${dragOverIndex === idx && dragIndex !== idx ? 'ring-2 ring-purple-500 ring-offset-2' : ''}`}
                        >
                            {/* Photo */}
                            <div className="aspect-[16/9] relative bg-gray-100">
                                {item.image_path ? (
                                    <img
                                        src={getProgramImagePublicUrl(item.image_path)}
                                        alt={item.program_title}
                                        className="w-full h-full object-cover"
                                    />
                                ) : (
                                    <div className="w-full h-full flex items-center justify-center text-gray-300 text-sm">
                                        Bez fotky
                                    </div>
                                )}
                                <div className="absolute top-2 left-2 bg-black/60 text-white text-xs w-6 h-6 flex items-center justify-center rounded-full font-bold">
                                    {idx + 1}
                                </div>
                                <div className="absolute top-2 right-2 flex gap-1">
                                    <button
                                        onClick={(e) => { e.stopPropagation(); handleOpenEdit(item) }}
                                        className="p-1.5 bg-white text-gray-700 rounded-full opacity-0 group-hover:opacity-100 transition-opacity shadow"
                                    >
                                        <PencilIcon className="w-4 h-4" />
                                    </button>
                                    <button
                                        onClick={(e) => handleDelete(e, item.id)}
                                        className="p-1.5 bg-red-600 text-white rounded-full opacity-0 group-hover:opacity-100 transition-opacity"
                                    >
                                        <TrashIcon className="w-4 h-4" />
                                    </button>
                                </div>
                            </div>

                            {/* Info */}
                            <div className="p-4">
                                <h3 className="font-bold text-gray-900 text-lg leading-tight">{item.program_title}</h3>
                                {item.subtitle && (
                                    <p className="text-gray-500 text-sm mt-1">{item.subtitle}</p>
                                )}
                                <div className="flex gap-2 mt-3 flex-wrap">
                                    {item.category && (
                                        <span className="text-xs bg-purple-50 text-purple-700 px-2 py-0.5 rounded-full font-medium">
                                            {categoryLabels[item.category] || item.category}
                                        </span>
                                    )}
                                    {item.year && (
                                        <span className="text-xs bg-gray-100 text-gray-600 px-2 py-0.5 rounded-full font-medium">
                                            {item.year}
                                        </span>
                                    )}
                                    {item.venue && (
                                        <span className="text-xs bg-gray-100 text-gray-600 px-2 py-0.5 rounded-full font-medium">
                                            {item.venue}
                                        </span>
                                    )}
                                </div>
                                {item.gallery_paths && item.gallery_paths.length > 0 && (
                                    <p className="text-xs text-gray-400 mt-2">{item.gallery_paths.length} fotiek v galérii</p>
                                )}
                            </div>
                        </div>
                    ))}
                </div>
            )}

            {/* ADD MODAL */}
            {showAddModal && (
                <div className="fixed inset-0 bg-black/50 z-50 flex items-center justify-center p-4">
                    <div className="bg-white rounded-2xl w-full max-w-2xl max-h-[80vh] overflow-hidden shadow-2xl">
                        <div className="flex justify-between items-center p-6 border-b">
                            <h2 className="text-xl font-bold">Pridať do repertoáru</h2>
                            <button onClick={() => setShowAddModal(false)} className="p-1 hover:bg-gray-100 rounded-lg">
                                <XMarkIcon className="w-6 h-6" />
                            </button>
                        </div>

                        <div className="p-6 overflow-y-auto" style={{ maxHeight: 'calc(80vh - 140px)' }}>
                            {!selectedProgram ? (
                                <>
                                    <p className="text-sm text-gray-500 mb-4">Vyberte program z existujúcich:</p>
                                    {availablePrograms.length === 0 ? (
                                        <p className="text-center py-8 text-gray-400">Všetky programy sú už v repertoári</p>
                                    ) : (
                                        <div className="space-y-2">
                                            {availablePrograms.map(program => (
                                                <button
                                                    key={program.title}
                                                    onClick={() => handleSelectProgram(program)}
                                                    className="w-full text-left p-4 rounded-xl border hover:border-purple-300 hover:bg-purple-50 transition-colors flex items-center gap-4"
                                                >
                                                    {program.image_path ? (
                                                        <img
                                                            src={getProgramImagePublicUrl(program.image_path)}
                                                            alt={program.title}
                                                            className="w-16 h-12 object-cover rounded-lg shrink-0"
                                                        />
                                                    ) : (
                                                        <div className="w-16 h-12 bg-gray-100 rounded-lg shrink-0 flex items-center justify-center text-gray-300 text-xs">—</div>
                                                    )}
                                                    <div className="min-w-0">
                                                        <div className="font-bold text-gray-900">{program.title}</div>
                                                        {program.subtitle && (
                                                            <div className="text-sm text-gray-500 truncate">{program.subtitle}</div>
                                                        )}
                                                        <div className="text-xs text-gray-400 mt-0.5">
                                                            {categoryLabels[program.category] || program.category}
                                                            {program.gallery_paths?.length > 0 && ` · ${program.gallery_paths.length} fotiek`}
                                                        </div>
                                                    </div>
                                                </button>
                                            ))}
                                        </div>
                                    )}
                                </>
                            ) : (
                                <>
                                    <div className="bg-purple-50 p-4 rounded-xl mb-6">
                                        <p className="text-sm text-purple-600 font-medium mb-1">Vybraný program:</p>
                                        <p className="font-bold text-lg">{selectedProgram.title}</p>
                                        {selectedProgram.subtitle && (
                                            <p className="text-gray-600 text-sm">{selectedProgram.subtitle}</p>
                                        )}
                                    </div>

                                    <div className="grid grid-cols-2 gap-4 mb-6">
                                        <div>
                                            <label className="block text-sm font-medium text-gray-700 mb-1">Rok</label>
                                            <input
                                                type="text"
                                                value={yearOverride}
                                                onChange={e => setYearOverride(e.target.value)}
                                                placeholder="napr. 2024"
                                                className="w-full border rounded-lg px-3 py-2"
                                            />
                                        </div>
                                        <div>
                                            <label className="block text-sm font-medium text-gray-700 mb-1">Miesto</label>
                                            <input
                                                type="text"
                                                value={venueOverride}
                                                onChange={e => setVenueOverride(e.target.value)}
                                                placeholder="napr. Divadlo Ludus"
                                                className="w-full border rounded-lg px-3 py-2"
                                            />
                                        </div>
                                    </div>

                                    <div className="flex gap-3">
                                        <button
                                            onClick={() => setSelectedProgram(null)}
                                            className="px-4 py-2 border rounded-lg text-gray-600 hover:bg-gray-50"
                                        >
                                            ← Späť
                                        </button>
                                        <button
                                            onClick={handleAdd}
                                            disabled={submitting}
                                            className="px-6 py-2 bg-purple-600 text-white rounded-lg hover:bg-purple-700 disabled:opacity-50 font-medium"
                                        >
                                            {submitting ? 'Ukladám...' : 'Pridať do repertoáru'}
                                        </button>
                                    </div>
                                </>
                            )}
                        </div>
                    </div>
                </div>
            )}

            {/* EDIT MODAL */}
            {showEditModal && editingItem && (
                <div className="fixed inset-0 bg-black/50 z-50 flex items-center justify-center p-4">
                    <div className="bg-white rounded-2xl w-full max-w-3xl max-h-[85vh] overflow-hidden shadow-2xl">
                        <div className="flex justify-between items-center p-6 border-b">
                            <h2 className="text-xl font-bold">Upraviť v repertoári</h2>
                            <button onClick={() => { setShowEditModal(false); setEditingItem(null) }} className="p-1 hover:bg-gray-100 rounded-lg">
                                <XMarkIcon className="w-6 h-6" />
                            </button>
                        </div>

                        <div className="p-6 overflow-y-auto" style={{ maxHeight: 'calc(85vh - 140px)' }}>
                            <div className="space-y-5">
                                <div>
                                    <label className="block text-sm font-medium text-gray-700 mb-1">Názov (v repertoári)</label>
                                    <input
                                        type="text"
                                        value={editForm.program_title || ''}
                                        onChange={e => setEditForm(p => ({ ...p, program_title: e.target.value }))}
                                        className="w-full border rounded-lg px-3 py-2"
                                    />
                                </div>

                                <div>
                                    <label className="block text-sm font-medium text-gray-700 mb-1">Podnadpis</label>
                                    <input
                                        type="text"
                                        value={editForm.subtitle || ''}
                                        onChange={e => setEditForm(p => ({ ...p, subtitle: e.target.value }))}
                                        className="w-full border rounded-lg px-3 py-2"
                                    />
                                </div>

                                <div className="grid grid-cols-2 gap-4">
                                    <div>
                                        <label className="block text-sm font-medium text-gray-700 mb-1">Rok</label>
                                        <input
                                            type="text"
                                            value={editForm.year || ''}
                                            onChange={e => setEditForm(p => ({ ...p, year: e.target.value }))}
                                            placeholder="napr. 2024"
                                            className="w-full border rounded-lg px-3 py-2"
                                        />
                                    </div>
                                    <div>
                                        <label className="block text-sm font-medium text-gray-700 mb-1">Miesto</label>
                                        <input
                                            type="text"
                                            value={editForm.venue || ''}
                                            onChange={e => setEditForm(p => ({ ...p, venue: e.target.value }))}
                                            className="w-full border rounded-lg px-3 py-2"
                                        />
                                    </div>
                                </div>

                                <div>
                                    <label className="block text-sm font-medium text-gray-700 mb-1">Kategória</label>
                                    <select
                                        value={editForm.category || ''}
                                        onChange={e => setEditForm(p => ({ ...p, category: e.target.value }))}
                                        className="w-full border rounded-lg px-3 py-2"
                                    >
                                        <option value="divadlo-ludus">Divadlo Ludus</option>
                                        <option value="skola-ludus">Škola Ludus</option>
                                        <option value="ludus-academy">Ludus Academy</option>
                                    </select>
                                </div>

                                {/* Gallery */}
                                <div>
                                    <label className="block text-sm font-medium text-gray-700 mb-2">Fotky</label>
                                    <div className="grid grid-cols-4 gap-2 mb-3">
                                        {editForm.gallery_paths && editForm.gallery_paths.map((path, idx) => (
                                            <div
                                                key={path}
                                                draggable
                                                onDragStart={() => setEditDragIndex(idx)}
                                                onDragOver={e => { e.preventDefault(); setEditDragOverIndex(idx) }}
                                                onDragEnd={() => { setEditDragIndex(null); setEditDragOverIndex(null) }}
                                                onDrop={e => { e.preventDefault(); handleEditGalleryDrop(editDragIndex, idx) }}
                                                className={`relative group aspect-square cursor-grab active:cursor-grabbing transition-all ${
                                                    editDragIndex === idx ? 'opacity-40 scale-95' : ''
                                                } ${editDragOverIndex === idx && editDragIndex !== idx ? 'ring-2 ring-purple-500 ring-offset-2 rounded-lg' : ''}`}
                                            >
                                                <img
                                                    src={getProgramImagePublicUrl(path)}
                                                    alt={`Foto ${idx + 1}`}
                                                    className="w-full h-full object-cover rounded-lg border pointer-events-none"
                                                />
                                                <div className="absolute top-1 left-1 bg-black/60 text-white text-xs w-5 h-5 flex items-center justify-center rounded-full font-bold">
                                                    {idx + 1}
                                                </div>
                                                <button
                                                    type="button"
                                                    onClick={() => handleEditRemoveGalleryImage(idx)}
                                                    className="absolute top-1 right-1 p-1 bg-red-600 text-white rounded-full opacity-0 group-hover:opacity-100 transition-opacity"
                                                >
                                                    <TrashIcon className="w-3 h-3" />
                                                </button>
                                            </div>
                                        ))}
                                    </div>
                                    <label className="cursor-pointer bg-purple-50 text-purple-700 px-4 py-2 rounded-lg font-medium hover:bg-purple-100 flex items-center justify-center gap-2">
                                        <PhotoIcon className="w-5 h-5" />
                                        <span>{uploadingImage ? 'Nahrávam...' : 'Pridať fotky'}</span>
                                        <input
                                            type="file"
                                            multiple
                                            className="hidden"
                                            accept="image/*"
                                            onChange={handleEditGalleryUpload}
                                            disabled={uploadingImage}
                                        />
                                    </label>
                                </div>
                            </div>

                            <div className="flex gap-3 mt-8 pt-6 border-t">
                                <button
                                    onClick={() => { setShowEditModal(false); setEditingItem(null) }}
                                    className="px-4 py-2 border rounded-lg text-gray-600 hover:bg-gray-50"
                                >
                                    Zrušiť
                                </button>
                                <button
                                    onClick={handleEditSave}
                                    disabled={submitting}
                                    className="px-6 py-2 bg-purple-600 text-white rounded-lg hover:bg-purple-700 disabled:opacity-50 font-medium"
                                >
                                    {submitting ? 'Ukladám...' : 'Uložiť zmeny'}
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            )}
        </div>
    )
}
