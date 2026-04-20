import { useEffect, useRef, useState } from 'react'

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
} from '../api/lexanBlogs'

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

const INITIAL_CONTENT = ''

export default function LexanBlogEditor({ editId, onClose }) {
  const isNew = !editId || editId === 'new'

  const [postId, setPostId] = useState(isNew ? null : editId)
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
  const [selectedImgInfo, setSelectedImgInfo] = useState(null)

  const contentRef = useRef(null)
  const fileInputRef = useRef(null)
  const inlineImageRef = useRef(null)
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
        const post = await getBlogPost(editId)
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
        onClose()
      } finally {
        if (!cancelled) setLoading(false)
      }
    })()
    return () => { cancelled = true }
  }, [editId, isNew, onClose])

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
    setSelectedImgInfo(null)
  }

  function handleEditorAction(e) {
    if (e.target.tagName === 'IMG') {
      setSelectedImgInfo({
        node: e.target,
        top: e.target.offsetTop,
        left: e.target.offsetLeft,
        width: e.target.offsetWidth,
        height: e.target.offsetHeight
      })
    } else {
      setSelectedImgInfo(null)
    }
  }

  function removeSelectedImage() {
    if (selectedImgInfo?.node) {
      selectedImgInfo.node.remove()
      setSelectedImgInfo(null)
      onContentInput()
    }
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

  async function handleInlineImageUpload(e) {
    const file = e.target.files?.[0]
    if (!file) return
    try {
      const url = await uploadBlogCoverImage(file, postId || 'inline-' + Date.now())
      exec('insertImage', url)
    } catch (err) {
      alert('Upload obrázku zlyhal: ' + err.message)
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
    <div className="h-full bg-gray-100 flex flex-col relative">
      <style>{LEXAN_PREVIEW_CSS}</style>

      {/* Top bar */}
      <div className="h-14 bg-white border-b border-gray-200 flex items-center px-4 gap-3 sticky top-0 z-20">
        <button
          onClick={onClose}
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
          title="Otvoriť náhľad na lexan.sk"
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
        <div className="w-px h-5 bg-gray-200 mx-1" />
        <ToolbarBtn label="Obrázok" onClick={() => inlineImageRef.current?.click()}><PhotoIcon className="h-4 w-4" /></ToolbarBtn>
        <input ref={inlineImageRef} type="file" accept="image/*" onChange={handleInlineImageUpload} className="hidden" />
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


        </aside>

        {/* Main preview */}
        <div className="flex-1 overflow-y-auto bg-gray-50 pb-24">
          <section 
            className="w-full flex items-center justify-center py-20"
            style={{ 
              backgroundImage: `linear-gradient(rgba(0, 0, 0, 0.6), rgba(0, 0, 0, 0.6)), url('http://localhost:3005/sources/Uvodna-stranka/Posuvacia-cast-2.jpg')`,
              backgroundSize: 'cover',
              backgroundPosition: 'center',
              backgroundColor: '#1a1a1a'
            }}
          >
            <h1 className="text-4xl md:text-5xl font-extrabold text-white uppercase tracking-[0.05em]" style={{ fontFamily: "'Montserrat', sans-serif" }}>
              Blog
            </h1>
          </section>

          <div className="max-w-4xl mx-auto px-4 w-full mt-16">

            <div className="bg-white shadow-xl shadow-gray-200/40 border border-gray-100 overflow-hidden">
              <div className="p-8 md:p-16">
                <div className="mb-12 border-b border-gray-100 pb-10 text-center">
                  <div className="flex justify-center items-center gap-3 mb-6">
                    <span className="text-[10px] font-bold uppercase tracking-widest text-[#5a5a58] bg-gray-100 px-3 py-1.5">{category || 'Kategória'}</span>
                    <span className="text-sm text-gray-400 font-medium">•</span>
                    <span className="text-[12px] font-bold text-gray-400 tracking-wider uppercase">{readingTime || 'Čas'}</span>
                  </div>
                  <h1 className="text-4xl md:text-5xl font-bold text-[#333] leading-[1.1] mb-6" style={{ fontFamily: "'Montserrat', sans-serif" }}>{title || 'Názov článku'}</h1>
                  {excerpt && (
                    <p className="text-[1.1rem] text-gray-500 max-w-2xl mx-auto leading-relaxed" style={{ fontFamily: "'Montserrat', sans-serif" }}>{excerpt}</p>
                  )}
                </div>

                <div className="relative">
                  <div
                    ref={contentRef}
                    contentEditable
                    suppressContentEditableWarning
                    onInput={onContentInput}
                    onBlur={onContentInput}
                    onClick={handleEditorAction}
                    onKeyUp={handleEditorAction}
                    className="lexan-content outline-none focus:outline-none min-h-[300px]"
                  />
                  {selectedImgInfo && (
                    <div 
                      className="absolute z-10 border-[3px] border-red-500 rounded-lg pointer-events-none"
                      style={{ 
                        top: selectedImgInfo.top, 
                        left: selectedImgInfo.left, 
                        width: selectedImgInfo.width, 
                        height: selectedImgInfo.height 
                      }}
                    >
                      <button 
                        onClick={removeSelectedImage}
                        className="absolute -top-4 -right-4 h-8 w-8 bg-red-600 text-white rounded-full flex items-center justify-center font-bold pointer-events-auto shadow-lg hover:bg-red-700 hover:scale-110 transition-transform"
                        title="Odstrániť obrázok"
                      >
                        ✕
                      </button>
                    </div>
                  )}
                </div>
              </div>
            </div>
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
const LEXAN_PREVIEW_CSS = `
@import url('https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700;800&display=swap');

.lexan-content {
  font-size: 1.05rem;
  line-height: 1.8;
  color: #4a4a4a;
  font-family: 'Montserrat', sans-serif;
}
.lexan-content:empty::before {
  content: "Začnite písať obsah článku…";
  color: #cbd5e1;
}
.lexan-content h2 {
  font-size: 1.8rem;
  font-weight: 700;
  color: #333;
  margin: 3.5rem 0 1.5rem;
  line-height: 1.3;
}
.lexan-content h3 {
  font-size: 1.4rem;
  font-weight: 700;
  color: #333;
  margin: 2.5rem 0 1rem;
}
.lexan-content p {
  margin-bottom: 1.5rem;
}
.lexan-content strong {
  color: #222;
  font-weight: 700;
}
.lexan-content ul {
  margin: 1.5rem 0 2rem;
  padding-left: 1rem;
  list-style: none;
}
.lexan-content ul li {
  position: relative;
  padding-left: 1.5rem;
  margin-bottom: 0.75rem;
}
.lexan-content ul li::before {
  content: "";
  position: absolute;
  left: 0;
  top: 0.65rem;
  width: 0.4rem;
  height: 0.4rem;
  border-radius: 50%;
  background: #5a5a58;
}
.lexan-content a {
  color: #5a5a58;
  text-decoration: underline;
  text-underline-offset: 4px;
  font-weight: 600;
  transition: color 0.2s ease;
}
.lexan-content a:hover {
  color: #000;
}
.lexan-content blockquote {
  border-left: 4px solid #5a5a58;
  padding-left: 1.5rem;
  margin: 2rem 0;
  font-style: italic;
  color: #666;
}
.lexan-content img {
  width: 100%;
  height: auto;
  border-radius: 8px;
  margin: 2.5rem 0;
  box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
}
`
