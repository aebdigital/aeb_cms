import { useState } from 'react'
import {
  ArrowLeftIcon,
  CheckIcon,
  ArrowDownTrayIcon,
  PlusIcon,
  TrashIcon,
  Bars3Icon,
} from '@heroicons/react/24/outline'
import { updateEspronPage, createEspronPage, toSitePage } from '../api/espronPages'
import ParagraphsEditor from './espron-blocks/ParagraphsEditor'
import FactsEditor from './espron-blocks/FactsEditor'
import PairsEditor from './espron-blocks/PairsEditor'
import StepsEditor from './espron-blocks/StepsEditor'
import FaqEditor from './espron-blocks/FaqEditor'

const BLOCK_TYPES = [
  { type: 'paragraphs', label: 'Odseky', desc: 'Textové odseky' },
  { type: 'facts', label: 'Fakty', desc: 'Čísla / štatistiky' },
  { type: 'pairs', label: 'Karty', desc: 'Dvojsĺpcové karty' },
  { type: 'steps', label: 'Postup', desc: 'Kroky postupu' },
  { type: 'faq', label: 'FAQ', desc: 'Otázky a odpovede' },
]

const FAMILY_OPTIONS = [
  { value: 'service', label: 'Služba' },
  { value: 'about', label: 'O nás' },
  { value: 'contact', label: 'Kontakt' },
  { value: 'tepovanie', label: 'Tepovanie' },
  { value: 'insulation-main', label: 'Zateplenie (hlavná)' },
  { value: 'insulation-city', label: 'Zateplenie (mesto)' },
  { value: 'insulation-case-study', label: 'Zateplenie (prípadová štúdia)' },
  { value: 'insulation-guide', label: 'Zateplenie (sprievodca)' },
  { value: 'faq', label: 'FAQ stránka' },
  { value: 'staffing', label: 'Personálne' },
]

function getDefaultBlock(type) {
  switch (type) {
    case 'paragraphs': return { type, title: '', paragraphs: [''] }
    case 'facts': return { type, title: '', items: [{ label: '', value: '' }] }
    case 'pairs': return { type, title: '', items: [{ title: '', body: '' }] }
    case 'steps': return { type, title: '', items: [{ title: '', body: '', details: [] }] }
    case 'faq': return { type, title: '', items: [{ question: '', answer: '' }] }
    default: return { type, title: '' }
  }
}

function BlockEditor({ block, onChange }) {
  switch (block.type) {
    case 'paragraphs': return <ParagraphsEditor block={block} onChange={onChange} />
    case 'facts': return <FactsEditor block={block} onChange={onChange} />
    case 'pairs': return <PairsEditor block={block} onChange={onChange} />
    case 'steps': return <StepsEditor block={block} onChange={onChange} />
    case 'faq': return <FaqEditor block={block} onChange={onChange} />
    default: return <p className="text-xs text-gray-400">Neznámy typ bloku: {block.type}</p>
  }
}

