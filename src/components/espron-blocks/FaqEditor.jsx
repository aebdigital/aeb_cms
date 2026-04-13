import { PlusIcon, TrashIcon } from '@heroicons/react/24/outline'

export default function FaqEditor({ block, onChange }) {
  const title = block.title ?? ''
  const items = block.items ?? [{ question: '', answer: '' }]

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
    onChange({ ...block, items: [...items, { question: '', answer: '' }] })
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
          placeholder="Časté otázky"
        />
      </div>

      <div className="space-y-3">
        <label className="block text-xs font-medium text-gray-600">Otázky a odpovede</label>
        {items.map((item, i) => (
          <div key={i} className="flex gap-2 items-start">
            <div className="flex-1 space-y-2">
              <input
                type="text"
                value={item.question}
                onChange={(e) => updateItem(i, 'question', e.target.value)}
                className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm focus:ring-2 focus:ring-purple-500 focus:border-transparent"
                placeholder={`Otázka ${i + 1}`}
              />
              <textarea
                value={item.answer}
                onChange={(e) => updateItem(i, 'answer', e.target.value)}
                rows={2}
                className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm focus:ring-2 focus:ring-purple-500 focus:border-transparent resize-y"
                placeholder="Odpoveď"
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
          Pridať otázku
        </button>
      </div>
    </div>
  )
}
