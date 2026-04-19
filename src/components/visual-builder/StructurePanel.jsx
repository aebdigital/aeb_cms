import { useState } from 'react'
import { useDrag } from './DragContext'

// ─── Labels & icons per element type ─────────────────────────────────────────

const TYPE_LABEL = {
  heading: (el) => (el.level ?? 'h2').toUpperCase(),
  paragraph: () => 'Odsek',
  button: () => 'Tlačidlo',
  badge: () => 'Badge',
  image: () => 'Obrázok',
  container: () => 'Kontajner',
  divider: () => 'Oddeľovač',
  spacer: () => 'Spacer',
  contactForm: () => 'Formulár',
}

function TypeIcon({ type, level }) {
  const stroke = 'currentColor'
  const common = { width: 12, height: 12, viewBox: '0 0 16 16', fill: 'none', stroke, strokeWidth: 1.5 }
  switch (type) {
    case 'heading':
      return (
        <svg {...common} viewBox="0 0 16 16">
          <text x="1" y="13" fontSize="13" fontWeight="700" fontFamily="serif" fill="currentColor" stroke="none">
            {(level ?? 'h2').charAt(0).toUpperCase()}
          </text>
        </svg>
      )
    case 'paragraph':
      return <svg {...common}><path d="M2 4h12M2 7h12M2 10h8" strokeLinecap="round" /></svg>
    case 'button':
      return <svg {...common}><rect x="1" y="4" width="14" height="8" rx="2" /><path d="M5 8h6" strokeLinecap="round" /></svg>
    case 'badge':
      return <svg {...common}><rect x="1" y="5" width="14" height="6" rx="3" /></svg>
    case 'image':
      return (
        <svg {...common}>
          <rect x="1" y="2" width="14" height="12" rx="2" />
          <circle cx="5.5" cy="6" r="1.5" />
          <path d="M1 11l4-3 3 2.5 2.5-2L15 12" strokeLinecap="round" strokeLinejoin="round" />
        </svg>
      )
    case 'container':
      return <svg {...common}><rect x="1" y="1" width="14" height="14" rx="2" /><rect x="3.5" y="3.5" width="4" height="9" rx="1" /><rect x="9" y="3.5" width="4" height="9" rx="1" /></svg>
    case 'divider':
      return <svg {...common}><path d="M2 8h12" strokeLinecap="round" /></svg>
    case 'spacer':
      return <svg {...common}><path d="M8 3v10M4 3h8M4 13h8" strokeLinecap="round" /></svg>
    case 'contactForm':
      return <svg {...common}><rect x="1" y="2" width="14" height="12" rx="2" /><path d="M3.5 5.5h9M3.5 8h9M3.5 10.5h5" strokeLinecap="round" /></svg>
    default:
      return <span style={{ width: 12, height: 12, display: 'inline-block' }} />
  }
}

// ─── Tree helpers (local to this panel) ──────────────────────────────────────

function findInTree(elements, id) {
  for (const el of elements) {
    if (el.id === id) return el
    if (el.children) {
      const found = findInTree(el.children, id)
      if (found) return found
    }
  }
  return null
}

function findLocation(elements, id, parentId = null) {
  for (let i = 0; i < elements.length; i++) {
    if (elements[i].id === id) return { parentId, index: i }
    if (elements[i].children) {
      const found = findLocation(elements[i].children, id, elements[i].id)
      if (found) return found
    }
  }
  return null
}

// ─── Tree node ───────────────────────────────────────────────────────────────

