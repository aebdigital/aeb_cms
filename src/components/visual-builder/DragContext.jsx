import { createContext, useContext, useRef } from 'react'

/**
 * Shared drag state — stored in a ref so it doesn't trigger re-renders.
 * Shape: { kind: 'palette'|'canvas'|null, elementType: string|null, elementId: string|null }
 */
export const DragContext = createContext(null)

export function DragProvider({ children }) {
  const drag = useRef({ kind: null, elementType: null, elementId: null })
  return <DragContext.Provider value={drag}>{children}</DragContext.Provider>
}

export function useDrag() {
  const ref = useContext(DragContext)
  if (!ref) throw new Error('useDrag must be used inside DragProvider')
  return ref
}
