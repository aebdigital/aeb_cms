import { useState, useEffect } from 'react'
import { PlusIcon, TrashIcon, XMarkIcon, PhotoIcon, ArrowUpTrayIcon } from '@heroicons/react/24/outline'
import { useAuth } from '../contexts/AuthContext'
import { 
  listLuskReferences, 
  createLuskReference, 
  updateLuskReference, 
  deleteLuskReference, 
  reorderLuskReferences,
  uploadLuskImage
} from '../api/luskReferences'
import { compressImage } from '../lib/fileUtils'

const LUSK_CATEGORIES = [
  { value: 'maria-theresa', label: 'Maria Theresa', hasTitles: false },
  { value: 'glass-arm', label: 'Glass Arm', hasTitles: false },
  { value: 'brilliant-collection', label: 'Brilliant Collection', hasTitles: false },
  { value: 'brass-arm', label: 'Brass Arm', hasTitles: false },
  { value: 'ostatne', label: 'Realizácie', hasTitles: true },
]

export default function LuskReferences({ mode = 'kolekcie' }) {
  const isKolekcie = mode === 'kolekcie'
  const filteredCategories = LUSK_CATEGORIES.filter(cat => 
    isKolekcie ? cat.hasTitles === false : cat.hasTitles === true
  )

  const { currentSite, loading: authLoading } = useAuth()
  const [references, setReferences] = useState([])
  const [loading, setLoading] = useState(false)
  const [initialLoad, setInitialLoad] = useState(true)
  const [error, setError] = useState(null)
  const [activeCategory, setActiveCategory] = useState(filteredCategories[0]?.value || 'maria-theresa')
  const [showEditModal, setShowEditModal] = useState(false)
  const [saving, setSaving] = useState(false)
  
  const [editingRef, setEditingRef] = useState(null)
  const [refTitle, setRefTitle] = useState('')
  const [refCategory, setRefCategory] = useState(filteredCategories[0]?.value || 'maria-theresa')
  const [previewImage, setPreviewImage] = useState(null)
  const [lightboxImage, setLightboxImage] = useState(null)
  const [previewFile, setPreviewFile] = useState(null)
  const [lightboxFile, setLightboxFile] = useState(null)

  // Load references when site or category changes
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
        const data = await listLuskReferences(currentSite.id, activeCategory)
        if (!cancelled) setReferences(data)
      } catch (err) {
        console.error('Error loading lusk references:', err)
        if (!cancelled) setError(err.message || 'Chyba pri načítaní referencií')
      } finally {
        if (!cancelled) {
          setLoading(false)
          setInitialLoad(false)
        }
      }
    }

    loadData()
    return () => { cancelled = true }
  }, [currentSite?.id, activeCategory, authLoading])

  const openAddModal = () => {
    setEditingRef(null)
    setRefTitle('')
    setRefCategory(activeCategory)
    setPreviewImage(null)
    setLightboxImage(null)
    setPreviewFile(null)
    setLightboxFile(null)
    setShowEditModal(true)
  }

  const openEditModal = (ref) => {
    setEditingRef(ref)
    setRefTitle(ref.title)
    setRefCategory(ref.category)
    setPreviewImage(ref.image_url)
    setLightboxImage(ref.lightbox_url)
    setPreviewFile(null)
    setLightboxFile(null)
    setShowEditModal(true)
  }

  const handleSave = async () => {
    const activeCatInfo = LUSK_CATEGORIES.find(c => c.value === refCategory)
    if (activeCatInfo?.hasTitles && !refTitle) return alert('Zadajte názov realizácie')
    if (!currentSite?.id) return

    setSaving(true)
    try {
      let finalPreviewUrl = previewImage
      let finalLightboxUrl = lightboxImage

      // Upload images if they were changed
      if (previewFile) {
        const compressed = await compressImage(previewFile)
        finalPreviewUrl = await uploadLuskImage(compressed, currentSite.slug, 'preview')
      }
      if (lightboxFile) {
        const compressed = await compressImage(lightboxFile)
        finalLightboxUrl = await uploadLuskImage(compressed, currentSite.slug, 'lightbox')
      }

      const payload = {
        site_id: currentSite.id,
        title: refTitle,
        category: refCategory,
        image_url: finalPreviewUrl,
        lightbox_url: finalLightboxUrl,
        display_order: editingRef ? editingRef.display_order : references.length
      }

      if (editingRef) {
        const updated = await updateLuskReference(editingRef.id, payload)
        setReferences(prev => prev.map(r => r.id === updated.id ? updated : r))
      } else {
        const created = await createLuskReference(payload)
        if (activeCategory === refCategory) {
          setReferences(prev => [...prev, created])
        }
      }

      setShowEditModal(false)
    } catch (err) {
      console.error('Save error:', err)
      alert('Chyba pri ukladaní: ' + err.message)
    } finally {
      setSaving(false)
    }
  }

  const handleDelete = async (id) => {
    if (!confirm('Naozaj chcete vymazať túto referenciu?')) return
    try {
      await deleteLuskReference(id)
      setReferences(prev => prev.filter(r => r.id !== id))
    } catch (err) {
      console.error('Delete error:', err)
      alert('Chyba pri mazaní: ' + err.message)
    }
  }

  // Drag and drop for reordering
  const [draggedIndex, setDraggedIndex] = useState(null)
  const handleDragStart = (e, index) => {
    setDraggedIndex(index)
    e.dataTransfer.effectAllowed = 'move'
  }
  const handleDragOver = (e) => {
    e.preventDefault()
    e.dataTransfer.dropEffect = 'move'
  }
  const handleDrop = async (e, dropIndex) => {
    e.preventDefault()
    if (draggedIndex === null || draggedIndex === dropIndex) {
      setDraggedIndex(null)
      return
    }

    const newRefs = [...references]
    const [draggedItem] = newRefs.splice(draggedIndex, 1)
    newRefs.splice(dropIndex, 0, draggedItem)

    const reordered = newRefs.map((r, idx) => ({ ...r, display_order: idx }))
    setReferences(reordered)
    setDraggedIndex(null)

    try {
      await reorderLuskReferences(reordered.map(r => ({ id: r.id, display_order: r.display_order })))
    } catch (err) {
      console.error('Reorder error:', err)
      // Refresh on error
      const data = await listLuskReferences(currentSite.id, activeCategory)
      setReferences(data)
    }
  }

  if (initialLoad || authLoading) {
    return (
      <div className="flex items-center justify-center h-64">
        <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-amber-600"></div>
      </div>
    )
  }

  return (
    <div className="p-6 max-w-7xl mx-auto">
      <div className="flex justify-between items-center mb-8">
        <div>
          <h1 className="text-3xl font-bold text-slate-900">
            {isKolekcie ? 'Lusk Kolekcie' : 'Lusk Realizácie'}
          </h1>
          <p className="text-slate-500 mt-1">
            {isKolekcie ? 'Spravujte 4 hlavné kategórie lustrov' : 'Spravujte ostatné realizácie a projekty'}
          </p>
        </div>
        <button
          onClick={openAddModal}
          className="flex items-center gap-2 bg-amber-600 hover:bg-amber-700 text-white px-5 py-2.5 rounded-xl font-semibold shadow-lg shadow-amber-200 transition-all transform hover:scale-105 active:scale-95"
        >
          <PlusIcon className="w-5 h-5" />
          Pridať referenciu
        </button>
      </div>

      {/* Category Tabs - Only show if mode has multiple categories */}
      {filteredCategories.length > 1 && (
        <div className="flex gap-2 mb-8 flex-wrap">
          {filteredCategories.map(cat => (
            <button
              key={cat.value}
              onClick={() => setActiveCategory(cat.value)}
              className={`px-5 py-2.5 rounded-xl font-medium transition-all ${
                activeCategory === cat.value
                  ? 'bg-slate-900 text-white shadow-md'
                  : 'bg-white text-slate-600 border border-slate-200 hover:bg-slate-50'
              }`}
            >
              {cat.label}
            </button>
          ))}
        </div>
      )}

      {error && (
        <div className="bg-red-50 border-l-4 border-red-500 text-red-700 p-4 rounded-r-lg mb-8 flex items-center justify-between">
          <span>{error}</span>
          <button onClick={() => setError(null)} className="text-red-500 hover:text-red-700 font-bold">&times;</button>
        </div>
      )}

      {loading ? (
        <div className="flex items-center justify-center h-64">
          <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-amber-600"></div>
        </div>
      ) : references.length === 0 ? (
        <div className="bg-white border-2 border-dashed border-slate-200 rounded-3xl py-20 px-6 text-center">
          <PhotoIcon className="w-16 h-16 text-slate-300 mx-auto mb-4" />
          <h3 className="text-lg font-medium text-slate-900 mb-1">Žiadne referencie</h3>
          <p className="text-slate-500 mb-6">V tejto kategórii zatiaľ nie sú žiadne realizácie.</p>
          <button
            onClick={openAddModal}
            className="text-amber-600 hover:text-amber-700 font-semibold"
          >
            Vytvorte prvú referenciu
          </button>
        </div>
      ) : (
        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-6">
          {references.map((ref, index) => (
            <div
              key={ref.id}
              draggable
              onDragStart={(e) => handleDragStart(e, index)}
              onDragOver={handleDragOver}
              onDrop={(e) => handleDrop(e, index)}
              onDragEnd={() => setDraggedIndex(null)}
              className={`group bg-white rounded-2xl border border-slate-100 shadow-sm overflow-hidden hover:shadow-xl hover:shadow-slate-200/50 transition-all duration-300 transform cursor-move ${
                draggedIndex === index ? 'opacity-30 scale-95' : 'hover:-translate-y-1'
              }`}
            >
              <div className="aspect-[4/3] relative overflow-hidden bg-slate-100">
                {ref.image_url ? (
                  <img
                    src={ref.image_url}
                    alt={ref.title}
                    className="w-full h-full object-contain transition-transform duration-500 group-hover:scale-110"
                  />
                ) : (
                  <div className="w-full h-full flex items-center justify-center text-slate-400">
                    <PhotoIcon className="w-10 h-10" />
                  </div>
                )}
                <div className="absolute inset-0 bg-slate-900/40 opacity-0 group-hover:opacity-100 transition-all flex items-center justify-center gap-3">
                  <button
                    onClick={() => openEditModal(ref)}
                    className="p-2.5 bg-white rounded-full text-slate-700 hover:bg-amber-50 hover:text-amber-600 transition-colors shadow-lg"
                    title="Upraviť"
                  >
                    <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M15.232 5.232l3.536 3.536m-2.036-5.036a2.5 2.5 0 113.536 3.536L6.5 21.036H3v-3.572L16.732 3.732z" />
                    </svg>
                  </button>
                  <button
                    onClick={() => handleDelete(ref.id)}
                    className="p-2.5 bg-white rounded-full text-red-600 hover:bg-red-50 transition-colors shadow-lg"
                    title="Vymazať"
                  >
                    <TrashIcon className="w-5 h-5" />
                  </button>
                </div>
              </div>
              <div className="p-2">
                {LUSK_CATEGORIES.find(c => c.value === activeCategory)?.hasTitles && (
                  <h3 className="font-bold text-slate-900 truncate">{ref.title}</h3>
                )}
              </div>
            </div>
          ))}
        </div>
      )}

      {/* Modal - Unified for Add/Edit */}
      {showEditModal && (
        <div className="fixed inset-0 bg-slate-900/60 backdrop-blur-sm flex items-center justify-center z-50 p-4">
          <div className="bg-white rounded-3xl shadow-2xl max-w-2xl w-full max-h-[90vh] overflow-y-auto overflow-x-hidden transform animate-in fade-in zoom-in duration-200">
            <div className="flex justify-between items-center p-6 border-b border-slate-100 sticky top-0 bg-white z-10">
              <h2 className="text-xl font-bold text-slate-900">
                {editingRef ? 'Upraviť referenciu' : 'Nová referencia'}
              </h2>
              <button 
                onClick={() => setShowEditModal(false)}
                className="p-2 hover:bg-slate-100 rounded-full text-slate-400 hover:text-slate-600 transition-colors"
              >
                <XMarkIcon className="w-6 h-6" />
              </button>
            </div>

            <div className="p-6 space-y-6">
              {LUSK_CATEGORIES.find(c => c.value === refCategory)?.hasTitles && (
                <div>
                  <label className="block text-sm font-bold text-slate-700 mb-2 uppercase tracking-wider">
                    Názov realizácie
                  </label>
                  <input
                    type="text"
                    value={refTitle}
                    onChange={(e) => setRefTitle(e.target.value)}
                    className="w-full bg-slate-50 border border-slate-200 rounded-xl px-4 py-3 focus:outline-none focus:ring-2 focus:ring-amber-500 focus:bg-white transition-all"
                    placeholder="Napr. Showroom Praha"
                  />
                </div>
              )}

              <div>
                <label className="block text-sm font-bold text-slate-700 mb-2 uppercase tracking-wider">
                  Kategória
                </label>
                <select
                  value={refCategory}
                  onChange={(e) => setRefCategory(e.target.value)}
                  className="w-full bg-slate-50 border border-slate-200 rounded-xl px-4 py-3 focus:outline-none focus:ring-2 focus:ring-amber-500 focus:bg-white transition-all appearance-none"
                >
                  {filteredCategories.map(c => (
                    <option key={c.value} value={c.value}>{c.label}</option>
                  ))}
                </select>
              </div>

              <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
                {/* Preview Photo */}
                <div>
                  <label className="block text-sm font-bold text-slate-700 mb-2 uppercase tracking-wider">
                    Náhľadová fotka (karta)
                  </label>
                  <div className="relative group aspect-[4/3] rounded-2xl border-2 border-dashed border-slate-200 overflow-hidden bg-slate-50 flex flex-col items-center justify-center cursor-pointer hover:border-amber-400 hover:bg-amber-50/30 transition-all">
                    {previewImage ? (
                      <img src={previewImage} alt="Preview" className="w-full h-full object-cover" />
                    ) : (
                      <div className="text-center p-4">
                        <PhotoIcon className="w-10 h-10 text-slate-300 mx-auto mb-2" />
                        <span className="text-xs text-slate-500">Kliknite pre nahratie</span>
                      </div>
                    )}
                    <input
                      type="file"
                      accept="image/*"
                      onChange={(e) => {
                        const file = e.target.files[0];
                        if (file) {
                          setPreviewFile(file);
                          setPreviewImage(URL.createObjectURL(file));
                        }
                      }}
                      className="absolute inset-0 opacity-0 cursor-pointer"
                    />
                    {previewImage && (
                      <div className="absolute top-2 right-2 flex gap-1">
                        <div className="bg-amber-600 text-white p-1.5 rounded-lg shadow-lg">
                          <ArrowUpTrayIcon className="w-4 h-4" />
                        </div>
                      </div>
                    )}
                  </div>
                </div>

                {/* Lightbox Photo */}
                <div>
                  <label className="block text-sm font-bold text-slate-700 mb-2 uppercase tracking-wider">
                    Lightbox fotka (veľký detail)
                  </label>
                  <div className="relative group aspect-[4/3] rounded-2xl border-2 border-dashed border-slate-200 overflow-hidden bg-slate-50 flex flex-col items-center justify-center cursor-pointer hover:border-amber-400 hover:bg-amber-50/30 transition-all">
                    {lightboxImage ? (
                      <img src={lightboxImage} alt="Lightbox" className="w-full h-full object-cover" />
                    ) : (
                      <div className="text-center p-4">
                        <PhotoIcon className="w-10 h-10 text-slate-300 mx-auto mb-2" />
                        <span className="text-xs text-slate-500">Kliknite pre nahratie</span>
                      </div>
                    )}
                    <input
                      type="file"
                      accept="image/*"
                      onChange={(e) => {
                        const file = e.target.files[0];
                        if (file) {
                          setLightboxFile(file);
                          setLightboxImage(URL.createObjectURL(file));
                        }
                      }}
                      className="absolute inset-0 opacity-0 cursor-pointer"
                    />
                    {lightboxImage && (
                      <div className="absolute top-2 right-2 flex gap-1">
                        <div className="bg-amber-600 text-white p-1.5 rounded-lg shadow-lg">
                          <ArrowUpTrayIcon className="w-4 h-4" />
                        </div>
                      </div>
                    )}
                  </div>
                </div>
              </div>
            </div>

            <div className="p-6 border-t border-slate-100 bg-slate-50/50 sticky bottom-0 z-10 flex gap-4">
              <button
                onClick={() => setShowEditModal(false)}
                className="flex-1 px-6 py-3 border border-slate-200 rounded-xl text-slate-700 font-semibold hover:bg-white hover:border-slate-300 transition-all"
                disabled={saving}
              >
                Zrušiť
              </button>
              <button
                onClick={handleSave}
                disabled={saving || !refTitle}
                className="flex-3 px-10 py-3 bg-amber-600 text-white rounded-xl font-bold hover:bg-amber-700 disabled:opacity-50 disabled:cursor-not-allowed shadow-lg shadow-amber-200 transition-all flex items-center justify-center gap-2"
              >
                {saving && <div className="w-4 h-4 border-2 border-white/30 border-t-white rounded-full animate-spin"></div>}
                {saving ? 'Ukladám...' : (editingRef ? 'Uložiť zmeny' : 'Vytvoriť referenciu')}
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  )
}
