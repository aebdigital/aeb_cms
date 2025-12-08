import { useState, useEffect } from 'react'
import { useAuth } from '../contexts/AuthContext'
import { getOrCreateOznamyPage, getOrCreateAnnouncementBlock, updateAnnouncementBlock } from '../api/oznamy'

const Oznamy = () => {
  const { currentSite, loading: authLoading } = useAuth()
  const [loading, setLoading] = useState(false)
  const [initialLoad, setInitialLoad] = useState(true)
  const [saving, setSaving] = useState(false)
  const [error, setError] = useState(null)
  const [formData, setFormData] = useState({
    id: '',
    pageId: '',
    title: '',
    description: '',
    enabled: false,
  })

  // Load announcement data when site changes
  useEffect(() => {
    if (authLoading || !currentSite?.id) {
      if (!authLoading && !currentSite?.id) {
        setInitialLoad(false)
      }
      return
    }

    let cancelled = false

    async function loadAnnouncement() {
      setLoading(true)
      setError(null)

      try {
        const page = await getOrCreateOznamyPage(currentSite.id)
        const popup = await getOrCreateAnnouncementBlock(page.id)
        if (!cancelled) {
          setFormData({
            id: popup.id,
            pageId: popup.pageId,
            title: popup.title,
            description: popup.description,
            enabled: popup.enabled,
          })
        }
      } catch (err) {
        console.error('Failed to load announcement:', err)
        if (!cancelled) {
          setError(err.message || 'Chyba pri nacitavani oznamu')
        }
      } finally {
        if (!cancelled) {
          setLoading(false)
          setInitialLoad(false)
        }
      }
    }

    loadAnnouncement()

    return () => {
      cancelled = true
    }
  }, [currentSite?.id, authLoading])

  const handleSubmit = async (e) => {
    e.preventDefault()

    if (!formData.title.trim()) {
      alert('Vyplnte nazov oznamu')
      return
    }

    setSaving(true)
    setError(null)

    try {
      await updateAnnouncementBlock(formData)
      alert('Oznam ulozeny')
    } catch (err) {
      console.error('Failed to save announcement:', err)
      setError(err.message || 'Chyba pri ukladani oznamu')
    } finally {
      setSaving(false)
    }
  }

  if (initialLoad || authLoading) {
    return (
      <div className="flex items-center justify-center h-64">
        <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-purple-600"></div>
      </div>
    )
  }

  if (!currentSite) {
    return (
      <div className="flex items-center justify-center h-64">
        <p className="text-gray-500">Vyberte stranku pre zobrazenie oznamov</p>
      </div>
    )
  }

  return (
    <div className="p-6">
      <div className="flex justify-between items-center mb-6">
        <h1 className="text-2xl font-bold text-gray-800">Oznamy</h1>
      </div>

      {error && (
        <div className="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-6">
          {error}
        </div>
      )}

      <div className="bg-white rounded-xl shadow-lg p-6">
        <h2 className="text-lg font-semibold mb-4">Oznam na webovej stranke</h2>
        <p className="text-gray-500 text-sm mb-6">
          Tento oznam sa zobrazi navstevnikom vasej webovej stranky ako popup.
        </p>

        <form onSubmit={handleSubmit} className="space-y-4">
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">
              Nazov oznamu
            </label>
            <input
              type="text"
              value={formData.title}
              onChange={(e) => setFormData(prev => ({ ...prev, title: e.target.value }))}
              className="w-full border border-gray-300 rounded-lg px-3 py-2 focus:ring-2 focus:ring-purple-500 focus:border-transparent"
              placeholder="Zadajte nazov oznamu"
            />
          </div>

          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">
              Text oznamu
            </label>
            <textarea
              value={formData.description}
              onChange={(e) => setFormData(prev => ({ ...prev, description: e.target.value }))}
              rows={5}
              className="w-full border border-gray-300 rounded-lg px-3 py-2 focus:ring-2 focus:ring-purple-500 focus:border-transparent"
              placeholder="Zadajte text oznamu"
            />
          </div>

          <div className="flex items-center">
            <input
              type="checkbox"
              id="enabled"
              checked={formData.enabled}
              onChange={(e) => setFormData(prev => ({ ...prev, enabled: e.target.checked }))}
              className="h-4 w-4 text-purple-600 focus:ring-purple-500 border-gray-300 rounded"
            />
            <label htmlFor="enabled" className="ml-2 text-sm text-gray-700">
              Zobrazit oznam na webe
            </label>
          </div>

          <div className="pt-4 border-t border-gray-200">
            <button
              type="submit"
              disabled={saving}
              className="bg-purple-600 hover:bg-purple-700 disabled:bg-purple-400 text-white px-6 py-2 rounded-lg font-semibold transition-colors"
            >
              {saving ? 'Ukladam...' : 'Ulozit'}
            </button>
          </div>
        </form>

        {/* Status indicator */}
        <div className="mt-6 pt-4 border-t border-gray-200">
          <div className="flex items-center gap-2">
            <span className="text-sm text-gray-600">Stav oznamu:</span>
            {formData.enabled ? (
              <span className="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-green-100 text-green-800">
                Aktivny - zobrazuje sa na webe
              </span>
            ) : (
              <span className="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-gray-100 text-gray-600">
                Neaktivny - skryty
              </span>
            )}
          </div>
        </div>
      </div>
    </div>
  )
}

export default Oznamy
