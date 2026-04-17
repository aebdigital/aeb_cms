import { useState, useRef, useEffect } from 'react'
import { useNavigate, useParams } from 'react-router-dom'
import {
  ComputerDesktopIcon,
  DeviceTabletIcon,
  DevicePhoneMobileIcon,
  ArrowLeftIcon,
  EyeIcon,
} from '@heroicons/react/24/outline'
import { DragProvider } from '../components/visual-builder/DragContext'
import ElementPalette from '../components/visual-builder/ElementPalette'
import BuilderCanvas from '../components/visual-builder/BuilderCanvas'
import PropertiesPanel from '../components/visual-builder/PropertiesPanel'
import StructurePanel from '../components/visual-builder/StructurePanel'
import { getVisualPage, createVisualPage, updateVisualPage } from '../api/visualPages'

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

function slugify(str) {
  return (str || '')
    .toString()
    .normalize('NFD')
    .replace(/[\u0300-\u036f]/g, '')
    .toLowerCase()
    .trim()
    .replace(/[^a-z0-9\s-]/g, '')
    .replace(/\s+/g, '-')
    .replace(/-+/g, '-')
}

export default function VisualBuilder() {
  const navigate = useNavigate()
  const { id: routeId } = useParams()
  const isNew = !routeId || routeId === 'new'

  const [pageId, setPageId] = useState(isNew ? null : routeId)
  const [title, setTitle] = useState('Nová stránka')
  const [slug, setSlug] = useState('')
  const [elements, setElements] = useState([])
  const [selectedId, setSelectedId] = useState(null)
  const [draggingId, setDraggingId] = useState(null)
  const [viewport, setViewport] = useState('desktop')
  const [loadingPage, setLoadingPage] = useState(!isNew)
  const [saving, setSaving] = useState(false)
  const [loadError, setLoadError] = useState(null)

  useEffect(() => {
    if (isNew) return
    let cancelled = false
    ;(async () => {
      try {
        const page = await getVisualPage(routeId)
        if (cancelled) return
        setTitle(page.title)
        setSlug(page.slug)
        setElements(Array.isArray(page.elements) ? page.elements : [])
      } catch (err) {
        if (!cancelled) setLoadError(err.message)
      } finally {
        if (!cancelled) setLoadingPage(false)
      }
    })()
    return () => { cancelled = true }
  }, [routeId, isNew])

  async function handleSave() {
    if (saving) return
    const finalSlug = (slug || slugify(title) || `page-${Date.now()}`).trim()
    try {
      setSaving(true)
      if (pageId) {
        await updateVisualPage(pageId, { title, slug: finalSlug, elements })
      } else {
        const created = await createVisualPage({ title, slug: finalSlug, elements })
        setPageId(created.id)
      }
      navigate('/visual-builder')
    } catch (err) {
      alert('Chyba pri ukladaní: ' + err.message)
    } finally {
      setSaving(false)
    }
  }

  function handlePreview() {
    const finalSlug = slug || slugify(title)
    if (!finalSlug) {
      alert('Najskôr uložte stránku so slug-om.')
      return
    }
    // Always include preview=1 — drafts are visible this way
    window.open(`http://localhost:3006/p/${finalSlug}?preview=1`, '_blank', 'noopener,noreferrer')
  }

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

      // When moving within the same parent forward (source below target index),
      // extraction shifts the target index down by one — adjust so drop lands where user intended.
      const [sourceParentId, sourceIndex] = findLocationInTree(prev, sourceId)
      let adjustedIndex = targetIndex
      if (sourceParentId === targetParentId && sourceIndex !== null && sourceIndex < targetIndex) {
        adjustedIndex = targetIndex - 1
      }

      const [without, extracted] = extractFromTree(prev, sourceId)
      if (!extracted) return prev
      return insertIntoTree(without, targetParentId ?? null, extracted, adjustedIndex)
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

  if (loadingPage) {
    return (
      <div className="h-screen flex items-center justify-center bg-gray-950 text-white">
        <div className="text-center">
          <div className="w-10 h-10 border-4 border-indigo-500 border-t-transparent rounded-full animate-spin mx-auto mb-3"></div>
          <p className="text-sm text-gray-400">Načítavam stránku…</p>
        </div>
      </div>
    )
  }

  if (loadError) {
    return (
      <div className="h-screen flex items-center justify-center bg-gray-950 text-white px-4">
        <div className="text-center max-w-md">
          <p className="text-red-400 font-medium mb-2">Chyba: {loadError}</p>
          <button
            onClick={() => navigate('/visual-builder')}
            className="mt-4 px-4 py-2 bg-indigo-600 hover:bg-indigo-500 text-white text-sm rounded-lg"
          >
            Späť na zoznam
          </button>
        </div>
      </div>
    )
  }

  return (
    <DragProvider>
      <div className="h-screen flex flex-col overflow-hidden bg-gray-950 text-white" style={{ userSelect: 'none' }}>
        {/* Top bar */}
        <header className="h-12 flex items-center justify-between px-3 bg-gray-900 border-b border-gray-800 flex-shrink-0 z-10 gap-3">
          <div className="flex items-center gap-2 min-w-0">
            <button onClick={() => navigate('/visual-builder')} className="p-1.5 hover:bg-gray-800 rounded-md transition-colors flex-shrink-0" title="Späť na zoznam">
              <ArrowLeftIcon className="h-4 w-4 text-gray-400" />
            </button>
            <input
              type="text"
              value={title}
              onChange={(e) => setTitle(e.target.value)}
              placeholder="Názov stránky"
              className="bg-transparent text-sm font-semibold text-white placeholder-gray-500 outline-none focus:bg-gray-800 px-2 py-1 rounded min-w-0 w-48"
            />
            <span className="text-xs text-gray-500 flex-shrink-0">/</span>
            <input
              type="text"
              value={slug}
              onChange={(e) => setSlug(slugify(e.target.value))}
              placeholder={slugify(title) || 'slug'}
              className="bg-transparent text-xs text-gray-300 placeholder-gray-600 outline-none focus:bg-gray-800 px-2 py-1 rounded min-w-0 w-40"
            />
          </div>

          <div className="flex items-center gap-1 bg-gray-800 rounded-lg p-1 flex-shrink-0">
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

          <div className="flex items-center gap-2 flex-shrink-0">
            <span className="text-xs text-gray-600 hidden md:inline">{elements.length} prvkov</span>
            <button
              onClick={handlePreview}
              className="flex items-center gap-1.5 px-3 py-1.5 bg-gray-800 hover:bg-gray-700 text-gray-200 text-xs font-semibold rounded-lg transition-colors"
              title="Náhľad v novej karte"
            >
              <EyeIcon className="h-3.5 w-3.5" />
              Náhľad
            </button>
            <button
              onClick={handleSave}
              disabled={saving}
              className="px-3 py-1.5 bg-indigo-600 hover:bg-indigo-500 disabled:opacity-60 disabled:cursor-not-allowed text-white text-xs font-semibold rounded-lg transition-colors"
            >
              {saving ? 'Ukladám…' : 'Uložiť'}
            </button>
          </div>
        </header>

        <div className="flex flex-1 overflow-hidden flex-col">
          <div className="flex flex-1 overflow-hidden">
            <StructurePanel
              elements={elements}
              selectedId={selectedId}
              draggingId={draggingId}
              onSelect={setSelectedId}
              onMoveElement={moveElement}
              onAddElement={addElement}
              onDragStart={setDraggingId}
              onDragEnd={() => setDraggingId(null)}
            />

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

          <ElementPalette
            orientation="horizontal"
            onAddElement={(type) => addElement(type, null)}
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

// Returns [parentId, index] of an element within its parent's child list.
function findLocationInTree(elements, id, parentId = null) {
  for (let i = 0; i < elements.length; i++) {
    if (elements[i].id === id) return [parentId, i]
    if (elements[i].children) {
      const result = findLocationInTree(elements[i].children, id, elements[i].id)
      if (result[1] !== null) return result
    }
  }
  return [null, null]
}
