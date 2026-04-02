import { useEffect, useRef } from 'react'
import './ConfirmDialog.css'

export default function ConfirmDialog({ open, title, message, confirmLabel, cancelLabel, onConfirm, onCancel, danger }) {
  const dialogRef = useRef(null)

  useEffect(() => {
    if (open) {
      dialogRef.current?.focus()
    }
  }, [open])

  useEffect(() => {
    const handleKeyDown = (e) => {
      if (e.key === 'Escape' && open) onCancel()
    }
    window.addEventListener('keydown', handleKeyDown)
    return () => window.removeEventListener('keydown', handleKeyDown)
  }, [open, onCancel])

  if (!open) return null

  return (
    <div className="confirm-overlay" onClick={onCancel}>
      <div className="confirm-dialog" ref={dialogRef} tabIndex={-1} onClick={e => e.stopPropagation()}>
        <div className="confirm-icon-wrapper">
          <svg className="confirm-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
            <path d="M10.29 3.86L1.82 18a2 2 0 0 0 1.71 3h16.94a2 2 0 0 0 1.71-3L13.71 3.86a2 2 0 0 0-3.42 0z" />
            <line x1="12" y1="9" x2="12" y2="13" />
            <line x1="12" y1="17" x2="12.01" y2="17" />
          </svg>
        </div>
        <h3 className="confirm-title">{title || 'Potvrdiť akciu'}</h3>
        <p className="confirm-message">{message}</p>
        <div className="confirm-actions">
          <button className="confirm-btn confirm-btn-cancel" onClick={onCancel}>
            {cancelLabel || 'Zrušiť'}
          </button>
          <button className={`confirm-btn ${danger ? 'confirm-btn-danger' : 'confirm-btn-primary'}`} onClick={onConfirm}>
            {confirmLabel || 'Potvrdiť'}
          </button>
        </div>
      </div>
    </div>
  )
}
