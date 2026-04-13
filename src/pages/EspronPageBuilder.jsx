import { useState, useEffect } from 'react'
import { useNavigate } from 'react-router-dom'
import { useAuth } from '../contexts/AuthContext'
import { listEspronPages, deleteEspronPage } from '../api/espronPages'
import EspronPageEditor from '../components/EspronPageEditor'
import {
  PlusIcon,
  TrashIcon,
  PencilIcon,
  ArrowRightOnRectangleIcon,
  DocumentPlusIcon,
  GlobeAltIcon,
} from '@heroicons/react/24/outline'

export default function EspronPageBuilder() {
  const { user, profile, logout } = useAuth()
  const navigate = useNavigate()
  const [pages, setPages] = useState([])
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState(null)
  const [selectedPage, setSelectedPage] = useState(null) // null = list view, {} = new page, {...} = edit page

  useEffect(() => {
    loadPages()
  }, [])

  async function loadPages() {
    try {
      setLoading(true)
      setError(null)
      const data = await listEspronPages()
      setPages(data)
    } catch (err) {
      setError(err.message)
    } finally {
      setLoading(false)
    }
  }

  async function handleDelete(page, e) {
    e.stopPropagation()
    if (!confirm(`Naozaj odstrániť stránku "${page.label}"?`)) return
    try {
      await deleteEspronPage(page.id)
      setPages(pages.filter(p => p.id !== page.id))
    } catch (err) {
      alert('Chyba pri mazaní: ' + err.message)
    }
  }

  function handleSaved(savedPage) {
    setPages(prev => {
      const exists = prev.find(p => p.id === savedPage.id)
      if (exists) return prev.map(p => p.id === savedPage.id ? savedPage : p)
      return [savedPage, ...prev]
    })
    setSelectedPage(null)
  }

  async function handleLogout() {
    try {
      await logout()
      navigate('/login')
    } catch (err) {
      console.error(err)
    }
  }

  return (
    <div className="min-h-screen bg-gray-50">
      {/* Top Bar */}
      <header className="bg-gradient-to-r from-slate-900 via-indigo-900 to-slate-900 text-white shadow-lg">
        <div className="max-w-6xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="flex items-center justify-between h-16">
            <div className="flex items-center gap-3">
              <div className="w-8 h-8 bg-gradient-to-r from-indigo-400 to-purple-400 rounded-lg flex items-center justify-center">
                <GlobeAltIcon className="w-5 h-5 text-white" />
              </div>
              <div>
                <span className="font-bold text-lg leading-none">Espron</span>
                <span className="text-gray-400 text-sm ml-1.5">Page Builder</span>
              </div>
            </div>
            <div className="flex items-center gap-3">
              <span className="text-sm text-gray-300 hidden sm:block">
                {profile?.full_name || user?.email}
              </span>
              <button
                onClick={handleLogout}
                className="p-2 hover:bg-white/10 rounded-lg transition-colors"
                title="Odhlásiť sa"
              >
                <ArrowRightOnRectangleIcon className="h-5 w-5" />
              </button>
            </div>
          </div>
        </div>
      </header>

      <div className="max-w-6xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        {selectedPage !== null ? (
          /* Editor view */
          <EspronPageEditor
            page={selectedPage?.id ? selectedPage : null}
            onBack={() => setSelectedPage(null)}
            onSaved={handleSaved}
          />
        ) : (
          /* List view */
          <div>
            <div className="flex items-center justify-between mb-6">
              <div>
                <h1 className="text-2xl font-bold text-gray-900">Espron stránky</h1>
                <p className="text-sm text-gray-500 mt-0.5">
                  Vytvorte novú stránku, exportujte JSON a nasaďte ju na espron-next.
                </p>
              </div>
              <button
                onClick={() => setSelectedPage({})}
                className="flex items-center gap-2 px-4 py-2 bg-gradient-to-r from-indigo-600 to-purple-600 text-white rounded-lg hover:from-indigo-700 hover:to-purple-700 transition-all text-sm shadow-sm"
              >
                <PlusIcon className="h-4 w-4" />
                Nová stránka
              </button>
            </div>

            {/* How-to banner */}
            <div className="bg-indigo-50 border border-indigo-200 rounded-xl p-4 mb-6">
              <p className="text-sm font-semibold text-indigo-800 mb-1">Ako to funguje</p>
              <ol className="text-sm text-indigo-700 space-y-0.5 list-decimal list-inside">
                <li>Vytvorte stránku a vyplňte obsah</li>
                <li>Kliknite na <strong>Exportovať JSON</strong> — stiahne sa súbor</li>
                <li>Umiestnite súbor do <code className="bg-indigo-100 px-1 rounded text-xs">espron-next/_cms_pages/</code></li>
                <li>Nasaďte espron-next — stránka bude živá</li>
              </ol>
            </div>

            {error && (
              <div className="bg-red-50 border border-red-200 rounded-xl p-4 mb-4 text-sm text-red-700">
                {error}
              </div>
            )}

            {loading ? (
              <div className="space-y-3">
                {[1, 2, 3].map(i => (
                  <div key={i} className="h-16 bg-white rounded-xl border border-gray-200 animate-pulse" />
                ))}
              </div>
            ) : pages.length === 0 ? (
              <div className="bg-white rounded-xl border-2 border-dashed border-gray-200 p-12 text-center">
                <DocumentPlusIcon className="h-12 w-12 text-gray-300 mx-auto mb-3" />
                <p className="text-gray-500 font-medium">Žiadne stránky</p>
                <p className="text-gray-400 text-sm mt-1">Kliknite na „Nová stránka" pre začatie.</p>
              </div>
            ) : (
              <div className="space-y-2">
                {pages.map(page => (
                  <div
                    key={page.id}
                    onClick={() => setSelectedPage(page)}
                    className="group flex items-center justify-between bg-white rounded-xl border border-gray-200 px-5 py-4 cursor-pointer hover:border-indigo-300 hover:shadow-sm transition-all"
                  >
                    <div className="flex items-center gap-4 min-w-0">
                      <div className="min-w-0">
                        <p className="font-medium text-gray-900 truncate">{page.label}</p>
                        <p className="text-xs text-gray-400 truncate">{page.path}</p>
                      </div>
                      <div className="flex items-center gap-2 flex-shrink-0">
                        <span className={`text-xs px-2 py-0.5 rounded-full font-medium ${
                          page.is_published
                            ? 'bg-green-100 text-green-700'
                            : 'bg-gray-100 text-gray-500'
                        }`}>
                          {page.is_published ? 'Publikovaná' : 'Draft'}
                        </span>
                        <span className="text-xs bg-indigo-50 text-indigo-600 px-2 py-0.5 rounded-full font-medium hidden sm:inline">
                          {page.blocks?.length ?? 0} blokov
                        </span>
                      </div>
                    </div>

                    <div className="flex items-center gap-1 opacity-0 group-hover:opacity-100 transition-opacity flex-shrink-0 ml-4">
                      <button
                        onClick={(e) => { e.stopPropagation(); setSelectedPage(page) }}
                        className="p-2 text-gray-400 hover:text-indigo-600 hover:bg-indigo-50 rounded-lg transition-colors"
                        title="Upraviť"
                      >
                        <PencilIcon className="h-4 w-4" />
                      </button>
                      <button
                        onClick={(e) => handleDelete(page, e)}
                        className="p-2 text-gray-400 hover:text-red-600 hover:bg-red-50 rounded-lg transition-colors"
                        title="Odstrániť"
                      >
                        <TrashIcon className="h-4 w-4" />
                      </button>
                    </div>
                  </div>
                ))}
              </div>
            )}
          </div>
        )}
      </div>
    </div>
  )
}
