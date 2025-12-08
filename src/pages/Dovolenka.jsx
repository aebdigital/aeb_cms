import { useState, useEffect } from 'react'
import { useAuth } from '../contexts/AuthContext'
import {
  getOrCreateDovolenkaPage,
  getVacationPhoneBlocks,
  createVacationPhoneBlock,
  toggleVacationPhone,
  deleteVacationPhoneBlock,
} from '../api/dovolenka'

const Dovolenka = () => {
  const { currentSite, loading: authLoading } = useAuth()
  const [loading, setLoading] = useState(false)
  const [initialLoad, setInitialLoad] = useState(true)
  const [error, setError] = useState(null)
  const [pageId, setPageId] = useState(null)
  const [phones, setPhones] = useState([])
  const [newPhone, setNewPhone] = useState('')
  const [adding, setAdding] = useState(false)

  // Load vacation phone data when site changes
  useEffect(() => {
    if (authLoading || !currentSite?.id) {
      if (!authLoading && !currentSite?.id) {
        setInitialLoad(false)
      }
      return
    }

    let cancelled = false

    async function loadVacationPhones() {
      setLoading(true)
      setError(null)

      try {
        const page = await getOrCreateDovolenkaPage(currentSite.id)
        if (!cancelled) {
          setPageId(page.id)
          const phoneBlocks = await getVacationPhoneBlocks(page.id)
          if (!cancelled) {
            setPhones(phoneBlocks)
          }
        }
      } catch (err) {
        console.error('Failed to load vacation phones:', err)
        if (!cancelled) {
          setError(err.message || 'Chyba pri nacitavani telefonnych cisel')
        }
      } finally {
        if (!cancelled) {
          setLoading(false)
          setInitialLoad(false)
        }
      }
    }

    loadVacationPhones()

    return () => {
      cancelled = true
    }
  }, [currentSite?.id, authLoading])

  const handleToggleVacation = async (blockId) => {
    try {
      const newEnabled = await toggleVacationPhone(blockId)
      setPhones(prev =>
        prev.map(p =>
          p.id === blockId ? { ...p, enabled: newEnabled } : p
        )
      )
    } catch (err) {
      console.error('Failed to toggle vacation:', err)
      setError(err.message || 'Chyba pri prepinani dovolenky')
    }
  }

  const handleAddPhone = async (e) => {
    e.preventDefault()
    if (!newPhone.trim() || !pageId) return

    setAdding(true)
    setError(null)

    try {
      const newBlock = await createVacationPhoneBlock(pageId, newPhone.trim(), false)
      setPhones(prev => [...prev, newBlock])
      setNewPhone('')
    } catch (err) {
      console.error('Failed to add phone:', err)
      setError(err.message || 'Chyba pri pridavani telefonu')
    } finally {
      setAdding(false)
    }
  }

  const handleDeletePhone = async (blockId) => {
    if (!confirm('Naozaj chcete vymazat toto telefonne cislo?')) return

    try {
      await deleteVacationPhoneBlock(blockId)
      setPhones(prev => prev.filter(p => p.id !== blockId))
    } catch (err) {
      console.error('Failed to delete phone:', err)
      setError(err.message || 'Chyba pri mazani telefonu')
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
        <p className="text-gray-500">Vyberte stranku pre spravu dovolenky</p>
      </div>
    )
  }

  return (
    <div className="p-6">
      <div className="bg-white rounded-lg shadow-lg p-6">
        <h2 className="text-2xl font-semibold mb-6">Dovolenka - Sprava telefonnych cisel</h2>
        <p className="text-gray-600 mb-6">
          Aktivujte dovolenku pre telefonne cisla. Cisla na dovolenke nebudu zobrazene v paticke ani na kontaktnej stranke.
        </p>

        {error && (
          <div className="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-6">
            {error}
          </div>
        )}

        {/* Add new phone form */}
        <form onSubmit={handleAddPhone} className="mb-6">
          <div className="flex gap-3">
            <input
              type="text"
              value={newPhone}
              onChange={(e) => setNewPhone(e.target.value)}
              placeholder="Zadajte telefonne cislo (napr. +421 900 123 456)"
              className="flex-1 border border-gray-300 rounded-lg px-4 py-2 focus:ring-2 focus:ring-purple-500 focus:border-transparent"
            />
            <button
              type="submit"
              disabled={adding || !newPhone.trim()}
              className="bg-purple-600 hover:bg-purple-700 disabled:bg-purple-400 text-white px-6 py-2 rounded-lg font-semibold transition-colors"
            >
              {adding ? 'Pridavam...' : 'Pridat cislo'}
            </button>
          </div>
        </form>

        {/* Phone list */}
        {phones.length === 0 ? (
          <div className="text-center py-8 text-gray-500">
            <p>Ziadne telefonne cisla</p>
            <p className="text-sm mt-1">Pridajte telefonne cislo pomocou formulara vyssie</p>
          </div>
        ) : (
          <div className="space-y-4">
            {phones.map((phone) => (
              <div
                key={phone.id}
                className="flex items-center justify-between border border-gray-200 rounded-lg p-4"
              >
                <div>
                  <p className="text-lg font-semibold">{phone.phone}</p>
                  <p className="text-sm text-gray-600">
                    {phone.enabled
                      ? 'Na dovolenke - cislo je skryte'
                      : 'Aktivne - cislo je zobrazene'}
                  </p>
                </div>
                <div className="flex gap-2">
                  <button
                    onClick={() => handleToggleVacation(phone.id)}
                    className={`px-6 py-2 rounded-lg font-semibold transition-colors ${
                      phone.enabled
                        ? 'bg-green-600 hover:bg-green-700 text-white'
                        : 'bg-orange-600 hover:bg-orange-700 text-white'
                    }`}
                  >
                    {phone.enabled ? 'Ukoncit dovolenku' : 'Aktivovat dovolenku'}
                  </button>
                  <button
                    onClick={() => handleDeletePhone(phone.id)}
                    className="px-4 py-2 rounded-lg font-semibold bg-red-100 hover:bg-red-200 text-red-700 transition-colors"
                  >
                    Vymazat
                  </button>
                </div>
              </div>
            ))}
          </div>
        )}
      </div>
    </div>
  )
}

export default Dovolenka
