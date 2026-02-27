import { useState, useEffect } from 'react'
import { Outlet, Link, useLocation, useNavigate } from 'react-router-dom'
import { useAuth } from '../contexts/AuthContext'
import { getPagesForSite } from '../api/pages'
import { useTranslation } from '../i18n'
import {
  FolderIcon,
  PhotoIcon,
  DocumentTextIcon,
  EnvelopeIcon,
  CogIcon,
  Bars3Icon,
  XMarkIcon,
  UserCircleIcon,
  TruckIcon,
  HomeIcon,
  DocumentIcon,
  ArrowRightOnRectangleIcon,
  NewspaperIcon,
  CalendarDaysIcon
} from '@heroicons/react/24/outline'

// Map page slugs to icons
const iconMap = {
  'projekty': FolderIcon,
  'vozidla': TruckIcon,
  'galerie': PhotoIcon,
  'blogy': DocumentTextIcon,
  'kontakt': EnvelopeIcon,
  'nastavenia': CogIcon,
  'home': HomeIcon,
  'default': DocumentIcon,
  'ludus-galeria': PhotoIcon,
  'ludus-aktuality': NewspaperIcon,
  'ludus-program': CalendarDaysIcon,
  'ludus-repertoar': DocumentTextIcon,
  'legis-blogy': NewspaperIcon,
  'darius-vozidla': TruckIcon
}

function getIconForSlug(slug) {
  return iconMap[slug] || iconMap['default']
}

