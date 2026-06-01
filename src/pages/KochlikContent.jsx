import { useCallback, useEffect, useMemo, useState } from 'react'
import { createPortal } from 'react-dom'
import {
  EyeIcon,
  PencilSquareIcon,
  PhotoIcon,
  PlusIcon,
  TrashIcon,
  XMarkIcon,
} from '@heroicons/react/24/outline'
import { useAuth } from '../contexts/AuthContext'
import { useNotification } from '../contexts/NotificationContext'
import {
  KOCHLIK_OWNER_ID,
  createKochlikHomeBanner,
  deleteKochlikHomeBanner,
  listKochlikHomeBanners,
  updateKochlikHomeBanner,
  uploadKochlikBannerImage,
} from '../api'

const PREVIEW_ORIGIN = 'http://localhost:3006'

function resolveImage(url) {
  if (!url) return ''
  if (url.startsWith('http://') || url.startsWith('https://') || url.startsWith('data:')) {
    return url
  }
  return `${PREVIEW_ORIGIN}${url.startsWith('/') ? '' : '/'}${url}`
}

const EMPTY_BANNER = {
  title: '',
  text: '',
  image_url: '',
  href: '/produkt-kategoria/dizajnove',
  button_label: 'Pozrieť',
  sort_order: 0,
  is_active: true,
}

