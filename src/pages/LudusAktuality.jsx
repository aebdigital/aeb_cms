import { useState, useEffect } from 'react'
import { PlusIcon, PencilIcon, TrashIcon, XMarkIcon, HomeIcon } from '@heroicons/react/24/outline'
import { useAuth } from '../contexts/AuthContext'
import { getAktuality, createAktualita, updateAktualita, deleteAktualita, countHomepageAktuality, AKTUALITY_CATEGORIES } from '../api/aktuality'

const initialForm = {
  title: '',
  description: '',
  link: '',
  date: new Date().toISOString().split('T')[0],
  category: 'skola-ludus',
  show_on_homepage: false,
  published: true
}

export default function LudusAktuality() {
  const { currentSite, loading: authLoading } = useAuth()
  const [aktuality, setAktuality] = useState([])
  const [loading, setLoading] = useState(false)
  const [initialLoad, setInitialLoad] = useState(true)
  const [error, setError] = useState(null)
  const [filterCategory, setFilterCategory] = useState('')
  const [showModal, setShowModal] = useState(false)
  const [isEditMode, setIsEditMode] = useState(false)
  const [editingId, setEditingId] = useState(null)
  const [formData, setFormData] = useState(initialForm)
  const [submitting, setSubmitting] = useState(false)
  const [homepageCount, setHomepageCount] = useState(0)

  // Load aktuality when site changes
  useEffect(() => {
    if (authLoading || !currentSite?.id) {
      if (!authLoading && !currentSite?.id) {
        setInitialLoad(false)
      }
      return
    }

    let cancelled = false

    async function loadData() {
      setLoading(true)
      setError(null)

      try {
        const [data, count] = await Promise.all([
          getAktuality(currentSite.id),
          countHomepageAktuality(currentSite.id)
        ])
        if (!cancelled) {
          setAktuality(data)
          setHomepageCount(count)
        }
      } catch (err) {
        console.error('Error loading aktuality:', err)
        if (!cancelled) {
          setError(err.message || 'Chyba pri nacitavani aktualit')
        }
      } finally {
        if (!cancelled) {
          setLoading(false)
          setInitialLoad(false)
        }
      }
    }

    loadData()

    return () => {
      cancelled = true
    }
  }, [currentSite?.id, authLoading])

  const filteredAktuality = filterCategory
    ? aktuality.filter(a => a.category === filterCategory)
    : aktuality

  const openAddModal = () => {
    setFormData(initialForm)
    setIsEditMode(false)
    setEditingId(null)
    setShowModal(true)
  }

  const openEditModal = (item) => {
    setFormData({
      title: item.title,
      description: item.description || '',
      link: item.link || '',
      date: item.date,
      category: item.category,
      show_on_homepage: item.show_on_homepage,
      published: item.published
    })
    setIsEditMode(true)
    setEditingId(item.id)
    setShowModal(true)
  }

  const handleSubmit = async (e) => {
    e.preventDefault()

    if (!formData.title.trim()) {
      alert('Vyplnte nazov aktuality')
      return
    }

    setSubmitting(true)
    setError(null)

    try {
      if (isEditMode && editingId) {
        await updateAktualita(editingId, formData, currentSite.id)
      } else {
        await createAktualita({
          ...formData,
          site_id: currentSite.id
        })
      }

      // Reload data
      const [data, count] = await Promise.all([
        getAktuality(currentSite.id),
        countHomepageAktuality(currentSite.id)
      ])
      setAktuality(data)
      setHomepageCount(count)
      setShowModal(false)
    } catch (err) {
      console.error('Save error:', err)
      setError(err.message || 'Chyba pri ukladani')
    } finally {
      setSubmitting(false)
    }
  }

  const handleDelete = async (id) => {
    if (!confirm('Naozaj chcete vymazat tuto aktualitu?')) return

    try {
      await deleteAktualita(id)
      const [data, count] = await Promise.all([
        getAktuality(currentSite.id),
        countHomepageAktuality(currentSite.id)
      ])
      setAktuality(data)
      setHomepageCount(count)
    } catch (err) {
      console.error('Delete error:', err)
      setError(err.message || 'Chyba pri mazani')
    }
  }

  const formatDate = (dateStr) => {
    const date = new Date(dateStr)
    return date.toLocaleDateString('sk-SK', { day: '2-digit', month: '2-digit', year: 'numeric' })
  }

  const getCategoryLabel = (value) => {
    return AKTUALITY_CATEGORIES.find(c => c.value === value)?.label || value
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
        <p className="text-gray-500">Vyberte stranku pre zobrazenie aktualit</p>
      </div>
    )
  }

  return (
    <div className="p-6">
      <div className="flex justify-between items-center mb-6">
        <div>
          <h1 className="text-2xl font-bold text-gray-800">Aktuality</h1>
          <p className="text-sm text-gray-500 mt-1">
            Na domovskej stranke: {homepageCount}/3
          </p>
        </div>
        <button
          onClick={openAddModal}
          className="flex items-center gap-2 bg-purple-600 hover:bg-purple-700 text-white px-4 py-2 rounded-lg font-semibold transition-colors"
        >
          <PlusIcon className="w-5 h-5" />
          Pridat aktualitu
        </button>
      </div>

      {error && (
        <div className="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-6">
          {error}
          <button onClick={() => setError(null)} className="float-right font-bold">&times;</button>
        </div>
      )}

      {/* Category Filter */}
      <div className="flex gap-2 mb-6 flex-wrap">
        <button
          onClick={() => setFilterCategory('')}
          className={`px-4 py-2 rounded-lg font-medium transition-colors ${
            filterCategory === ''
              ? 'bg-purple-600 text-white'
              : 'bg-gray-100 text-gray-700 hover:bg-gray-200'
          }`}
        >
          Vsetky
        </button>
        {AKTUALITY_CATEGORIES.map(cat => (
          <button
            key={cat.value}
            onClick={() => setFilterCategory(cat.value)}
            className={`px-4 py-2 rounded-lg font-medium transition-colors ${
              filterCategory === cat.value
                ? 'bg-purple-600 text-white'
                : 'bg-gray-100 text-gray-700 hover:bg-gray-200'
            }`}
          >
            {cat.label}
          </button>
        ))}
      </div>

      {/* Aktuality List */}
      {loading ? (
        <div className="flex items-center justify-center h-64">
          <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-purple-600"></div>
        </div>
      ) : filteredAktuality.length === 0 ? (
        <div className="text-center py-12 bg-white rounded-xl shadow">
          <p className="text-gray-500 mb-4">Ziadne aktuality</p>
          <button
            onClick={openAddModal}
            className="text-purple-600 hover:text-purple-700 font-medium"
          >
            Vytvorit prvu aktualitu
          </button>
        </div>
      ) : (
        <div className="bg-white rounded-xl shadow overflow-hidden">
          <table className="w-full">
            <thead className="bg-gray-50 border-b">
              <tr>
                <th className="text-left px-4 py-3 text-sm font-semibold text-gray-700">Nazov</th>
                <th className="text-left px-4 py-3 text-sm font-semibold text-gray-700">Kategoria</th>
                <th className="text-left px-4 py-3 text-sm font-semibold text-gray-700">Datum</th>
                <th className="text-center px-4 py-3 text-sm font-semibold text-gray-700">Homepage</th>
                <th className="text-center px-4 py-3 text-sm font-semibold text-gray-700">Stav</th>
                <th className="text-right px-4 py-3 text-sm font-semibold text-gray-700">Akcie</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-gray-100">
              {filteredAktuality.map(item => (
                <tr key={item.id} className="hover:bg-gray-50">
                  <td className="px-4 py-3">
                    <div>
                      <div className="flex items-center gap-2">
                        <p className="font-medium text-gray-900">{item.title}</p>
                        {item.link && (
                          <a href={item.link} target="_blank" rel="noopener noreferrer" className="text-purple-500 hover:text-purple-700" title={item.link} onClick={(e) => e.stopPropagation()}>
                            <svg className="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M13.828 10.172a4 4 0 00-5.656 0l-4 4a4 4 0 105.656 5.656l1.102-1.101M10.172 13.828a4 4 0 005.656 0l4-4a4 4 0 00-5.656-5.656l-1.1 1.1" /></svg>
                          </a>
                        )}
                      </div>
                      {item.description && (
                        <p className="text-sm text-gray-500 truncate max-w-xs">{item.description}</p>
                      )}
                    </div>
                  </td>
                  <td className="px-4 py-3">
                    <span className="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-blue-100 text-blue-800">
                      {getCategoryLabel(item.category)}
                    </span>
                  </td>
                  <td className="px-4 py-3 text-sm text-gray-600">
                    {formatDate(item.date)}
                  </td>
                  <td className="px-4 py-3 text-center">
                    {item.show_on_homepage ? (
                      <HomeIcon className="w-5 h-5 text-green-600 mx-auto" />
                    ) : (
                      <span className="text-gray-300">-</span>
                    )}
                  </td>
                  <td className="px-4 py-3 text-center">
                    {item.published ? (
                      <span className="inline-flex items-center px-2 py-0.5 rounded text-xs font-medium bg-green-100 text-green-800">
                        Publikovane
                      </span>
                    ) : (
                      <span className="inline-flex items-center px-2 py-0.5 rounded text-xs font-medium bg-gray-100 text-gray-600">
                        Skryte
                      </span>
                    )}
                  </td>
                  <td className="px-4 py-3 text-right">
                    <div className="flex items-center justify-end gap-2">
                      <button
                        onClick={() => openEditModal(item)}
                        className="p-1 text-gray-500 hover:text-purple-600 transition-colors"
                        title="Upravit"
                      >
                        <PencilIcon className="w-5 h-5" />
                      </button>
                      <button
                        onClick={() => handleDelete(item.id)}
                        className="p-1 text-gray-500 hover:text-red-600 transition-colors"
                        title="Vymazat"
                      >
                        <TrashIcon className="w-5 h-5" />
                      </button>
                    </div>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      )}

      {/* Add/Edit Modal */}
      {showModal && (
        <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 p-4">
          <div className="bg-white rounded-xl shadow-xl max-w-lg w-full max-h-[90vh] overflow-y-auto">
            <div className="flex justify-between items-center p-4 border-b">
              <h2 className="text-lg font-semibold">
                {isEditMode ? 'Upravit aktualitu' : 'Nova aktualita'}
              </h2>
              <button onClick={() => setShowModal(false)}>
                <XMarkIcon className="w-6 h-6 text-gray-500 hover:text-gray-700" />
              </button>
            </div>

            <form onSubmit={handleSubmit} className="p-4 space-y-4">
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">
                  Nazov *
                </label>
                <input
                  type="text"
                  value={formData.title}
                  onChange={(e) => setFormData(prev => ({ ...prev, title: e.target.value }))}
                  className="w-full border border-gray-300 rounded-lg px-3 py-2 focus:ring-2 focus:ring-purple-500 focus:border-transparent"
                  placeholder="Nazov aktuality"
                  required
                />
              </div>

              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">
                  Popis
                </label>
                <textarea
                  value={formData.description}
                  onChange={(e) => setFormData(prev => ({ ...prev, description: e.target.value }))}
                  rows={4}
                  className="w-full border border-gray-300 rounded-lg px-3 py-2 focus:ring-2 focus:ring-purple-500 focus:border-transparent"
                  placeholder="Kratky popis aktuality..."
                />
              </div>

              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">
                  Odkaz (URL)
                </label>
                <input
                  type="url"
                  value={formData.link}
                  onChange={(e) => setFormData(prev => ({ ...prev, link: e.target.value }))}
                  className="w-full border border-gray-300 rounded-lg px-3 py-2 focus:ring-2 focus:ring-purple-500 focus:border-transparent"
                  placeholder="https://..."
                />
              </div>

              <div className="grid grid-cols-2 gap-4">
                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-1">
                    Datum
                  </label>
                  <input
                    type="date"
                    value={formData.date}
                    onChange={(e) => setFormData(prev => ({ ...prev, date: e.target.value }))}
                    className="w-full border border-gray-300 rounded-lg px-3 py-2 focus:ring-2 focus:ring-purple-500 focus:border-transparent"
                  />
                </div>

                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-1">
                    Kategoria
                  </label>
                  <select
                    value={formData.category}
                    onChange={(e) => setFormData(prev => ({ ...prev, category: e.target.value }))}
                    className="w-full border border-gray-300 rounded-lg px-3 py-2 focus:ring-2 focus:ring-purple-500 focus:border-transparent"
                  >
                    {AKTUALITY_CATEGORIES.map(cat => (
                      <option key={cat.value} value={cat.value}>{cat.label}</option>
                    ))}
                  </select>
                </div>
              </div>

              <div className="flex items-center gap-6">
                <div className="flex items-center">
                  <input
                    type="checkbox"
                    id="show_on_homepage"
                    checked={formData.show_on_homepage}
                    onChange={(e) => setFormData(prev => ({ ...prev, show_on_homepage: e.target.checked }))}
                    className="h-4 w-4 text-purple-600 focus:ring-purple-500 border-gray-300 rounded"
                  />
                  <label htmlFor="show_on_homepage" className="ml-2 text-sm text-gray-700">
                    Zobrazit na homepage
                  </label>
                </div>

                <div className="flex items-center">
                  <input
                    type="checkbox"
                    id="published"
                    checked={formData.published}
                    onChange={(e) => setFormData(prev => ({ ...prev, published: e.target.checked }))}
                    className="h-4 w-4 text-purple-600 focus:ring-purple-500 border-gray-300 rounded"
                  />
                  <label htmlFor="published" className="ml-2 text-sm text-gray-700">
                    Publikovane
                  </label>
                </div>
              </div>

              {formData.show_on_homepage && !isEditMode && homepageCount >= 3 && (
                <div className="bg-yellow-50 border border-yellow-200 text-yellow-800 px-3 py-2 rounded text-sm">
                  Pozor: Uz mate 3 aktuality na homepage. Tato nebude pridana kym jednu neodstranite.
                </div>
              )}

              {homepageCount > 0 && (
                <p className="text-xs text-gray-500">
                  Aktualit na homepage: {homepageCount}/3
                </p>
              )}

              <div className="flex gap-2 pt-4 border-t">
                <button
                  type="button"
                  onClick={() => setShowModal(false)}
                  className="flex-1 px-4 py-2 border border-gray-300 rounded-lg text-gray-700 hover:bg-gray-50"
                  disabled={submitting}
                >
                  Zrusit
                </button>
                <button
                  type="submit"
                  disabled={submitting}
                  className="flex-1 px-4 py-2 bg-purple-600 text-white rounded-lg hover:bg-purple-700 disabled:bg-purple-400"
                >
                  {submitting ? 'Ukladam...' : (isEditMode ? 'Ulozit' : 'Vytvorit')}
                </button>
              </div>
            </form>
          </div>
        </div>
      )}
    </div>
  )
}
