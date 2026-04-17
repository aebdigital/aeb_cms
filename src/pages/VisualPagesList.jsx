import { useEffect, useState } from 'react'
import { useNavigate } from 'react-router-dom'
import {
  PlusIcon,
  PencilIcon,
  TrashIcon,
  EyeIcon,
  DocumentPlusIcon,
  GlobeAltIcon,
} from '@heroicons/react/24/outline'
import { listVisualPages, deleteVisualPage, togglePublishVisualPage } from '../api/visualPages'

const PREVIEW_ORIGIN = 'http://localhost:3006'

// Iframe is rendered at desktop width and then scaled down to fit the card.
const PREVIEW_RENDER_WIDTH = 1440
const PREVIEW_RENDER_HEIGHT = 900
const PREVIEW_SCALE = 0.26

export default function VisualPagesList() {
  const navigate = useNavigate()
  const [pages, setPages] = useState([])
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState(null)

  useEffect(() => {
    loadPages()
  }, [])

  async function loadPages() {
    try {
      setLoading(true)
      setError(null)
      const data = await listVisualPages()
      setPages(data)
    } catch (err) {
      setError(err.message)
    } finally {
      setLoading(false)
    }
  }

  async function handleDelete(page, e) {
    e.stopPropagation()
    if (!confirm(`Naozaj odstrániť stránku "${page.title}"?`)) return
    try {
      await deleteVisualPage(page.id)
      setPages(prev => prev.filter(p => p.id !== page.id))
    } catch (err) {
      alert('Chyba pri mazaní: ' + err.message)
    }
  }

  async function handleTogglePublish(page, e) {
    e.stopPropagation()
    try {
      const updated = await togglePublishVisualPage(page.id, !page.is_published)
      setPages(prev => prev.map(p => p.id === page.id ? updated : p))
    } catch (err) {
      alert('Chyba: ' + err.message)
    }
  }

  function handlePreview(page, e) {
    e.stopPropagation()
    const url = `${PREVIEW_ORIGIN}/p/${page.slug}${page.is_published ? '' : '?preview=1'}`
    window.open(url, '_blank', 'noopener,noreferrer')
  }

  return (
    <div>
      <div className="flex items-center justify-between mb-6">
        <div>
          <h1 className="text-2xl font-bold text-gray-900">Espron stránky</h1>
          <p className="text-sm text-gray-500 mt-0.5">
            Vytvorte stránku v drag-and-drop builderi a publikujte na espron-next.
          </p>
        </div>
        <button
          onClick={() => navigate('/visual-builder/edit/new')}
          className="flex items-center gap-2 px-4 py-2 bg-gradient-to-r from-indigo-600 to-purple-600 text-white rounded-lg hover:from-indigo-700 hover:to-purple-700 transition-all text-sm shadow-sm"
        >
          <PlusIcon className="h-4 w-4" />
          Nová stránka
        </button>
      </div>

      {error && (
        <div className="bg-red-50 border border-red-200 rounded-xl p-4 mb-4 text-sm text-red-700">
          {error}
        </div>
      )}

      {loading ? (
        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-5">
          {[1, 2, 3].map(i => (
            <div key={i} className="aspect-[4/3] bg-white rounded-xl border border-gray-200 animate-pulse" />
          ))}
        </div>
      ) : pages.length === 0 ? (
        <div className="bg-white rounded-xl border-2 border-dashed border-gray-200 p-12 text-center">
          <DocumentPlusIcon className="h-12 w-12 text-gray-300 mx-auto mb-3" />
          <p className="text-gray-500 font-medium">Žiadne stránky</p>
          <p className="text-gray-400 text-sm mt-1">Kliknite na „Nová stránka" pre začatie.</p>
        </div>
      ) : (
        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-5">
          {pages.map(page => {
            const previewUrl = `${PREVIEW_ORIGIN}/p/${page.slug}?preview=1`
            return (
              <div
                key={page.id}
                onClick={() => navigate(`/visual-builder/edit/${page.id}`)}
                className="group bg-white rounded-xl border border-gray-200 overflow-hidden cursor-pointer hover:border-indigo-300 hover:shadow-lg transition-all flex flex-col"
              >
                {/* Preview area */}
                <div
                  className="relative bg-gray-50 border-b border-gray-200 overflow-hidden"
                  style={{
                    height: `${PREVIEW_RENDER_HEIGHT * PREVIEW_SCALE}px`,
                  }}
                >
                  {page.elements && page.elements.length > 0 ? (
                    <div
                      className="absolute top-0 left-0"
                      style={{
                        width: `${PREVIEW_RENDER_WIDTH}px`,
                        height: `${PREVIEW_RENDER_HEIGHT}px`,
                        transform: `scale(${PREVIEW_SCALE})`,
                        transformOrigin: 'top left',
                        pointerEvents: 'none',
                      }}
                    >
                      <iframe
                        src={previewUrl}
                        title={`Náhľad: ${page.title}`}
                        className="w-full h-full border-0 bg-white"
                        loading="lazy"
                        sandbox="allow-same-origin allow-scripts"
                      />
                    </div>
                  ) : (
                    <div className="absolute inset-0 flex flex-col items-center justify-center text-gray-300">
                      <DocumentPlusIcon className="h-10 w-10 mb-1" />
                      <p className="text-xs">Prázdna stránka</p>
                    </div>
                  )}

                  {/* Hover overlay with actions */}
                  <div className="absolute inset-0 bg-gradient-to-t from-black/50 via-black/0 to-black/0 opacity-0 group-hover:opacity-100 transition-opacity pointer-events-none" />
                  <div className="absolute top-2 right-2 flex items-center gap-1 opacity-0 group-hover:opacity-100 transition-opacity">
                    <button
                      onClick={(e) => handlePreview(page, e)}
                      className="p-1.5 bg-white/95 backdrop-blur text-gray-700 hover:text-indigo-600 rounded-lg shadow-sm transition-colors"
                      title="Otvoriť v novej karte"
                    >
                      <EyeIcon className="h-4 w-4" />
                    </button>
                    <button
                      onClick={(e) => { e.stopPropagation(); navigate(`/visual-builder/edit/${page.id}`) }}
                      className="p-1.5 bg-white/95 backdrop-blur text-gray-700 hover:text-indigo-600 rounded-lg shadow-sm transition-colors"
                      title="Upraviť"
                    >
                      <PencilIcon className="h-4 w-4" />
                    </button>
                    <button
                      onClick={(e) => handleDelete(page, e)}
                      className="p-1.5 bg-white/95 backdrop-blur text-gray-700 hover:text-red-600 rounded-lg shadow-sm transition-colors"
                      title="Odstrániť"
                    >
                      <TrashIcon className="h-4 w-4" />
                    </button>
                  </div>
                </div>

                {/* Meta row */}
                <div className="flex items-center justify-between gap-3 px-4 py-3">
                  <div className="min-w-0 flex-1">
                    <p className="font-medium text-gray-900 text-sm truncate">{page.title}</p>
                    <p className="text-xs text-gray-400 truncate">/p/{page.slug}</p>
                  </div>
                  <button
                    onClick={(e) => handleTogglePublish(page, e)}
                    className={`text-[10px] px-2 py-1 rounded-full font-semibold transition-colors flex-shrink-0 ${
                      page.is_published
                        ? 'bg-green-100 text-green-700 hover:bg-green-200'
                        : 'bg-gray-100 text-gray-500 hover:bg-gray-200'
                    }`}
                    title={page.is_published ? 'Kliknite na zneplatnenie' : 'Kliknite na publikovanie'}
                  >
                    {page.is_published ? 'PUBLIKOVANÁ' : 'DRAFT'}
                  </button>
                </div>
              </div>
            )
          })}
        </div>
      )}
    </div>
  )
}
