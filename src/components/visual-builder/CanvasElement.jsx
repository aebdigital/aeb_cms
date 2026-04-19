import { useState } from 'react'
import { useDrag } from './DragContext'
import DroppableArea from './DroppableArea'

// ─── Style builder ────────────────────────────────────────────────────────────

function buildInlineStyle(style) {
  if (!style) return {}
  const px = (v) => (v !== undefined && v !== '' && v !== 'auto') ? `${v}px` : v === 'auto' ? 'auto' : undefined

  // blockAlign: center uses margin auto on both sides; right uses auto on left only.
  // Requires element width < 100% to be visible (we note this in UI).
  const blockAlign = style.blockAlign
  let effectiveMl = px(style.marginLeft)
  let effectiveMr = px(style.marginRight)
  if (blockAlign === 'center') { effectiveMl = 'auto'; effectiveMr = 'auto' }
  else if (blockAlign === 'right') { effectiveMl = 'auto' }

  return {
    paddingTop: px(style.paddingTop),
    paddingRight: px(style.paddingRight),
    paddingBottom: px(style.paddingBottom),
    paddingLeft: px(style.paddingLeft),
    marginTop: px(style.marginTop),
    marginRight: effectiveMr,
    marginBottom: px(style.marginBottom),
    marginLeft: effectiveMl,
    maxWidth: style.maxWidth || undefined,
    boxShadow: style.boxShadow || undefined,
    fontSize: px(style.fontSize),
    fontWeight: style.fontWeight || undefined,
    color: style.color || undefined,
    textAlign: style.textAlign || undefined,
    lineHeight: style.lineHeight || undefined,
    backgroundColor: style.backgroundColor || undefined,
    borderRadius: px(style.borderRadius),
    borderWidth: Number(style.borderWidth) > 0 ? px(style.borderWidth) : undefined,
    borderColor: Number(style.borderWidth) > 0 ? style.borderColor : undefined,
    borderStyle: Number(style.borderWidth) > 0 ? (style.borderStyle || 'solid') : undefined,
    width: style.width || undefined,
    height: style.height === 'auto' ? 'auto' : (style.height ? px(style.height) : undefined),
    minHeight: style.minHeight ? px(style.minHeight) : undefined,
    display: style.display || undefined,
    flexDirection: style.display === 'flex' ? style.flexDirection : undefined,
    alignItems: style.display === 'flex' ? style.alignItems : undefined,
    justifyContent: style.display === 'flex' ? style.justifyContent : undefined,
    gap: style.display === 'flex' && style.gap ? px(style.gap) : undefined,
    objectFit: style.objectFit || undefined,
    boxSizing: 'border-box',
  }
}

// ─── Type label map ───────────────────────────────────────────────────────────

const TYPE_LABEL = {
  heading: (el) => (el.level ?? 'h2').toUpperCase(),
  paragraph: () => 'P',
  button: () => 'BTN',
  image: () => 'IMG',
  container: () => 'DIV',
  divider: () => 'HR',
  spacer: () => 'SPACER',
  badge: () => 'BADGE',
  contactForm: () => 'FORM',
}

// ─── Element renderer ─────────────────────────────────────────────────────────

