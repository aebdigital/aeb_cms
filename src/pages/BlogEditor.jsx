import { useEffect, useRef, useState } from 'react'
import { useNavigate, useParams } from 'react-router-dom'
import {
  ArrowLeftIcon,
  EyeIcon,
  PhotoIcon,
  BoldIcon,
  ItalicIcon,
  ListBulletIcon,
  LinkIcon,
} from '@heroicons/react/24/outline'
import {
  createBlogPost,
  getBlogPost,
  updateBlogPost,
  uploadBlogCoverImage,
} from '../api/blogs'

const PREVIEW_ORIGIN = 'http://localhost:3006'

function slugify(s) {
  return (s || '')
    .toLowerCase()
    .normalize('NFD').replace(/[\u0300-\u036f]/g, '')
    .replace(/[^a-z0-9\s-]/g, '')
    .trim()
    .replace(/\s+/g, '-')
    .replace(/-+/g, '-')
    .slice(0, 80)
}

const INITIAL_CONTENT = '<p>Začnite písať obsah článku…</p>'

export default function BlogEditor() {
  const { id } = useParams()
  const navigate = useNavigate()
  const isNew = !id || id === 'new'

  const [postId, setPostId] = useState(isNew ? null : id)
  const [loading, setLoading] = useState(!isNew)
  const [saving, setSaving] = useState(false)
  const [slug, setSlug] = useState('')
  const [slugTouched, setSlugTouched] = useState(false)
  const [title, setTitle] = useState('')
  const [excerpt, setExcerpt] = useState('')
  const [category, setCategory] = useState('Návod')
  const [readingTime, setReadingTime] = useState('5 min')
  const [coverImage, setCoverImage] = useState(null)
  const [isPublished, setIsPublished] = useState(false)

  const contentRef = useRef(null)
  const fileInputRef = useRef(null)
  const contentInitialized = useRef(false)
  const contentHtmlRef = useRef(INITIAL_CONTENT)

  useEffect(() => {
    if (isNew) {
      contentHtmlRef.current = INITIAL_CONTENT
      return
    }
    let cancelled = false
    ;(async () => {
      try {
        const post = await getBlogPost(id)
        if (cancelled) return
        setPostId(post.id)
        setSlug(post.slug)
        setSlugTouched(true)
        setTitle(post.title || '')
        setExcerpt(post.excerpt || '')
        setCategory(post.category || 'Návod')
        setReadingTime(post.reading_time || '5 min')
        setCoverImage(post.cover_image || null)
        setIsPublished(!!post.is_published)
        contentHtmlRef.current = post.content_html || INITIAL_CONTENT
      } catch (err) {
        alert('Chyba pri načítaní: ' + err.message)
        navigate('/espron-blog')
      } finally {
        if (!cancelled) setLoading(false)
      }
    })()
    return () => { cancelled = true }
  }, [id, isNew, navigate])

  useEffect(() => {
    if (loading) return
    if (contentInitialized.current) return
    if (contentRef.current) {
      contentRef.current.innerHTML = contentHtmlRef.current
      contentInitialized.current = true
    }
  }, [loading])

  useEffect(() => {
    if (!slugTouched) setSlug(slugify(title))
  }, [title, slugTouched])

  function onContentInput() {
    contentHtmlRef.current = contentRef.current.innerHTML
  }

  function exec(command, value = null) {
    document.execCommand(command, false, value)
    contentRef.current?.focus()
    onContentInput()
  }

  function format(tag) {
    document.execCommand('formatBlock', false, tag)
    onContentInput()
  }

  async function handleCoverUpload(e) {
    const file = e.target.files?.[0]
    if (!file) return
    try {
      const url = await uploadBlogCoverImage(file, postId || 'new')
      setCoverImage(url)
    } catch (err) {
      alert('Upload zlyhal: ' + err.message)
    } finally {
      e.target.value = ''
    }
  }

  async function save(publish = null) {
    const finalSlug = slug.trim() || slugify(title) || 'novy-clanok'
    if (!title.trim()) return alert('Zadajte názov článku')
    setSaving(true)
    try {
      const payload = {
        slug: finalSlug,
        title: title.trim(),
        excerpt: excerpt.trim(),
        category: category.trim() || 'Blog',
        reading_time: readingTime.trim() || '5 min',
        cover_image: coverImage,
        content_html: contentHtmlRef.current || INITIAL_CONTENT,
        is_published: publish !== null ? publish : isPublished,
      }
      if (postId) {
        const updated = await updateBlogPost(postId, payload)
        setIsPublished(updated.is_published)
      } else {
        const created = await createBlogPost(payload)
        setPostId(created.id)
        setIsPublished(created.is_published)
        navigate(`/espron-blog/edit/${created.id}`, { replace: true })
      }
    } catch (err) {
      alert('Chyba pri ukladaní: ' + err.message)
    } finally {
      setSaving(false)
    }
  }

  function openPreview() {
    const finalSlug = slug.trim() || slugify(title)
    if (!finalSlug) return alert('Najprv uložte článok')
    const url = `${PREVIEW_ORIGIN}/blog/${finalSlug}${isPublished ? '' : '?preview=1'}`
    window.open(url, '_blank', 'noopener,noreferrer')
  }

  if (loading) {
    return <div className="min-h-screen flex items-center justify-center text-gray-500">Načítavam…</div>
  }

  return (
    <div className="min-h-screen bg-gray-100 flex flex-col">
      <style>{ESPRON_PREVIEW_CSS}</style>

      {/* Top bar */}
      <div className="h-14 bg-white border-b border-gray-200 flex items-center px-4 gap-3 sticky top-0 z-20">
        <button
          onClick={() => navigate('/espron-blog')}
          className="p-2 hover:bg-gray-100 rounded-lg text-gray-600"
          title="Späť na zoznam"
        >
          <ArrowLeftIcon className="h-5 w-5" />
        </button>
        <div className="flex-1 flex items-center gap-3 min-w-0">
          <input
            value={title}
            onChange={e => setTitle(e.target.value)}
            placeholder="Názov článku"
            className="text-sm font-semibold bg-transparent outline-none focus:bg-gray-50 rounded px-2 py-1 min-w-0 flex-shrink"
            style={{ width: '26rem', maxWidth: '100%' }}
          />
          <span className="text-gray-300">/</span>
          <div className="flex items-center gap-1 text-xs text-gray-500">
            <span>/blog/</span>
            <input
              value={slug}
              onChange={e => { setSlug(e.target.value); setSlugTouched(true) }}
              placeholder="slug"
              className="bg-transparent outline-none focus:bg-gray-50 rounded px-1.5 py-0.5 font-mono"
              style={{ width: '14rem' }}
            />
          </div>
        </div>
        <button
          onClick={openPreview}
          className="flex items-center gap-1.5 px-3 py-1.5 text-sm text-gray-700 hover:bg-gray-100 rounded-lg"
          title="Otvoriť náhľad na espron.sk"
        >
          <EyeIcon className="h-4 w-4" />
          Náhľad
        </button>
        <button
          onClick={() => save()}
          disabled={saving}
          className="px-3 py-1.5 text-sm text-gray-700 hover:bg-gray-100 rounded-lg disabled:opacity-50"
        >
          {saving ? 'Ukladám…' : 'Uložiť'}
        </button>
        <button
          onClick={() => save(!isPublished)}
          disabled={saving}
          className={`px-4 py-1.5 text-sm rounded-lg font-semibold shadow-sm disabled:opacity-50 ${
            isPublished
              ? 'bg-green-600 text-white hover:bg-green-700'
              : 'bg-gradient-to-r from-indigo-600 to-purple-600 text-white hover:from-indigo-700 hover:to-purple-700'
          }`}
        >
          {isPublished ? 'Publikované – zneplatniť' : 'Publikovať'}
        </button>
      </div>

      {/* Formatting toolbar */}
      <div className="h-11 bg-white border-b border-gray-200 flex items-center px-4 gap-1 sticky top-14 z-10">
        <ToolbarBtn label="H2" onClick={() => format('h2')}>H2</ToolbarBtn>
        <ToolbarBtn label="H3" onClick={() => format('h3')}>H3</ToolbarBtn>
        <ToolbarBtn label="Odstavec" onClick={() => format('p')}>¶</ToolbarBtn>
        <div className="w-px h-5 bg-gray-200 mx-1" />
        <ToolbarBtn label="Tučné" onClick={() => exec('bold')}><BoldIcon className="h-4 w-4" /></ToolbarBtn>
        <ToolbarBtn label="Kurzíva" onClick={() => exec('italic')}><ItalicIcon className="h-4 w-4" /></ToolbarBtn>
        <ToolbarBtn label="Zoznam" onClick={() => exec('insertUnorderedList')}><ListBulletIcon className="h-4 w-4" /></ToolbarBtn>
        <ToolbarBtn
          label="Odkaz"
          onClick={() => {
            const url = prompt('URL (napr. /kontakt alebo https://...)')
            if (url) exec('createLink', url)
          }}
        >
          <LinkIcon className="h-4 w-4" />
        </ToolbarBtn>
        <div className="flex-1" />
        <div className="text-xs text-gray-400">
          {isPublished ? 'Zmeny sa prejavia na webe po uložení' : 'Koncept – viditeľný len s ?preview=1'}
        </div>
      </div>

      {/* Workspace */}
      <div className="flex-1 flex overflow-hidden">
        {/* Sidebar meta */}
        <aside className="w-72 shrink-0 border-r border-gray-200 bg-white overflow-y-auto p-5 space-y-6">
          <Field label="Kategória" hint="napr. Návod, Tipy">
            <input
              value={category}
              onChange={e => setCategory(e.target.value)}
              className="w-full border border-gray-200 rounded-lg px-3 py-2 text-sm focus:ring-2 focus:ring-indigo-500 outline-none"
            />
          </Field>

          <Field label="Čas čítania" hint="napr. 5 min">
            <input
              value={readingTime}
              onChange={e => setReadingTime(e.target.value)}
              className="w-full border border-gray-200 rounded-lg px-3 py-2 text-sm focus:ring-2 focus:ring-indigo-500 outline-none"
            />
          </Field>

          <Field label="Krátky popis" hint="Zobrazený na /blog karte">
            <textarea
              value={excerpt}
              onChange={e => setExcerpt(e.target.value)}
              rows={4}
              className="w-full border border-gray-200 rounded-lg px-3 py-2 text-sm focus:ring-2 focus:ring-indigo-500 outline-none resize-none"
            />
          </Field>

          <Field label="Úvodný obrázok" hint="Odporúčané 1920×840">
            <div className="space-y-2">
              {coverImage ? (
                <div className="relative aspect-[16/9] rounded-lg overflow-hidden border border-gray-200 bg-gray-50">
                  <img src={coverImage} alt="cover" className="absolute inset-0 w-full h-full object-cover" />
                </div>
              ) : (
                <div className="aspect-[16/9] rounded-lg border-2 border-dashed border-gray-200 bg-gray-50 flex items-center justify-center text-gray-400">
                  <PhotoIcon className="h-8 w-8" />
                </div>
              )}
              <button
                onClick={() => fileInputRef.current?.click()}
                className="w-full px-3 py-2 text-xs font-semibold bg-gray-100 hover:bg-gray-200 rounded-lg text-gray-700"
              >
                {coverImage ? 'Nahrať nový' : 'Nahrať obrázok'}
              </button>
              {coverImage && (
                <button
                  onClick={() => setCoverImage(null)}
                  className="w-full px-3 py-2 text-xs text-red-600 hover:bg-red-50 rounded-lg"
                >
                  Odstrániť
                </button>
              )}
              <input
                ref={fileInputRef}
                type="file"
                accept="image/*"
                onChange={handleCoverUpload}
                className="hidden"
              />
            </div>
          </Field>
        </aside>

        {/* Main preview */}
        <div className="flex-1 overflow-y-auto">
          <div className="espron-preview">
            {/* Hero */}
            <section className="espron-hero">
              <div className="espron-hero-bg" />
              <div className="espron-hero-inner">
                <span className="espron-breadcrumb">← Blog</span>
                <p className="espron-kicker">{category || 'Blog'}</p>
                <h1 className="espron-hero-title">{title || 'Názov článku'}</h1>
              </div>
            </section>

            {/* Article */}
            <article className="espron-article">
              {excerpt && <p className="espron-lead">{excerpt}</p>}
              <div
                ref={contentRef}
                contentEditable
                suppressContentEditableWarning
                onInput={onContentInput}
                onBlur={onContentInput}
                className="espron-content"
              />
            </article>
          </div>
        </div>
      </div>
    </div>
  )
}

