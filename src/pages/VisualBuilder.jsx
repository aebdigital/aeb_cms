import { useState, useRef } from 'react'
import { useNavigate } from 'react-router-dom'
import {
  ComputerDesktopIcon,
  DeviceTabletIcon,
  DevicePhoneMobileIcon,
  ArrowLeftIcon,
} from '@heroicons/react/24/outline'
import { DragProvider } from '../components/visual-builder/DragContext'
import ElementPalette from '../components/visual-builder/ElementPalette'
import BuilderCanvas from '../components/visual-builder/BuilderCanvas'
import PropertiesPanel from '../components/visual-builder/PropertiesPanel'

// ─── ID generator ─────────────────────────────────────────────────────────────

let _counter = 0
function genId() {
  return `el-${Date.now()}-${++_counter}`
}

// ─── Default styles per type ──────────────────────────────────────────────────

const DEFAULT_STYLES = {
  heading: {
    fontSize: '32', fontWeight: '700', color: '#111827', textAlign: 'left',
    marginTop: '0', marginRight: '0', marginBottom: '16', marginLeft: '0',
    paddingTop: '0', paddingRight: '0', paddingBottom: '0', paddingLeft: '0',
    lineHeight: '1.2', backgroundColor: '', borderRadius: '0',
    borderWidth: '0', borderColor: '#e5e7eb', borderStyle: 'solid', width: '100%',
  },
  paragraph: {
    fontSize: '16', fontWeight: '400', color: '#374151', textAlign: 'left',
    marginTop: '0', marginRight: '0', marginBottom: '16', marginLeft: '0',
    paddingTop: '0', paddingRight: '0', paddingBottom: '0', paddingLeft: '0',
    lineHeight: '1.7', backgroundColor: '', borderRadius: '0',
    borderWidth: '0', borderColor: '#e5e7eb', borderStyle: 'solid', width: '100%',
  },
  button: {
    fontSize: '14', fontWeight: '600', color: '#ffffff', textAlign: 'center',
    marginTop: '0', marginRight: '0', marginBottom: '0', marginLeft: '0',
    paddingTop: '12', paddingRight: '28', paddingBottom: '12', paddingLeft: '28',
    lineHeight: '1', backgroundColor: '#6366f1', borderRadius: '8',
    borderWidth: '0', borderColor: 'transparent', borderStyle: 'solid',
  },
  image: {
    width: '100%', height: 'auto',
    marginTop: '0', marginRight: '0', marginBottom: '16', marginLeft: '0',
    paddingTop: '0', paddingRight: '0', paddingBottom: '0', paddingLeft: '0',
    borderRadius: '0', borderWidth: '0', borderColor: '#e5e7eb', borderStyle: 'solid',
    objectFit: 'cover',
  },
  container: {
    display: 'flex', flexDirection: 'row', alignItems: 'flex-start',
    justifyContent: 'flex-start', gap: '16',
    paddingTop: '20', paddingRight: '20', paddingBottom: '20', paddingLeft: '20',
    marginTop: '0', marginRight: '0', marginBottom: '16', marginLeft: '0',
    backgroundColor: '#f9fafb', borderRadius: '12',
    borderWidth: '1', borderColor: '#e5e7eb', borderStyle: 'solid',
    width: '100%', minHeight: '80',
  },
  divider: {
    marginTop: '16', marginRight: '0', marginBottom: '16', marginLeft: '0',
    paddingTop: '0', paddingRight: '0', paddingBottom: '0', paddingLeft: '0',
    borderWidth: '1', borderColor: '#e5e7eb', borderStyle: 'solid', width: '100%',
  },
  spacer: {
    height: '40', width: '100%', backgroundColor: '',
    marginTop: '0', marginRight: '0', marginBottom: '0', marginLeft: '0',
    paddingTop: '0', paddingRight: '0', paddingBottom: '0', paddingLeft: '0',
  },
  badge: {
    fontSize: '11', fontWeight: '600', color: '#6366f1', textAlign: 'center',
    paddingTop: '4', paddingRight: '12', paddingBottom: '4', paddingLeft: '12',
    marginTop: '0', marginRight: '0', marginBottom: '8', marginLeft: '0',
    backgroundColor: '#ede9fe', borderRadius: '999',
    borderWidth: '0', borderColor: 'transparent', borderStyle: 'solid', lineHeight: '1.5',
  },
}

