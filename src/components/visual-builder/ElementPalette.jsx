const PALETTE_GROUPS = [
  {
    label: 'Rozloženie',
    items: [
      {
        type: 'container',
        label: 'Container',
        desc: 'Flexbox obálka',
        icon: (
          <svg viewBox="0 0 16 16" fill="none" stroke="currentColor" strokeWidth="1.5" className="w-4 h-4">
            <rect x="1" y="1" width="14" height="14" rx="2" />
            <rect x="3.5" y="3.5" width="4" height="9" rx="1" />
            <rect x="9" y="3.5" width="4" height="9" rx="1" />
          </svg>
        ),
      },
      {
        type: 'spacer',
        label: 'Spacer',
        desc: 'Prázdny priestor',
        icon: (
          <svg viewBox="0 0 16 16" fill="none" stroke="currentColor" strokeWidth="1.5" className="w-4 h-4">
            <path d="M8 3v10M4 3h8M4 13h8" strokeLinecap="round" />
          </svg>
        ),
      },
      {
        type: 'divider',
        label: 'Oddeľovač',
        desc: 'Horizontálna čiara',
        icon: (
          <svg viewBox="0 0 16 16" fill="none" stroke="currentColor" strokeWidth="1.5" className="w-4 h-4">
            <path d="M2 8h12" strokeLinecap="round" />
          </svg>
        ),
      },
    ],
  },
  {
    label: 'Typografia',
    items: [
      {
        type: 'heading',
        label: 'Nadpis',
        desc: 'H1 – H4',
        icon: (
          <svg viewBox="0 0 16 16" fill="currentColor" className="w-4 h-4">
            <text x="1" y="13" fontSize="13" fontWeight="700" fontFamily="serif">H</text>
          </svg>
        ),
      },
      {
        type: 'paragraph',
        label: 'Odsek',
        desc: 'Textový blok',
        icon: (
          <svg viewBox="0 0 16 16" fill="none" stroke="currentColor" strokeWidth="1.5" className="w-4 h-4">
            <path d="M2 4h12M2 7h12M2 10h8" strokeLinecap="round" />
          </svg>
        ),
      },
      {
        type: 'badge',
        label: 'Badge',
        desc: 'Malý štítok',
        icon: (
          <svg viewBox="0 0 16 16" fill="none" stroke="currentColor" strokeWidth="1.5" className="w-4 h-4">
            <rect x="1" y="5" width="14" height="6" rx="3" />
          </svg>
        ),
      },
    ],
  },
  {
    label: 'UI Prvky',
    items: [
      {
        type: 'button',
        label: 'Tlačidlo',
        desc: 'CTA tlačidlo',
        icon: (
          <svg viewBox="0 0 16 16" fill="none" stroke="currentColor" strokeWidth="1.5" className="w-4 h-4">
            <rect x="1" y="4" width="14" height="8" rx="2" />
            <path d="M5 8h6" strokeLinecap="round" />
          </svg>
        ),
      },
      {
        type: 'contactForm',
        label: 'Kontakt. formulár',
        desc: 'Form so SMTP2GO',
        icon: (
          <svg viewBox="0 0 16 16" fill="none" stroke="currentColor" strokeWidth="1.5" className="w-4 h-4">
            <rect x="1" y="2" width="14" height="12" rx="2" />
            <path d="M3.5 5.5h9M3.5 8h9M3.5 10.5h5" strokeLinecap="round" />
          </svg>
        ),
      },
    ],
  },
  {
    label: 'Médiá',
    items: [
      {
        type: 'image',
        label: 'Obrázok',
        desc: 'Obrázok / banner',
        icon: (
          <svg viewBox="0 0 16 16" fill="none" stroke="currentColor" strokeWidth="1.5" className="w-4 h-4">
            <rect x="1" y="2" width="14" height="12" rx="2" />
            <circle cx="5.5" cy="6" r="1.5" />
            <path d="M1 11l4-3 3 2.5 2.5-2L15 12" strokeLinecap="round" strokeLinejoin="round" />
          </svg>
        ),
      },
    ],
  },
]

