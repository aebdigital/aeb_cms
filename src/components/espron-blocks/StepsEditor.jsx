import { PlusIcon, TrashIcon } from '@heroicons/react/24/outline'

export default function StepsEditor({ block, onChange }) {
  const title = block.title ?? ''
  const items = block.items ?? [{ title: '', body: '', details: [] }]

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
    onChange({ ...block, items: [...items, { title: '', body: '', details: [] }] })
  }

  function removeItem(index) {
    onChange({ ...block, items: items.filter((_, i) => i !== index) })
  }

  function updateDetail(itemIndex, detailIndex, val) {
    const updatedItems = items.map((item, i) => {
      if (i !== itemIndex) return item
      const updatedDetails = (item.details ?? []).map((d, j) => (j === detailIndex ? val : d))
      return { ...item, details: updatedDetails }
    })
    onChange({ ...block, items: updatedItems })
  }

  function addDetail(itemIndex) {
    const updatedItems = items.map((item, i) => {
      if (i !== itemIndex) return item
      return { ...item, details: [...(item.details ?? []), ''] }
    })
    onChange({ ...block, items: updatedItems })
  }

  function removeDetail(itemIndex, detailIndex) {
    const updatedItems = items.map((item, i) => {
      if (i !== itemIndex) return item
      return { ...item, details: (item.details ?? []).filter((_, j) => j !== detailIndex) }
    })
    onChange({ ...block, items: updatedItems })
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
          placeholder="Postup práce"
        />
      </div>

      <div className="space-y-4">
        <label className="block text-xs font-medium text-gray-600">Kroky</label>
        {items.map((item, i) => (
          <div key={i} className="border border-gray-200 rounded-lg p-3 space-y-2 bg-gray-50">
            <div className="flex gap-2 items-start">
              <div className="w-7 h-7 rounded-full bg-purple-100 text-purple-700 text-xs font-bold flex items-center justify-center flex-shrink-0 mt-1">
                {i + 1}
              </div>
              <div className="flex-1 space-y-2">
                <input
                  type="text"
                  value={item.title}
                  onChange={(e) => updateItem(i, 'title', e.target.value)}
                  className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm focus:ring-2 focus:ring-purple-500 focus:border-transparent bg-white"
                  placeholder={`Nadpis kroku ${i + 1}`}
                />
                <textarea
                  value={item.body ?? ''}
                  onChange={(e) => updateItem(i, 'body', e.target.value)}
                  rows={2}
                  className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm focus:ring-2 focus:ring-purple-500 focus:border-transparent resize-y bg-white"
                  placeholder="Popis kroku (voliteľné)"
                />

                {/* Details list */}
                {(item.details ?? []).length > 0 && (
                  <div className="space-y-1 pl-1">
                    {(item.details ?? []).map((detail, j) => (
                      <div key={j} className="flex gap-1 items-center">
                        <input
                          type="text"
                          value={detail}
                          onChange={(e) => updateDetail(i, j, e.target.value)}
                          className="flex-1 px-2 py-1.5 border border-gray-200 rounded-md text-xs focus:ring-1 focus:ring-purple-400 bg-white"
                          placeholder={`Detail ${j + 1}`}
                        />
                        <button
                          onClick={() => removeDetail(i, j)}
                          className="p-1 text-gray-300 hover:text-red-500 transition-colors"
                        >
                          <TrashIcon className="h-3 w-3" />
                        </button>
                      </div>
                    ))}
                  </div>
                )}
                <button
                  onClick={() => addDetail(i)}
                  className="flex items-center gap-1 text-xs text-gray-500 hover:text-purple-600 transition-colors"
                >
                  <PlusIcon className="h-3 w-3" />
                  Pridať detail
                </button>
              </div>
              <button
                onClick={() => removeItem(i)}
                className="p-1.5 text-gray-400 hover:text-red-500 transition-colors flex-shrink-0"
              >
                <TrashIcon className="h-4 w-4" />
              </button>
            </div>
          </div>
        ))}
        <button
          onClick={addItem}
          className="flex items-center gap-1 text-xs text-purple-600 hover:text-purple-700 transition-colors"
        >
          <PlusIcon className="h-3.5 w-3.5" />
          Pridať krok
        </button>
      </div>
    </div>
  )
}