const DEFAULT_CONTENT = {
  heading: 'Nadpis sekcie',
  paragraph: 'Toto je textový odsek. Kliknite pre úpravu obsahu a štýlov.',
  button: 'Kliknite sem',
  badge: 'ESPRON',
}

function createNewElement(type) {
  return {
    id: genId(),
    type,
    content: DEFAULT_CONTENT[type] ?? '',
    src: type === 'image' ? 'https://placehold.co/1200x500/f1f5f9/94a3b8?text=Image' : '',
    alt: type === 'image' ? 'Popis obrázka' : '',
    level: type === 'heading' ? 'h2' : undefined,
    children: type === 'container' ? [] : undefined,
    style: { ...(DEFAULT_STYLES[type] ?? {}) },
  }
}

// ─── Tree helpers ─────────────────────────────────────────────────────────────

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

function updateInTree(elements, id, fn) {
  return elements.map(el => {
    if (el.id === id) return fn(el)
    if (el.children) return { ...el, children: updateInTree(el.children, id, fn) }
    return el
  })
}

function deleteFromTree(elements, id) {
  return elements
    .filter(el => el.id !== id)
    .map(el => el.children ? { ...el, children: deleteFromTree(el.children, id) } : el)
}

// Returns [treeWithoutId, extractedElement]
function extractFromTree(elements, id) {
  let extracted = null
  const next = elements
    .filter(el => { if (el.id === id) { extracted = el; return false } return true })
    .map(el => {
      if (!el.children) return el
      const [newChildren, found] = extractFromTree(el.children, id)
      if (found) extracted = found
      return { ...el, children: newChildren }
    })
  return [next, extracted]
}

function insertIntoTree(elements, parentId, newEl, atIndex) {
  if (parentId === null) {
    const next = [...elements]
    next.splice(atIndex ?? next.length, 0, newEl)
    return next
  }
  return elements.map(el => {
    if (el.id === parentId) {
      const children = [...(el.children ?? [])]
      children.splice(atIndex ?? children.length, 0, newEl)
      return { ...el, children }
    }
    if (el.children) return { ...el, children: insertIntoTree(el.children, parentId, newEl, atIndex) }
    return el
  })
}

function hasDescendant(el, targetId) {
  if (!el.children) return false
  return el.children.some(c => c.id === targetId || hasDescendant(c, targetId))
}

// ─── Main component ───────────────────────────────────────────────────────────

const VIEWPORT_WIDTHS = { desktop: '100%', tablet: '768px', mobile: '390px' }

