import { useEffect, useState } from 'react'
import { Navigate } from 'react-router-dom'
import { useAuth } from '../contexts/AuthContext'
import { getPagesForSite } from '../api/pages'

export default function DynamicHomePage() {
  const { currentSite } = useAuth()
  const [firstNavSlug, setFirstNavSlug] = useState(null)
  const [loading, setLoading] = useState(true)

  useEffect(() => {
    if (currentSite?.id) {
      loadFirstNavPage()
    }
  }, [currentSite?.id])

  async function loadFirstNavPage() {
    try {
      const pages = await getPagesForSite(currentSite.id)
      const navPages = pages.filter(p => p.show_in_nav)

      if (navPages.length > 0) {
        setFirstNavSlug(navPages[0].slug)
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
          <p className="text-gray-600">Nacitavam...</p>
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
