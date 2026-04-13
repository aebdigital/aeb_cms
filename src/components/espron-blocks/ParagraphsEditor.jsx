import { PlusIcon, TrashIcon } from '@heroicons/react/24/outline'

export default function ParagraphsEditor({ block, onChange }) {
  const title = block.title ?? ''
  const paragraphs = block.paragraphs ?? ['']

  function updateTitle(val) {
    onChange({ ...block, title: val })
  }

  function updateParagraph(index, val) {
    const updated = paragraphs.map((p, i) => (i === index ? val : p))
    onChange({ ...block, paragraphs: updated })
  }

  function addParagraph() {
    onChange({ ...block, paragraphs: [...paragraphs, ''] })
  }

  function removeParagraph(index) {
    onChange({ ...block, paragraphs: paragraphs.filter((_, i) => i !== index) })
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
          placeholder="Nadpis tejto sekcie"
        />
      </div>

      <div className="space-y-2">
        <label className="block text-xs font-medium text-gray-600">Odseky</label>
        {paragraphs.map((para, i) => (
          <div key={i} className="flex gap-2">
            <textarea
              value={para}
              onChange={(e) => updateParagraph(i, e.target.value)}
              rows={3}
              className="flex-1 px-3 py-2 border border-gray-300 rounded-lg text-sm focus:ring-2 focus:ring-purple-500 focus:border-transparent resize-y"
              placeholder={`Odsek ${i + 1}`}
            />
            <button
              onClick={() => removeParagraph(i)}
              className="self-start p-2 text-gray-400 hover:text-red-500 transition-colors"
            >
              <TrashIcon className="h-4 w-4" />
            </button>
          </div>
        ))}
        <button
          onClick={addParagraph}
          className="flex items-center gap-1 text-xs text-purple-600 hover:text-purple-700 transition-colors"
        >
          <PlusIcon className="h-3.5 w-3.5" />
          Pridať odsek
        </button>
      </div>
    </div>
  )
}
