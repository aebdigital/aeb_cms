import { useState, useEffect } from 'react'
import { createPortal } from 'react-dom'
import { 
  PlusIcon, 
  TrashIcon, 
  XMarkIcon, 
  PhotoIcon, 
  PencilSquareIcon,
  ArrowLongLeftIcon,
  MagnifyingGlassIcon,
  StarIcon
} from '@heroicons/react/24/outline'
import { useAuth } from '../contexts/AuthContext'
import { useNotification } from '../contexts/NotificationContext'
import { t } from '../i18n/translations'
import { 
  getProjects, 
  createProject, 
  updateProject, 
  deleteProject,
  uploadProjectImage,
  getPublicUrl
} from '../api'
import LegisBlogRichTextEditor from '../components/LegisBlogRichTextEditor'

export default function Projekty() {
  const { currentSite, loading: authLoading, profile } = useAuth()
  const { showNotification } = useNotification()
  const lang = profile?.lang || 'sk'

  const [projects, setProjects] = useState([])
  const [loading, setLoading] = useState(false)
  const [initialLoad, setInitialLoad] = useState(true)
  const [showModal, setShowModal] = useState(false)
  const [editingProject, setEditingProject] = useState(null)
  const [searchTerm, setSearchTerm] = useState('')
  const [showSuccessAnim, setShowSuccessAnim] = useState(false)

  // Form State
  const [formData, setFormData] = useState({
    title: '',
    category: '',
    year: new Date().getFullYear(),
    location: '',
    date: '',
    description: '',
    preview_photo: '',
    images: [],
    seo: { metaDescription: '', keywords: '' }
  })

  useEffect(() => {
    if (currentSite?.id) {
      loadProjects()
    }
  }, [currentSite?.id])

  async function loadProjects() {
    setLoading(true)
    try {
      const data = await getProjects(currentSite.id)
      setProjects(data)
    } catch (err) {
      console.error('Error loading projects:', err)
      showNotification(t('chybaPriNacitavani', lang), 'error')
    } finally {
      setLoading(false)
      setInitialLoad(false)
    }
  }

  const openAddModal = () => {
    setEditingProject(null)
    setFormData({
      title: '',
      category: '',
      year: new Date().getFullYear(),
      location: '',
      date: '',
      description: '',
      preview_photo: '',
      images: [],
      seo: { metaDescription: '', keywords: '' }
    })
    setShowModal(true)
  }

  const openEditModal = (project) => {
    setEditingProject(project)
    setFormData({
      ...project,
      preview_photo: project.preview_photo || project.heroImage || '',
      images: project.images || [],
      seo: project.seo || { metaDescription: '', keywords: '' }
    })
    setShowModal(true)
  }

  const handleInputChange = (field, value) => {
    if (field.includes('.')) {
      const [parent, child] = field.split('.')
      setFormData(prev => ({
        ...prev,
        [parent]: { ...prev[parent], [child]: value }
      }))
    } else {
      setFormData(prev => ({ ...prev, [field]: value }))
    }
  }

  const handleFileUpload = async (e, type, index = null) => {
    const files = Array.from(e.target.files || [])
    if (files.length === 0) return

    try {
      const paths = []
      for (const file of files) {
        const { path } = await uploadProjectImage({
          file,
          siteSlug: currentSite.slug,
          projectId: editingProject?.id
        })
        paths.push(getPublicUrl(path))
      }

      if (type === 'preview') {
        setFormData(prev => ({ ...prev, preview_photo: paths[0] }))
      } else if (type === 'gallery') {
        setFormData(prev => ({ 
          ...prev, 
          images: [...prev.images, ...paths] 
        }))
      }
    } catch (err) {
      console.error('Upload error:', err)
      showNotification(t('chybaPriNahravani', lang), 'error')
    }
    // Reset input
    e.target.value = ''
  }

  const removeGalleryImage = (index) => {
    setFormData(prev => ({
      ...prev,
      images: prev.images.filter((_, i) => i !== index)
    }))
  }

  const handleSubmit = async (e) => {
    e.preventDefault()
    setLoading(true)

    try {
      // Clean payload for DB - only include columns that exist in public.projects
      const payload = {
        site_id: currentSite.id,
        title: formData.title,
        category: formData.category,
        year: formData.year,
        location: formData.location,
        date: formData.date,
        description: formData.description,
        hero_image: formData.preview_photo,
        images: formData.images,
        seo: formData.seo
      }

      if (editingProject) {
        await updateProject(editingProject.id, payload)
        showNotification(t('ulozene', lang), 'success')
      } else {
        await createProject(payload)
        setShowSuccessAnim(true)
        setTimeout(() => setShowSuccessAnim(false), 2000)
      }
      
      setShowModal(false)
      loadProjects()
    } catch (err) {
      console.error('Save error:', err)
      showNotification(t('chybaPriUkladani', lang).replace('vozidla', 'projektu'), 'error')
    } finally {
      setLoading(false)
    }
  }

  const handleDelete = async (id) => {
    if (!confirm(t('steIstiProjekt', lang))) return

    try {
      await deleteProject(id)
      showNotification(t('vymazane', lang), 'success')
      setProjects(prev => prev.filter(p => p.id !== id))
    } catch (err) {
      console.error('Delete error:', err)
      showNotification(t('chybaPriMazani', lang), 'error')
    }
  }

  const filteredProjects = projects.filter(p => 
    p.title.toLowerCase().includes(searchTerm.toLowerCase()) ||
    p.category?.toLowerCase().includes(searchTerm.toLowerCase())
  )

  if (initialLoad || authLoading) {
    return (
      <div className="flex items-center justify-center min-h-[400px]">
        <div className="w-12 h-12 border-4 border-purple-600 border-t-transparent rounded-full animate-spin"></div>
      </div>
    )
  }

  return (
    <div className="space-y-6 p-6">
      {/* Success Animation Overlay */}
      {showSuccessAnim && (
        <div className="fixed inset-0 z-[100] flex items-center justify-center pointer-events-none">
          <div className="bg-white/90 backdrop-blur rounded-3xl p-12 shadow-2xl flex flex-col items-center animate-in zoom-in duration-300">
            <div className="w-24 h-24 bg-green-100 rounded-full flex items-center justify-center mb-6">
              <svg className="w-16 h-16 text-green-500 animate-in fade-in zoom-in duration-500 delay-200" fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth="3">
                <path strokeLinecap="round" strokeLinejoin="round" d="M5 13l4 4L19 7" />
              </svg>
            </div>
            <h2 className="text-2xl font-bold text-gray-800">{t('ulozene', lang)}</h2>
          </div>
        </div>
      )}

      {/* Header */}
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-2xl font-bold text-gray-900">{t('projekty', lang)}</h1>
          <p className="mt-1 text-sm text-gray-500">
            Spravujte referencie a realizované stavby
          </p>
        </div>
        <button
          onClick={openAddModal}
          className="inline-flex items-center px-4 py-2 border border-transparent shadow-sm text-sm font-medium rounded-xl text-white bg-gradient-to-r from-purple-600 to-blue-600 hover:from-purple-700 hover:to-blue-700 transition-all"
        >
          <PlusIcon className="-ml-1 mr-2 h-5 w-5" />
          {t('pridatProjekt', lang)}
        </button>
      </div>

      {/* Search */}
      <div className="max-w-md relative">
        <MagnifyingGlassIcon className="absolute left-3 top-1/2 -translate-y-1/2 h-5 w-5 text-gray-400" />
        <input
          type="text"
          placeholder="Hľadať projekt..."
          value={searchTerm}
          onChange={(e) => setSearchTerm(e.target.value)}
          className="w-full pl-10 pr-4 py-2 border border-gray-300 rounded-xl focus:ring-2 focus:ring-purple-500 focus:border-transparent transition-all"
        />
      </div>

      {/* Grid */}
      {filteredProjects.length === 0 ? (
        <div className="bg-white rounded-2xl border border-dashed border-gray-300 p-12 text-center">
          <PhotoIcon className="mx-auto h-12 w-12 text-gray-400 mb-4" />
          <p className="text-gray-500">{t('ziadneProjekty', lang)}</p>
        </div>
      ) : (
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8 pb-12">
          {filteredProjects.map((project) => (
            <div 
              key={project.id} 
              className="group relative overflow-hidden rounded-lg aspect-[4/3] bg-white shadow-lg transform hover:-translate-y-2 transition-all duration-300 border border-[#F49C12]/20"
            >
              <div className="relative h-full w-full bg-gray-100">
                {project.hero_image || project.preview_photo || project.heroImage ? (
                  <img 
                    src={project.hero_image || project.preview_photo || project.heroImage} 
                    alt={project.title} 
                    className="w-full h-full object-cover transition-transform duration-700 group-hover:scale-110"
                  />
                ) : (
                  <div className="w-full h-full flex items-center justify-center">
                    <PhotoIcon className="w-12 h-12 text-gray-300" />
                  </div>
                )}
              </div>

              {/* Title & Category Overlay (Matching Website) */}
              <div className="absolute inset-x-0 bottom-0 p-6 bg-gradient-to-t from-black/90 via-black/60 to-transparent translate-y-2 group-hover:translate-y-0 transition-transform duration-300">
                <p className="text-[#F49C12] text-[10px] font-bold uppercase tracking-[0.2em] mb-1 opacity-0 group-hover:opacity-100 transition-opacity duration-300 delay-100 font-body">
                  {project.category}
                </p>
                <h3 className="text-white text-lg font-bold font-primary leading-tight">
                  {project.title}
                </h3>
                <div className="mt-2 flex items-center gap-3 text-xs text-white/60 opacity-0 group-hover:opacity-100 transition-opacity duration-300 delay-200">
                  <span>{project.year}</span>
                  <span className="w-1 h-1 bg-white/30 rounded-full"></span>
                  <span className="truncate">{project.location}</span>
                </div>
              </div>

              {/* Actions Overlay (Floating) */}
              <div className="absolute top-4 right-4 flex flex-col gap-2 opacity-0 group-hover:opacity-100 transition-all duration-300 translate-x-4 group-hover:translate-x-0">
                <button
                  onClick={() => openEditModal(project)}
                  className="p-2.5 bg-white/90 backdrop-blur rounded-xl text-gray-800 hover:bg-[#F49C12] hover:text-white transition-all shadow-lg"
                  title={t('upravit', lang)}
                >
                  <PencilSquareIcon className="w-5 h-5" />
                </button>
                <button
                  onClick={() => handleDelete(project.id)}
                  className="p-2.5 bg-white/90 backdrop-blur rounded-xl text-red-600 hover:bg-red-600 hover:text-white transition-all shadow-lg"
                  title={t('vymazat', lang)}
                >
                  <TrashIcon className="w-5 h-5" />
                </button>
              </div>
            </div>
          ))}
        </div>
      )}

      {/* Project Modal */}
      {showModal && createPortal(
        <div className="fixed inset-0 z-[9999] flex items-start justify-center p-4 sm:p-6 lg:p-10 overflow-y-auto bg-black/60 backdrop-blur-sm">
          <div 
            className="fixed inset-0 pointer-events-auto"
            onClick={() => setShowModal(false)}
          />
          <div className="bg-white rounded-3xl shadow-2xl w-full max-w-[90vw] max-h-[90vh] overflow-hidden flex flex-col relative z-20 animate-in fade-in slide-in-from-top-4 duration-300">
            <div className="flex items-center justify-between p-6 border-b">
              <h2 className="text-xl font-bold text-gray-900">
                {editingProject ? t('upravitProjekt', lang) : t('novyProjekt', lang)}
              </h2>
              <button 
                onClick={() => setShowModal(false)}
                className="p-2 hover:bg-gray-100 rounded-full transition-colors"
              >
                <XMarkIcon className="w-6 h-6 text-gray-400" />
              </button>
            </div>

            <form id="project-form" onSubmit={handleSubmit} className="flex-1 overflow-y-auto p-8 space-y-10 bg-gray-50/30">
              <div className="grid grid-cols-1 lg:grid-cols-12 gap-10">
                {/* Left Column: Info & Description (4/12) */}
                <div className="lg:col-span-4 space-y-8">
                  <section className="bg-white p-6 rounded-2xl shadow-sm border border-gray-100 space-y-6">
                    <h3 className="text-xs font-bold text-[#421F10] uppercase tracking-widest border-b pb-3 mb-4">Základné informácie</h3>
                    
                    <div className="space-y-4">
                      <div>
                        <label className="block text-sm font-bold text-gray-700 mb-1.5 font-primary">{t('nazovProjektu', lang)}</label>
                        <input
                          required
                          type="text"
                          value={formData.title}
                          onChange={(e) => handleInputChange('title', e.target.value)}
                          className="w-full border border-gray-200 rounded-xl px-4 py-3 focus:ring-2 focus:ring-[#F49C12] focus:border-transparent transition-all font-body text-lg"
                        />
                      </div>

                      <div className="grid grid-cols-1 gap-4">
                        <div>
                          <label className="block text-sm font-bold text-gray-700 mb-1.5 font-primary">{t('kategoria', lang)}</label>
                          <input
                            type="text"
                            placeholder="napr. NÍZKOENERGETICKÝ DOM"
                            value={formData.category}
                            onChange={(e) => handleInputChange('category', e.target.value)}
                            className="w-full border border-gray-200 rounded-xl px-4 py-3 focus:ring-2 focus:ring-[#F49C12] focus:border-transparent transition-all font-body"
                          />
                        </div>
                        <div className="grid grid-cols-2 gap-4">
                          <div>
                            <label className="block text-sm font-bold text-gray-700 mb-1.5 font-primary">{t('rok', lang)}</label>
                            <input
                              type="number"
                              value={formData.year}
                              onChange={(e) => handleInputChange('year', parseInt(e.target.value))}
                              className="w-full border border-gray-200 rounded-xl px-4 py-3 focus:ring-2 focus:ring-[#F49C12] focus:border-transparent transition-all font-body"
                            />
                          </div>
                          <div>
                            <label className="block text-sm font-bold text-gray-700 mb-1.5 font-primary">{t('lokalita', lang)}</label>
                            <input
                              type="text"
                              value={formData.location}
                              onChange={(e) => handleInputChange('location', e.target.value)}
                              className="w-full border border-gray-200 rounded-xl px-4 py-3 focus:ring-2 focus:ring-[#F49C12] focus:border-transparent transition-all font-body text-sm"
                            />
                          </div>
                        </div>
                      </div>
                    </div>
                  </section>

                  {/* SEO */}
                  <section className="bg-white p-6 rounded-2xl shadow-sm border border-gray-100 space-y-6">
                    <h3 className="text-xs font-bold text-[#421F10] uppercase tracking-widest border-b pb-3 mb-4">SEO Optimalizácia</h3>
                    <div className="space-y-4">
                      <div>
                        <label className="block text-sm font-bold text-gray-700 mb-1.5 font-primary">Meta Popis</label>
                        <textarea
                          rows={2}
                          value={formData.seo.metaDescription}
                          onChange={(e) => handleInputChange('seo.metaDescription', e.target.value)}
                          className="w-full border border-gray-200 rounded-xl px-4 py-3 focus:ring-2 focus:ring-[#F49C12] focus:border-transparent transition-all font-body text-sm"
                        />
                      </div>
                    </div>
                  </section>
                </div>

                {/* Right Column: Media & Full-Width Description (8/12) */}
                <div className="lg:col-span-8 space-y-8">
                  {/* Description - Moved here to give it more width/space if needed, or keeping it above gallery */}
                  <section className="bg-white p-6 rounded-2xl shadow-sm border border-gray-100">
                    <h3 className="text-xs font-bold text-[#421F10] uppercase tracking-widest border-b pb-3 mb-4">{t('textProjektu', lang)}</h3>
                    <div className="mt-4 min-h-[300px]">
                      <LegisBlogRichTextEditor
                        value={formData.description}
                        onChange={(val) => handleInputChange('description', val)}
                      />
                    </div>
                  </section>

                  {/* Integrated Gallery */}
                  <section className="bg-white p-6 rounded-2xl shadow-sm border border-gray-100">
                    <div className="flex items-center justify-between mb-6 border-b pb-3">
                      <div>
                        <h3 className="text-xs font-bold text-[#421F10] uppercase tracking-widest leading-relaxed">Médiá projektu</h3>
                        <p className="text-[10px] text-gray-500 font-medium mt-1 uppercase tracking-tighter">Zvoľte hlavnú fotku pomocou hviezdičky</p>
                      </div>
                      <label className="cursor-pointer bg-[#F49C12] text-white px-4 py-2 rounded-xl text-xs font-bold hover:shadow-lg hover:shadow-[#F49C12]/20 transition-all flex items-center gap-2">
                        <PlusIcon className="w-4 h-4" />
                        Pridať fotografie
                        <input type="file" multiple className="hidden" accept="image/*" onChange={(e) => handleFileUpload(e, 'gallery')} />
                      </label>
                    </div>
                    
                    <div className="grid grid-cols-2 md:grid-cols-3 gap-6">
                      {formData.images.map((img, idx) => {
                        const isMain = formData.preview_photo === img;
                        return (
                          <div key={idx} className={`aspect-[4/3] rounded-2xl border-2 overflow-hidden relative group transition-all ${isMain ? 'border-[#F49C12] shadow-xl ring-4 ring-[#F49C12]/10' : 'border-gray-50'}`}>
                            <img src={img} alt={`Gallery ${idx}`} className="w-full h-full object-cover" />
                            
                            {isMain && (
                              <div className="absolute top-2 left-2 bg-[#F49C12] text-white px-2 py-0.5 rounded-lg text-[10px] font-bold uppercase tracking-wider shadow-md">
                                Hlavná fotka
                              </div>
                            )}

                            <div className="absolute inset-0 bg-black/60 opacity-0 group-hover:opacity-100 transition-opacity flex items-center justify-center gap-3">
                              <button 
                                type="button"
                                onClick={() => handleInputChange('preview_photo', img)}
                                className={`p-2 rounded-xl transition-all hover:scale-110 ${isMain ? 'bg-[#F49C12] text-white' : 'bg-white text-gray-900 shadow-xl'}`}
                                title="Nastaviť ako hlavnú"
                              >
                                <StarIcon className={`w-6 h-6 ${isMain ? 'fill-current' : 'text-gray-400'}`} />
                              </button>
                              <button 
                                type="button"
                                onClick={() => removeGalleryImage(idx)}
                                className="p-2 bg-red-600 text-white rounded-xl hover:scale-110 transition-transform shadow-xl"
                                title="Odstrániť"
                              >
                                <TrashIcon className="w-6 h-6" />
                              </button>
                            </div>
                          </div>
                        );
                      })}
                      <label className="aspect-[4/3] rounded-2xl border-2 border-dashed border-gray-100 flex flex-col items-center justify-center text-gray-300 hover:border-[#F49C12] hover:text-[#F49C12] cursor-pointer transition-all bg-gray-50/30">
                        <PlusIcon className="w-10 h-10" />
                        <span className="text-[10px] font-bold uppercase mt-2 tracking-widest">Nahrať ďalšie</span>
                        <input type="file" multiple className="hidden" accept="image/*" onChange={(e) => handleFileUpload(e, 'gallery')} />
                      </label>
                    </div>
                  </section>
                </div>
              </div>
            </form>

            {/* Actions - Fixed outside scrolling form */}
            <div className="flex gap-4 p-6 bg-white border-t z-20 rounded-b-3xl">
              <button
                type="button"
                onClick={() => setShowModal(false)}
                className="px-8 py-4 border border-gray-200 rounded-2xl text-gray-600 font-bold hover:bg-gray-50 transition-all font-primary uppercase tracking-widest text-sm"
              >
                {t('zrusit', lang)}
              </button>
              <button
                disabled={loading}
                form="project-form"
                type="submit"
                className="flex-1 px-8 py-4 bg-[#421F10] text-white rounded-2xl font-bold shadow-xl shadow-[#421F10]/20 hover:bg-[#F49C12] hover:shadow-[#F49C12]/30 transition-all font-primary uppercase tracking-widest text-sm"
              >
                {loading ? 'Ukladám...' : t('ulozit', lang)}
              </button>
            </div>
          </div>
        </div>,
        document.body
      )}
    </div>
  )
}