function ToolbarBtn({ children, label, onClick }) {
  return (
    <button
      type="button"
      onMouseDown={(e) => e.preventDefault()}
      onClick={onClick}
      title={label}
      className="h-8 min-w-8 px-2 flex items-center justify-center text-sm font-semibold text-gray-600 hover:bg-gray-100 rounded"
    >
      {children}
    </button>
  )
}

function Field({ label, hint, children }) {
  return (
    <div>
      <label className="block text-[10px] font-bold text-gray-500 uppercase tracking-wider mb-1.5">
        {label}
      </label>
      {children}
      {hint && <p className="text-[10px] text-gray-400 mt-1">{hint}</p>}
    </div>
  )
}

// CSS matching espron-next-navrh theme tokens and the blog article layout.
// Keep in sync with globals.css and app/(site)/blog/[slug]/page.tsx renderer.
const ESPRON_PREVIEW_CSS = `
.espron-preview {
  --color-primary: #172c70;
  --color-primary-dark: #0f1d4a;
  --color-foreground: #1a1a1a;
  --color-muted: #6b7280;
  --color-border: #e5e7eb;
  font-family: Manrope, ui-sans-serif, system-ui, sans-serif;
  color: var(--color-foreground);
}

.espron-hero {
  position: relative;
  overflow: hidden;
  background: var(--color-primary-dark);
  color: white;
  padding: 7rem 0 4.5rem;
}
.espron-hero-bg {
  position: absolute;
  inset: 0;
  background:
    radial-gradient(circle at top left, rgba(255,255,255,0.14), transparent 34%),
    linear-gradient(120deg, rgba(255,255,255,0.06), transparent 26%);
  pointer-events: none;
}
.espron-hero-inner {
  position: relative;
  width: 92%;
  max-width: 72rem;
  margin: 0 auto;
}
.espron-breadcrumb {
  font-size: 0.75rem;
  font-weight: 600;
  letter-spacing: 0.22em;
  text-transform: uppercase;
  color: rgba(255,255,255,0.5);
  display: inline-block;
  margin-bottom: 1.5rem;
}
.espron-kicker {
  font-size: 0.6875rem;
  font-weight: 600;
  letter-spacing: 0.3em;
  text-transform: uppercase;
  color: rgba(255,255,255,0.55);
  margin-bottom: 1rem;
}
.espron-hero-title {
  font-size: clamp(1.875rem, 4vw, 3.75rem);
  font-weight: 800;
  line-height: 1.08;
  letter-spacing: -0.02em;
  color: white;
  max-width: 56rem;
}

.espron-article {
  width: 92%;
  max-width: 48rem;
  margin: 0 auto;
  padding: 4rem 0 6rem;
}
.espron-lead {
  font-size: 1rem;
  line-height: 2;
  color: rgba(26,26,26,0.75);
  margin-bottom: 2.5rem;
}

.espron-content { outline: none; }
.espron-content:focus { outline: none; }

.espron-content h2 {
  font-size: 1.25rem;
  font-weight: 700;
  line-height: 1.3;
  color: var(--color-foreground);
  margin: 2.5rem 0 1.25rem;
}
.espron-content h3 {
  font-size: 1rem;
  font-weight: 700;
  color: var(--color-foreground);
  margin: 2rem 0 0.75rem;
}
.espron-content p {
  font-size: 0.875rem;
  line-height: 1.75;
  color: rgba(26,26,26,0.75);
  margin: 0 0 1rem;
}
.espron-content strong { font-weight: 700; color: var(--color-foreground); }
.espron-content em { font-style: italic; }
.espron-content ul {
  margin: 1rem 0 1.5rem;
  padding-left: 1.25rem;
  list-style: none;
}
.espron-content ul li {
  position: relative;
  padding-left: 1.25rem;
  font-size: 0.875rem;
  line-height: 1.75;
  color: rgba(26,26,26,0.75);
  margin-bottom: 0.5rem;
}
.espron-content ul li::before {
  content: "";
  position: absolute;
  left: 0;
  top: 0.55rem;
  width: 0.5rem;
  height: 0.5rem;
  border-radius: 9999px;
  background: var(--color-primary);
}
.espron-content a {
  color: var(--color-primary);
  text-decoration: underline;
  text-underline-offset: 3px;
}
.espron-content:empty::before {
  content: "Začnite písať obsah článku…";
  color: #cbd5e1;
}
`
