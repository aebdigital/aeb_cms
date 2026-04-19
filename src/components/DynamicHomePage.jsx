import { useEffect, useState } from 'react'
import { Navigate } from 'react-router-dom'
import { useAuth } from '../contexts/AuthContext'
import { getPagesForSite } from '../api/pages'

const VAVROSTAV_OWNER_ID = '9083c583-0fcf-483d-b3f1-ba435287ec04'

export default function DynamicHomePage() {
  const { user, currentSite } = useAuth()
  const [firstNavSlug, setFirstNavSlug] = useState(null)
  const [loading, setLoading] = useState(true)

  useEffect(() => {
    if (currentSite?.id) {
      loadFirstNavPage()
    } else {
      setLoading(false)
    }
  }, [currentSite?.id])

  // Espron account goes straight to the visual builder
  if (user?.email === 'info@espron.sk') {
    return <Navigate to="/visual-builder" replace />
  }

  if (user?.id === VAVROSTAV_OWNER_ID) {
    return <Navigate to="/vavrostav-obchod" replace />
  }

  async function loadFirstNavPage() {
    try {
      const pages = await getPagesForSite(currentSite.id)
      const navPages = pages.filter(p => p.show_in_nav)

      // List of valid slugs that have routes defined in App.jsx
      const VALID_SLUGS = [
        'projekty', 'galerie', 'blogy', 'kontakt', 'nastavenia',
        'vozidla', 'ponuka', 'oznamy', 'dovolenka',
        'ludus-galeria', 'ludus-aktuality', 'ludus-program', 'ludus-repertoar',
        'darius-vozidla'
      ]

      const validNavPage = navPages.find(p => VALID_SLUGS.includes(p.slug))

      if (validNavPage) {
        setFirstNavSlug(validNavPage.slug)
      }
    } catch (err) {
      console.error('Error loading nav pages:', err)
    } finally {
      setLoading(false)
    }
  }

  if (loading) {
    return (
      <div className="flex items-center justify-center min-h-[400px]">
        <div className="text-center">
          <div className="w-12 h-12 border-4 border-purple-600 border-t-transparent rounded-full animate-spin mx-auto mb-4"></div>
          <p className="text-gray-600">Načítavam...</p>
        </div>
      </div>
    )
  }

  if (firstNavSlug) {
    return <Navigate to={`/${firstNavSlug}`} replace />
  }

  // Fallback if no nav pages configured
  return (
    <div className="text-center py-12">
      <h2 className="text-2xl font-bold text-gray-900 mb-4">Vitajte</h2>
      <p className="text-gray-600">Ziadne stranky nie su nastavene v navigacii.</p>
    </div>
  )
}
