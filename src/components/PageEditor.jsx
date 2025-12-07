import { useState, useEffect } from 'react'
import { getPageWithBlocks, createBlock, deleteBlock, reorderBlocks } from '../api/pageDetail'
import { updatePage } from '../api/pages'
import CarListBlockEditor from './CarListBlockEditor'
import HeroBlockEditor from './HeroBlockEditor'
import {
  PlusIcon,
  TrashIcon,
  Bars3Icon,
  ArrowLeftIcon,
  CheckIcon
} from '@heroicons/react/24/outline'

export default function PageEditor({ page, onBack }) {
  const [pageData, setPageData] = useState(null)
  const [blocks, setBlocks] = useState([])
  const [loading, setLoading] = useState(true)
  const [saving, setSaving] = useState(false)
  const [error, setError] = useState(null)
  const [showAddBlock, setShowAddBlock] = useState(false)

  // Editable page fields
  const [title, setTitle] = useState('')
  const [slug, setSlug] = useState('')
  const [navLabel, setNavLabel] = useState('')
  const [isPublic, setIsPublic] = useState(false)
  const [showInNav, setShowInNav] = useState(false)

  useEffect(() => {
    if (page?.id) {
      loadPageData()
    }
  }, [page?.id])

  async function loadPageData() {
    try {
      setLoading(true)
      const { page: pageInfo, blocks: pageBlocks } = await getPageWithBlocks(page.id)
      setPageData(pageInfo)
      setBlocks(pageBlocks)
      setTitle(pageInfo.title)
      setSlug(pageInfo.slug)
      setNavLabel(pageInfo.nav_label || '')
      setIsPublic(pageInfo.is_public)
      setShowInNav(pageInfo.show_in_nav)
    } catch (err) {
      setError(err.message)
    } finally {
      setLoading(false)
    }
  }

  async function handleSavePageSettings() {
    try {
      setSaving(true)
      await updatePage(page.id, {
        title,
        slug,
        nav_label: navLabel || null,
        is_public: isPublic,
        show_in_nav: showInNav
      })
      alert('Stranka bola ulozena!')
    } catch (err) {
      alert('Chyba pri ukladani: ' + err.message)
    } finally {
      setSaving(false)
    }
  }

  async function handleAddBlock(type) {
    try {
      const newOrder = blocks.length > 0 ? Math.max(...blocks.map(b => b.order)) + 1 : 0
      const defaultData = getDefaultBlockData(type)

      const newBlock = await createBlock({
        page_id: page.id,
        type,
        order: newOrder,
        data: defaultData
      })

      setBlocks([...blocks, newBlock])
      setShowAddBlock(false)
    } catch (err) {
      alert('Chyba pri pridavani bloku: ' + err.message)
    }
  }

  async function handleDeleteBlock(blockId) {
    if (!confirm('Naozaj chcete odstranit tento blok?')) return

    try {
      await deleteBlock(blockId)
      setBlocks(blocks.filter(b => b.id !== blockId))
    } catch (err) {
      alert('Chyba pri mazani bloku: ' + err.message)
    }
  }

  function handleBlockUpdate(blockId, updatedBlock) {
    setBlocks(blocks.map(b => b.id === blockId ? updatedBlock : b))
  }

  function getDefaultBlockData(type) {
    switch (type) {
      case 'hero':
        return {
          title: 'Nadpis',
          subtitle: 'Podnadpis',
          backgroundImage: '',
          ctaText: '',
          ctaLink: ''
        }
      case 'carList':
        return {
          layout: 'grid',
          limit: 50,
          filter: {
            featuredOnly: false,
            minPrice: null,
            maxPrice: null,
            fuel: null,
            transmission: null
          }
        }
      case 'text':
        return {
          content: '<p>Obsah textu</p>'
        }
      case 'image':
        return {
          src: '',
          alt: '',
          caption: ''
        }
      default:
        return {}
    }
  }

  function renderBlockEditor(block) {
    switch (block.type) {
      case 'hero':
        return (
          <HeroBlockEditor
            key={block.id}
            block={block}
            onUpdate={(updated) => handleBlockUpdate(block.id, updated)}
          />
        )
      case 'carList':
        return (
          <CarListBlockEditor
            key={block.id}
            block={block}
            siteId={pageData?.site_id}
            onUpdate={(updated) => handleBlockUpdate(block.id, updated)}
          />
        )
      default:
        return (
          <div key={block.id} className="bg-gray-50 rounded-lg p-4">
            <p className="text-sm text-gray-500 mb-2">Blok: {block.type}</p>
            <pre className="text-xs bg-white p-2 rounded overflow-auto">
              {JSON.stringify(block.data, null, 2)}
            </pre>
          </div>
        )
    }
  }

  if (loading) {
    return (
      <div className="p-6">
        <div className="animate-pulse space-y-4">
          <div className="h-8 bg-gray-200 rounded w-1/3"></div>
          <div className="h-32 bg-gray-200 rounded"></div>
          <div className="h-32 bg-gray-200 rounded"></div>
        </div>
      </div>
    )
  }

  if (error) {
    return (
      <div className="p-6">
        <div className="bg-red-50 border border-red-200 rounded-lg p-4">
          <p className="text-red-600">{error}</p>
          <button onClick={loadPageData} className="mt-2 text-red-700 underline">
            Skusit znova
          </button>
        </div>
      </div>
    )
  }

  return (
    <div className="max-w-4xl mx-auto p-6">
      {/* Header */}
      <div className="flex items-center justify-between mb-6">
        <button
          onClick={onBack}
          className="flex items-center text-gray-600 hover:text-gray-900"
        >
          <ArrowLeftIcon className="h-5 w-5 mr-2" />
          Spat na zoznam
        </button>
        <button
          onClick={handleSavePageSettings}
          disabled={saving}
          className="flex items-center px-4 py-2 bg-gradient-to-r from-purple-600 to-blue-600 text-white rounded-lg hover:from-purple-700 hover:to-blue-700 disabled:opacity-50"
        >
          {saving ? (
            <>
              <svg className="animate-spin h-4 w-4 mr-2" viewBox="0 0 24 24">
                <circle className="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="4" fill="none" />
                <path className="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4z" />
              </svg>
              Ukladam...
            </>
          ) : (
            <>
              <CheckIcon className="h-4 w-4 mr-2" />
              Ulozit stranku
            </>
          )}
        </button>
      </div>

      {/* Page Settings */}
      <div className="bg-white rounded-xl shadow-sm border border-gray-200 p-6 mb-6">
        <h2 className="text-lg font-semibold mb-4">Nastavenia stranky</h2>

        <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">
              Nazov stranky
            </label>
            <input
              type="text"
              value={title}
              onChange={(e) => setTitle(e.target.value)}
              className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-purple-500 focus:border-transparent"
            />
          </div>

          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">
              URL slug
            </label>
            <input
              type="text"
              value={slug}
              onChange={(e) => setSlug(e.target.value)}
              className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-purple-500 focus:border-transparent"
            />
          </div>

          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">
              Nazov v navigacii (volitelne)
            </label>
            <input
              type="text"
              value={navLabel}
              onChange={(e) => setNavLabel(e.target.value)}
              placeholder={title}
              className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-purple-500 focus:border-transparent"
            />
          </div>

          <div className="flex items-center space-x-6">
            <label className="flex items-center">
              <input
                type="checkbox"
                checked={isPublic}
                onChange={(e) => setIsPublic(e.target.checked)}
                className="w-4 h-4 text-purple-600 rounded focus:ring-purple-500"
              />
              <span className="ml-2 text-sm text-gray-700">Verejna stranka</span>
            </label>

            <label className="flex items-center">
              <input
                type="checkbox"
                checked={showInNav}
                onChange={(e) => setShowInNav(e.target.checked)}
                className="w-4 h-4 text-purple-600 rounded focus:ring-purple-500"
              />
              <span className="ml-2 text-sm text-gray-700">Zobrazit v navigacii</span>
            </label>
          </div>
        </div>
      </div>

      {/* Blocks */}
      <div className="space-y-4">
        <div className="flex items-center justify-between">
          <h2 className="text-lg font-semibold">Bloky obsahu</h2>
          <button
            onClick={() => setShowAddBlock(!showAddBlock)}
            className="flex items-center px-3 py-1.5 text-sm bg-gray-100 hover:bg-gray-200 rounded-lg transition-colors"
          >
            <PlusIcon className="h-4 w-4 mr-1" />
            Pridat blok
          </button>
        </div>

        {/* Add Block Menu */}
        {showAddBlock && (
          <div className="bg-white rounded-xl shadow-sm border border-gray-200 p-4">
            <p className="text-sm text-gray-600 mb-3">Vyberte typ bloku:</p>
            <div className="grid grid-cols-2 md:grid-cols-4 gap-2">
              {['hero', 'carList', 'text', 'image'].map((type) => (
                <button
                  key={type}
                  onClick={() => handleAddBlock(type)}
                  className="p-3 text-left border border-gray-200 rounded-lg hover:border-purple-500 hover:bg-purple-50 transition-colors"
                >
                  <p className="font-medium text-gray-900 capitalize">{type}</p>
                  <p className="text-xs text-gray-500">
                    {type === 'hero' && 'Hlavicka s obrazkom'}
                    {type === 'carList' && 'Zoznam vozidiel'}
                    {type === 'text' && 'Textovy blok'}
                    {type === 'image' && 'Obrazok'}
                  </p>
                </button>
              ))}
            </div>
          </div>
        )}

        {/* Block List */}
        {blocks.length === 0 ? (
          <div className="bg-gray-50 rounded-xl p-8 text-center">
            <p className="text-gray-500">Ziadne bloky. Kliknite na "Pridat blok" pre vytvorenie obsahu.</p>
          </div>
        ) : (
          <div className="space-y-4">
            {blocks.map((block, index) => (
              <div
                key={block.id}
                className="bg-white rounded-xl shadow-sm border border-gray-200 overflow-hidden"
              >
                {/* Block Header */}
                <div className="flex items-center justify-between px-4 py-2 bg-gray-50 border-b border-gray-200">
                  <div className="flex items-center">
                    <Bars3Icon className="h-4 w-4 text-gray-400 mr-2 cursor-grab" />
                    <span className="text-sm font-medium text-gray-700 capitalize">
                      {block.type}
                    </span>
                    <span className="ml-2 text-xs text-gray-400">
                      #{index + 1}
                    </span>
                  </div>
                  <button
                    onClick={() => handleDeleteBlock(block.id)}
                    className="p-1 text-gray-400 hover:text-red-600 transition-colors"
                  >
                    <TrashIcon className="h-4 w-4" />
                  </button>
                </div>

                {/* Block Content */}
                <div className="p-4">
                  {renderBlockEditor(block)}
                </div>
              </div>
            ))}
          </div>
        )}
      </div>
    </div>
  )
}
