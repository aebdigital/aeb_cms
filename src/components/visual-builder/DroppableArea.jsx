import { useState, useRef } from 'react'
import { useDrag } from './DragContext'
import CanvasElement from './CanvasElement'

/**
 * A reusable droppable list — used at root level AND inside every container.
 * Handles both palette drops (new element) and canvas drops (move element).
 */
export default function DroppableArea({
  elements,
  parentId,       // null = root canvas, string = parent container id
  selectedId,
  draggingId,
  isRoot,
  onSelect,
  onAddElement,
  onMoveElement,
  onDelete,
  onDuplicate,
  onDragStart,
  onDragEnd,
}) {
  const [dropIndex, setDropIndex] = useState(null)
  const [isOver, setIsOver] = useState(false)
  const drag = useDrag()
  const ref = useRef(null)

  function calcDropIndex(clientY) {
    const slots = ref.current
      ? Array.from(ref.current.querySelectorAll(':scope > [data-slot]'))
      : []
    if (slots.length === 0) return 0
    for (let i = 0; i < slots.length; i++) {
      const rect = slots[i].getBoundingClientRect()
      if (clientY < rect.top + rect.height / 2) return i
    }
    return slots.length
  }

  function handleDragOver(e) {
    e.preventDefault()
    e.stopPropagation()
    e.dataTransfer.dropEffect = drag.current.kind === 'canvas' ? 'move' : 'copy'
    setIsOver(true)
    setDropIndex(calcDropIndex(e.clientY))
  }

  function handleDrop(e) {
    e.preventDefault()
    e.stopPropagation()
    const idx = dropIndex ?? elements.length

    if (drag.current.kind === 'palette' && drag.current.elementType) {
      onAddElement(drag.current.elementType, parentId, idx)
    } else if (drag.current.kind === 'canvas' && drag.current.elementId) {
      onMoveElement(drag.current.elementId, parentId, idx)
    }

    drag.current = { kind: null, elementType: null, elementId: null }
    setDropIndex(null)
    setIsOver(false)
    onDragEnd?.()
  }

  function handleDragLeave(e) {
    if (!ref.current?.contains(e.relatedTarget)) {
      setDropIndex(null)
      setIsOver(false)
    }
  }

  const isEmpty = elements.length === 0

  // Visual style when a container is a drop target
  const containerStyle = !isRoot ? {
    minHeight: 60,
    borderRadius: 6,
    transition: 'background 0.15s, outline 0.15s',
    background: isOver && isEmpty ? 'rgba(99,102,241,0.07)' : 'transparent',
    outline: isOver
      ? '2px dashed #818cf8'
      : isEmpty
        ? '1.5px dashed #d1d5db'
        : 'none',
    outlineOffset: '-1px',
  } : {}

  return (
    <div
      ref={ref}
      onDragOver={handleDragOver}
      onDrop={handleDrop}
      onDragLeave={handleDragLeave}
      onClick={(e) => { if (e.target === e.currentTarget) onSelect(null) }}
      style={containerStyle}
    >
      {isEmpty && !isRoot && (
        <div style={{
          display: 'flex', alignItems: 'center', justifyContent: 'center',
          padding: '14px 8px', pointerEvents: 'none',
        }}>
          <span style={{ fontSize: 11, color: '#9ca3af' }}>
            Prázdny — presuňte sem prvky
          </span>
        </div>
      )}

      {elements.map((el, index) => (
        <div key={el.id} data-slot style={{ position: 'relative' }}>
          <DropLine active={dropIndex === index} />
          <CanvasElement
            element={el}
            isSelected={selectedId === el.id}
            isDragging={draggingId === el.id}
            selectedId={selectedId}
            draggingId={draggingId}
            onSelect={onSelect}
            onAddElement={onAddElement}
            onMoveElement={onMoveElement}
            onDelete={onDelete}
            onDuplicate={onDuplicate}
            onDragStart={onDragStart}
            onDragEnd={onDragEnd}
          />
        </div>
      ))}

      <DropLine active={dropIndex === elements.length && elements.length > 0} />
    </div>
  )
}

function DropLine({ active }) {
  return (
    <div style={{
      height: active ? 3 : 0,
      background: '#6366f1',
      borderRadius: 4,
      margin: active ? '3px 4px' : '0 4px',
      transition: 'height 0.1s, margin 0.1s',
      boxShadow: active ? '0 0 10px #6366f160' : 'none',
      pointerEvents: 'none',
    }} />
  )
}