export default function KochlikContent() {
  const { user, loading: authLoading } = useAuth()
  const { showNotification } = useNotification()
  const [banners, setBanners] = useState([])
  const [loading, setLoading] = useState(true)
  const [saving, setSaving] = useState(false)
  const [uploading, setUploading] = useState(false)
  const [editingBanner, setEditingBanner] = useState(null)
  const [bannerForm, setBannerForm] = useState(EMPTY_BANNER)
  const [isModalOpen, setIsModalOpen] = useState(false)

  const hasAccess = user?.id === KOCHLIK_OWNER_ID
    || user?.email === 'info@kochlik.eu'
    || user?.email === 'alexander.hidveghy@gmail.com'

  const activeBannerCount = useMemo(
    () => banners.filter(banner => banner.is_active).length,
    [banners]
  )

  const loadData = useCallback(async () => {
    setLoading(true)
    try {
      setBanners(await listKochlikHomeBanners())
    } catch (err) {
      console.error('Kochlik banner load error:', err)
      showNotification('Nepodarilo sa načítať bannery', 'error')
    } finally {
      setLoading(false)
    }
  }, [showNotification])

  useEffect(() => {
    if (authLoading || !hasAccess) return
    loadData()
  }, [authLoading, hasAccess, loadData])

  useEffect(() => {
    if (isModalOpen) {
      document.body.style.overflow = 'hidden'
    } else {
      document.body.style.overflow = ''
    }
    return () => {
      document.body.style.overflow = ''
    }
  }, [isModalOpen])

  function openCreateModal() {
    setEditingBanner(null)
    setBannerForm({
      ...EMPTY_BANNER,
      sort_order: banners.length > 0
        ? Math.max(...banners.map(banner => Number(banner.sort_order || 0))) + 10
        : 10,
    })
    setIsModalOpen(true)
  }

  function openEditModal(banner) {
    setEditingBanner(banner)
    setBannerForm({
      title: banner.title || '',
      text: banner.text || '',
      image_url: banner.image_url || '',
      href: banner.href || '/',
      button_label: banner.button_label || 'Pozrieť',
      sort_order: banner.sort_order || 0,
      is_active: Boolean(banner.is_active),
    })
    setIsModalOpen(true)
  }

  function closeModal() {
    setEditingBanner(null)
    setBannerForm(EMPTY_BANNER)
    setIsModalOpen(false)
  }

  async function handleImageUpload(event) {
    const file = event.target.files?.[0]
    event.target.value = ''
    if (!file || !file.type.startsWith('image/')) return

    setUploading(true)
    try {
      const imageUrl = await uploadKochlikBannerImage(file, editingBanner?.id || 'new')
      setBannerForm(prev => ({ ...prev, image_url: imageUrl }))
      showNotification('Obrázok bannera bol nahraný', 'success')
    } catch (err) {
      console.error('Kochlik banner upload error:', err)
      showNotification('Obrázok sa nepodarilo nahrať', 'error')
    } finally {
      setUploading(false)
    }
  }

  async function handleSubmit(event) {
    event.preventDefault()

    const payload = {
      title: bannerForm.title.trim(),
      text: bannerForm.text.trim() || null,
      image_url: bannerForm.image_url.trim() || null,
      href: bannerForm.href.trim() || '/',
      button_label: bannerForm.button_label.trim() || 'Pozrieť',
      sort_order: Number(bannerForm.sort_order || 0),
      is_active: Boolean(bannerForm.is_active),
    }

    if (!payload.title) {
      showNotification('Vyplňte nadpis bannera', 'error')
      return
    }

    setSaving(true)
    try {
      if (editingBanner) {
        const updated = await updateKochlikHomeBanner(editingBanner.id, payload)
        setBanners(prev => prev.map(banner => banner.id === updated.id ? updated : banner))
        showNotification('Banner bol uložený', 'success')
      } else {
        const created = await createKochlikHomeBanner(payload)
        setBanners(prev => [...prev, created].sort((a, b) => a.sort_order - b.sort_order))
        showNotification('Banner bol pridaný', 'success')
      }
      closeModal()
    } catch (err) {
      console.error('Kochlik banner save error:', err)
      showNotification(err.message || 'Banner sa nepodarilo uložiť', 'error')
    } finally {
      setSaving(false)
    }
  }

  async function handleDelete(banner) {
    if (!confirm(`Naozaj vymazať banner "${banner.title}"?`)) return

    try {
      await deleteKochlikHomeBanner(banner.id)
      setBanners(prev => prev.filter(item => item.id !== banner.id))
      showNotification('Banner bol vymazaný', 'success')
    } catch (err) {
      console.error('Kochlik banner delete error:', err)
      showNotification('Banner sa nepodarilo vymazať', 'error')
    }
  }

  if (authLoading) return <div className="flex h-64 items-center justify-center"><div className="h-8 w-8 animate-spin rounded-full border-b-2 border-emerald-600"></div></div>
  if (!hasAccess) return <div className="flex h-64 items-center justify-center"><p className="text-gray-500">Nemáte prístup.</p></div>

  return (
    <div className="space-y-6">
      <div className="flex flex-col gap-4 lg:flex-row lg:items-end lg:justify-between">
        <div>
          <p className="text-sm font-semibold uppercase tracking-[0.18em] text-emerald-700">Kochlik</p>
          <h1 className="mt-1 text-3xl font-bold text-gray-950">Obsah úvodnej stránky</h1>
          <p className="mt-2 text-sm text-gray-500">
            Aktívne bannery: {activeBannerCount}. Poradie určuje, v akom slede sa zobrazia v hero slideri.
          </p>
        </div>
        <button
          onClick={openCreateModal}
          className="inline-flex items-center justify-center rounded-2xl bg-emerald-600 px-5 py-3 text-sm font-extrabold text-white transition hover:bg-emerald-700"
        >
          <PlusIcon className="mr-2 h-5 w-5" />
          Pridať banner
        </button>
      </div>

      {loading ? (
        <div className="rounded-3xl bg-white p-12 text-center text-gray-500 shadow-sm ring-1 ring-gray-100">
          Načítavam bannery...
        </div>
      ) : banners.length === 0 ? (
        <div className="rounded-3xl border-2 border-dashed border-gray-200 bg-white p-12 text-center">
          <PhotoIcon className="mx-auto mb-3 h-12 w-12 text-gray-300" />
          <p className="font-semibold text-gray-600">Zatiaľ nie sú vytvorené žiadne bannery.</p>
        </div>
      ) : (
        <div className="grid gap-5 lg:grid-cols-2 xl:grid-cols-3">
          {banners
            .slice()
            .sort((a, b) => a.sort_order - b.sort_order)
            .map(banner => (
              <article key={banner.id} className="overflow-hidden rounded-3xl bg-white shadow-sm ring-1 ring-gray-100">
                <div className="relative aspect-[16/9] bg-gray-100">
                  {banner.image_url ? (
                    <img src={resolveImage(banner.image_url)} alt={banner.title} className="h-full w-full object-cover" />
                  ) : (
                    <div className="flex h-full items-center justify-center text-gray-300">
                      <PhotoIcon className="h-12 w-12" />
                    </div>
                  )}
                  <span className={`absolute left-4 top-4 rounded-full px-3 py-1 text-xs font-bold ${
                    banner.is_active ? 'bg-emerald-500 text-white' : 'bg-gray-900/70 text-white'
                  }`}>
                    {banner.is_active ? 'Aktívny' : 'Skrytý'}
                  </span>
                  <span className="absolute right-4 top-4 rounded-full bg-white/90 px-3 py-1 text-xs font-bold text-gray-700 shadow-sm">
                    #{banner.sort_order}
                  </span>
                </div>
                <div className="space-y-4 p-5">
                  <div>
                    <h2 className="line-clamp-2 text-lg font-extrabold text-gray-950">{banner.title}</h2>
                    {banner.text && <p className="mt-2 line-clamp-3 text-sm leading-6 text-gray-500">{banner.text}</p>}
                    <p className="mt-2 truncate text-xs font-semibold text-blue-600">{banner.href}</p>
                  </div>
                  <div className="flex items-center justify-end gap-2">
                    {banner.href && (
                      <a
                        href={`https://kochlik.sk${banner.href.startsWith('/') ? banner.href : `/${banner.href}`}`}
                        target="_blank"
                        rel="noopener noreferrer"
                        className="inline-flex items-center rounded-xl bg-gray-100 px-3 py-2 text-xs font-bold text-gray-700 transition hover:bg-gray-200"
                      >
                        <EyeIcon className="mr-1 h-4 w-4" />
                        Náhľad
                      </a>
                    )}
                    <button
                      type="button"
                      onClick={() => openEditModal(banner)}
                      className="inline-flex items-center rounded-xl bg-emerald-50 px-3 py-2 text-xs font-bold text-emerald-700 transition hover:bg-emerald-100"
                    >
                      <PencilSquareIcon className="mr-1 h-4 w-4" />
                      Upraviť
                    </button>
                    <button
                      type="button"
                      onClick={() => handleDelete(banner)}
                      className="inline-flex items-center rounded-xl bg-red-50 px-3 py-2 text-xs font-bold text-red-600 transition hover:bg-red-100"
                    >
                      <TrashIcon className="mr-1 h-4 w-4" />
                      Vymazať
                    </button>
                  </div>
                </div>
              </article>
            ))}
        </div>
      )}

      {isModalOpen && createPortal(
        <div className="fixed inset-0 z-50 flex items-center justify-center overflow-y-auto bg-gray-900/50 px-4 py-6 backdrop-blur-sm sm:px-0">
          <div className="relative max-h-[92vh] w-full max-w-5xl overflow-y-auto rounded-3xl bg-white shadow-2xl">
            <div className="sticky top-0 z-10 flex items-center justify-between border-b border-gray-100 bg-white px-6 py-4">
              <h2 className="text-xl font-bold text-gray-950">{editingBanner ? 'Upraviť banner' : 'Nový banner'}</h2>
              <button onClick={closeModal} className="rounded-full p-2 text-gray-400 transition hover:bg-gray-100 hover:text-gray-600">
                <XMarkIcon className="h-6 w-6" />
              </button>
            </div>

            <form onSubmit={handleSubmit} className="grid gap-6 p-6 lg:grid-cols-[1fr_380px]">
              <div className="space-y-4">
                <label className="block">
                  <span className="text-xs font-bold uppercase tracking-wider text-gray-600">Nadpis</span>
                  <input
                    value={bannerForm.title}
                    onChange={(event) => setBannerForm(prev => ({ ...prev, title: event.target.value }))}
                    className="mt-1 w-full rounded-xl border border-gray-200 px-3 py-2 text-sm outline-none focus:border-emerald-500 focus:ring-1 focus:ring-emerald-500"
                    required
                  />
                </label>
                <label className="block">
                  <span className="text-xs font-bold uppercase tracking-wider text-gray-600">Text</span>
                  <textarea
                    rows={6}
                    value={bannerForm.text}
                    onChange={(event) => setBannerForm(prev => ({ ...prev, text: event.target.value }))}
                    className="mt-1 w-full rounded-xl border border-gray-200 px-3 py-2 text-sm outline-none focus:border-emerald-500 focus:ring-1 focus:ring-emerald-500"
                  />
                </label>
                <div className="grid gap-4 sm:grid-cols-2">
                  <label className="block">
                    <span className="text-xs font-bold uppercase tracking-wider text-gray-600">Odkaz tlačidla</span>
                    <input
                      value={bannerForm.href}
                      onChange={(event) => setBannerForm(prev => ({ ...prev, href: event.target.value }))}
                      className="mt-1 w-full rounded-xl border border-gray-200 px-3 py-2 text-sm outline-none focus:border-emerald-500 focus:ring-1 focus:ring-emerald-500"
                    />
                  </label>
                  <label className="block">
                    <span className="text-xs font-bold uppercase tracking-wider text-gray-600">Text tlačidla</span>
                    <input
                      value={bannerForm.button_label}
                      onChange={(event) => setBannerForm(prev => ({ ...prev, button_label: event.target.value }))}
                      className="mt-1 w-full rounded-xl border border-gray-200 px-3 py-2 text-sm outline-none focus:border-emerald-500 focus:ring-1 focus:ring-emerald-500"
                    />
                  </label>
                  <label className="block">
                    <span className="text-xs font-bold uppercase tracking-wider text-gray-600">Poradie</span>
                    <input
                      type="number"
                      value={bannerForm.sort_order}
                      onChange={(event) => setBannerForm(prev => ({ ...prev, sort_order: event.target.value }))}
                      className="mt-1 w-full rounded-xl border border-gray-200 px-3 py-2 text-sm outline-none focus:border-emerald-500 focus:ring-1 focus:ring-emerald-500"
                    />
                  </label>
                  <label className="mt-6 flex items-center gap-3 rounded-xl bg-gray-50 px-3 py-2">
                    <input
                      type="checkbox"
                      checked={bannerForm.is_active}
                      onChange={(event) => setBannerForm(prev => ({ ...prev, is_active: event.target.checked }))}
                      className="h-4 w-4 rounded border-gray-300 text-emerald-600 focus:ring-emerald-500"
                    />
                    <span className="text-sm font-semibold text-gray-700">Zobraziť na webe</span>
                  </label>
                </div>
              </div>

              <aside className="space-y-4 rounded-2xl bg-gray-50 p-4">
                <div>
                  <span className="text-xs font-bold uppercase tracking-wider text-gray-600">Obrázok bannera</span>
                  <div className="relative mt-2 aspect-[16/10] overflow-hidden rounded-2xl bg-gray-100 ring-1 ring-gray-200">
                    {bannerForm.image_url ? (
                      <img src={resolveImage(bannerForm.image_url)} alt="" className="h-full w-full object-cover" />
                    ) : (
                      <div className="flex h-full items-center justify-center text-gray-300">
                        <PhotoIcon className="h-12 w-12" />
                      </div>
                    )}
                  </div>
                </div>
                <label className="flex cursor-pointer items-center justify-center rounded-xl bg-gray-200 px-4 py-3 text-sm font-bold text-gray-900 transition hover:bg-gray-300">
                  {uploading ? 'Nahrávam...' : 'Nahrať obrázok'}
                  <input type="file" accept="image/*" className="hidden" disabled={uploading} onChange={handleImageUpload} />
                </label>
                <input
                  value={bannerForm.image_url}
                  onChange={(event) => setBannerForm(prev => ({ ...prev, image_url: event.target.value }))}
                  placeholder="URL obrázka"
                  className="w-full rounded-xl border border-gray-200 px-3 py-2 text-xs outline-none focus:border-emerald-500 focus:ring-1 focus:ring-emerald-500"
                />
                <div className="flex justify-end gap-3 pt-4">
                  <button
                    type="button"
                    onClick={closeModal}
                    className="rounded-xl border border-gray-200 px-5 py-2 text-sm font-bold text-gray-700 transition hover:bg-gray-50"
                  >
                    Zrušiť
                  </button>
                  <button
                    type="submit"
                    disabled={saving}
                    className="rounded-xl bg-emerald-600 px-5 py-2 text-sm font-extrabold text-white transition hover:bg-emerald-700 disabled:opacity-60"
                  >
                    {saving ? 'Ukladám...' : 'Uložiť'}
                  </button>
                </div>
              </aside>
            </form>
          </div>
        </div>,
        document.body
      )}
    </div>
  )
}