export default function VisualBuilder() {
  const navigate = useNavigate()
  const [elements, setElements] = useState([])
  const [selectedId, setSelectedId] = useState(null)
  const [draggingId, setDraggingId] = useState(null)
  const [viewport, setViewport] = useState('desktop')

  const selectedElement = selectedId ? findInTree(elements, selectedId) : null

  // Add a new element (from palette)
  function addElement(type, parentId, atIndex) {
    const newEl = createNewElement(type)
    setElements(prev => insertIntoTree(prev, parentId ?? null, newEl, atIndex))
    setSelectedId(newEl.id)
  }

  // Move an existing element to a new location
  function moveElement(sourceId, targetParentId, targetIndex) {
    setElements(prev => {
      // Can't drop into self or own descendants
      const source = findInTree(prev, sourceId)
      if (!source) return prev
      if (targetParentId !== null) {
        if (targetParentId === sourceId) return prev
        if (hasDescendant(source, targetParentId)) return prev
      }
      const [without, extracted] = extractFromTree(prev, sourceId)
      if (!extracted) return prev
      return insertIntoTree(without, targetParentId ?? null, extracted, targetIndex)
    })
  }

  function updateElement(id, updates) {
    setElements(prev => updateInTree(prev, id, el => ({ ...el, ...updates })))
  }

  function updateElementStyle(id, styleUpdates) {
    setElements(prev => updateInTree(prev, id, el => ({ ...el, style: { ...el.style, ...styleUpdates } })))
  }

  function deleteElement(id) {
    setElements(prev => deleteFromTree(prev, id))
    setSelectedId(prev => prev === id ? null : prev)
  }

  function duplicateElement(id) {
    setElements(prev => {
      const source = findInTree(prev, id)
      if (!source) return prev
      const copy = { ...source, id: genId() }
      // Find the parent
      const [, parentId] = findParent(prev, id)
      const siblings = parentId ? (findInTree(prev, parentId)?.children ?? []) : prev
      const idx = siblings.findIndex(el => el.id === id)
      return insertIntoTree(prev, parentId ?? null, copy, idx + 1)
    })
  }

  return (
    <DragProvider>
      <div className="h-screen flex flex-col overflow-hidden bg-gray-950 text-white" style={{ userSelect: 'none' }}>
        {/* Top bar */}
        <header className="h-11 flex items-center justify-between px-3 bg-gray-900 border-b border-gray-800 flex-shrink-0 z-10">
          <div className="flex items-center gap-2">
            <button onClick={() => navigate(-1)} className="p-1.5 hover:bg-gray-800 rounded-md transition-colors" title="Späť">
              <ArrowLeftIcon className="h-4 w-4 text-gray-400" />
            </button>
            <span className="text-sm font-semibold text-white">Visual Builder</span>
            <span className="text-[10px] font-medium bg-indigo-900 text-indigo-300 px-1.5 py-0.5 rounded-full">Beta</span>
          </div>

          <div className="flex items-center gap-1 bg-gray-800 rounded-lg p-1">
            {[
              { id: 'desktop', Icon: ComputerDesktopIcon, label: 'Desktop' },
              { id: 'tablet', Icon: DeviceTabletIcon, label: 'Tablet' },
              { id: 'mobile', Icon: DevicePhoneMobileIcon, label: 'Mobil' },
            ].map(({ id, Icon, label }) => (
              <button key={id} onClick={() => setViewport(id)} title={label}
                className={`p-1.5 rounded-md transition-colors ${viewport === id ? 'bg-gray-600 text-white' : 'text-gray-500 hover:text-gray-300'}`}>
                <Icon className="h-4 w-4" />
              </button>
            ))}
          </div>

          <div className="flex items-center gap-2">
            <span className="text-xs text-gray-600">{elements.length} prvkov</span>
            <button className="px-3 py-1.5 bg-indigo-600 hover:bg-indigo-500 text-white text-xs font-semibold rounded-lg transition-colors">Uložiť</button>
          </div>
        </header>

        <div className="flex flex-1 overflow-hidden">
          <ElementPalette onAddElement={(type) => addElement(type, null)} />

          <BuilderCanvas
            elements={elements}
            selectedId={selectedId}
            draggingId={draggingId}
            viewportWidth={VIEWPORT_WIDTHS[viewport]}
            onSelect={setSelectedId}
            onAddElement={addElement}
            onMoveElement={moveElement}
            onDelete={deleteElement}
            onDuplicate={duplicateElement}
            onDragStart={setDraggingId}
            onDragEnd={() => setDraggingId(null)}
          />

          <PropertiesPanel
            element={selectedElement}
            onUpdate={(updates) => selectedElement && updateElement(selectedElement.id, updates)}
            onUpdateStyle={(updates) => selectedElement && updateElementStyle(selectedElement.id, updates)}
            onDelete={() => selectedElement && deleteElement(selectedElement.id)}
            onDuplicate={() => selectedElement && duplicateElement(selectedElement.id)}
          />
        </div>
      </div>
    </DragProvider>
  )
}

// Helper: find parent id of a node
function findParent(elements, id, parentId = null) {
  for (const el of elements) {
    if (el.id === id) return [el, parentId]
    if (el.children) {
      const result = findParent(el.children, id, el.id)
      if (result[0]) return result
    }
  }
  return [null, null]
}
