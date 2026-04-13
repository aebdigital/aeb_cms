import { useState } from 'react'

// ─── Small shared inputs ───────────────────────────────────────────────────────

function Label({ children }) {
  return (
    <p style={{ fontSize: 9, fontWeight: 700, textTransform: 'uppercase', letterSpacing: '0.1em', color: '#6b7280', margin: '12px 0 6px' }}>
      {children}
    </p>
  )
}

function NumInput({ label, value, onChange, min = 0, max = 9999, step = 1 }) {
  return (
    <div>
      {label && <p style={{ fontSize: 9, color: '#9ca3af', marginBottom: 3 }}>{label}</p>}
      <input
        type="number"
        value={value ?? 0}
        min={min}
        max={max}
        step={step}
        onChange={(e) => onChange(Number(e.target.value))}
        style={{
          width: '100%', background: '#1f2937', border: '1px solid #374151',
          color: '#f9fafb', fontSize: 11, borderRadius: 6,
          padding: '5px 8px', outline: 'none', boxSizing: 'border-box',
        }}
        onFocus={(e) => (e.target.style.borderColor = '#6366f1')}
        onBlur={(e) => (e.target.style.borderColor = '#374151')}
      />
    </div>
  )
}

function TextInput({ label, value, onChange, placeholder, mono }) {
  return (
    <div>
      {label && <p style={{ fontSize: 9, color: '#9ca3af', marginBottom: 3 }}>{label}</p>}
      <input
        type="text"
        value={value ?? ''}
        onChange={(e) => onChange(e.target.value)}
        placeholder={placeholder}
        style={{
          width: '100%', background: '#1f2937', border: '1px solid #374151',
          color: '#f9fafb', fontSize: 11, borderRadius: 6,
          padding: '5px 8px', outline: 'none', boxSizing: 'border-box',
          fontFamily: mono ? 'monospace' : 'inherit',
        }}
        onFocus={(e) => (e.target.style.borderColor = '#6366f1')}
        onBlur={(e) => (e.target.style.borderColor = '#374151')}
      />
    </div>
  )
}

function ColorInput({ label, value, onChange }) {
  return (
    <div>
      {label && <p style={{ fontSize: 9, color: '#9ca3af', marginBottom: 3 }}>{label}</p>}
      <div style={{ display: 'flex', gap: 6, alignItems: 'center' }}>
        <input
          type="color"
          value={value && value !== 'transparent' ? value : '#ffffff'}
          onChange={(e) => onChange(e.target.value)}
          style={{
            width: 28, height: 28, border: '1px solid #374151',
            borderRadius: 6, padding: 2, background: '#1f2937', cursor: 'pointer', flexShrink: 0,
          }}
        />
        <input
          type="text"
          value={value ?? ''}
          onChange={(e) => onChange(e.target.value)}
          placeholder="transparent"
          style={{
            flex: 1, background: '#1f2937', border: '1px solid #374151',
            color: '#f9fafb', fontSize: 10, borderRadius: 6,
            padding: '5px 7px', outline: 'none', fontFamily: 'monospace', boxSizing: 'border-box',
          }}
          onFocus={(e) => (e.target.style.borderColor = '#6366f1')}
          onBlur={(e) => (e.target.style.borderColor = '#374151')}
        />
      </div>
    </div>
  )
}

function ToggleGroup({ options, value, onChange }) {
  return (
    <div style={{ display: 'flex', gap: 2, flexWrap: 'wrap' }}>
      {options.map(opt => (
        <button
          key={opt.value ?? opt}
          onClick={() => onChange(opt.value ?? opt)}
          style={{
            padding: '4px 8px', fontSize: 10, borderRadius: 5, border: 'none',
            cursor: 'pointer', fontWeight: 600, transition: 'all 0.1s',
            background: (opt.value ?? opt) === value ? '#6366f1' : '#1f2937',
            color: (opt.value ?? opt) === value ? '#fff' : '#9ca3af',
          }}
        >
          {opt.label ?? opt}
        </button>
      ))}
    </div>
  )
}

function SelectInput({ label, value, onChange, options }) {
  return (
    <div>
      {label && <p style={{ fontSize: 9, color: '#9ca3af', marginBottom: 3 }}>{label}</p>}
      <select
        value={value ?? ''}
        onChange={(e) => onChange(e.target.value)}
        style={{
          width: '100%', background: '#1f2937', border: '1px solid #374151',
          color: '#f9fafb', fontSize: 11, borderRadius: 6,
          padding: '5px 8px', outline: 'none', boxSizing: 'border-box',
        }}
        onFocus={(e) => (e.target.style.borderColor = '#6366f1')}
        onBlur={(e) => (e.target.style.borderColor = '#374151')}
      >
        {options.map(opt => (
          <option key={opt.value ?? opt} value={opt.value ?? opt}>
            {opt.label ?? opt}
          </option>
        ))}
      </select>
    </div>
  )
}