export default function Layout() {
  const [sidebarOpen, setSidebarOpen] = useState(false)
  const location = useLocation()
  const navigate = useNavigate()
  const { user, profile, currentSite, logout, loading: authLoading } = useAuth()
  const { t } = useTranslation()

  const [navPages, setNavPages] = useState([])
  const [allPages, setAllPages] = useState([])
  const [loadingPages, setLoadingPages] = useState(true)

  // 1. Fetch pages when site changes
  useEffect(() => {
    if (currentSite?.id) {
      loadPages()
    }
  }, [currentSite?.id])

  // 2. Access Control: Check permissions whenever location or pages change
  useEffect(() => {
    if (!loadingPages && allPages.length > 0) {
      checkAccess()
    }
  }, [location.pathname, allPages, loadingPages])

  async function loadPages() {
    try {
      setLoadingPages(true)
      const pages = await getPagesForSite(currentSite.id)
      setAllPages(pages)

      // Filter to only show pages that should be in nav
      const navItems = pages
        .filter(p => p.show_in_nav)
        .filter(p => {
          if (p.slug === 'legis-blogy') {
            return user?.email?.toLowerCase().includes('kubasky');
          }
          return true;
        })
        .map(p => ({
          name: p.nav_label || p.title,
          href: `/${p.slug}`,
          slug: p.slug,
          icon: getIconForSlug(p.slug)
        }))
      setNavPages(navItems)
    } catch (err) {
      console.error('Error loading pages:', err)
      setNavPages([])
      setAllPages([])
    } finally {
      setLoadingPages(false)
    }
  }

  function checkAccess() {
    // Extract current slug from pathname (remove leading slash)
    const currentSlug = location.pathname.substring(1);

    // Always allow:
    // - root path (handled by DynamicHomePage)
    // - nastavenia (Settings) - assuming it's available for all
    // - empty/dashboard
    const alwaysAllowed = ['', 'nastavenia', 'cms'];

    if (!alwaysAllowed.includes(currentSlug)) {
      // Check if current slug corresponds to a defined page for this site
      const isAllowed = allPages.some(p => p.slug === currentSlug);

      if (!isAllowed) {
        console.warn(`Access denied to /${currentSlug} for site ${currentSite.name}. Redirecting to home.`);
        navigate('/', { replace: true });
      }
    }
  }

  async function handleLogout() {
    try {
      await logout()
      navigate('/login')
    } catch (err) {
      console.error('Logout error:', err)
    }
  }

  // Show loading while auth is checking
  if (authLoading) {
    return (
      <div className="min-h-screen flex items-center justify-center bg-gray-50">
        <div className="text-center">
          <div className="w-16 h-16 border-4 border-purple-600 border-t-transparent rounded-full animate-spin mx-auto mb-4"></div>
          <p className="text-gray-600">Načítavam...</p>
        </div>
      </div>
    )
  }

  return (
    <div className="min-h-full">
      {/* Mobile sidebar */}
      <div className={`fixed inset-0 flex z-40 md:hidden ${sidebarOpen ? '' : 'hidden'}`}>
        <div className="fixed inset-0 bg-gray-600 bg-opacity-75" onClick={() => setSidebarOpen(false)} />
        <div className="relative flex-1 flex flex-col max-w-xs w-full bg-gradient-to-br from-slate-900 via-purple-900 to-slate-900">
          <div className="absolute top-0 right-0 -mr-12 pt-2">
            <button
              className="ml-1 flex items-center justify-center h-10 w-10 rounded-full focus:outline-none focus:ring-2 focus:ring-inset focus:ring-white"
              onClick={() => setSidebarOpen(false)}
            >
              <XMarkIcon className="h-6 w-6 text-white" />
            </button>
          </div>
          <div className="flex-1 h-0 pt-5 pb-4 overflow-y-auto">
            <div className="flex-shrink-0 flex items-center px-4">
              <div className="flex items-center space-x-3">
                <div className="w-8 h-8 bg-gradient-to-r from-blue-500 to-purple-600 rounded-lg flex items-center justify-center">
                  <svg className="w-5 h-5 text-white" fill="currentColor" viewBox="0 0 20 20">
                    <path d="M3 4a1 1 0 011-1h12a1 1 0 011 1v2a1 1 0 01-1 1H4a1 1 0 01-1-1V4zM3 10a1 1 0 011-1h6a1 1 0 011 1v6a1 1 0 01-1 1H4a1 1 0 01-1-1v-6zM14 9a1 1 0 00-1 1v6a1 1 0 001 1h2a1 1 0 001-1v-6a1 1 0 00-1-1h-2z" />
                  </svg>
                </div>
                <h1 className="text-xl font-bold text-white">CMS Admin</h1>
              </div>
            </div>

            {/* Site name */}
            {currentSite && (
              <div className="px-4 mt-4">
                <div className="px-3 py-2 bg-white/10 rounded-lg">
                  <p className="text-xs text-gray-400">{t('aktualnaStranka')}</p>
                  <p className="text-sm text-white font-medium">{currentSite.name}</p>
                </div>
              </div>
            )}

            <nav className="mt-5 px-2 space-y-1">
              {loadingPages ? (
                <div className="px-3 py-2">
                  <div className="animate-pulse space-y-2">
                    {[1, 2, 3].map(i => (
                      <div key={i} className="h-10 bg-white/10 rounded-xl"></div>
                    ))}
                  </div>
                </div>
              ) : navPages.length > 0 ? (
                navPages.map((item) => {
                  const current = location.pathname === item.href
                  return (
                    <Link
                      key={item.slug}
                      to={item.href}
                      className={`${current
                        ? 'bg-white/20 text-white backdrop-blur-sm border border-white/20'
                        : 'text-gray-300 hover:bg-white/10 hover:text-white'
                        } group flex items-center px-3 py-2.5 text-base font-medium rounded-xl transition-all duration-200`}
                      onClick={() => setSidebarOpen(false)}
                    >
                      <item.icon className="mr-4 h-5 w-5 flex-shrink-0" />
                      {item.name}
                    </Link>
                  )
                })
              ) : (
                <div className="px-3 py-4 text-center">
                  <p className="text-gray-400 text-sm">Žiadne stránky v navigácii</p>
                </div>
              )}
            </nav>
          </div>

          {/* Mobile logout */}
          <div className="px-4 py-4 border-t border-white/10">
            <button
              onClick={handleLogout}
              className="w-full flex items-center px-3 py-2.5 text-gray-300 hover:bg-white/10 hover:text-white rounded-xl transition-all"
            >
              <ArrowRightOnRectangleIcon className="mr-4 h-5 w-5" />
              {t('odhlasitSa')}
            </button>
          </div>
        </div>
      </div>

      {/* Desktop sidebar */}
      <div className="hidden md:flex md:w-64 md:flex-col md:fixed md:inset-y-0">
        <div className="flex-1 flex flex-col min-h-0 bg-gradient-to-br from-slate-900 via-purple-900 to-slate-900 shadow-2xl">
          <div className="flex-1 flex flex-col pt-5 pb-4 overflow-y-auto">
            <div className="flex items-center flex-shrink-0 px-6 py-4">
              <div className="flex items-center space-x-3">
                <div className="w-10 h-10 bg-gradient-to-r from-blue-500 to-purple-600 rounded-xl flex items-center justify-center shadow-lg">
                  <svg className="w-6 h-6 text-white" fill="currentColor" viewBox="0 0 20 20">
                    <path d="M3 4a1 1 0 011-1h12a1 1 0 011 1v2a1 1 0 01-1 1H4a1 1 0 01-1-1V4zM3 10a1 1 0 011-1h6a1 1 0 011 1v6a1 1 0 01-1 1H4a1 1 0 01-1-1v-6zM14 9a1 1 0 00-1 1v6a1 1 0 001 1h2a1 1 0 001-1v-6a1 1 0 00-1-1h-2z" />
                  </svg>
                </div>
                <h1 className="text-2xl font-bold text-white">CMS Admin</h1>
              </div>
            </div>

            {/* Site name */}
            {currentSite && (
              <div className="px-6 mb-4">
                <div className="px-4 py-3 bg-white/10 rounded-xl">
                  <p className="text-xs text-gray-400">{t('aktualnaStranka')}</p>
                  <p className="text-sm text-white font-medium">{currentSite.name}</p>
                </div>
              </div>
            )}

            <nav className="mt-2 flex-1 px-6 space-y-3">
              {loadingPages ? (
                <div className="animate-pulse space-y-3">
                  {[1, 2, 3, 4].map(i => (
                    <div key={i} className="h-12 bg-white/10 rounded-xl"></div>
                  ))}
                </div>
              ) : navPages.length > 0 ? (
                navPages.map((item) => {
                  const current = location.pathname === item.href
                  return (
                    <Link
                      key={item.slug}
                      to={item.href}
                      className={`${current
                        ? 'bg-white/20 text-white backdrop-blur-sm border border-white/20 shadow-lg'
                        : 'text-gray-300 hover:bg-white/10 hover:text-white'
                        } group flex items-center px-4 py-3 text-sm font-light rounded-xl transition-all duration-200 hover:transform hover:scale-105`}
                    >
                      <item.icon className="mr-3 h-5 w-5 flex-shrink-0" />
                      {item.name}
                    </Link>
                  )
                })
              ) : (
                <div className="text-center py-8">
                  <DocumentIcon className="h-8 w-8 text-gray-500 mx-auto mb-2" />
                  <p className="text-gray-400 text-sm">Žiadne stránky</p>
                  <p className="text-gray-500 text-xs mt-1">Pridajte stránky v nastaveniach</p>
                </div>
              )}
            </nav>
          </div>

          {/* Desktop logout */}
          <div className="px-6 py-4 border-t border-white/10">
            <button
              onClick={handleLogout}
              className="w-full flex items-center px-4 py-3 text-gray-300 hover:bg-white/10 hover:text-white rounded-xl transition-all"
            >
              <ArrowRightOnRectangleIcon className="mr-3 h-5 w-5" />
              {t('odhlasitSa')}
            </button>
          </div>
        </div>
      </div>

      {/* Main content */}
      <div className="md:pl-64 flex flex-col flex-1 bg-gray-50">
        {/* Modern Topbar */}
        <div className="sticky top-0 z-10 bg-white/80 backdrop-blur-md border-b border-gray-200/50 shadow-sm">
          <div className="flex items-center justify-between h-16 px-4 sm:px-6 lg:px-8">
            <div className="flex items-center">
              <button
                className="md:hidden -ml-0.5 -mt-0.5 h-12 w-12 inline-flex items-center justify-center rounded-lg text-gray-500 hover:text-gray-900 hover:bg-gray-100 focus:outline-none focus:ring-2 focus:ring-inset focus:ring-purple-500 transition-colors"
                onClick={() => setSidebarOpen(true)}
              >
                <Bars3Icon className="h-6 w-6" />
              </button>
            </div>
            <div className="flex items-center space-x-4">
              <div className="flex items-center space-x-3">
                <div className="hidden md:block text-right">
                  <p className="text-sm font-medium text-gray-900">
                    {profile?.full_name || user?.email || 'User'}
                  </p>
                  <p className="text-xs text-gray-500">
                    {profile?.role || 'admin'}
                  </p>
                </div>
                <button className="flex items-center justify-center w-8 h-8 rounded-full bg-gradient-to-r from-purple-500 to-blue-600 text-white">
                  <UserCircleIcon className="h-5 w-5" />
                </button>
              </div>
            </div>
          </div>
        </div>
        <main className="flex-1">
          <div className="py-6">
            <div className="max-w-7xl mx-auto px-4 sm:px-6 md:px-8">
              <Outlet />
            </div>
          </div>
        </main>
      </div>
    </div>
  )
}
