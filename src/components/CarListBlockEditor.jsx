import { useState, useEffect } from 'react'
import { updateBlockData } from '../api/pageDetail'
import { getCarsForSite } from '../api/cars'
import { CheckIcon, EyeIcon } from '@heroicons/react/24/outline'

export default function CarListBlockEditor({ block, siteId, onUpdate }) {
  const [layout, setLayout] = useState(block.data?.layout ?? 'grid')
  const [limit, setLimit] = useState(block.data?.limit ?? 50)
  const [featuredOnly, setFeaturedOnly] = useState(block.data?.filter?.featuredOnly ?? false)
  const [minPrice, setMinPrice] = useState(block.data?.filter?.minPrice ?? '')
  const [maxPrice, setMaxPrice] = useState(block.data?.filter?.maxPrice ?? '')
  const [fuel, setFuel] = useState(block.data?.filter?.fuel ?? '')
  const [transmission, setTransmission] = useState(block.data?.filter?.transmission ?? '')

  const [saving, setSaving] = useState(false)
  const [showPreview, setShowPreview] = useState(false)
  const [previewCars, setPreviewCars] = useState([])
  const [previewLoading, setPreviewLoading] = useState(false)

  async function handleSave() {
    setSaving(true)
    try {
      const newData = {
        layout,
        limit,
        filter: {
          featuredOnly,
          minPrice: minPrice ? Number(minPrice) : null,
          maxPrice: maxPrice ? Number(maxPrice) : null,
          fuel: fuel || null,
          transmission: transmission || null
        }
      }

      const updated = await updateBlockData(block.id, newData)
      onUpdate?.(updated)
      alert('Blok bol ulozeny!')
    } catch (err) {
      alert('Chyba pri ukladani: ' + err.message)
    } finally {
      setSaving(false)
    }
  }

  async function loadPreview() {
    if (!siteId) return

    setPreviewLoading(true)
    try {
      const cars = await getCarsForSite(siteId, {
        featuredOnly,
        minPrice: minPrice ? Number(minPrice) : null,
        maxPrice: maxPrice ? Number(maxPrice) : null,
        fuel: fuel || null,
        transmission: transmission || null,
        limit
      })
      setPreviewCars(cars)
      setShowPreview(true)
    } catch (err) {
      alert('Chyba pri nacitani nahadu: ' + err.message)
    } finally {
      setPreviewLoading(false)
    }
  }

  return (
    <div className="space-y-4">
      {/* Settings */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
        {/* Layout */}
        <div>
          <label className="block text-sm font-medium text-gray-700 mb-1">
            Rozlozenie
          </label>
          <select
            value={layout}
            onChange={(e) => setLayout(e.target.value)}
            className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-purple-500 focus:border-transparent"
          >
            <option value="grid">Mriezka (Grid)</option>
            <option value="list">Zoznam (List)</option>
          </select>
        </div>

        {/* Limit */}
        <div>
          <label className="block text-sm font-medium text-gray-700 mb-1">
            Maximálny počet
          </label>
          <input
            type="number"
            value={limit}
            onChange={(e) => setLimit(Number(e.target.value))}
            min="1"
            max="100"
            className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-purple-500 focus:border-transparent"
          />
        </div>

        {/* Featured Only */}
        <div className="flex items-end">
          <label className="flex items-center">
            <input
              type="checkbox"
              checked={featuredOnly}
              onChange={(e) => setFeaturedOnly(e.target.checked)}
              className="w-4 h-4 text-purple-600 rounded focus:ring-purple-500"
            />
            <span className="ml-2 text-sm text-gray-700">Iba odporucane vozidla</span>
          </label>
        </div>

        {/* Min Price */}
        <div>
          <label className="block text-sm font-medium text-gray-700 mb-1">
            Min. cena (EUR)
          </label>
          <input
            type="number"
            value={minPrice}
            onChange={(e) => setMinPrice(e.target.value)}
            placeholder="Bez limitu"
            className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-purple-500 focus:border-transparent"
          />
        </div>

        {/* Max Price */}
        <div>
          <label className="block text-sm font-medium text-gray-700 mb-1">
            Max. cena (EUR)
          </label>
          <input
            type="number"
            value={maxPrice}
            onChange={(e) => setMaxPrice(e.target.value)}
            placeholder="Bez limitu"
            className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-purple-500 focus:border-transparent"
          />
        </div>

        {/* Fuel */}
        <div>
          <label className="block text-sm font-medium text-gray-700 mb-1">
            Palivo
          </label>
          <select
            value={fuel}
            onChange={(e) => setFuel(e.target.value)}
            className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-purple-500 focus:border-transparent"
          >
            <option value="">Vsetky</option>
            <option value="Benzin">Benzin</option>
            <option value="Diesel">Diesel</option>
            <option value="Hybrid">Hybrid</option>
            <option value="Elektro">Elektro</option>
            <option value="LPG">LPG</option>
          </select>
        </div>

        {/* Transmission */}
        <div>
          <label className="block text-sm font-medium text-gray-700 mb-1">
            Prevodovka
          </label>
          <select
            value={transmission}
            onChange={(e) => setTransmission(e.target.value)}
            className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-purple-500 focus:border-transparent"
          >
            <option value="">Vsetky</option>
            <option value="Manualna">Manualna</option>
            <option value="Automaticka">Automaticka</option>
          </select>
        </div>
      </div>

      {/* Actions */}
      <div className="flex items-center justify-between pt-4 border-t border-gray-200">
        <button
          onClick={loadPreview}
          disabled={previewLoading}
          className="flex items-center px-4 py-2 text-gray-700 bg-gray-100 hover:bg-gray-200 rounded-lg transition-colors disabled:opacity-50"
        >
          {previewLoading ? (
            <>
              <svg className="animate-spin h-4 w-4 mr-2" viewBox="0 0 24 24">
                <circle className="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="4" fill="none" />
                <path className="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4z" />
              </svg>
              Nacitavam...
            </>
          ) : (
            <>
              <EyeIcon className="h-4 w-4 mr-2" />
              Nahlad ({previewCars.length} vozidiel)
            </>
          )}
        </button>

        <button
          onClick={handleSave}
          disabled={saving}
          className="flex items-center px-4 py-2 bg-gradient-to-r from-purple-600 to-blue-600 text-white rounded-lg hover:from-purple-700 hover:to-blue-700 disabled:opacity-50"
        >
          {saving ? (
            <>
              <svg className="animate-spin h-4 w-4 mr-2" viewBox="0 0 24 24">
                <circle className="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="4" fill="none" />
                <path className="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4z" />
              </svg>
              Ukladam...
            </>
          ) : (
            <>
              <CheckIcon className="h-4 w-4 mr-2" />
              Ulozit blok
            </>
          )}
        </button>
      </div>

      {/* Preview */}
      {showPreview && previewCars.length > 0 && (
        <div className="mt-4 pt-4 border-t border-gray-200">
          <div className="flex items-center justify-between mb-3">
            <h4 className="text-sm font-medium text-gray-700">
              Nahlad vozidiel ({previewCars.length})
            </h4>
            <button
              onClick={() => setShowPreview(false)}
              className="text-sm text-gray-500 hover:text-gray-700"
            >
              Skryt
            </button>
          </div>

          <div className={`grid gap-3 ${layout === 'grid' ? 'grid-cols-2 md:grid-cols-3' : 'grid-cols-1'}`}>
            {previewCars.slice(0, 6).map((car) => (
              <div
                key={car.id}
                className={`bg-gray-50 rounded-lg overflow-hidden ${
                  layout === 'list' ? 'flex items-center' : ''
                }`}
              >
                <div className={`${layout === 'list' ? 'w-24 h-16' : 'h-24'} bg-gray-200`}>
                  {car.image && (
                    <img
                      src={car.image}
                      alt={`${car.brand} ${car.model}`}
                      className="w-full h-full object-cover"
                    />
                  )}
                </div>
                <div className="p-2">
                  <p className="text-sm font-medium truncate">
                    {car.brand} {car.model}
                  </p>
                  <p className="text-xs text-gray-500">
                    {car.year} | {car.price?.toLocaleString()} EUR
                  </p>
                </div>
              </div>
            ))}
          </div>

          {previewCars.length > 6 && (
            <p className="text-xs text-gray-500 mt-2 text-center">
              ... a dalsich {previewCars.length - 6} vozidiel
            </p>
          )}
        </div>
      )}

      {showPreview && previewCars.length === 0 && (
        <div className="mt-4 pt-4 border-t border-gray-200">
          <p className="text-sm text-gray-500 text-center py-4">
            Ziadne vozidla zodpovedaju filtrom
          </p>
        </div>
      )}
    </div>
  )
}