function ElementRenderer({ element, selectedId, draggingId, onSelect, onAddElement, onMoveElement, onDelete, onDuplicate, onDragStart, onDragEnd }) {
  const s = buildInlineStyle(element.style)

  switch (element.type) {
    case 'heading': {
      const Tag = element.level ?? 'h2'
      return <Tag style={s}>{element.content || 'Nadpis'}</Tag>
    }

    case 'paragraph':
      return <p style={s}>{element.content || 'Text odseku...'}</p>

    case 'badge': {
      const wrapAlign = element.style?.blockAlign === 'center' ? 'center'
        : element.style?.blockAlign === 'right' ? 'right' : undefined
      return (
        <div style={{ marginTop: s.marginTop, marginBottom: s.marginBottom, textAlign: wrapAlign }}>
          <span style={{ ...s, marginTop: 0, marginBottom: 0, marginLeft: 0, marginRight: 0, display: 'inline-block' }}>
            {element.content || 'Badge'}
          </span>
        </div>
      )
    }

    case 'button': {
      const wrapAlign = element.style?.blockAlign === 'center' ? 'center'
        : element.style?.blockAlign === 'right' ? 'right' : undefined
      return (
        <div style={{ marginTop: s.marginTop, marginBottom: s.marginBottom, textAlign: wrapAlign }}>
          <button
            style={{ ...s, marginTop: 0, marginBottom: 0, marginLeft: 0, marginRight: 0, cursor: 'default', display: 'inline-block' }}
            onClick={(e) => e.preventDefault()}
          >
            {element.content || 'Tlačidlo'}
          </button>
        </div>
      )
    }

    case 'image':
      return (
        <img
          src={element.src || 'https://placehold.co/1200x500/f1f5f9/94a3b8?text=Image'}
          alt={element.alt || ''}
          style={{ ...s, display: 'block' }}
          draggable={false}
        />
      )

    case 'divider':
      return (
        <div style={{ marginTop: s.marginTop, marginBottom: s.marginBottom, width: '100%' }}>
          <hr style={{
            border: 'none',
            borderTop: `${Number(element.style?.borderWidth || 1)}px ${element.style?.borderStyle || 'solid'} ${element.style?.borderColor || '#e5e7eb'}`,
          }} />
        </div>
      )

    case 'spacer':
      return <div style={{ height: s.height ?? '40px', width: '100%', flexShrink: 0 }} />

    case 'container':
      // Containers get their own DroppableArea for children — this is what enables nesting
      return (
        <div style={{ ...s, position: 'relative' }}>
          <DroppableArea
            elements={element.children ?? []}
            parentId={element.id}
            selectedId={selectedId}
            draggingId={draggingId}
            isRoot={false}
            onSelect={onSelect}
            onAddElement={onAddElement}
            onMoveElement={onMoveElement}
            onDelete={onDelete}
            onDuplicate={onDuplicate}
            onDragStart={onDragStart}
            onDragEnd={onDragEnd}
          />
        </div>
      )

    case 'contactForm':
      return <ContactFormPreview element={element} style={s} />

    default:
      return (
        <div style={{ padding: 8, background: '#f3f4f6', borderRadius: 4, fontSize: 12, color: '#6b7280' }}>
          {element.type}
        </div>
      )
  }
}

// ─── Contact form preview (non-interactive) ──────────────────────────────────

function ContactFormPreview({ element, style }) {
  const fields = Array.isArray(element.fields) ? element.fields : []
  const rows = []
  for (let i = 0; i < fields.length; i++) {
    const f = fields[i]
    const next = fields[i + 1]
    if (f.width === 'half' && next && next.width === 'half') {
      rows.push([f, next])
      i++
    } else {
      rows.push([f])
    }
  }
  const inputStyle = {
    width: '100%', border: '1px solid #e5e7eb', borderRadius: 12,
    padding: '10px 14px', fontSize: 13, color: '#374151',
    background: '#fff', boxSizing: 'border-box',
  }
  return (
    <div style={style}>
      <div style={{ display: 'flex', flexDirection: 'column', gap: 16 }}>
        {rows.map((row, idx) => (
          <div
            key={idx}
            style={{
              display: 'grid',
              gridTemplateColumns: row.length === 2 ? '1fr 1fr' : '1fr',
              gap: 16,
            }}
          >
            {row.map(f => (
              <div key={f.id}>
                <p style={{ fontSize: 12, fontWeight: 500, color: '#6b7280', margin: '0 0 6px' }}>
                  {f.label || f.name}{f.required ? ' *' : ''}
                </p>
                {f.type === 'textarea' ? (
                  <div style={{ ...inputStyle, minHeight: 96, color: '#9ca3af' }}>
                    {f.placeholder || ''}
                  </div>
                ) : (
                  <div style={{ ...inputStyle, color: '#9ca3af' }}>
                    {f.placeholder || ''}
                  </div>
                )}
              </div>
            ))}
          </div>
        ))}
        <div>
          <div style={{
            display: 'inline-block', background: '#172c70', color: '#fff',
            padding: '14px 32px', borderRadius: 9999, fontSize: 13, fontWeight: 700,
          }}>
            {element.buttonText || 'Odoslať'}
          </div>
        </div>
      </div>
    </div>
  )
}