import { useDrag } from './DragContext'

export default function ElementPalette({ onAddElement, orientation = 'vertical' }) {
  const drag = useDrag()

  function handleDragStart(e, type) {
    drag.current = { kind: 'palette', elementType: type, elementId: null }
    e.dataTransfer.effectAllowed = 'copy'
  }

  function handleDragEnd() {
    drag.current = { kind: null, elementType: null, elementId: null }
  }

  if (orientation === 'horizontal') {
    // Flat bottom strip: all items in one scrollable row with group separators.
    return (
      <div
        className="flex items-stretch gap-1 bg-gray-900 border-t border-gray-800 overflow-x-auto flex-shrink-0"
        style={{ height: 68, padding: '8px 12px' }}
      >
        {PALETTE_GROUPS.map((group, gi) => (
          <div key={group.label} className="flex items-center gap-1">
            {gi > 0 && <span className="w-px h-8 bg-gray-800 mx-1" aria-hidden="true" />}
            <span className="text-[9px] font-bold uppercase tracking-widest text-gray-600 pr-1 select-none whitespace-nowrap">
              {group.label}
            </span>
            {group.items.map(item => (
              <button
                key={item.type}
                type="button"
                draggable
                onDragStart={(e) => handleDragStart(e, item.type)}
                onDragEnd={handleDragEnd}
                onClick={() => onAddElement(item.type)}
                title={`${item.label} — ${item.desc}`}
                className="flex flex-col items-center justify-center gap-1 px-3 py-1.5 rounded-md cursor-grab active:cursor-grabbing hover:bg-gray-800 transition-colors group border border-transparent hover:border-gray-700"
                style={{ minWidth: 64 }}
              >
                <span className="text-gray-400 group-hover:text-indigo-400 transition-colors">
                  {item.icon}
                </span>
                <span className="text-[10px] font-medium text-gray-400 group-hover:text-white transition-colors leading-none">
                  {item.label}
                </span>
              </button>
            ))}
          </div>
        ))}
      </div>
    )
  }

  return (
    <aside className="w-52 bg-gray-900 border-r border-gray-800 flex flex-col overflow-hidden flex-shrink-0">
      <div className="px-3 py-2.5 border-b border-gray-800">
        <p className="text-[10px] font-semibold uppercase tracking-widest text-gray-500">Prvky</p>
      </div>

      <div className="flex-1 overflow-y-auto py-2 scrollbar-thin">
        {PALETTE_GROUPS.map(group => (
          <div key={group.label} className="mb-3">
            <p className="px-3 pt-1 pb-1.5 text-[9px] font-bold uppercase tracking-widest text-gray-600">
              {group.label}
            </p>
            <div className="px-2 space-y-0.5">
              {group.items.map(item => (
                <div
                  key={item.type}
                  draggable
                  onDragStart={(e) => handleDragStart(e, item.type)}
                  onDragEnd={handleDragEnd}
                  onClick={() => onAddElement(item.type)}
                  className="flex items-center gap-2.5 px-2.5 py-2 rounded-lg cursor-grab active:cursor-grabbing hover:bg-gray-800 transition-colors group"
                >
                  <span className="text-gray-500 group-hover:text-indigo-400 transition-colors flex-shrink-0">
                    {item.icon}
                  </span>
                  <div className="min-w-0">
                    <p className="text-xs font-medium text-gray-300 group-hover:text-white transition-colors leading-none">
                      {item.label}
                    </p>
                    <p className="text-[10px] text-gray-600 leading-none mt-0.5 truncate">
                      {item.desc}
                    </p>
                  </div>
                </div>
              ))}
            </div>
          </div>
        ))}
      </div>
    </aside>
  )
}
