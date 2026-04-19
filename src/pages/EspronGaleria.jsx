import { useCallback, useEffect, useMemo, useState } from 'react'
import {
  PlusIcon,
  TrashIcon,
  ArrowUpIcon,
  ArrowDownIcon,
  PhotoIcon,
  EyeIcon,
  EyeSlashIcon,
} from '@heroicons/react/24/outline'
import {
  ESPRON_SERVICES,
  getServicesForSite,
  listServiceGallery,
  createServiceGalleryItem,
  updateServiceGalleryItem,
  deleteServiceGalleryItem,
  reorderServiceGallery,
  uploadServicePhoto,
} from '../api/serviceGalleries'
import { compressImages } from '../lib/fileUtils'

const SITES = [
  { value: 'sk', label: 'Slovensko (espron.sk)' },
  { value: 'cz', label: 'Česko (espron.cz)' },
]

export default function EspronGaleria() {
  const [site, setSite] = useState('sk')
  const services = useMemo(() => getServicesForSite(site), [site])
  const [activeSlug, setActiveSlug] = useState(services[0]?.slug ?? '')
  const [items, setItems] = useState([])
  const [loading, setLoading] = useState(false)
  const [uploading, setUploading] = useState(false)
  const [error, setError] = useState(null)

  const load = useCallback(async () => {
    try {
      setLoading(true)
      setError(null)
      const rows = await listServiceGallery(site, activeSlug)
      setItems(rows)
    } catch (err) {
      setError(err.message)
    } finally {
      setLoading(false)
    }
  }, [activeSlug, site])

  useEffect(() => {
    setActiveSlug(services[0]?.slug ?? '')
  }, [site, services])

  useEffect(() => {
    if (!activeSlug) return
    load()
  }, [activeSlug, load])

  async function handleUpload(event) {
    const files = Array.from(event.target.files ?? [])
    event.target.value = ''
    if (files.length === 0) return
    try {
      setUploading(true)
      setError(null)
      const compressed = await compressImages(files, 600)
      const baseOrder = items.length > 0
        ? Math.max(...items.map((i) => i.sort_order)) + 10
        : 10
      for (let i = 0; i < compressed.length; i++) {
        const file = compressed[i]
        const url = await uploadServicePhoto(file, site, activeSlug)
        await createServiceGalleryItem({
          service_slug: activeSlug,
          site,
          image_url: url,
          alt: '',
          caption: '',
          kind: 'image',
          sort_order: baseOrder + i * 10,
          is_published: true,
        })
      }
      await load()
    } catch (err) {
      setError(err.message)
    } finally {
      setUploading(false)
    }
  }

  async function handleDelete(item) {
    if (!confirm('Odstrániť túto fotku z galérie?')) return
    try {
      await deleteServiceGalleryItem(item.id)
      setItems((prev) => prev.filter((i) => i.id !== item.id))
    } catch (err) {
      alert('Chyba pri mazaní: ' + err.message)
    }
  }

  async function handleTogglePublish(item) {
    try {
      const updated = await updateServiceGalleryItem(item.id, {
        is_published: !item.is_published,
      })
      setItems((prev) => prev.map((i) => (i.id === item.id ? updated : i)))
    } catch (err) {
      alert('Chyba: ' + err.message)
    }
  }

  async function handleEditField(item, field, value) {
    try {
      const updated = await updateServiceGalleryItem(item.id, { [field]: value })
      setItems((prev) => prev.map((i) => (i.id === item.id ? updated : i)))
    } catch (err) {
      alert('Chyba: ' + err.message)
    }
  }

  async function handleMove(index, direction) {
    const target = index + direction
    if (target < 0 || target >= items.length) return
    const next = [...items]
    const [moved] = next.splice(index, 1)
    next.splice(target, 0, moved)
    const reordered = next.map((it, idx) => ({ ...it, sort_order: (idx + 1) * 10 }))
    setItems(reordered)
    try {
      await reorderServiceGallery(reordered.map((it) => ({ id: it.id, sort_order: it.sort_order })))
    } catch (err) {
      alert('Chyba pri presúvaní: ' + err.message)
      await load()
    }
  }

  const activeService = services.find((s) => s.slug === activeSlug)
  const publishedCount = items.filter((i) => i.is_published).length

  return (
    <div className="space-y-6">
      <div className="flex flex-wrap items-end gap-4">
        <div>
          <h1 className="text-2xl font-bold text-gray-900">Espron — Realizácie (galérie)</h1>
          <p className="mt-1 text-sm text-gray-500">
            Pridajte fotky realizácií k jednotlivým službám. Ak nie sú žiadne publikované,
            sekcia sa na webe nezobrazí.
          </p>
        </div>
        <div className="ml-auto">
          <label className="block text-xs font-semibold uppercase tracking-wide text-gray-500">
            Web
          </label>
          <select
            value={site}
            onChange={(e) => setSite(e.target.value)}
            className="mt-1 rounded-lg border border-gray-300 bg-white px-3 py-2 text-sm shadow-sm focus:border-blue-500 focus:outline-none"
          >
            {SITES.map((s) => (
              <option key={s.value} value={s.value}>{s.label}</option>
            ))}
          </select>
        </div>
      </div>

      <div className="grid gap-6 lg:grid-cols-[260px_1fr]">
        <aside className="rounded-2xl border border-gray-200 bg-white p-3">
          <p className="px-2 pb-2 pt-1 text-xs font-semibold uppercase tracking-wide text-gray-400">
            Služby
          </p>
          <ul className="space-y-1">
            {services.map((s) => {
              const active = s.slug === activeSlug
              return (
                <li key={s.slug}>
                  <button
                    type="button"
                    onClick={() => setActiveSlug(s.slug)}
                    className={`w-full rounded-lg px-3 py-2 text-left text-sm transition-colors ${
                      active
                        ? 'bg-blue-600 text-white shadow'
                        : 'text-gray-700 hover:bg-gray-100'
                    }`}
                  >
                    <span className="block font-medium">{s.label}</span>
                    <span className={`block text-[11px] uppercase tracking-wide ${
                      active ? 'text-white/70' : 'text-gray-400'
                    }`}>
                      /{s.slug}
                    </span>
                  </button>
                </li>
              )
            })}
          </ul>
        </aside>

        <section className="rounded-2xl border border-gray-200 bg-white p-6">
          <div className="mb-6 flex flex-wrap items-center gap-3">
            <div className="flex-1">
              <h2 className="text-lg font-semibold text-gray-900">
                {activeService?.label ?? 'Vyberte službu'}
              </h2>
              <p className="text-xs text-gray-500">
                {publishedCount} publikovaných · {items.length} celkom
              </p>
            </div>
            <label className="inline-flex cursor-pointer items-center gap-2 rounded-lg bg-blue-600 px-4 py-2 text-sm font-medium text-white shadow hover:bg-blue-700">
              <PlusIcon className="h-4 w-4" />
              {uploading ? 'Nahrávam…' : 'Pridať fotky'}
              <input
                type="file"
                accept="image/*"
                multiple
                disabled={uploading || !activeSlug}
                onChange={handleUpload}
                className="hidden"
              />
            </label>
          </div>

          {error ? (
            <div className="mb-4 rounded-lg border border-red-200 bg-red-50 px-4 py-3 text-sm text-red-700">
              {error}
            </div>
          ) : null}

          {loading ? (
            <p className="text-sm text-gray-500">Načítavam…</p>
          ) : items.length === 0 ? (
            <div className="rounded-xl border-2 border-dashed border-gray-200 px-6 py-16 text-center">
              <PhotoIcon className="mx-auto h-10 w-10 text-gray-300" />
              <p className="mt-3 text-sm text-gray-500">
                Zatiaľ žiadne fotky. Sekcia Realizácie sa pre túto službu nezobrazí.
              </p>
            </div>
          ) : (
            <ul className="grid gap-4 sm:grid-cols-2 xl:grid-cols-3">
              {items.map((item, index) => (
                <li
                  key={item.id}
                  className={`rounded-xl border bg-white shadow-sm overflow-hidden ${
                    item.is_published ? 'border-gray-200' : 'border-amber-300 bg-amber-50/40'
                  }`}
                >
                  <div className="relative aspect-[4/3] bg-gray-100">
                    <img
                      src={item.image_url}
                      alt={item.alt}
                      className="absolute inset-0 h-full w-full object-cover"
                      loading="lazy"
                    />
                  </div>
                  <div className="space-y-2 p-3">
                    <input
                      type="text"
                      defaultValue={item.alt}
                      onBlur={(e) => {
                        if (e.target.value !== item.alt) handleEditField(item, 'alt', e.target.value)
                      }}
                      placeholder="Alt text (popis pre vyhľadávače)"
                      className="w-full rounded border border-gray-200 px-2 py-1 text-xs"
                    />
                    <input
                      type="text"
                      defaultValue={item.caption}
                      onBlur={(e) => {
                        if (e.target.value !== item.caption) handleEditField(item, 'caption', e.target.value)
                      }}
                      placeholder="Titulok (napr. miesto realizácie)"
                      className="w-full rounded border border-gray-200 px-2 py-1 text-xs"
                    />
                    <div className="flex items-center justify-between gap-2 pt-1">
                      <div className="flex gap-1">
                        <button
                          type="button"
                          onClick={() => handleMove(index, -1)}
                          disabled={index === 0}
                          className="rounded p-1 text-gray-500 hover:bg-gray-100 disabled:opacity-40"
                          title="Posunúť hore"
                        >
                          <ArrowUpIcon className="h-4 w-4" />
                        </button>
                        <button
                          type="button"
                          onClick={() => handleMove(index, 1)}
                          disabled={index === items.length - 1}
                          className="rounded p-1 text-gray-500 hover:bg-gray-100 disabled:opacity-40"
                          title="Posunúť dole"
                        >
                          <ArrowDownIcon className="h-4 w-4" />
                        </button>
                      </div>
                      <div className="flex gap-1">
                        <button
                          type="button"
                          onClick={() => handleTogglePublish(item)}
                          className="rounded p-1 text-gray-500 hover:bg-gray-100"
                          title={item.is_published ? 'Skryť' : 'Publikovať'}
                        >
                          {item.is_published ? (
                            <EyeIcon className="h-4 w-4" />
                          ) : (
                            <EyeSlashIcon className="h-4 w-4 text-amber-600" />
                          )}
                        </button>
                        <button
                          type="button"
                          onClick={() => handleDelete(item)}
                          className="rounded p-1 text-red-500 hover:bg-red-50"
                          title="Odstrániť"
                        >
                          <TrashIcon className="h-4 w-4" />
                        </button>
                      </div>
                    </div>
                  </div>
                </li>
              ))}
            </ul>
          )}
        </section>
      </div>
    </div>
  )
}
