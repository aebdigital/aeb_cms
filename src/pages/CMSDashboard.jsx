import { useState } from 'react'
import { useAuth } from '../contexts/AuthContext'
import SiteSelector from '../components/SiteSelector'
import PageList from '../components/PageList'
import PageEditor from '../components/PageEditor'
import { useTranslation } from '../i18n'
import {
  ArrowRightOnRectangleIcon,
  DocumentIcon,
  Cog6ToothIcon,
  HomeIcon
} from '@heroicons/react/24/outline'

export default function CMSDashboard() {
  const { user, profile, currentSite, logout, loading } = useAuth()
  const { t } = useTranslation()
  const [selectedPage, setSelectedPage] = useState(null)
  const [activeSection, setActiveSection] = useState('pages')

  async function handleLogout() {
    try {
      await logout()
    } catch (err) {
      alert('Chyba pri odhlasovaní: ' + err.message)
    }
  }

  if (loading) {
    return (
      <div className="min-h-screen flex items-center justify-center bg-gray-50">
        <div className="text-center">
          <div className="w-16 h-16 border-4 border-purple-600 border-t-transparent rounded-full animate-spin mx-auto mb-4"></div>
          <p className="text-gray-600">Načítavam...</p>
        </div>
      </div>
    )
  }

  if (!currentSite) {
    return (
      <div className="min-h-screen flex items-center justify-center bg-gray-50">
        <div className="text-center max-w-md mx-auto p-8">
          <div className="w-16 h-16 bg-gray-200 rounded-full flex items-center justify-center mx-auto mb-4">
            <HomeIcon className="h-8 w-8 text-gray-400" />
          </div>
          <h2 className="text-xl font-semibold text-gray-900 mb-2">Žiadna stránka</h2>
          <p className="text-gray-600 mb-4">
            Nemáte prístup k žiadnej stránke. Kontaktujte administrátora.
          </p>
          <button
            onClick={handleLogout}
            className="text-purple-600 hover:text-purple-700"
          >
            {t('odhlasitSa')}
          </button>
        </div>
      </div>
    )
  }

  return (
    <div className="min-h-screen bg-gray-50">
      {/* Top Bar */}
      <header className="bg-gradient-to-r from-slate-900 via-purple-900 to-slate-900 text-white">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="flex items-center justify-between h-16">
            {/* Logo & Site Selector */}
            <div className="flex items-center space-x-4">
              <div className="flex items-center space-x-3">
                <div className="w-8 h-8 bg-gradient-to-r from-purple-500 to-blue-500 rounded-lg flex items-center justify-center">
                  <svg className="w-5 h-5 text-white" fill="currentColor" viewBox="0 0 20 20">
                    <path d="M3 4a1 1 0 011-1h12a1 1 0 011 1v2a1 1 0 01-1 1H4a1 1 0 01-1-1V4zM3 10a1 1 0 011-1h6a1 1 0 011 1v6a1 1 0 01-1 1H4a1 1 0 01-1-1v-6zM14 9a1 1 0 00-1 1v6a1 1 0 001 1h2a1 1 0 001-1v-6a1 1 0 00-1-1h-2z"/>
                  </svg>
                </div>
                <span className="font-bold text-lg">CMS</span>
              </div>

              <div className="h-6 w-px bg-white/20"></div>

              <SiteSelector />
            </div>

            {/* User Menu */}
            <div className="flex items-center space-x-4">
              <div className="text-right hidden sm:block">
                <p className="text-sm font-medium">{profile?.full_name || user?.email}</p>
                <p className="text-xs text-gray-300">{profile?.role || 'User'}</p>
              </div>
              <button
                onClick={handleLogout}
                className="p-2 hover:bg-white/10 rounded-lg transition-colors"
                title={t('odhlasitSa')}
              >
                <ArrowRightOnRectangleIcon className="h-5 w-5" />
              </button>
            </div>
          </div>
        </div>
      </header>

      {/* Main Content */}
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-6">
        <div className="flex gap-6">
          {/* Sidebar */}
          <aside className="w-64 flex-shrink-0">
            <div className="bg-white rounded-xl shadow-sm border border-gray-200 overflow-hidden">
              {/* Section Tabs */}
              <div className="border-b border-gray-200">
                <nav className="flex">
                  <button
                    onClick={() => {
                      setActiveSection('pages')
                      setSelectedPage(null)
                    }}
                    className={`flex-1 px-4 py-3 text-sm font-medium text-center transition-colors ${
                      activeSection === 'pages'
                        ? 'text-purple-600 border-b-2 border-purple-600 bg-purple-50'
                        : 'text-gray-600 hover:text-gray-900 hover:bg-gray-50'
                    }`}
                  >
                    <DocumentIcon className="h-4 w-4 mx-auto mb-1" />
                    Stránky
                  </button>
                  <button
                    onClick={() => {
                      setActiveSection('settings')
                      setSelectedPage(null)
                    }}
                    className={`flex-1 px-4 py-3 text-sm font-medium text-center transition-colors ${
                      activeSection === 'settings'
                        ? 'text-purple-600 border-b-2 border-purple-600 bg-purple-50'
                        : 'text-gray-600 hover:text-gray-900 hover:bg-gray-50'
                    }`}
                  >
                    <Cog6ToothIcon className="h-4 w-4 mx-auto mb-1" />
                    Nastavenia
                  </button>
                </nav>
              </div>

              {/* Page List */}
              {activeSection === 'pages' && (
                <PageList onSelectPage={setSelectedPage} />
              )}

              {/* Settings placeholder */}
              {activeSection === 'settings' && (
                <div className="p-4">
                  <p className="text-sm text-gray-500">Nastavenia stránky</p>
                  <div className="mt-4 space-y-2">
                    <div className="p-3 bg-gray-50 rounded-lg">
                      <p className="text-sm font-medium">{currentSite.name}</p>
                      <p className="text-xs text-gray-500">{currentSite.domain || currentSite.slug}</p>
                    </div>
                  </div>
                </div>
              )}
            </div>
          </aside>

          {/* Main Area */}
          <main className="flex-1">
            {selectedPage ? (
              <PageEditor
                page={selectedPage}
                onBack={() => setSelectedPage(null)}
              />
            ) : (
              <div className="bg-white rounded-xl shadow-sm border border-gray-200 p-8 text-center">
                <div className="max-w-md mx-auto">
                  <DocumentIcon className="h-12 w-12 text-gray-300 mx-auto mb-4" />
                  <h2 className="text-lg font-semibold text-gray-900 mb-2">
                    Vyberte stránku
                  </h2>
                  <p className="text-gray-600">
                    Kliknite na stránku v ľavom menu pre úpravu jej obsahu a nastavení.
                  </p>
                </div>
              </div>
            )}
          </main>
        </div>
      </div>
    </div>
  )
}
