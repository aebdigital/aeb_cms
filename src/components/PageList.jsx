import { useState, useEffect } from 'react'
import { useAuth } from '../contexts/AuthContext'
import { getPagesForSite, updatePageNavigation } from '../api/pages'
import {
  EyeIcon,
  EyeSlashIcon,
  Bars3Icon,
  PencilIcon,
  DocumentIcon
} from '@heroicons/react/24/outline'

export default function PageList({ onSelectPage }) {
  const { currentSite } = useAuth()
  const [pages, setPages] = useState([])
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState(null)

  useEffect(() => {
    if (currentSite?.id) {
      loadPages()
    }
  }, [currentSite?.id])

  async function loadPages() {
    try {
      setLoading(true)
      const data = await getPagesForSite(currentSite.id)
      setPages(data)
    } catch (err) {
      setError(err.message)
    } finally {
      setLoading(false)
    }
  }

  async function toggleNavVisibility(page) {
    try {
      await updatePageNavigation(page.id, { show_in_nav: !page.show_in_nav })
      setPages(pages.map(p =>
        p.id === page.id ? { ...p, show_in_nav: !p.show_in_nav } : p
      ))
    } catch (err) {
      alert('Chyba pri aktualizacii: ' + err.message)
    }
  }

  async function togglePublic(page) {
    try {
      await updatePageNavigation(page.id, { is_public: !page.is_public })
      setPages(pages.map(p =>
        p.id === page.id ? { ...p, is_public: !p.is_public } : p
      ))
    } catch (err) {
      alert('Chyba pri aktualizacii: ' + err.message)
    }
  }

  if (loading) {
    return (
      <div className="p-4">
        <div className="animate-pulse space-y-3">
          {[1, 2, 3].map(i => (
            <div key={i} className="h-12 bg-gray-200 rounded-lg"></div>
          ))}
        </div>
      </div>
    )
  }

  if (error) {
    return (
      <div className="p-4">
        <div className="bg-red-50 border border-red-200 rounded-lg p-4">
          <p className="text-red-600 text-sm">{error}</p>
          <button
            onClick={loadPages}
            className="mt-2 text-sm text-red-700 underline"
          >
            Skusit znova
          </button>
        </div>
      </div>
    )
  }

  if (pages.length === 0) {
    return (
      <div className="p-4 text-center">
        <DocumentIcon className="h-12 w-12 text-gray-300 mx-auto mb-2" />
        <p className="text-gray-500">Ziadne stranky</p>
      </div>
    )
  }

  return (
    <div className="p-2">
      <div className="space-y-1">
        {pages.map((page) => (
          <div
            key={page.id}
            className="group flex items-center justify-between p-3 rounded-lg hover:bg-gray-50 cursor-pointer transition-colors"
            onClick={() => onSelectPage?.(page)}
          >
            <div className="flex items-center flex-1 min-w-0">
              <Bars3Icon className="h-4 w-4 text-gray-400 mr-2 cursor-grab" />
              <div className="min-w-0">
                <p className="font-medium text-gray-900 truncate">
                  {page.nav_label || page.title}
                </p>
                <p className="text-xs text-gray-500 truncate">/{page.slug}</p>
              </div>
            </div>

            <div className="flex items-center space-x-1 opacity-0 group-hover:opacity-100 transition-opacity">
              {/* Toggle nav visibility */}
              <button
                onClick={(e) => {
                  e.stopPropagation()
                  toggleNavVisibility(page)
                }}
                className={`p-1.5 rounded-lg transition-colors ${
                  page.show_in_nav
                    ? 'text-green-600 hover:bg-green-50'
                    : 'text-gray-400 hover:bg-gray-100'
                }`}
                title={page.show_in_nav ? 'Zobrazene v navigacii' : 'Skryte v navigacii'}
              >
                {page.show_in_nav ? (
                  <EyeIcon className="h-4 w-4" />
                ) : (
                  <EyeSlashIcon className="h-4 w-4" />
                )}
              </button>

              {/* Public/Private indicator */}
              <span
                className={`text-xs px-2 py-0.5 rounded-full ${
                  page.is_public
                    ? 'bg-green-100 text-green-700'
                    : 'bg-gray-100 text-gray-600'
                }`}
              >
                {page.is_public ? 'Public' : 'Draft'}
              </span>

              {/* Edit button */}
              <button
                onClick={(e) => {
                  e.stopPropagation()
                  onSelectPage?.(page)
                }}
                className="p-1.5 text-gray-400 hover:text-purple-600 hover:bg-purple-50 rounded-lg transition-colors"
              >
                <PencilIcon className="h-4 w-4" />
              </button>
            </div>
          </div>
        ))}
      </div>
    </div>
  )
}
