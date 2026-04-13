import { PlusIcon, TrashIcon } from '@heroicons/react/24/outline'

export default function FactsEditor({ block, onChange }) {
  const title = block.title ?? ''
  const items = block.items ?? [{ label: '', value: '' }]

  function updateTitle(val) {
    onChange({ ...block, title: val })
  }

  function updateItem(index, field, val) {
    const updated = items.map((item, i) =>
      i === index ? { ...item, [field]: val } : item
    )
    onChange({ ...block, items: updated })
  }

  function addItem() {
    onChange({ ...block, items: [...items, { label: '', value: '' }] })
  }

  function removeItem(index) {
    onChange({ ...block, items: items.filter((_, i) => i !== index) })
  }

  return (
    <div className="space-y-3">
      <div>
        <label className="block text-xs font-medium text-gray-600 mb-1">Nadpis sekcie</label>
        <input
          type="text"
          value={title}
          onChange={(e) => updateTitle(e.target.value)}
          className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm focus:ring-2 focus:ring-purple-500 focus:border-transparent"
          placeholder="Kľúčové fakty"
        />
      </div>

      <div className="space-y-2">
        <label className="block text-xs font-medium text-gray-600">Fakty (štítok + hodnota)</label>
        {items.map((item, i) => (
          <div key={i} className="flex gap-2 items-start">
            <div className="flex-1 grid grid-cols-2 gap-2">
              <input
                type="text"
                value={item.label}
                onChange={(e) => updateItem(i, 'label', e.target.value)}
                className="px-3 py-2 border border-gray-300 rounded-lg text-sm focus:ring-2 focus:ring-purple-500 focus:border-transparent"
                placeholder="Štítok (napr. Rok)"
              />
              <input
                type="text"
                value={item.value}
                onChange={(e) => updateItem(i, 'value', e.target.value)}
                className="px-3 py-2 border border-gray-300 rounded-lg text-sm focus:ring-2 focus:ring-purple-500 focus:border-transparent"
                placeholder="Hodnota (napr. 2020)"
              />
            </div>
            <button
              onClick={() => removeItem(i)}
              className="p-2 text-gray-400 hover:text-red-500 transition-colors"
            >
              <TrashIcon className="h-4 w-4" />
            </button>
          </div>
        ))}
        <button
          onClick={addItem}
          className="flex items-center gap-1 text-xs text-purple-600 hover:text-purple-700 transition-colors"
        >
          <PlusIcon className="h-3.5 w-3.5" />
          Pridať fakt
        </button>
      </div>
    </div>
  )
}