// ─── Main CanvasElement ───────────────────────────────────────────────────────

export default function CanvasElement({
  element, isSelected, isDragging,
  selectedId, draggingId,
  onSelect, onAddElement, onMoveElement, onDelete, onDuplicate,
  onDragStart, onDragEnd,
}) {
  const [hovered, setHovered] = useState(false)
  const drag = useDrag()
  const showUI = isSelected || hovered

  const label = (TYPE_LABEL[element.type] ?? (() => element.type))(element)

  function handleDragStart(e) {
    e.stopPropagation()
    drag.current = { kind: 'canvas', elementType: null, elementId: element.id }
    e.dataTransfer.effectAllowed = 'move'
    onDragStart?.(element.id)
  }

  function handleDragEnd(e) {
    e.stopPropagation()
    drag.current = { kind: null, elementType: null, elementId: null }
    onDragEnd?.()
  }

  return (
    <div
      style={{ position: 'relative', opacity: isDragging ? 0.25 : 1, transition: 'opacity 0.15s' }}
      onClick={(e) => { e.stopPropagation(); onSelect(element.id) }}
      onMouseEnter={() => setHovered(true)}
      onMouseLeave={() => setHovered(false)}
      draggable
      onDragStart={handleDragStart}
      onDragEnd={handleDragEnd}
    >
      {/* Selection outline */}
      {showUI && (
        <div style={{
          position: 'absolute', inset: 0, pointerEvents: 'none', zIndex: 10,
          outline: isSelected ? '2px solid #6366f1' : '1.5px solid #a5b4fc',
          outlineOffset: 1,
          borderRadius: 2,
        }} />
      )}

      {/* Type label chip */}
      {showUI && (
        <div style={{
          position: 'absolute', top: -21, left: 0, zIndex: 20,
          pointerEvents: 'none', display: 'flex', alignItems: 'center',
        }}>
          <span style={{
            background: isSelected ? '#6366f1' : '#818cf8',
            color: '#fff', fontSize: 9, fontWeight: 700,
            padding: '2px 7px', borderRadius: '4px 4px 0 0',
            lineHeight: 1.5, userSelect: 'none',
          }}>
            {label}
          </span>
        </div>
      )}

      {/* Action buttons */}
      {isSelected && (
        <div
          style={{ position: 'absolute', top: -21, right: 0, zIndex: 20, display: 'flex', gap: 2 }}
          onClick={(e) => e.stopPropagation()}
        >
          <button
            onMouseDown={(e) => { e.stopPropagation(); onDuplicate(element.id) }}
            style={{
              background: '#374151', color: '#d1d5db', border: 'none',
              borderRadius: '4px 4px 0 0', padding: '2px 7px',
              fontSize: 9, cursor: 'pointer', fontWeight: 700, lineHeight: 1.5,
            }}
            title="Duplikovať"
          >⧉</button>
          <button
            onMouseDown={(e) => { e.stopPropagation(); onDelete(element.id) }}
            style={{
              background: '#dc2626', color: '#fff', border: 'none',
              borderRadius: '4px 4px 0 0', padding: '2px 7px',
              fontSize: 9, cursor: 'pointer', fontWeight: 700, lineHeight: 1.5,
            }}
            title="Odstrániť"
          >✕</button>
        </div>
      )}

      <ElementRenderer
        element={element}
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
  )
}