function TreeNode({
  element, depth, selectedId, draggingId, collapsedIds,
  onSelect, onToggleCollapse, onMove, onDragStart, onDragEnd,
}) {
  const drag = useDrag()
  const [dropZone, setDropZone] = useState(null) // 'before' | 'inside' | 'after'
  const isSelected = selectedId === element.id
  const isDragging = draggingId === element.id
  const isContainer = element.type === 'container'
  const hasChildren = isContainer && (element.children?.length ?? 0) > 0
  const isCollapsed = collapsedIds.has(element.id)
  const label = (TYPE_LABEL[element.type] ?? (() => element.type))(element)
  const preview = typeof element.content === 'string' && element.content.trim() ? element.content.trim() : null

  function handleDragStart(e) {
    e.stopPropagation()
    drag.current = { kind: 'canvas', elementType: null, elementId: element.id }
    e.dataTransfer.effectAllowed = 'move'
    onDragStart?.(element.id)
  }

  function handleDragEnd(e) {
    e.stopPropagation()
    drag.current = { kind: null, elementType: null, elementId: null }
    setDropZone(null)
    onDragEnd?.()
  }

  function handleDragOver(e) {
    // Accept both palette drops (new element) and canvas moves
    if (drag.current.kind !== 'canvas' && drag.current.kind !== 'palette') return
    if (drag.current.kind === 'canvas' && drag.current.elementId === element.id) return
    e.preventDefault()
    e.stopPropagation()
    e.dataTransfer.dropEffect = drag.current.kind === 'palette' ? 'copy' : 'move'
    const rect = e.currentTarget.getBoundingClientRect()
    const y = e.clientY - rect.top
    const h = rect.height
    if (isContainer && y > h * 0.3 && y < h * 0.7) setDropZone('inside')
    else if (y < h / 2) setDropZone('before')
    else setDropZone('after')
  }

  function handleDragLeave() {
    setDropZone(null)
  }

  function handleDrop(e) {
    e.preventDefault()
    e.stopPropagation()
    const zone = dropZone ?? 'after'
    setDropZone(null)
    if (drag.current.kind === 'canvas' && drag.current.elementId) {
      onMove({ kind: 'move', sourceId: drag.current.elementId, zone, targetId: element.id })
    } else if (drag.current.kind === 'palette' && drag.current.elementType) {
      onMove({ kind: 'add', elementType: drag.current.elementType, zone, targetId: element.id })
    }
    drag.current = { kind: null, elementType: null, elementId: null }
    onDragEnd?.()
  }

  const rowStyle = {
    display: 'flex', alignItems: 'center', gap: 4,
    padding: '3px 6px 3px 4px',
    paddingLeft: 4 + depth * 14,
    borderRadius: 4,
    cursor: 'grab',
    fontSize: 11,
    userSelect: 'none',
    color: isSelected ? '#fff' : '#c7d2fe',
    background: isSelected
      ? '#4338ca'
      : dropZone === 'inside'
        ? 'rgba(99,102,241,0.18)'
        : 'transparent',
    opacity: isDragging ? 0.4 : 1,
    transition: 'background 0.1s',
    position: 'relative',
  }

  return (
    <div>
      <div
        draggable
        onDragStart={handleDragStart}
        onDragEnd={handleDragEnd}
        onDragOver={handleDragOver}
        onDragLeave={handleDragLeave}
        onDrop={handleDrop}
        onClick={(e) => { e.stopPropagation(); onSelect(element.id) }}
        onMouseEnter={(e) => { if (!isSelected) e.currentTarget.style.background = 'rgba(255,255,255,0.04)' }}
        onMouseLeave={(e) => {
          if (!isSelected && dropZone !== 'inside') e.currentTarget.style.background = 'transparent'
        }}
        style={rowStyle}
      >
        {/* Drop line indicators */}
        {dropZone === 'before' && (
          <div style={{ position: 'absolute', top: -1, left: 4, right: 4, height: 2, background: '#6366f1', borderRadius: 2, pointerEvents: 'none' }} />
        )}
        {dropZone === 'after' && (
          <div style={{ position: 'absolute', bottom: -1, left: 4, right: 4, height: 2, background: '#6366f1', borderRadius: 2, pointerEvents: 'none' }} />
        )}

        {/* Chevron */}
        {hasChildren ? (
          <button
            onClick={(e) => { e.stopPropagation(); onToggleCollapse(element.id) }}
            style={{
              width: 14, height: 14, border: 'none', background: 'transparent',
              color: '#9ca3af', cursor: 'pointer', padding: 0, flexShrink: 0,
              display: 'flex', alignItems: 'center', justifyContent: 'center',
              fontSize: 9, lineHeight: 1,
              transform: isCollapsed ? 'rotate(-90deg)' : 'none',
              transition: 'transform 0.12s',
            }}
          >
            ▼
          </button>
        ) : (
          <span style={{ width: 14, flexShrink: 0 }} />
        )}

        {/* Icon */}
        <span style={{ color: isSelected ? '#e0e7ff' : '#818cf8', display: 'flex', flexShrink: 0 }}>
          <TypeIcon type={element.type} level={element.level} />
        </span>

        {/* Label */}
        <span style={{ fontWeight: 500, flexShrink: 0 }}>{label}</span>

        {/* Content preview */}
        {preview && (
          <span style={{
            color: isSelected ? 'rgba(255,255,255,0.55)' : '#6b7280',
            fontSize: 10, marginLeft: 4, fontWeight: 400,
            overflow: 'hidden', textOverflow: 'ellipsis', whiteSpace: 'nowrap',
            minWidth: 0, flex: 1,
          }}>
            {preview}
          </span>
        )}
      </div>

      {hasChildren && !isCollapsed && (
        <div>
          {element.children.map(child => (
            <TreeNode
              key={child.id}
              element={child}
              depth={depth + 1}
              selectedId={selectedId}
              draggingId={draggingId}
              collapsedIds={collapsedIds}
              onSelect={onSelect}
              onToggleCollapse={onToggleCollapse}
              onMove={onMove}
              onDragStart={onDragStart}
              onDragEnd={onDragEnd}
            />
          ))}
        </div>
      )}
    </div>
  )
}

// ─── Main panel ──────────────────────────────────────────────────────────────

