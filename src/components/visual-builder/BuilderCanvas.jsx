import { useDrag } from './DragContext'
import DroppableArea from './DroppableArea'

export default function BuilderCanvas({
  elements, selectedId, draggingId, viewportWidth,
  onSelect, onAddElement, onMoveElement, onDelete, onDuplicate,
  onDragStart, onDragEnd,
}) {
  return (
    <div
      className="flex-1 overflow-auto"
      style={{
        background: '#1a1a2e',
        backgroundImage: 'radial-gradient(circle, #2a2a4a 1px, transparent 1px)',
        backgroundSize: '24px 24px',
      }}
    >
      <div className="flex flex-col items-center py-10 px-6 min-h-full">
        <div
          style={{
            width: viewportWidth,
            minHeight: 600,
            background: '#fff',
            borderRadius: 8,
            boxShadow: '0 25px 80px rgba(0,0,0,0.5)',
            transition: 'width 0.3s ease',
            position: 'relative',
          }}
        >
          {elements.length === 0 ? (
            <EmptyCanvas onAddElement={onAddElement} onMoveElement={onMoveElement} onSelect={onSelect} onDragEnd={onDragEnd} />
          ) : (
            <div
              style={{
                maxWidth: 1024,
                marginLeft: 'auto',
                marginRight: 'auto',
                paddingLeft: 24,
                paddingRight: 24,
                paddingTop: 64,
                paddingBottom: 64,
              }}
            >
              <DroppableArea
                elements={elements}
                parentId={null}
                isRoot
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
          )}
        </div>
        <div style={{ height: 80 }} />
      </div>
    </div>
  )
}

function EmptyCanvas({ onAddElement, onMoveElement, onSelect, onDragEnd }) {
  const drag = useDrag()

  function handleDragOver(e) {
    e.preventDefault()
    e.dataTransfer.dropEffect = 'copy'
  }

  function handleDrop(e) {
    e.preventDefault()
    if (drag.current.kind === 'palette' && drag.current.elementType) {
      onAddElement(drag.current.elementType, null, 0)
    } else if (drag.current.kind === 'canvas' && drag.current.elementId) {
      onMoveElement(drag.current.elementId, null, 0)
    }
    drag.current = { kind: null, elementType: null, elementId: null }
    onDragEnd?.()
  }

  return (
    <div
      style={{ minHeight: 600, display: 'flex', flexDirection: 'column', alignItems: 'center', justifyContent: 'center' }}
      onDragOver={handleDragOver}
      onDrop={handleDrop}
      onClick={(e) => { if (e.target === e.currentTarget) onSelect(null) }}
    >
      <div style={{
        width: 64, height: 64, border: '2px dashed #d1d5db', borderRadius: 16,
        display: 'flex', alignItems: 'center', justifyContent: 'center', marginBottom: 16, pointerEvents: 'none',
      }}>
        <svg width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="#9ca3af" strokeWidth="1.5">
          <path d="M12 4v16m8-8H4" strokeLinecap="round" />
        </svg>
      </div>
      <p style={{ fontSize: 14, color: '#6b7280', fontWeight: 500, margin: 0, pointerEvents: 'none' }}>Presuňte prvky sem</p>
      <p style={{ fontSize: 12, color: '#9ca3af', marginTop: 4, pointerEvents: 'none' }}>alebo kliknite na prvok v ľavom paneli</p>
    </div>
  )
}
