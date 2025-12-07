import { useState } from 'react'
import { updateBlockData } from '../api/pageDetail'
import { CheckIcon } from '@heroicons/react/24/outline'

export default function HeroBlockEditor({ block, onUpdate }) {
  const [title, setTitle] = useState(block.data?.title ?? '')
  const [subtitle, setSubtitle] = useState(block.data?.subtitle ?? '')
  const [backgroundImage, setBackgroundImage] = useState(block.data?.backgroundImage ?? '')
  const [ctaText, setCtaText] = useState(block.data?.ctaText ?? '')
  const [ctaLink, setCtaLink] = useState(block.data?.ctaLink ?? '')
  const [saving, setSaving] = useState(false)

  async function handleSave() {
    setSaving(true)
    try {
      const newData = {
        title,
        subtitle,
        backgroundImage,
        ctaText,
        ctaLink
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

  return (
    <div className="space-y-4">
      {/* Preview */}
      <div
        className="relative h-40 rounded-lg overflow-hidden bg-gradient-to-r from-purple-600 to-blue-600"
        style={backgroundImage ? { backgroundImage: `url(${backgroundImage})`, backgroundSize: 'cover', backgroundPosition: 'center' } : {}}
      >
        <div className="absolute inset-0 bg-black/40 flex flex-col items-center justify-center text-white p-4">
          <h3 className="text-xl font-bold text-center">{title || 'Nadpis'}</h3>
          {subtitle && <p className="text-sm mt-1 opacity-90">{subtitle}</p>}
          {ctaText && (
            <button className="mt-3 px-4 py-1.5 bg-white text-gray-900 rounded-lg text-sm font-medium">
              {ctaText}
            </button>
          )}
        </div>
      </div>

      {/* Settings */}
      <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
        <div>
          <label className="block text-sm font-medium text-gray-700 mb-1">
            Nadpis
          </label>
          <input
            type="text"
            value={title}
            onChange={(e) => setTitle(e.target.value)}
            className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-purple-500 focus:border-transparent"
            placeholder="Hlavny nadpis"
          />
        </div>

        <div>
          <label className="block text-sm font-medium text-gray-700 mb-1">
            Podnadpis
          </label>
          <input
            type="text"
            value={subtitle}
            onChange={(e) => setSubtitle(e.target.value)}
            className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-purple-500 focus:border-transparent"
            placeholder="Volitelny podnadpis"
          />
        </div>

        <div className="md:col-span-2">
          <label className="block text-sm font-medium text-gray-700 mb-1">
            URL obrazku na pozadi
          </label>
          <input
            type="url"
            value={backgroundImage}
            onChange={(e) => setBackgroundImage(e.target.value)}
            className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-purple-500 focus:border-transparent"
            placeholder="https://example.com/image.jpg"
          />
        </div>

        <div>
          <label className="block text-sm font-medium text-gray-700 mb-1">
            Text tlacidla (CTA)
          </label>
          <input
            type="text"
            value={ctaText}
            onChange={(e) => setCtaText(e.target.value)}
            className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-purple-500 focus:border-transparent"
            placeholder="Zobrazit ponuku"
          />
        </div>

        <div>
          <label className="block text-sm font-medium text-gray-700 mb-1">
            Odkaz tlacidla
          </label>
          <input
            type="text"
            value={ctaLink}
            onChange={(e) => setCtaLink(e.target.value)}
            className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-purple-500 focus:border-transparent"
            placeholder="/ponuka"
          />
        </div>
      </div>

      {/* Save Button */}
      <div className="flex justify-end pt-4 border-t border-gray-200">
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
    </div>
  )
}