// 4-corner spacing editor (margin or padding)
function SpacingQuad({ label, top, right, bottom, left, onChange }) {
  return (
    <div>
      <Label>{label}</Label>
      <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: 4 }}>
        <NumInput label="T" value={top} onChange={(v) => onChange({ top: v })} />
        <NumInput label="R" value={right} onChange={(v) => onChange({ right: v })} />
        <NumInput label="B" value={bottom} onChange={(v) => onChange({ bottom: v })} />
        <NumInput label="L" value={left} onChange={(v) => onChange({ left: v })} />
      </div>
    </div>
  )
}

// ─── Main panel ───────────────────────────────────────────────────────────────

const FONT_WEIGHTS = [
  { value: '300', label: '300' }, { value: '400', label: '400' },
  { value: '500', label: '500' }, { value: '600', label: '600' },
  { value: '700', label: '700' }, { value: '800', label: '800' },
]

export default function PropertiesPanel({ element, onUpdate, onUpdateStyle, onDelete, onDuplicate }) {
  const [tab, setTab] = useState('content')

  const panelStyle = {
    width: 240, background: '#111827', borderLeft: '1px solid #1f2937',
    display: 'flex', flexDirection: 'column', overflow: 'hidden', flexShrink: 0,
  }

  if (!element) {
    return (
      <aside style={panelStyle}>
        <div style={{ flex: 1, display: 'flex', flexDirection: 'column', alignItems: 'center', justifyContent: 'center', padding: 24 }}>
          <div style={{
            width: 40, height: 40, background: '#1f2937', borderRadius: 10,
            display: 'flex', alignItems: 'center', justifyContent: 'center', marginBottom: 12,
          }}>
            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#4b5563" strokeWidth="1.5">
              <path d="M15.232 5.232l3.536 3.536m-2.036-5.036a2.5 2.5 0 113.536 3.536L6.5 21.036H3v-3.572L16.732 3.732z" strokeLinecap="round" strokeLinejoin="round" />
            </svg>
          </div>
          <p style={{ fontSize: 11, color: '#4b5563', textAlign: 'center', lineHeight: 1.5, margin: 0 }}>
            Vyberte prvok<br />na plátne
          </p>
        </div>
      </aside>
    )
  }

  const s = element.style ?? {}
  const us = (updates) => onUpdateStyle(updates)

  return (
    <aside style={panelStyle}>
      {/* Header */}
      <div style={{
        padding: '10px 12px 8px', borderBottom: '1px solid #1f2937',
        display: 'flex', alignItems: 'center', justifyContent: 'space-between', flexShrink: 0,
      }}>
        <div>
          <p style={{ fontSize: 11, fontWeight: 700, color: '#f9fafb', textTransform: 'capitalize', margin: 0 }}>
            {element.type}{element.level ? ` / ${element.level}` : ''}
          </p>
          <p style={{ fontSize: 9, color: '#374151', fontFamily: 'monospace', marginTop: 2 }}>{element.id}</p>
        </div>
        <div style={{ display: 'flex', gap: 2 }}>
          <button
            onClick={onDuplicate}
            title="Duplikovať"
            style={{ background: '#1f2937', border: 'none', borderRadius: 6, padding: '4px 7px', cursor: 'pointer', color: '#6b7280', fontSize: 12 }}
          >⧉</button>
          <button
            onClick={onDelete}
            title="Odstrániť"
            style={{ background: '#450a0a', border: 'none', borderRadius: 6, padding: '4px 7px', cursor: 'pointer', color: '#f87171', fontSize: 12 }}
          >✕</button>
        </div>
      </div>

      {/* Tabs */}
      <div style={{ display: 'flex', borderBottom: '1px solid #1f2937', flexShrink: 0 }}>
        {[
          { id: 'content', label: 'Obsah' },
          { id: 'layout', label: 'Layout' },
          { id: 'style', label: 'Štýl' },
        ].map(t => (
          <button
            key={t.id}
            onClick={() => setTab(t.id)}
            style={{
              flex: 1, padding: '8px 0', fontSize: 10, fontWeight: 600,
              border: 'none', cursor: 'pointer', transition: 'all 0.1s',
              borderBottom: tab === t.id ? '2px solid #6366f1' : '2px solid transparent',
              background: 'transparent',
              color: tab === t.id ? '#818cf8' : '#4b5563',
            }}
          >
            {t.label}
          </button>
        ))}
      </div>

      {/* Content */}
      <div style={{ flex: 1, overflowY: 'auto', padding: '4px 12px 24px' }}>

        {/* ── CONTENT TAB ── */}
        {tab === 'content' && (
          <div>
            {element.type === 'heading' && (
              <>
                <Label>Úroveň</Label>
                <ToggleGroup
                  options={['h1', 'h2', 'h3', 'h4'].map(v => ({ value: v, label: v.toUpperCase() }))}
                  value={element.level ?? 'h2'}
                  onChange={(v) => onUpdate({ level: v })}
                />
              </>
            )}

            {['heading', 'paragraph', 'button', 'badge'].includes(element.type) && (
              <>
                <Label>Text</Label>
                <textarea
                  value={element.content ?? ''}
                  onChange={(e) => onUpdate({ content: e.target.value })}
                  rows={element.type === 'paragraph' ? 5 : 2}
                  style={{
                    width: '100%', background: '#1f2937', border: '1px solid #374151',
                    color: '#f9fafb', fontSize: 11, borderRadius: 6, padding: '6px 8px',
                    outline: 'none', resize: 'vertical', boxSizing: 'border-box', lineHeight: 1.5,
                    fontFamily: 'inherit',
                  }}
                  onFocus={(e) => (e.target.style.borderColor = '#6366f1')}
                  onBlur={(e) => (e.target.style.borderColor = '#374151')}
                />
              </>
            )}

            {element.type === 'image' && (
              <>
                <Label>Zdroj obrázka</Label>
                <TextInput value={element.src} onChange={(v) => onUpdate({ src: v })} placeholder="https://..." />
                <div style={{ marginTop: 8 }}>
                  <TextInput label="Alt text" value={element.alt} onChange={(v) => onUpdate({ alt: v })} placeholder="Popis obrázka" />
                </div>
              </>
            )}

            {element.type === 'spacer' && (
              <>
                <Label>Výška (px)</Label>
                <NumInput value={s.height} onChange={(v) => us({ height: v })} />
              </>
            )}

            {element.type === 'divider' && (
              <>
                <Label>Hrúbka čiary</Label>
                <NumInput value={s.borderWidth} onChange={(v) => us({ borderWidth: v })} min={1} max={20} />
                <div style={{ marginTop: 8 }}>
                  <ColorInput label="Farba" value={s.borderColor} onChange={(v) => us({ borderColor: v })} />
                </div>
                <div style={{ marginTop: 8 }}>
                  <SelectInput
                    label="Štýl čiary"
                    value={s.borderStyle ?? 'solid'}
                    onChange={(v) => us({ borderStyle: v })}
                    options={['solid', 'dashed', 'dotted'].map(v => ({ value: v, label: v }))}
                  />
                </div>
              </>
            )}
          </div>
        )}

        {/* ── LAYOUT TAB ── */}
        {tab === 'layout' && (
          <div>
            <Label>Rozmery</Label>
            <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: 4 }}>
              <TextInput label="Šírka" value={s.width} onChange={(v) => us({ width: v })} placeholder="100%" />
              <TextInput label="Výška" value={s.height} onChange={(v) => us({ height: v })} placeholder="auto" />
            </div>
            {element.type === 'container' && (
              <div style={{ marginTop: 4 }}>
                <NumInput label="Min. výška" value={s.minHeight} onChange={(v) => us({ minHeight: v })} />
              </div>
            )}

            <SpacingQuad
              label="Margin (px)"
              top={s.marginTop} right={s.marginRight} bottom={s.marginBottom} left={s.marginLeft}
              onChange={({ top, right, bottom, left }) => us({
                ...(top !== undefined && { marginTop: top }),
                ...(right !== undefined && { marginRight: right }),
                ...(bottom !== undefined && { marginBottom: bottom }),
                ...(left !== undefined && { marginLeft: left }),
              })}
            />

            <SpacingQuad
              label="Padding (px)"
              top={s.paddingTop} right={s.paddingRight} bottom={s.paddingBottom} left={s.paddingLeft}
              onChange={({ top, right, bottom, left }) => us({
                ...(top !== undefined && { paddingTop: top }),
                ...(right !== undefined && { paddingRight: right }),
                ...(bottom !== undefined && { paddingBottom: bottom }),
                ...(left !== undefined && { paddingLeft: left }),
              })}
            />

            {element.type === 'container' && (
              <>
                <Label>Display</Label>
                <ToggleGroup
                  options={['flex', 'block', 'grid'].map(v => ({ value: v, label: v }))}
                  value={s.display ?? 'flex'}
                  onChange={(v) => us({ display: v })}
                />

                {s.display !== 'block' && (
                  <>
                    <Label>Flex smer</Label>
                    <ToggleGroup
                      options={[{ value: 'row', label: '→' }, { value: 'column', label: '↓' }, { value: 'row-reverse', label: '←' }, { value: 'column-reverse', label: '↑' }]}
                      value={s.flexDirection ?? 'row'}
                      onChange={(v) => us({ flexDirection: v })}
                    />

                    <Label>Align Items</Label>
                    <ToggleGroup
                      options={[
                        { value: 'flex-start', label: 'Start' },
                        { value: 'center', label: 'Center' },
                        { value: 'flex-end', label: 'End' },
                        { value: 'stretch', label: 'Stretch' },
                      ]}
                      value={s.alignItems ?? 'flex-start'}
                      onChange={(v) => us({ alignItems: v })}
                    />

                    <Label>Justify Content</Label>
                    <ToggleGroup
                      options={[
                        { value: 'flex-start', label: 'Start' },
                        { value: 'center', label: 'Center' },
                        { value: 'flex-end', label: 'End' },
                        { value: 'space-between', label: 'S.Btwn' },
                      ]}
                      value={s.justifyContent ?? 'flex-start'}
                      onChange={(v) => us({ justifyContent: v })}
                    />

                    <Label>Gap (px)</Label>
                    <NumInput value={s.gap} onChange={(v) => us({ gap: v })} />
                  </>
                )}
              </>
            )}
          </div>
        )}

        {/* ── STYLE TAB ── */}
        {tab === 'style' && (
          <div>
            {['heading', 'paragraph', 'button', 'badge'].includes(element.type) && (
              <>
                <Label>Typografia</Label>
                <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: 4 }}>
                  <NumInput label="Veľkosť (px)" value={s.fontSize} onChange={(v) => us({ fontSize: v })} min={6} max={200} />
                  <NumInput label="Line height" value={s.lineHeight} onChange={(v) => us({ lineHeight: v })} min={0} max={5} step={0.1} />
                </div>
                <div style={{ marginTop: 8 }}>
                  <p style={{ fontSize: 9, color: '#9ca3af', marginBottom: 4 }}>Hrúbka písma</p>
                  <ToggleGroup
                    options={FONT_WEIGHTS}
                    value={s.fontWeight ?? '400'}
                    onChange={(v) => us({ fontWeight: v })}
                  />
                </div>
                <div style={{ marginTop: 8 }}>
                  <p style={{ fontSize: 9, color: '#9ca3af', marginBottom: 4 }}>Zarovnanie</p>
                  <ToggleGroup
                    options={[
                      { value: 'left', label: '⬅' },
                      { value: 'center', label: '↔' },
                      { value: 'right', label: '➡' },
                    ]}
                    value={s.textAlign ?? 'left'}
                    onChange={(v) => us({ textAlign: v })}
                  />
                </div>
                <div style={{ marginTop: 8 }}>
                  <ColorInput label="Farba textu" value={s.color} onChange={(v) => us({ color: v })} />
                </div>
              </>
            )}

            <Label>Pozadie</Label>
            <ColorInput label="Farba" value={s.backgroundColor} onChange={(v) => us({ backgroundColor: v })} />

            <Label>Border</Label>
            <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: 4 }}>
              <NumInput label="Zaoblenie (px)" value={s.borderRadius} onChange={(v) => us({ borderRadius: v })} />
              <NumInput label="Hrúbka (px)" value={s.borderWidth} onChange={(v) => us({ borderWidth: v })} />
            </div>
            {Number(s.borderWidth) > 0 && (
              <div style={{ marginTop: 6 }}>
                <ColorInput label="Farba okraja" value={s.borderColor} onChange={(v) => us({ borderColor: v })} />
                <div style={{ marginTop: 6 }}>
                  <SelectInput
                    label="Štýl"
                    value={s.borderStyle ?? 'solid'}
                    onChange={(v) => us({ borderStyle: v })}
                    options={['solid', 'dashed', 'dotted'].map(v => ({ value: v, label: v }))}
                  />
                </div>
              </div>
            )}

            {element.type === 'image' && (
              <>
                <Label>Object Fit</Label>
                <ToggleGroup
                  options={['cover', 'contain', 'fill', 'none'].map(v => ({ value: v, label: v }))}
                  value={s.objectFit ?? 'cover'}
                  onChange={(v) => us({ objectFit: v })}
                />
              </>
            )}
          </div>
        )}
      </div>
    </aside>
  )
}