export default function EspronPageEditor({ page, onBack, onSaved }) {
  const isNew = !page?.id

  const [path, setPath] = useState(page?.path ?? '/')
  const [label, setLabel] = useState(page?.label ?? '')
  const [eyebrow, setEyebrow] = useState(page?.eyebrow ?? 'ESPRON')
  const [family, setFamily] = useState(page?.family ?? 'service')
  const [title, setTitle] = useState(page?.title ?? '')
  const [metaTitle, setMetaTitle] = useState(page?.meta_title ?? '')
  const [description, setDescription] = useState(page?.description ?? '')
  const [heroImage, setHeroImage] = useState(page?.hero_image ?? '')
  const [galleryImages, setGalleryImages] = useState(
    (page?.gallery_images ?? []).join('\n')
  )
  const [highlights, setHighlights] = useState(
    (page?.highlights ?? []).join('\n')
  )
  const [blocks, setBlocks] = useState(page?.blocks ?? [])
  const [related, setRelated] = useState(page?.related ?? [])
  const [isPublished, setIsPublished] = useState(page?.is_published ?? false)

  const [saving, setSaving] = useState(false)
  const [showAddBlock, setShowAddBlock] = useState(false)
  const [error, setError] = useState(null)

  function buildPayload() {
    return {
      path: path.startsWith('/') ? path : `/${path}`,
      label,
      eyebrow,
      family,
      title,
      meta_title: metaTitle || title,
      description,
      hero_image: heroImage || null,
      gallery_images: galleryImages.split('\n').map(s => s.trim()).filter(Boolean),
      highlights: highlights.split('\n').map(s => s.trim()).filter(Boolean),
      blocks,
      related,
      is_published: isPublished,
      lastmod: new Date().toISOString().split('T')[0],
    }
  }

  async function handleSave() {
    if (!label.trim() || !path.trim()) {
      setError('Vyplňte aspoň nadpis stránky a URL cestu.')
      return
    }
    setSaving(true)
    setError(null)
    try {
      const payload = buildPayload()
      let saved
      if (isNew) {
        saved = await createEspronPage(payload)
      } else {
        saved = await updateEspronPage(page.id, payload)
      }
      onSaved?.(saved)
    } catch (err) {
      setError(err.message)
    } finally {
      setSaving(false)
    }
  }

  function handleExport() {
    const payload = buildPayload()
    // Build the SitePage-compatible object manually (matches toSitePage shape)
    const sitePage = {
      path: payload.path,
      label: payload.label,
      eyebrow: payload.eyebrow,
      family: payload.family,
      title: payload.title,
      metaTitle: payload.meta_title,
      description: payload.description,
      lastmod: payload.lastmod,
      ...(payload.hero_image ? { heroImage: payload.hero_image } : {}),
      galleryImages: payload.gallery_images,
      highlights: payload.highlights,
      blocks: payload.blocks,
      related: payload.related,
    }

    const json = JSON.stringify(sitePage, null, 2)
    const blob = new Blob([json], { type: 'application/json' })
    const url = URL.createObjectURL(blob)
    const a = document.createElement('a')
    // filename = slug (strip leading slash)
    const slug = payload.path.replace(/^\//, '').replace(/\//g, '-') || 'espron-page'
    a.href = url
    a.download = `${slug}.json`
    a.click()
    URL.revokeObjectURL(url)
  }

  function addBlock(type) {
    setBlocks([...blocks, getDefaultBlock(type)])
    setShowAddBlock(false)
  }

  function updateBlock(index, updated) {
    setBlocks(blocks.map((b, i) => (i === index ? updated : b)))
  }

  function removeBlock(index) {
    if (!confirm('Odstrániť tento blok?')) return
    setBlocks(blocks.filter((_, i) => i !== index))
  }

  function moveBlock(index, direction) {
    const newBlocks = [...blocks]
    const target = index + direction
    if (target < 0 || target >= newBlocks.length) return
    ;[newBlocks[index], newBlocks[target]] = [newBlocks[target], newBlocks[index]]
    setBlocks(newBlocks)
  }

  function addRelated() {
    setRelated([...related, { href: '', label: '' }])
  }

  function updateRelated(index, field, val) {
    setRelated(related.map((r, i) => (i === index ? { ...r, [field]: val } : r)))
  }

  function removeRelated(index) {
    setRelated(related.filter((_, i) => i !== index))
  }

  return (
    <div className="max-w-3xl mx-auto space-y-6 pb-16">
      {/* Header */}
      <div className="flex items-center justify-between">
        <button
          onClick={onBack}
          className="flex items-center gap-2 text-gray-600 hover:text-gray-900 transition-colors"
        >
          <ArrowLeftIcon className="h-4 w-4" />
          <span className="text-sm">Späť na zoznam</span>
        </button>
        <div className="flex items-center gap-2">
          <button
            onClick={handleExport}
            className="flex items-center gap-2 px-4 py-2 border border-gray-300 text-gray-700 rounded-lg hover:bg-gray-50 transition-colors text-sm"
          >
            <ArrowDownTrayIcon className="h-4 w-4" />
            Exportovať JSON
          </button>
          <button
            onClick={handleSave}
            disabled={saving}
            className="flex items-center gap-2 px-4 py-2 bg-gradient-to-r from-purple-600 to-blue-600 text-white rounded-lg hover:from-purple-700 hover:to-blue-700 disabled:opacity-50 transition-all text-sm"
          >
            {saving ? (
              <>
                <svg className="animate-spin h-4 w-4" viewBox="0 0 24 24">
                  <circle className="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="4" fill="none" />
                  <path className="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4z" />
                </svg>
                Ukladám...
              </>
            ) : (
              <>
                <CheckIcon className="h-4 w-4" />
                Uložiť
              </>
            )}
          </button>
        </div>
      </div>

      {error && (
        <div className="bg-red-50 border border-red-200 rounded-lg p-3 text-sm text-red-700">
          {error}
        </div>
      )}

      {/* Basic Info */}
      <div className="bg-white rounded-xl border border-gray-200 shadow-sm p-6 space-y-4">
        <h2 className="font-semibold text-gray-900">Základné informácie</h2>
        <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
          <div>
            <label className="block text-xs font-medium text-gray-600 mb-1">
              URL cesta <span className="text-red-500">*</span>
            </label>
            <input
              type="text"
              value={path}
              onChange={(e) => setPath(e.target.value)}
              className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm focus:ring-2 focus:ring-purple-500 focus:border-transparent"
              placeholder="/nova-sluzba"
            />
            <p className="text-xs text-gray-400 mt-1">Začínajte lomítkom, napr. /nova-sluzba</p>
          </div>
          <div>
            <label className="block text-xs font-medium text-gray-600 mb-1">
              Nadpis stránky <span className="text-red-500">*</span>
            </label>
            <input
              type="text"
              value={label}
              onChange={(e) => setLabel(e.target.value)}
              className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm focus:ring-2 focus:ring-purple-500 focus:border-transparent"
              placeholder="Nová služba"
            />
          </div>
          <div>
            <label className="block text-xs font-medium text-gray-600 mb-1">Eyebrow text</label>
            <input
              type="text"
              value={eyebrow}
              onChange={(e) => setEyebrow(e.target.value)}
              className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm focus:ring-2 focus:ring-purple-500 focus:border-transparent"
              placeholder="ESPRON"
            />
            <p className="text-xs text-gray-400 mt-1">Malý text nad nadpisom v hero sekcii</p>
          </div>
          <div>
            <label className="block text-xs font-medium text-gray-600 mb-1">Kategória (family)</label>
            <select
              value={family}
              onChange={(e) => setFamily(e.target.value)}
              className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm focus:ring-2 focus:ring-purple-500 focus:border-transparent"
            >
              {FAMILY_OPTIONS.map(opt => (
                <option key={opt.value} value={opt.value}>{opt.label}</option>
              ))}
            </select>
          </div>
          <div>
            <label className="block text-xs font-medium text-gray-600 mb-1">Title tag</label>
            <input
              type="text"
              value={title}
              onChange={(e) => setTitle(e.target.value)}
              className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm focus:ring-2 focus:ring-purple-500 focus:border-transparent"
              placeholder="Nová služba | ESPRON"
            />
          </div>
          <div>
            <label className="block text-xs font-medium text-gray-600 mb-1">Meta title (SEO)</label>
            <input
              type="text"
              value={metaTitle}
              onChange={(e) => setMetaTitle(e.target.value)}
              className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm focus:ring-2 focus:ring-purple-500 focus:border-transparent"
              placeholder="Nechajte prázdne = rovnaké ako title tag"
            />
          </div>
          <div className="md:col-span-2">
            <label className="block text-xs font-medium text-gray-600 mb-1">Meta description</label>
            <textarea
              value={description}
              onChange={(e) => setDescription(e.target.value)}
              rows={2}
              className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm focus:ring-2 focus:ring-purple-500 focus:border-transparent resize-y"
              placeholder="Krátky popis stránky pre vyhľadávače (150–160 znakov)"
            />
          </div>
          <div className="md:col-span-2 flex items-center gap-2">
            <input
              type="checkbox"
              id="is_published"
              checked={isPublished}
              onChange={(e) => setIsPublished(e.target.checked)}
              className="w-4 h-4 text-purple-600 rounded focus:ring-purple-500"
            />
            <label htmlFor="is_published" className="text-sm text-gray-700">Publikovaná</label>
          </div>
        </div>
      </div>

      {/* Hero & Gallery */}
      <div className="bg-white rounded-xl border border-gray-200 shadow-sm p-6 space-y-4">
        <h2 className="font-semibold text-gray-900">Hero & galéria</h2>
        <div>
          <label className="block text-xs font-medium text-gray-600 mb-1">URL hero obrázka</label>
          <input
            type="text"
            value={heroImage}
            onChange={(e) => setHeroImage(e.target.value)}
            className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm focus:ring-2 focus:ring-purple-500 focus:border-transparent"
            placeholder="https://..."
          />
        </div>
        <div>
          <label className="block text-xs font-medium text-gray-600 mb-1">
            URL obrázkov galérie <span className="text-gray-400">(každý na nový riadok)</span>
          </label>
          <textarea
            value={galleryImages}
            onChange={(e) => setGalleryImages(e.target.value)}
            rows={4}
            className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm focus:ring-2 focus:ring-purple-500 focus:border-transparent resize-y font-mono"
            placeholder="https://example.com/img1.jpg&#10;https://example.com/img2.jpg"
          />
        </div>
        <div>
          <label className="block text-xs font-medium text-gray-600 mb-1">
            Highlights <span className="text-gray-400">(každý na nový riadok — zobrazujú sa v hero sekcii)</span>
          </label>
          <textarea
            value={highlights}
            onChange={(e) => setHighlights(e.target.value)}
            rows={3}
            className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm focus:ring-2 focus:ring-purple-500 focus:border-transparent resize-y"
            placeholder="Rýchle a kvalitné prevedenie&#10;15+ rokov skúseností&#10;Záruka na práce"
          />
        </div>
      </div>

      {/* Content Blocks */}
      <div className="space-y-3">
        <div className="flex items-center justify-between">
          <h2 className="font-semibold text-gray-900">Obsahové bloky</h2>
          <button
            onClick={() => setShowAddBlock(!showAddBlock)}
            className="flex items-center gap-1.5 px-3 py-1.5 text-sm bg-gray-100 hover:bg-gray-200 rounded-lg transition-colors"
          >
            <PlusIcon className="h-4 w-4" />
            Pridať blok
          </button>
        </div>

        {showAddBlock && (
          <div className="bg-white rounded-xl border border-gray-200 shadow-sm p-4">
            <p className="text-xs text-gray-500 mb-3">Vyberte typ bloku:</p>
            <div className="grid grid-cols-2 md:grid-cols-5 gap-2">
              {BLOCK_TYPES.map(({ type, label: bLabel, desc }) => (
                <button
                  key={type}
                  onClick={() => addBlock(type)}
                  className="p-3 text-left border border-gray-200 rounded-lg hover:border-purple-400 hover:bg-purple-50 transition-colors"
                >
                  <p className="font-medium text-gray-900 text-sm">{bLabel}</p>
                  <p className="text-xs text-gray-400 mt-0.5">{desc}</p>
                </button>
              ))}
            </div>
          </div>
        )}

        {blocks.length === 0 ? (
          <div className="bg-gray-50 rounded-xl border-2 border-dashed border-gray-200 p-8 text-center">
            <p className="text-gray-400 text-sm">Žiadne bloky. Kliknite na „Pridať blok".</p>
          </div>
        ) : (
          <div className="space-y-3">
            {blocks.map((block, index) => {
              const meta = BLOCK_TYPES.find(b => b.type === block.type)
              return (
                <div
                  key={index}
                  className="bg-white rounded-xl border border-gray-200 shadow-sm overflow-hidden"
                >
                  {/* Block header */}
                  <div className="flex items-center justify-between px-4 py-2.5 bg-gray-50 border-b border-gray-200">
                    <div className="flex items-center gap-2">
                      <Bars3Icon className="h-4 w-4 text-gray-300" />
                      <span className="text-sm font-medium text-gray-700">
                        {meta?.label ?? block.type}
                      </span>
                      {block.title && (
                        <span className="text-xs text-gray-400 truncate max-w-[200px]">
                          — {block.title}
                        </span>
                      )}
                    </div>
                    <div className="flex items-center gap-1">
                      <button
                        onClick={() => moveBlock(index, -1)}
                        disabled={index === 0}
                        className="p-1 text-gray-400 hover:text-gray-600 disabled:opacity-30 transition-colors text-xs"
                        title="Posunúť hore"
                      >▲</button>
                      <button
                        onClick={() => moveBlock(index, 1)}
                        disabled={index === blocks.length - 1}
                        className="p-1 text-gray-400 hover:text-gray-600 disabled:opacity-30 transition-colors text-xs"
                        title="Posunúť dole"
                      >▼</button>
                      <button
                        onClick={() => removeBlock(index)}
                        className="p-1.5 text-gray-400 hover:text-red-500 transition-colors"
                      >
                        <TrashIcon className="h-4 w-4" />
                      </button>
                    </div>
                  </div>
                  <div className="p-4">
                    <BlockEditor
                      block={block}
                      onChange={(updated) => updateBlock(index, updated)}
                    />
                  </div>
                </div>
              )
            })}
          </div>
        )}
      </div>

      {/* Related pages */}
      <div className="bg-white rounded-xl border border-gray-200 shadow-sm p-6 space-y-3">
        <div className="flex items-center justify-between">
          <h2 className="font-semibold text-gray-900">Súvisiace stránky</h2>
          <button
            onClick={addRelated}
            className="flex items-center gap-1 text-xs text-purple-600 hover:text-purple-700 transition-colors"
          >
            <PlusIcon className="h-3.5 w-3.5" />
            Pridať
          </button>
        </div>
        {related.length === 0 ? (
          <p className="text-xs text-gray-400">Žiadne súvisiace stránky.</p>
        ) : (
          <div className="space-y-2">
            {related.map((r, i) => (
              <div key={i} className="flex gap-2 items-center">
                <input
                  type="text"
                  value={r.href}
                  onChange={(e) => updateRelated(i, 'href', e.target.value)}
                  className="flex-1 px-3 py-2 border border-gray-300 rounded-lg text-sm focus:ring-2 focus:ring-purple-500 focus:border-transparent"
                  placeholder="/sluzba"
                />
                <input
                  type="text"
                  value={r.label}
                  onChange={(e) => updateRelated(i, 'label', e.target.value)}
                  className="flex-1 px-3 py-2 border border-gray-300 rounded-lg text-sm focus:ring-2 focus:ring-purple-500 focus:border-transparent"
                  placeholder="Názov stránky"
                />
                <button
                  onClick={() => removeRelated(i)}
                  className="p-2 text-gray-400 hover:text-red-500 transition-colors"
                >
                  <TrashIcon className="h-4 w-4" />
                </button>
              </div>
            ))}
          </div>
        )}
      </div>
    </div>
  )
}
