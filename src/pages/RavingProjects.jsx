import { useEffect, useMemo, useState } from 'react'
import { createPortal } from 'react-dom'
import {
  ArrowDownIcon,
  ArrowUpIcon,
  EyeIcon,
  EyeSlashIcon,
  PencilSquareIcon,
  PhotoIcon,
  PlusIcon,
  TrashIcon,
  XMarkIcon,
} from '@heroicons/react/24/outline'
import { useAuth } from '../contexts/AuthContext'
import { useNotification } from '../contexts/NotificationContext'
import {
  RAVING_OWNER_EMAIL,
  RAVING_PROJECT_CATEGORIES,
  createRavingProject,
  deleteRavingProject,
  getRavingProjects,
  reorderRavingProjects,
  slugifyRavingProjectTitle,
  updateRavingProject,
  uploadRavingProjectImage,
} from '../api/ravingProjects'


const RAVING_WEBSITE_URL = window.location.hostname === 'localhost' || window.location.hostname === '127.0.0.1'
  ? 'http://127.0.0.1:3016'
  : 'https://www.raving.sk'

function getRavingImageSrc(url, legacyFolder) {
  if (!url) return ''
  if (url.startsWith('http://') || url.startsWith('https://') || url.startsWith('data:') || url.startsWith('blob:')) {
    return url
  }
  if (url.startsWith('/')) {
    return `${RAVING_WEBSITE_URL}${url}`
  }
  if (legacyFolder) {
    return `${RAVING_WEBSITE_URL}/sources/referencie/${legacyFolder}/${url}`
  }
  return url
}

const OWNER_EMAIL = 'alexander.hidveghy@gmail.com'

const emptyForm = {
  title: '',
  description: '',
  slug: '',
  category: 'priemyselne',
  cover_image_url: '',
  gallery_images: [],
  sort_order: 0,
  is_published: true,
  seo_title: '',
  seo_description: '',
  legacy_folder: '',
  legacy_first_image: '',
}

function categoryLabel(value) {
  return RAVING_PROJECT_CATEGORIES.find(category => category.value === value)?.label || value
}