export default function StructurePanel({
  elements, selectedId, draggingId,
  onSelect, onMoveElement, onAddElement,
  onDragStart, onDragEnd,
}) {
  const [collapsedIds, setCollapsedIds] = useState(() => new Set())
  const drag = useDrag()
  const [rootDrop, setRootDrop] = useState(false)

  function toggleCollapse(id) {
    setCollapsedIds(prev => {
      const next = new Set(prev)
      if (next.has(id)) next.delete(id)
      else next.add(id)
      return next
    })
  }

  function handleTreeAction(action) {
    if (action.kind === 'move') {
      const loc = findLocation(elements, action.targetId)
      if (!loc) return
      if (action.zone === 'before') {
        onMoveElement(action.sourceId, loc.parentId, loc.index)
      } else if (action.zone === 'after') {
        onMoveElement(action.sourceId, loc.parentId, loc.index + 1)
      } else if (action.zone === 'inside') {
        const target = findInTree(elements, action.targetId)
        const atIndex = target?.children?.length ?? 0
        onMoveElement(action.sourceId, action.targetId, atIndex)
      }
    } else if (action.kind === 'add') {
      const loc = findLocation(elements, action.targetId)
      if (!loc) return
      if (action.zone === 'before') {
        onAddElement(action.elementType, loc.parentId, loc.index)
      } else if (action.zone === 'after') {
        onAddElement(action.elementType, loc.parentId, loc.index + 1)
      } else if (action.zone === 'inside') {
        const target = findInTree(elements, action.targetId)
        const atIndex = target?.children?.length ?? 0
        onAddElement(action.elementType, action.targetId, atIndex)
      }
    }
  }

  // Empty-area drop: append to root
  function handleRootDragOver(e) {
    if (drag.current.kind !== 'canvas' && drag.current.kind !== 'palette') return
    e.preventDefault()
    e.dataTransfer.dropEffect = drag.current.kind === 'palette' ? 'copy' : 'move'
    setRootDrop(true)
  }

  function handleRootDragLeave() {
    setRootDrop(false)
  }

  function handleRootDrop(e) {
    e.preventDefault()
    setRootDrop(false)
    if (drag.current.kind === 'canvas' && drag.current.elementId) {
      onMoveElement(drag.current.elementId, null, elements.length)
    } else if (drag.current.kind === 'palette' && drag.current.elementType) {
      onAddElement(drag.current.elementType, null, elements.length)
    }
    drag.current = { kind: null, elementType: null, elementId: null }
    onDragEnd?.()
  }

  return (
    <aside
      style={{
        width: 240, background: '#0b0f1a', borderRight: '1px solid #1f2937',
        display: 'flex', flexDirection: 'column', overflow: 'hidden', flexShrink: 0,
      }}
    >
      <div style={{
        padding: '10px 12px 8px', borderBottom: '1px solid #1f2937',
        display: 'flex', alignItems: 'center', justifyContent: 'space-between', flexShrink: 0,
      }}>
        <p style={{ fontSize: 11, fontWeight: 700, color: '#e5e7eb', margin: 0, letterSpacing: 0.3 }}>
          Štruktúra
        </p>
        {elements.length > 0 && (
          <button
            onClick={() => {
              // Expand/collapse all containers
              setCollapsedIds(prev => prev.size > 0 ? new Set() : collectAllContainerIds(elements))
            }}
            title="Rozbaliť / Zbaliť všetko"
            style={{
              background: 'transparent', border: 'none', color: '#6b7280',
              cursor: 'pointer', fontSize: 11, padding: '2px 6px', borderRadius: 4,
            }}
          >
            ⇕
          </button>
        )}
      </div>

      <div
        onDragOver={handleRootDragOver}
        onDragLeave={handleRootDragLeave}
        onDrop={handleRootDrop}
        style={{
          flex: 1, overflowY: 'auto', padding: '8px 6px',
          background: rootDrop ? 'rgba(99,102,241,0.06)' : 'transparent',
          transition: 'background 0.1s',
        }}
      >
        {elements.length === 0 ? (
          <p style={{ fontSize: 10, color: '#4b5563', padding: '16px 8px', textAlign: 'center', margin: 0, lineHeight: 1.5 }}>
            Žiadne prvky.<br />Pridajte ich zo spodného panela.
          </p>
        ) : elements.map(el => (
          <TreeNode
            key={el.id}
            element={el}
            depth={0}
            selectedId={selectedId}
            draggingId={draggingId}
            collapsedIds={collapsedIds}
            onSelect={onSelect}
            onToggleCollapse={toggleCollapse}
            onMove={handleTreeAction}
            onDragStart={onDragStart}
            onDragEnd={onDragEnd}
          />
        ))}
      </div>
    </aside>
  )
}

function collectAllContainerIds(elements, set = new Set()) {
  for (const el of elements) {
    if (el.type === 'container') set.add(el.id)
    if (el.children) collectAllContainerIds(el.children, set)
  }
  return set
}
