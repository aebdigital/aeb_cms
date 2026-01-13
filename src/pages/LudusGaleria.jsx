import { useState, useEffect } from 'react'
import { PlusIcon, TrashIcon, XMarkIcon } from '@heroicons/react/24/outline'
import { useAuth } from '../contexts/AuthContext'
import { getGalleryImages, createGalleryImage, updateGalleryImage, deleteGalleryImage, reorderGalleryImages, GALLERY_CATEGORIES } from '../api/galleryImages'
import { uploadGalleryImage, deleteGalleryImageFromStorage, getGalleryImagePublicUrl } from '../api/galleryStorage'
import { compressImage } from '../lib/fileUtils'

export default function LudusGaleria() {
  const { currentSite, loading: authLoading } = useAuth()
  const [images, setImages] = useState([])
  const [loading, setLoading] = useState(false)
  const [initialLoad, setInitialLoad] = useState(true)
  const [error, setError] = useState(null)
  const [activeCategory, setActiveCategory] = useState('skola-ludus')
  const [showUploadModal, setShowUploadModal] = useState(false)
  const [uploading, setUploading] = useState(false)
  const [uploadProgress, setUploadProgress] = useState('')
  const [pendingFiles, setPendingFiles] = useState([])
  const [editingImage, setEditingImage] = useState(null)
  const [editAltText, setEditAltText] = useState('')

  // Load images when site or category changes
  useEffect(() => {
    if (authLoading || !currentSite?.id) {
      if (!authLoading && !currentSite?.id) {
        setInitialLoad(false)
      }
      return
    }

    let cancelled = false

    async function loadImages() {
      setLoading(true)
      setError(null)

      try {
        const data = await getGalleryImages(currentSite.id, activeCategory)
        if (!cancelled) {
          setImages(data)
        }
      } catch (err) {
        console.error('Error loading gallery images:', err)
        if (!cancelled) {
          setError(err.message || 'Chyba pri nacitavani obrazkov')
        }
      } finally {
        if (!cancelled) {
          setLoading(false)
          setInitialLoad(false)
        }
      }
    }

    loadImages()

    return () => {
      cancelled = true
    }
  }, [currentSite?.id, activeCategory, authLoading])

  const handleFileSelect = (e) => {
    const files = Array.from(e.target.files || [])
    setPendingFiles(prev => [...prev, ...files])
    e.target.value = ''
  }

  const removePendingFile = (index) => {
    setPendingFiles(prev => prev.filter((_, i) => i !== index))
  }

  const handleUpload = async () => {
    if (pendingFiles.length === 0) return

    setUploading(true)
    setUploadProgress('Pripravujem obrazky...')

    try {
      const currentOrder = images.length

      for (let i = 0; i < pendingFiles.length; i++) {
        setUploadProgress(`Komprimujem obrazok ${i + 1}/${pendingFiles.length}...`)
        const compressed = await compressImage(pendingFiles[i])

        setUploadProgress(`Nahravanie ${i + 1}/${pendingFiles.length}...`)
        const { path } = await uploadGalleryImage({
          file: compressed,
          siteSlug: currentSite.slug,
          category: activeCategory
        })

        await createGalleryImage({
          site_id: currentSite.id,
          category: activeCategory,
          image_path: path,
          alt_text: null,
          display_order: currentOrder + i
        })
      }

      // Reload images
      const data = await getGalleryImages(currentSite.id, activeCategory)
      setImages(data)
      setPendingFiles([])
      setShowUploadModal(false)
      setUploadProgress('')
    } catch (err) {
      console.error('Upload error:', err)
      setError(err.message || 'Chyba pri nahravani')
    } finally {
      setUploading(false)
      setUploadProgress('')
    }
  }

  const handleDelete = async (image) => {
    if (!confirm('Naozaj chcete vymazat tento obrazok?')) return

    try {
      await deleteGalleryImageFromStorage(image.image_path)
      await deleteGalleryImage(image.id)
      setImages(prev => prev.filter(img => img.id !== image.id))
    } catch (err) {
      console.error('Delete error:', err)
      setError(err.message || 'Chyba pri mazani')
    }
  }

  const handleEditAltText = async () => {
    if (!editingImage) return

    try {
      await updateGalleryImage(editingImage.id, { alt_text: editAltText })
      setImages(prev => prev.map(img =>
        img.id === editingImage.id ? { ...img, alt_text: editAltText } : img
      ))
      setEditingImage(null)
      setEditAltText('')
    } catch (err) {
      console.error('Update error:', err)
      setError(err.message || 'Chyba pri aktualizacii')
    }
  }

  const openEditModal = (image) => {
    setEditingImage(image)
    setEditAltText(image.alt_text || '')
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

    const newImages = [...images]
    const [draggedItem] = newImages.splice(draggedIndex, 1)
    newImages.splice(dropIndex, 0, draggedItem)

    // Update display_order
    const reorderedImages = newImages.map((img, idx) => ({
      ...img,
      display_order: idx
    }))

    setImages(reorderedImages)
    setDraggedIndex(null)

    // Save to database
    try {
      await reorderGalleryImages(reorderedImages.map(img => ({
        id: img.id,
        display_order: img.display_order
      })))
    } catch (err) {
      console.error('Reorder error:', err)
      // Reload on error
      const data = await getGalleryImages(currentSite.id, activeCategory)
      setImages(data)
    }
  }

  if (initialLoad || authLoading) {
    return (
      <div className="flex items-center justify-center h-64">
        <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-purple-600"></div>
      </div>
    )
  }

  if (!currentSite) {
    return (
      <div className="flex items-center justify-center h-64">
        <p className="text-gray-500">Vyberte stranku pre zobrazenie galerie</p>
      </div>
    )
  }

  return (
    <div className="p-6">
      <div className="flex justify-between items-center mb-6">
        <h1 className="text-2xl font-bold text-gray-800">Galeria</h1>
        <button
          onClick={() => setShowUploadModal(true)}
          className="flex items-center gap-2 bg-purple-600 hover:bg-purple-700 text-white px-4 py-2 rounded-lg font-semibold transition-colors"
        >
          <PlusIcon className="w-5 h-5" />
          Pridat fotky
        </button>
      </div>

      {error && (
        <div className="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-6">
          {error}
          <button onClick={() => setError(null)} className="float-right font-bold">&times;</button>
        </div>
      )}

      {/* Category Tabs */}
      <div className="flex gap-2 mb-6 flex-wrap">
        {GALLERY_CATEGORIES.map(cat => (
          <button
            key={cat.value}
            onClick={() => setActiveCategory(cat.value)}
            className={`px-4 py-2 rounded-lg font-medium transition-colors ${
              activeCategory === cat.value
                ? 'bg-purple-600 text-white'
                : 'bg-gray-100 text-gray-700 hover:bg-gray-200'
            }`}
          >
            {cat.label}
          </button>
        ))}
      </div>

      {/* Image Grid */}
      {loading ? (
        <div className="flex items-center justify-center h-64">
          <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-purple-600"></div>
        </div>
      ) : images.length === 0 ? (
        <div className="text-center py-12 bg-white rounded-xl shadow">
          <p className="text-gray-500 mb-4">Ziadne fotky v tejto kategorii</p>
          <button
            onClick={() => setShowUploadModal(true)}
            className="text-purple-600 hover:text-purple-700 font-medium"
          >
            Nahrat prve fotky
          </button>
        </div>
      ) : (
        <div className="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-4 xl:grid-cols-5 gap-4">
          {images.map((image, index) => (
            <div
              key={image.id}
              draggable
              onDragStart={(e) => handleDragStart(e, index)}
              onDragOver={handleDragOver}
              onDrop={(e) => handleDrop(e, index)}
              onDragEnd={() => setDraggedIndex(null)}
              className={`relative group bg-white rounded-lg shadow overflow-hidden cursor-move ${
                draggedIndex === index ? 'opacity-50' : ''
              }`}
            >
              <img
                src={getGalleryImagePublicUrl(image.image_path)}
                alt={image.alt_text || 'Gallery image'}
                className="w-full h-40 object-cover"
              />
              <div className="absolute inset-0 bg-black bg-opacity-0 group-hover:bg-opacity-40 transition-all flex items-center justify-center gap-2 opacity-0 group-hover:opacity-100">
                <button
                  onClick={() => openEditModal(image)}
                  className="p-2 bg-white rounded-full text-gray-700 hover:bg-gray-100"
                  title="Upravit alt text"
                >
                  <svg className="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M15.232 5.232l3.536 3.536m-2.036-5.036a2.5 2.5 0 113.536 3.536L6.5 21.036H3v-3.572L16.732 3.732z" />
                  </svg>
                </button>
                <button
                  onClick={() => handleDelete(image)}
                  className="p-2 bg-white rounded-full text-red-600 hover:bg-red-50"
                  title="Vymazat"
                >
                  <TrashIcon className="w-4 h-4" />
                </button>
              </div>
              {image.alt_text && (
                <div className="absolute bottom-0 left-0 right-0 bg-black bg-opacity-60 text-white text-xs p-1 truncate">
                  {image.alt_text}
                </div>
              )}
            </div>
          ))}
        </div>
      )}

      {/* Upload Modal */}
      {showUploadModal && (
        <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 p-4">
          <div className="bg-white rounded-xl shadow-xl max-w-lg w-full max-h-[90vh] overflow-y-auto">
            <div className="flex justify-between items-center p-4 border-b">
              <h2 className="text-lg font-semibold">Nahrat fotky do: {GALLERY_CATEGORIES.find(c => c.value === activeCategory)?.label}</h2>
              <button onClick={() => { setShowUploadModal(false); setPendingFiles([]) }}>
                <XMarkIcon className="w-6 h-6 text-gray-500 hover:text-gray-700" />
              </button>
            </div>

            <div className="p-4">
              <div className="border-2 border-dashed border-gray-300 rounded-lg p-8 text-center mb-4">
                <input
                  type="file"
                  accept="image/*"
                  multiple
                  onChange={handleFileSelect}
                  className="hidden"
                  id="file-upload"
                />
                <label htmlFor="file-upload" className="cursor-pointer">
                  <div className="text-gray-500">
                    <svg className="mx-auto h-12 w-12 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M4 16l4.586-4.586a2 2 0 012.828 0L16 16m-2-2l1.586-1.586a2 2 0 012.828 0L20 14m-6-6h.01M6 20h12a2 2 0 002-2V6a2 2 0 00-2-2H6a2 2 0 00-2 2v12a2 2 0 002 2z" />
                    </svg>
                    <p className="mt-2">Kliknite pre vyber alebo pretiahnite fotky</p>
                  </div>
                </label>
              </div>

              {/* Pending files list */}
              {pendingFiles.length > 0 && (
                <div className="space-y-2 mb-4">
                  <p className="text-sm font-medium text-gray-700">{pendingFiles.length} fotiek na nahratie:</p>
                  {pendingFiles.map((file, index) => (
                    <div key={index} className="flex items-center justify-between bg-gray-50 p-2 rounded">
                      <span className="text-sm truncate flex-1">{file.name}</span>
                      <button
                        onClick={() => removePendingFile(index)}
                        className="text-red-500 hover:text-red-700 ml-2"
                      >
                        <XMarkIcon className="w-4 h-4" />
                      </button>
                    </div>
                  ))}
                </div>
              )}

              {uploadProgress && (
                <div className="mb-4 text-center text-purple-600 font-medium">
                  {uploadProgress}
                </div>
              )}

              <div className="flex gap-2">
                <button
                  onClick={() => { setShowUploadModal(false); setPendingFiles([]) }}
                  className="flex-1 px-4 py-2 border border-gray-300 rounded-lg text-gray-700 hover:bg-gray-50"
                  disabled={uploading}
                >
                  Zrusit
                </button>
                <button
                  onClick={handleUpload}
                  disabled={pendingFiles.length === 0 || uploading}
                  className="flex-1 px-4 py-2 bg-purple-600 text-white rounded-lg hover:bg-purple-700 disabled:bg-purple-400"
                >
                  {uploading ? 'Nahravanie...' : 'Nahrat'}
                </button>
              </div>
            </div>
          </div>
        </div>
      )}

      {/* Edit Alt Text Modal */}
      {editingImage && (
        <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 p-4">
          <div className="bg-white rounded-xl shadow-xl max-w-md w-full">
            <div className="flex justify-between items-center p-4 border-b">
              <h2 className="text-lg font-semibold">Upravit popis obrazka</h2>
              <button onClick={() => setEditingImage(null)}>
                <XMarkIcon className="w-6 h-6 text-gray-500 hover:text-gray-700" />
              </button>
            </div>

            <div className="p-4">
              <img
                src={getGalleryImagePublicUrl(editingImage.image_path)}
                alt=""
                className="w-full h-40 object-cover rounded-lg mb-4"
              />
              <label className="block text-sm font-medium text-gray-700 mb-1">
                Alt text (popis pre vyhladavace)
              </label>
              <input
                type="text"
                value={editAltText}
                onChange={(e) => setEditAltText(e.target.value)}
                className="w-full border border-gray-300 rounded-lg px-3 py-2 focus:ring-2 focus:ring-purple-500 focus:border-transparent"
                placeholder="Popis obrazka..."
              />

              <div className="flex gap-2 mt-4">
                <button
                  onClick={() => setEditingImage(null)}
                  className="flex-1 px-4 py-2 border border-gray-300 rounded-lg text-gray-700 hover:bg-gray-50"
                >
                  Zrusit
                </button>
                <button
                  onClick={handleEditAltText}
                  className="flex-1 px-4 py-2 bg-purple-600 text-white rounded-lg hover:bg-purple-700"
                >
                  Ulozit
                </button>
              </div>
            </div>
          </div>
        </div>
      )}
    </div>
  )
}