export default function RavingProjects() {
  const { user } = useAuth()
  const { showNotification } = useNotification()
  const [projects, setProjects] = useState([])
  const [loading, setLoading] = useState(true)
  const [saving, setSaving] = useState(false)
  const [search, setSearch] = useState('')
  const [showModal, setShowModal] = useState(false)
  const [editingProject, setEditingProject] = useState(null)
  const [formData, setFormData] = useState(emptyForm)

  const canManage = user?.email === RAVING_OWNER_EMAIL || user?.email === OWNER_EMAIL

  useEffect(() => {
    loadProjects()
  }, [])

  useEffect(() => {
    if (showModal) {
      document.body.style.overflow = 'hidden'
    } else {
      document.body.style.overflow = ''
    }
    return () => {
      document.body.style.overflow = ''
    }
  }, [showModal])

  async function loadProjects(silent = false) {
    if (!silent) setLoading(true)
    try {
      setProjects(await getRavingProjects())
    } catch (err) {
      console.error('Raving projects load error:', err)
      showNotification('Referencie sa nepodarilo načítať', 'error')
    } finally {
      if (!silent) setLoading(false)
    }
  }

  const filteredProjects = useMemo(() => {
    const term = search.trim().toLowerCase()
    if (!term) return projects

    return projects.filter(project =>
      project.title.toLowerCase().includes(term)
      || project.description?.toLowerCase().includes(term)
      || project.category?.toLowerCase().includes(term)
    )
  }, [projects, search])

  function openCreateModal() {
    setEditingProject(null)
    setFormData({
      ...emptyForm,
      sort_order: projects.length,
    })
    setShowModal(true)
  }

  function openEditModal(project) {
    setEditingProject(project)
    setFormData({
      ...emptyForm,
      ...project,
      gallery_images: project.gallery_images || [],
      seo_title: project.seo_title || '',
      seo_description: project.seo_description || '',
      legacy_folder: project.legacy_folder || '',
      legacy_first_image: project.legacy_first_image || '',
    })
    setShowModal(true)
  }

  function updateField(field, value) {
    setFormData(prev => {
      const next = { ...prev, [field]: value }
      if (field === 'title' && (!prev.slug || prev.slug === slugifyRavingProjectTitle(prev.title))) {
        next.slug = slugifyRavingProjectTitle(value)
      }
      return next
    })
  }

  async function handleCoverUpload(event) {
    const file = event.target.files?.[0]
    if (!file) return

    try {
      const url = await uploadRavingProjectImage(file, editingProject?.id)
      updateField('cover_image_url', url)
      showNotification('Titulná fotka bola nahratá', 'success')
    } catch (err) {
      console.error('Raving cover upload error:', err)
      showNotification('Fotku sa nepodarilo nahrať', 'error')
    } finally {
      event.target.value = ''
    }
  }

  async function handleGalleryUpload(event) {
    const files = Array.from(event.target.files || [])
    if (files.length === 0) return

    try {
      const uploaded = []
      for (const file of files) {
        uploaded.push(await uploadRavingProjectImage(file, editingProject?.id))
      }
      setFormData(prev => ({
        ...prev,
        gallery_images: [...prev.gallery_images, ...uploaded],
      }))
      showNotification('Galéria bola nahratá', 'success')
    } catch (err) {
      console.error('Raving gallery upload error:', err)
      showNotification('Galériu sa nepodarilo nahrať', 'error')
    } finally {
      event.target.value = ''
    }
  }

  function removeGalleryImage(index) {
    setFormData(prev => ({
      ...prev,
      gallery_images: prev.gallery_images.filter((_, current) => current !== index),
    }))
  }

  async function handleSubmit(event) {
    event.preventDefault()
    if (!canManage) return

    setSaving(true)
    try {
      const payload = {
        title: formData.title.trim(),
        description: formData.description.trim(),
        slug: formData.slug.trim() || slugifyRavingProjectTitle(formData.title),
        category: formData.category,
        cover_image_url: formData.cover_image_url || '',
        gallery_images: formData.gallery_images || [],
        sort_order: Number(formData.sort_order) || 0,
        is_published: Boolean(formData.is_published),
        seo_title: formData.seo_title || null,
        seo_description: formData.seo_description || null,
        legacy_folder: formData.legacy_folder || null,
        legacy_first_image: formData.legacy_first_image || null,
      }

      if (editingProject) {
        const updated = await updateRavingProject(editingProject.id, payload)
        setEditingProject(updated)
        setFormData(prev => ({ ...prev, ...updated }))
      } else {
        const created = await createRavingProject(payload)
        setEditingProject(created)
        setFormData(prev => ({ ...prev, ...created }))
      }

      showNotification('Referencie boli uložené', 'success')
      await loadProjects(true)
    } catch (err) {
      console.error('Raving project save error:', err)
      showNotification(err.message || 'Referenciu sa nepodarilo uložiť', 'error')
    } finally {
      setSaving(false)
    }
  }

  async function handleDelete(project) {
    if (!canManage || !confirm(`Vymazať referenciu "${project.title}"?`)) return

    try {
      await deleteRavingProject(project.id)
      setProjects(prev => prev.filter(item => item.id !== project.id))
      showNotification('Referencia bola vymazaná', 'success')
    } catch (err) {
      console.error('Raving project delete error:', err)
      showNotification('Referenciu sa nepodarilo vymazať', 'error')
    }
  }

  async function moveProject(project, direction) {
    const currentIndex = projects.findIndex(item => item.id === project.id)
    const nextIndex = currentIndex + direction
    if (currentIndex < 0 || nextIndex < 0 || nextIndex >= projects.length) return

    const nextProjects = [...projects]
    const [moved] = nextProjects.splice(currentIndex, 1)
    nextProjects.splice(nextIndex, 0, moved)
    const ordered = nextProjects.map((item, index) => ({ ...item, sort_order: index }))

    setProjects(ordered)
    try {
      await reorderRavingProjects(ordered.map(item => ({ id: item.id, sort_order: item.sort_order })))
      showNotification('Poradie bolo uložené', 'success')
    } catch (err) {
      console.error('Raving reorder error:', err)
      showNotification('Poradie sa nepodarilo uložiť', 'error')
      loadProjects()
    }
  }

  if (!canManage) {
    return (
      <div className="p-6">
        <div className="rounded-xl border border-red-200 bg-red-50 p-6 text-red-700">
          Tento účet nemá prístup k Raving referenciám.
        </div>
      </div>
    )
  }

  if (loading) {
    return (
      <div className="flex min-h-[400px] items-center justify-center">
        <div className="h-12 w-12 animate-spin rounded-full border-4 border-purple-600 border-t-transparent" />
      </div>
    )
  }

  return (
    <div className="space-y-6 p-6">
      <div className="flex flex-col gap-4 lg:flex-row lg:items-center lg:justify-between">
        <div>
          <p className="text-sm font-semibold uppercase tracking-[0.2em] text-purple-600">Raving</p>
          <h1 className="mt-1 text-2xl font-bold text-gray-900">Referencie</h1>
          <p className="mt-1 text-sm text-gray-500">Spravujte projekty presne pre sekciu Referencie na raving.sk.</p>
        </div>
        <button
          onClick={openCreateModal}
          className="inline-flex items-center justify-center rounded-xl bg-gradient-to-r from-purple-600 to-blue-600 px-4 py-2 text-sm font-medium text-white shadow-sm transition hover:from-purple-700 hover:to-blue-700"
        >
          <PlusIcon className="-ml-1 mr-2 h-5 w-5" />
          Pridať projekt
        </button>
      </div>

      <div className="max-w-md">
        <input
          value={search}
          onChange={event => setSearch(event.target.value)}
          placeholder="Hľadať referencie..."
          className="w-full rounded-xl border border-gray-200 bg-white px-4 py-3 text-sm text-gray-900 shadow-sm outline-none transition focus:border-purple-500 focus:ring-2 focus:ring-purple-200"
        />
      </div>

      <div className="grid gap-5 md:grid-cols-2 xl:grid-cols-3">
        {filteredProjects.map((project, index) => (
          <article key={project.id} className="overflow-hidden rounded-xl border border-gray-200 bg-white shadow-sm">
            <div className="relative aspect-[16/10] bg-gray-100">
              {project.cover_image_url ? (
                <img src={getRavingImageSrc(project.cover_image_url, project.legacy_folder)} alt={project.title} className="h-full w-full object-cover" />
              ) : (
                <div className="flex h-full items-center justify-center text-gray-400">
                  <PhotoIcon className="h-12 w-12" />
                </div>
              )}
              <div className="absolute left-3 top-3 rounded-full bg-white/90 px-3 py-1 text-xs font-semibold text-gray-800 shadow">
                {categoryLabel(project.category)}
              </div>
              <div className="absolute right-3 top-3 rounded-full bg-black/70 px-3 py-1 text-xs font-semibold text-white">
                {project.is_published ? 'Publikované' : 'Skryté'}
              </div>
            </div>
            <div className="space-y-4 p-4">
              <div>
                <h2 className="line-clamp-2 text-lg font-semibold text-gray-900">{project.title}</h2>
                <p className="mt-1 line-clamp-2 text-sm text-gray-500">{project.description}</p>
              </div>
              <div className="flex items-center justify-between gap-2 border-t border-gray-100 pt-3">
                <div className="flex gap-1">
                  <button
                    onClick={() => moveProject(project, -1)}
                    disabled={index === 0}
                    className="rounded-lg p-2 text-gray-500 transition hover:bg-gray-100 disabled:cursor-not-allowed disabled:opacity-30"
                    title="Posunúť vyššie"
                  >
                    <ArrowUpIcon className="h-4 w-4" />
                  </button>
                  <button
                    onClick={() => moveProject(project, 1)}
                    disabled={index === projects.length - 1}
                    className="rounded-lg p-2 text-gray-500 transition hover:bg-gray-100 disabled:cursor-not-allowed disabled:opacity-30"
                    title="Posunúť nižšie"
                  >
                    <ArrowDownIcon className="h-4 w-4" />
                  </button>
                </div>
                <div className="flex gap-1">
                  <button
                    onClick={() => openEditModal(project)}
                    className="rounded-lg p-2 text-blue-600 transition hover:bg-blue-50"
                    title="Upraviť"
                  >
                    <PencilSquareIcon className="h-5 w-5" />
                  </button>
                  <button
                    onClick={() => updateRavingProject(project.id, { is_published: !project.is_published }).then(() => loadProjects(true))}
                    className="rounded-lg p-2 text-gray-600 transition hover:bg-gray-100"
                    title={project.is_published ? 'Skryť' : 'Publikovať'}
                  >
                    {project.is_published ? <EyeIcon className="h-5 w-5" /> : <EyeSlashIcon className="h-5 w-5" />}
                  </button>
                  <button
                    onClick={() => handleDelete(project)}
                    className="rounded-lg p-2 text-red-600 transition hover:bg-red-50"
                    title="Vymazať"
                  >
                    <TrashIcon className="h-5 w-5" />
                  </button>
                </div>
              </div>
            </div>
          </article>
        ))}
      </div>

      {filteredProjects.length === 0 && (
        <div className="rounded-xl border border-dashed border-gray-300 bg-white p-10 text-center text-gray-500">
          Žiadne referencie.
        </div>
      )}

      {showModal && createPortal(
        <div className="fixed inset-0 z-[9999] flex items-center justify-center bg-black/50 p-4">
          <form onSubmit={handleSubmit} className="relative w-full max-w-5xl max-h-[90vh] flex flex-col rounded-2xl bg-white shadow-2xl">
            <div className="flex items-center justify-between border-b border-gray-100 px-6 py-4 flex-shrink-0">
              <div>
                <h2 className="text-xl font-bold text-gray-900">{editingProject ? 'Upraviť projekt' : 'Nový projekt'}</h2>
                <p className="text-sm text-gray-500">Tieto údaje sa zobrazujú na webe v referenciách.</p>
              </div>
              <button type="button" onClick={() => setShowModal(false)} className="rounded-lg p-2 text-gray-500 transition hover:bg-gray-100">
                <XMarkIcon className="h-6 w-6" />
              </button>
            </div>

            <div className="flex-grow overflow-y-auto p-6 grid gap-6 lg:grid-cols-[1.1fr_0.9fr] min-h-0">
              <div className="space-y-4">
                <div>
                  <label className="mb-1.5 block text-sm font-semibold text-gray-700">Názov projektu</label>
                  <input
                    required
                    value={formData.title}
                    onChange={event => updateField('title', event.target.value)}
                    className="w-full rounded-xl border border-gray-200 px-4 py-3 outline-none transition focus:border-purple-500 focus:ring-2 focus:ring-purple-200"
                  />
                </div>

                <div className="grid gap-4 md:grid-cols-2">
                  <div>
                    <label className="mb-1.5 block text-sm font-semibold text-gray-700">Slug URL</label>
                    <input
                      required
                      value={formData.slug}
                      onChange={event => updateField('slug', slugifyRavingProjectTitle(event.target.value))}
                      className="w-full rounded-xl border border-gray-200 px-4 py-3 outline-none transition focus:border-purple-500 focus:ring-2 focus:ring-purple-200"
                    />
                  </div>
                  <div>
                    <label className="mb-1.5 block text-sm font-semibold text-gray-700">Kategória</label>
                    <select
                      value={formData.category}
                      onChange={event => updateField('category', event.target.value)}
                      className="w-full rounded-xl border border-gray-200 px-4 py-3 outline-none transition focus:border-purple-500 focus:ring-2 focus:ring-purple-200"
                    >
                      {RAVING_PROJECT_CATEGORIES.map(category => (
                        <option key={category.value} value={category.value}>{category.label}</option>
                      ))}
                    </select>
                  </div>
                </div>

                <div>
                  <label className="mb-1.5 block text-sm font-semibold text-gray-700">Krátky popis</label>
                  <textarea
                    required
                    rows={4}
                    value={formData.description}
                    onChange={event => updateField('description', event.target.value)}
                    className="w-full rounded-xl border border-gray-200 px-4 py-3 outline-none transition focus:border-purple-500 focus:ring-2 focus:ring-purple-200"
                  />
                </div>

                <div className="grid gap-4 md:grid-cols-2">
                  <div>
                    <label className="mb-1.5 block text-sm font-semibold text-gray-700">SEO titulok</label>
                    <input
                      value={formData.seo_title}
                      onChange={event => updateField('seo_title', event.target.value)}
                      className="w-full rounded-xl border border-gray-200 px-4 py-3 outline-none transition focus:border-purple-500 focus:ring-2 focus:ring-purple-200"
                    />
                  </div>
                  <div>
                    <label className="mb-1.5 block text-sm font-semibold text-gray-700">SEO popis</label>
                    <input
                      value={formData.seo_description}
                      onChange={event => updateField('seo_description', event.target.value)}
                      className="w-full rounded-xl border border-gray-200 px-4 py-3 outline-none transition focus:border-purple-500 focus:ring-2 focus:ring-purple-200"
                    />
                  </div>
                </div>

                <label className="flex items-center gap-3 rounded-xl border border-gray-200 px-4 py-3 text-sm font-medium text-gray-700">
                  <input
                    type="checkbox"
                    checked={formData.is_published}
                    onChange={event => updateField('is_published', event.target.checked)}
                    className="h-4 w-4 rounded border-gray-300 text-purple-600"
                  />
                  Publikované na webe
                </label>
              </div>

              <div className="space-y-5">
                <div>
                  <label className="mb-1.5 block text-sm font-semibold text-gray-700">Titulná fotka</label>
                  <div className="overflow-hidden rounded-xl border border-gray-200 bg-gray-50">
                    {formData.cover_image_url ? (
                      <img src={getRavingImageSrc(formData.cover_image_url, formData.legacy_folder)} alt="" className="aspect-[16/10] w-full object-cover" />
                    ) : (
                      <div className="flex aspect-[16/10] items-center justify-center text-gray-400">
                        <PhotoIcon className="h-12 w-12" />
                      </div>
                    )}
                    <div className="p-3">
                      <input type="file" accept="image/*" onChange={handleCoverUpload} className="w-full text-sm" />
                    </div>
                  </div>
                </div>

                <div>
                  <label className="mb-1.5 block text-sm font-semibold text-gray-700">Galéria projektu</label>
                  <input type="file" accept="image/*" multiple onChange={handleGalleryUpload} className="mb-3 w-full text-sm" />
                  <div className="grid grid-cols-3 gap-2 rounded-xl border border-gray-200 bg-gray-50 p-2">
                    {formData.gallery_images.map((image, index) => (
                      <div key={`${image}-${index}`} className="group relative aspect-square overflow-hidden rounded-lg bg-gray-200">
                        <img src={getRavingImageSrc(image, formData.legacy_folder)} alt="" className="h-full w-full object-cover" />
                        <button
                          type="button"
                          onClick={() => removeGalleryImage(index)}
                          className="absolute right-1 top-1 rounded-full bg-red-600 p-1 text-white opacity-0 transition group-hover:opacity-100"
                        >
                          <XMarkIcon className="h-4 w-4" />
                        </button>
                      </div>
                    ))}
                    {formData.gallery_images.length === 0 && (
                      <div className="col-span-3 py-8 text-center text-sm text-gray-500">Zatiaľ bez nových CMS fotiek.</div>
                    )}
                  </div>
                </div>


              </div>

            </div>

            <div className="flex justify-end gap-3 border-t border-gray-100 px-6 py-4 flex-shrink-0">
              <button
                type="button"
                onClick={() => setShowModal(false)}
                className="rounded-xl border border-gray-200 px-5 py-2.5 text-sm font-medium text-gray-700 transition hover:bg-gray-50"
              >
                Zrušiť
              </button>
              <button
                type="submit"
                disabled={saving}
                className="rounded-xl bg-gradient-to-r from-purple-600 to-blue-600 px-5 py-2.5 text-sm font-medium text-white transition hover:from-purple-700 hover:to-blue-700 disabled:opacity-60"
              >
                {saving ? 'Ukladám...' : 'Uložiť'}
              </button>
            </div>
          </form>
        </div>,
        document.body
      )}
    </div>
  )
}
