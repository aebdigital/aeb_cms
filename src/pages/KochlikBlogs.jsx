import { useCallback, useEffect, useState, useRef } from 'react'
import { createPortal } from 'react-dom'
import {
  DocumentPlusIcon,
  EyeIcon,
  PencilSquareIcon,
  PhotoIcon,
  PlusIcon,
  TrashIcon,
  XMarkIcon,
} from '@heroicons/react/24/outline'
import { useAuth } from '../contexts/AuthContext'
import { useNotification } from '../contexts/NotificationContext'
import {
  KOCHLIK_OWNER_ID,
  createKochlikBlogPost,
  deleteKochlikBlogPost,
  listKochlikBlogPosts,
  togglePublishKochlikBlogPost,
  updateKochlikBlogPost,
  uploadKochlikBlogImage,
} from '../api'

const PREVIEW_ORIGIN = 'http://localhost:3006'

function resolveImage(url) {
  if (!url) return ''
  if (url.startsWith('http://') || url.startsWith('https://') || url.startsWith('data:')) {
    return url
  }
  return `${PREVIEW_ORIGIN}${url.startsWith('/') ? '' : '/'}${url}`
}

const EMPTY_POST = {
  title: '',
  slug: '',
  excerpt: '',
  category: 'Blog',
  reading_time: '5 min',
  cover_image: '',
  content_html: '',
  seo_title: '',
  seo_description: '',
  is_published: false,
  published_at: '',
}

function slugify(value) {
  return (value || '')
    .toLowerCase()
    .normalize('NFD')
    .replace(/[\u0300-\u036f]/g, '')
    .replace(/[^a-z0-9\s-]/g, '')
    .trim()
    .replace(/\s+/g, '-')
    .replace(/-+/g, '-')
    .slice(0, 80)
}

function formatDate(value) {
  if (!value) return 'Nezverejnené'
  const date = new Date(value)
  if (Number.isNaN(date.getTime())) return 'Nezverejnené'
  return new Intl.DateTimeFormat('sk-SK', {
    day: 'numeric',
    month: 'short',
    year: 'numeric',
  }).format(date)
}

function toDateTimeLocal(value) {
  if (!value) return ''
  const date = new Date(value)
  if (Number.isNaN(date.getTime())) return ''
  const local = new Date(date.getTime() - date.getTimezoneOffset() * 60000)
  return local.toISOString().slice(0, 16)
}

function fromDateTimeLocal(value) {
  if (!value) return null
  const date = new Date(value)
  return Number.isNaN(date.getTime()) ? null : date.toISOString()
}

export default function KochlikBlogs() {
  const { user, loading: authLoading } = useAuth()
  const { showNotification } = useNotification()
  const [posts, setPosts] = useState([])
  const [loading, setLoading] = useState(true)
  const [saving, setSaving] = useState(false)
  const [uploading, setUploading] = useState(false)
  const [editingPost, setEditingPost] = useState(null)
  const [postForm, setPostForm] = useState(EMPTY_POST)
  const [slugTouched, setSlugTouched] = useState(false)
  const [isModalOpen, setIsModalOpen] = useState(false)

  const hasAccess = user?.id === KOCHLIK_OWNER_ID
    || user?.email === 'info@kochlik.eu'
    || user?.email === 'alexander.hidveghy@gmail.com'

  const loadData = useCallback(async () => {
    setLoading(true)
    try {
      setPosts(await listKochlikBlogPosts())
    } catch (err) {
      console.error('Kochlik blog load error:', err)
      showNotification('Nepodarilo sa načítať blogy', 'error')
    } finally {
      setLoading(false)
    }
  }, [showNotification])

  useEffect(() => {
    if (authLoading || !hasAccess) return
    loadData()
  }, [authLoading, hasAccess, loadData])

  useEffect(() => {
    if (isModalOpen) {
      document.body.style.overflow = 'hidden'
    } else {
      document.body.style.overflow = ''
    }
    return () => {
      document.body.style.overflow = ''
    }
  }, [isModalOpen])

  function openCreateModal() {
    setEditingPost(null)
    setSlugTouched(false)
    setPostForm(EMPTY_POST)
    setIsModalOpen(true)
  }

  function openEditModal(post) {
    setEditingPost(post)
    setSlugTouched(true)
    setPostForm({
      title: post.title || '',
      slug: post.slug || '',
      excerpt: post.excerpt || '',
      category: post.category || 'Blog',
      reading_time: post.reading_time || '5 min',
      cover_image: post.cover_image || '',
      content_html: post.content_html || '',
      seo_title: post.seo_title || '',
      seo_description: post.seo_description || '',
      is_published: Boolean(post.is_published),
      published_at: toDateTimeLocal(post.published_at),
    })
    setIsModalOpen(true)
  }

  function closeModal() {
    setEditingPost(null)
    setSlugTouched(false)
    setPostForm(EMPTY_POST)
    setIsModalOpen(false)
  }

  function updateTitle(value) {
    setPostForm(prev => ({
      ...prev,
      title: value,
      slug: slugTouched ? prev.slug : slugify(value),
    }))
  }

  async function handleCoverUpload(event) {
    const file = event.target.files?.[0]
    event.target.value = ''
    if (!file || !file.type.startsWith('image/')) return

    setUploading(true)
    try {
      const imageUrl = await uploadKochlikBlogImage(file, editingPost?.id || 'new')
      setPostForm(prev => ({ ...prev, cover_image: imageUrl }))
      showNotification('Obrázok článku bol nahraný', 'success')
    } catch (err) {
      console.error('Kochlik blog image upload error:', err)
      showNotification('Obrázok sa nepodarilo nahrať', 'error')
    } finally {
      setUploading(false)
    }
  }

  function buildPayload() {
    const isPublished = Boolean(postForm.is_published)
    const publishedAt = fromDateTimeLocal(postForm.published_at)

    return {
      title: postForm.title.trim(),
      slug: (postForm.slug || slugify(postForm.title)).trim(),
      excerpt: postForm.excerpt.trim() || null,
      category: postForm.category.trim() || 'Blog',
      reading_time: postForm.reading_time.trim() || '5 min',
      cover_image: postForm.cover_image.trim() || null,
      content_html: postForm.content_html.trim() || '',
      seo_title: postForm.seo_title.trim() || null,
      seo_description: postForm.seo_description.trim() || null,
      is_published: isPublished,
      published_at: isPublished ? (publishedAt || new Date().toISOString()) : publishedAt,
    }
  }

  async function handleSubmit(event) {
    event.preventDefault()
    const payload = buildPayload()

    if (!payload.title || !payload.slug) {
      showNotification('Vyplňte názov a URL slug článku', 'error')
      return
    }

    setSaving(true)
    try {
      if (editingPost) {
        const updated = await updateKochlikBlogPost(editingPost.id, payload)
        setPosts(prev => prev.map(post => post.id === updated.id ? updated : post))
        showNotification('Článok bol uložený', 'success')
      } else {
        const created = await createKochlikBlogPost(payload)
        setPosts(prev => [created, ...prev])
        showNotification('Článok bol pridaný', 'success')
      }
      closeModal()
    } catch (err) {
      console.error('Kochlik blog save error:', err)
      showNotification(err.message || 'Článok sa nepodarilo uložiť', 'error')
    } finally {
      setSaving(false)
    }
  }

  async function handleDelete(post) {
    if (!confirm(`Naozaj vymazať článok "${post.title}"?`)) return

    try {
      await deleteKochlikBlogPost(post.id)
      setPosts(prev => prev.filter(item => item.id !== post.id))
      showNotification('Článok bol vymazaný', 'success')
    } catch (err) {
      console.error('Kochlik blog delete error:', err)
      showNotification('Článok sa nepodarilo vymazať', 'error')
    }
  }

  async function handleTogglePublish(post) {
    try {
      const updated = await togglePublishKochlikBlogPost(post)
      setPosts(prev => prev.map(item => item.id === updated.id ? updated : item))
      showNotification(updated.is_published ? 'Článok bol publikovaný' : 'Článok je koncept', 'success')
    } catch (err) {
      console.error('Kochlik blog publish error:', err)
      showNotification('Stav článku sa nepodarilo zmeniť', 'error')
    }
  }

  if (authLoading) return <div className="flex h-64 items-center justify-center"><div className="h-8 w-8 animate-spin rounded-full border-b-2 border-emerald-600"></div></div>
  if (!hasAccess) return <div className="flex h-64 items-center justify-center"><p className="text-gray-500">Nemáte prístup.</p></div>

  return (
    <div className="space-y-6">
      <div className="flex flex-col gap-4 lg:flex-row lg:items-end lg:justify-between">
        <div>
          <p className="text-sm font-semibold uppercase tracking-[0.18em] text-emerald-700">Kochlik</p>
          <h1 className="mt-1 text-3xl font-bold text-gray-950">Blog</h1>
          <p className="mt-2 text-sm text-gray-500">Články sa po publikovaní zobrazia na kochlik.sk/blog.</p>
        </div>
        <button
          onClick={openCreateModal}
          className="inline-flex items-center justify-center rounded-2xl bg-emerald-600 px-5 py-3 text-sm font-extrabold text-white transition hover:bg-emerald-700"
        >
          <PlusIcon className="mr-2 h-5 w-5" />
          Nový článok
        </button>
      </div>

      {loading ? (
        <div className="rounded-3xl bg-white p-12 text-center text-gray-500 shadow-sm ring-1 ring-gray-100">
          Načítavam články...
        </div>
      ) : posts.length === 0 ? (
        <div className="rounded-3xl border-2 border-dashed border-gray-200 bg-white p-12 text-center">
          <DocumentPlusIcon className="mx-auto mb-3 h-12 w-12 text-gray-300" />
          <p className="font-semibold text-gray-600">Zatiaľ nemáte žiadne články.</p>
        </div>
      ) : (
        <div className="grid gap-5 md:grid-cols-2 xl:grid-cols-3">
          {posts.map(post => (
            <article key={post.id} className="overflow-hidden rounded-3xl bg-white shadow-sm ring-1 ring-gray-100">
              <button
                type="button"
                onClick={() => openEditModal(post)}
                className="group block w-full text-left"
              >
                <div className="relative aspect-[16/10] bg-gray-100">
                  {post.cover_image ? (
                    <img src={resolveImage(post.cover_image)} alt={post.title} className="h-full w-full object-cover transition duration-300 group-hover:scale-[1.02]" />
                  ) : (
                    <div className="flex h-full items-center justify-center text-gray-300">
                      <PhotoIcon className="h-12 w-12" />
                    </div>
                  )}
                  <span className={`absolute left-4 top-4 rounded-full px-3 py-1 text-xs font-bold ${
                    post.is_published ? 'bg-emerald-500 text-white' : 'bg-gray-900/70 text-white'
                  }`}>
                    {post.is_published ? 'Publikovaný' : 'Koncept'}
                  </span>
                </div>
              </button>
              <div className="space-y-4 p-5">
                <div>
                  <p className="text-xs font-bold uppercase tracking-wider text-gray-400">{post.category || 'Blog'} · {formatDate(post.published_at)}</p>
                  <h2 className="mt-2 line-clamp-2 text-lg font-extrabold text-gray-950">{post.title}</h2>
                  <p className="mt-1 truncate text-xs font-semibold text-blue-600">/blog/{post.slug}</p>
                  {post.excerpt && <p className="mt-3 line-clamp-3 text-sm leading-6 text-gray-500">{post.excerpt}</p>}
                </div>
                <div className="flex flex-wrap items-center justify-end gap-2">
                  {post.is_published ? (
                    <a
                      href={`${PREVIEW_ORIGIN}/blog/${post.slug}`}
                      target="_blank"
                      rel="noopener noreferrer"
                      className="inline-flex items-center rounded-xl bg-gray-100 px-3 py-2 text-xs font-bold text-gray-700 transition hover:bg-gray-200"
                    >
                      <EyeIcon className="mr-1 h-4 w-4" />
                      Náhľad
                    </a>
                  ) : (
                    <span className="inline-flex items-center rounded-xl bg-gray-100 px-3 py-2 text-xs font-bold text-gray-400">
                      <EyeIcon className="mr-1 h-4 w-4" />
                      Náhľad po publikovaní
                    </span>
                  )}
                  <button
                    type="button"
                    onClick={() => handleTogglePublish(post)}
                    className={`rounded-xl px-3 py-2 text-xs font-bold transition ${
                      post.is_published
                        ? 'bg-green-100 text-green-700 hover:bg-green-200'
                        : 'bg-gray-100 text-gray-600 hover:bg-gray-200'
                    }`}
                  >
                    {post.is_published ? 'Zneplatniť' : 'Publikovať'}
                  </button>
                  <button
                    type="button"
                    onClick={() => openEditModal(post)}
                    className="inline-flex items-center rounded-xl bg-emerald-50 px-3 py-2 text-xs font-bold text-emerald-700 transition hover:bg-emerald-100"
                  >
                    <PencilSquareIcon className="mr-1 h-4 w-4" />
                    Upraviť
                  </button>
                  <button
                    type="button"
                    onClick={() => handleDelete(post)}
                    className="inline-flex items-center rounded-xl bg-red-50 px-3 py-2 text-xs font-bold text-red-600 transition hover:bg-red-100"
                  >
                    <TrashIcon className="mr-1 h-4 w-4" />
                    Vymazať
                  </button>
                </div>
              </div>
            </article>
          ))}
        </div>
      )}

      {isModalOpen && createPortal(
        <div className="fixed inset-0 z-50 flex items-center justify-center overflow-y-auto bg-gray-900/50 px-4 py-6 backdrop-blur-sm sm:px-0">
          <div className="relative max-h-[92vh] w-full max-w-7xl overflow-y-auto rounded-3xl bg-white shadow-2xl">
            <div className="sticky top-0 z-10 flex items-center justify-between border-b border-gray-100 bg-white px-6 py-4">
              <h2 className="text-xl font-bold text-gray-950">{editingPost ? 'Upraviť článok' : 'Nový článok'}</h2>
              <button onClick={closeModal} className="rounded-full p-2 text-gray-400 transition hover:bg-gray-100 hover:text-gray-600">
                <XMarkIcon className="h-6 w-6" />
              </button>
            </div>

            <form onSubmit={handleSubmit} className="grid gap-6 p-6 lg:grid-cols-[1fr_380px]">
              <div className="space-y-4">
                <label className="block">
                  <span className="text-xs font-bold uppercase tracking-wider text-gray-600">Názov</span>
                  <input
                    value={postForm.title}
                    onChange={(event) => updateTitle(event.target.value)}
                    className="mt-1 w-full rounded-xl border border-gray-200 px-3 py-2 text-sm outline-none focus:border-emerald-500 focus:ring-1 focus:ring-emerald-500"
                    required
                  />
                </label>
                <label className="block">
                  <span className="text-xs font-bold uppercase tracking-wider text-gray-600">URL slug</span>
                  <input
                    value={postForm.slug}
                    onChange={(event) => {
                      setSlugTouched(true)
                      setPostForm(prev => ({ ...prev, slug: slugify(event.target.value) }))
                    }}
                    className="mt-1 w-full rounded-xl border border-gray-200 px-3 py-2 text-sm font-mono outline-none focus:border-emerald-500 focus:ring-1 focus:ring-emerald-500"
                    required
                  />
                </label>
                <label className="block">
                  <span className="text-xs font-bold uppercase tracking-wider text-gray-600">Krátky popis</span>
                  <textarea
                    rows={4}
                    value={postForm.excerpt}
                    onChange={(event) => setPostForm(prev => ({ ...prev, excerpt: event.target.value }))}
                    className="mt-1 w-full rounded-xl border border-gray-200 px-3 py-2 text-sm outline-none focus:border-emerald-500 focus:ring-1 focus:ring-emerald-500"
                  />
                </label>
                <div className="block">
                  <span className="text-xs font-bold uppercase tracking-wider text-gray-600">Obsah článku</span>
                  <RichTextEditor
                    value={postForm.content_html}
                    onChange={(val) => setPostForm(prev => ({ ...prev, content_html: val }))}
                  />
                </div>
              </div>

              <aside className="space-y-4 rounded-2xl bg-gray-50 p-4">
                <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-1">
                  <label className="block">
                    <span className="text-xs font-bold uppercase tracking-wider text-gray-600">Kategória</span>
                    <input
                      value={postForm.category}
                      onChange={(event) => setPostForm(prev => ({ ...prev, category: event.target.value }))}
                      className="mt-1 w-full rounded-xl border border-gray-200 px-3 py-2 text-sm outline-none focus:border-emerald-500 focus:ring-1 focus:ring-emerald-500"
                    />
                  </label>
                  <label className="block">
                    <span className="text-xs font-bold uppercase tracking-wider text-gray-600">Čas čítania</span>
                    <input
                      value={postForm.reading_time}
                      onChange={(event) => setPostForm(prev => ({ ...prev, reading_time: event.target.value }))}
                      className="mt-1 w-full rounded-xl border border-gray-200 px-3 py-2 text-sm outline-none focus:border-emerald-500 focus:ring-1 focus:ring-emerald-500"
                    />
                  </label>
                  <label className="block">
                    <span className="text-xs font-bold uppercase tracking-wider text-gray-600">Dátum publikovania</span>
                    <input
                      type="datetime-local"
                      value={postForm.published_at}
                      onChange={(event) => setPostForm(prev => ({ ...prev, published_at: event.target.value }))}
                      className="mt-1 w-full rounded-xl border border-gray-200 px-3 py-2 text-sm outline-none focus:border-emerald-500 focus:ring-1 focus:ring-emerald-500"
                    />
                  </label>
                </div>

                <label className="flex items-center gap-3 rounded-xl bg-white px-3 py-3">
                  <input
                    type="checkbox"
                    checked={postForm.is_published}
                    onChange={(event) => setPostForm(prev => ({ ...prev, is_published: event.target.checked }))}
                    className="h-4 w-4 rounded border-gray-300 text-emerald-600 focus:ring-emerald-500"
                  />
                  <span className="text-sm font-semibold text-gray-700">Publikovať na webe</span>
                </label>

                <div>
                  <span className="text-xs font-bold uppercase tracking-wider text-gray-600">Úvodný obrázok</span>
                  <div className="relative mt-2 aspect-[16/10] overflow-hidden rounded-2xl bg-gray-100 ring-1 ring-gray-200">
                    {postForm.cover_image ? (
                      <img src={resolveImage(postForm.cover_image)} alt="" className="h-full w-full object-cover" />
                    ) : (
                      <div className="flex h-full items-center justify-center text-gray-300">
                        <PhotoIcon className="h-12 w-12" />
                      </div>
                    )}
                  </div>
                </div>
                <label className="flex cursor-pointer items-center justify-center rounded-xl bg-gray-200 px-4 py-3 text-sm font-bold text-gray-900 transition hover:bg-gray-300">
                  {uploading ? 'Nahrávam...' : 'Nahrať obrázok'}
                  <input type="file" accept="image/*" className="hidden" disabled={uploading} onChange={handleCoverUpload} />
                </label>
                <input
                  value={postForm.cover_image}
                  onChange={(event) => setPostForm(prev => ({ ...prev, cover_image: event.target.value }))}
                  placeholder="URL obrázka"
                  className="w-full rounded-xl border border-gray-200 px-3 py-2 text-xs outline-none focus:border-emerald-500 focus:ring-1 focus:ring-emerald-500"
                />

                <label className="block">
                  <span className="text-xs font-bold uppercase tracking-wider text-gray-600">SEO titulok</span>
                  <input
                    value={postForm.seo_title}
                    onChange={(event) => setPostForm(prev => ({ ...prev, seo_title: event.target.value }))}
                    className="mt-1 w-full rounded-xl border border-gray-200 px-3 py-2 text-sm outline-none focus:border-emerald-500 focus:ring-1 focus:ring-emerald-500"
                  />
                </label>
                <label className="block">
                  <span className="text-xs font-bold uppercase tracking-wider text-gray-600">SEO popis</span>
                  <textarea
                    rows={3}
                    value={postForm.seo_description}
                    onChange={(event) => setPostForm(prev => ({ ...prev, seo_description: event.target.value }))}
                    className="mt-1 w-full rounded-xl border border-gray-200 px-3 py-2 text-sm outline-none focus:border-emerald-500 focus:ring-1 focus:ring-emerald-500"
                  />
                </label>

                <div className="flex justify-end gap-3 pt-4">
                  <button
                    type="button"
                    onClick={closeModal}
                    className="rounded-xl border border-gray-200 px-5 py-2 text-sm font-bold text-gray-700 transition hover:bg-gray-50"
                  >
                    Zrušiť
                  </button>
                  <button
                    type="submit"
                    disabled={saving}
                    className="rounded-xl bg-emerald-600 px-5 py-2 text-sm font-extrabold text-white transition hover:bg-emerald-700 disabled:opacity-60"
                  >
                    {saving ? 'Ukladám...' : 'Uložiť'}
                  </button>
                </div>
              </aside>
            </form>
          </div>
        </div>,
        document.body
      )}
    </div>
  )
}

function RichTextEditor({ value, onChange }) {
  const editorRef = useRef(null)
  const [isSourceView, setIsSourceView] = useState(false)

  useEffect(() => {
    if (editorRef.current && !isSourceView && editorRef.current.innerHTML !== value) {
      editorRef.current.innerHTML = value || '<p><br></p>'
    }
  }, [value, isSourceView])

  const handleInput = () => {
    if (editorRef.current) {
      onChange(editorRef.current.innerHTML)
    }
  }

  const handleTextAreaChange = (e) => {
    onChange(e.target.value)
  }

  const execCmd = (command, val = null) => {
    document.execCommand(command, false, val)
    handleInput()
  }

  return (
    <div className="border border-gray-200 rounded-xl overflow-hidden bg-white mt-1">
      {/* Toolbar */}
      <div className="flex flex-wrap items-center justify-between gap-1 bg-gray-50 border-b border-gray-150 p-2">
        <div className="flex flex-wrap gap-1 items-center">
          {!isSourceView && (
            <>
              <button
                type="button"
                onClick={() => execCmd('bold')}
                className="px-2 py-1 text-xs font-bold rounded hover:bg-gray-200 transition text-gray-700"
                title="Tučné"
              >
                B
              </button>
              <button
                type="button"
                onClick={() => execCmd('italic')}
                className="px-2 py-1 text-xs italic rounded hover:bg-gray-200 transition text-gray-700"
                title="Kurzíva"
              >
                I
              </button>
              <button
                type="button"
                onClick={() => execCmd('underline')}
                className="px-2 py-1 text-xs underline rounded hover:bg-gray-200 transition text-gray-700"
                title="Podčiarknuté"
              >
                U
              </button>
              <div className="w-[1px] h-4 bg-gray-200 mx-1" />
              <button
                type="button"
                onClick={() => execCmd('formatBlock', '<h2>')}
                className="px-2 py-0.5 text-xs font-bold rounded hover:bg-gray-200 transition text-gray-700"
                title="Nadpis 2"
              >
                H2
              </button>
              <button
                type="button"
                onClick={() => execCmd('formatBlock', '<h3>')}
                className="px-2 py-0.5 text-xs font-bold rounded hover:bg-gray-200 transition text-gray-700"
                title="Nadpis 3"
              >
                H3
              </button>
              <button
                type="button"
                onClick={() => execCmd('formatBlock', '<p>')}
                className="px-2 py-0.5 text-xs rounded hover:bg-gray-200 transition text-gray-700"
                title="Odstavec"
              >
                P
              </button>
              <div className="w-[1px] h-4 bg-gray-200 mx-1" />
              <button
                type="button"
                onClick={() => execCmd('insertUnorderedList')}
                className="px-2 py-0.5 text-xs rounded hover:bg-gray-200 transition text-gray-700"
                title="Odrážky"
              >
                • Zoznam
              </button>
              <button
                type="button"
                onClick={() => execCmd('insertOrderedList')}
                className="px-2 py-0.5 text-xs rounded hover:bg-gray-200 transition text-gray-700"
                title="Číslovanie"
              >
                1. Zoznam
              </button>
              <div className="w-[1px] h-4 bg-gray-200 mx-1" />
              <button
                type="button"
                onClick={() => {
                  const url = prompt('Zadajte URL odkazu:', 'https://')
                  if (url) execCmd('createLink', url)
                }}
                className="px-2 py-0.5 text-xs rounded hover:bg-gray-200 transition text-gray-700"
                title="Vložiť odkaz"
              >
                🔗 Odkaz
              </button>
              <button
                type="button"
                onClick={() => execCmd('unlink')}
                className="px-2 py-0.5 text-xs rounded hover:bg-gray-200 transition text-gray-700"
                title="Odobrať odkaz"
              >
                Odobrať
              </button>
              <div className="w-[1px] h-4 bg-gray-200 mx-1" />
              <button
                type="button"
                onClick={() => execCmd('removeFormat')}
                className="px-2 py-0.5 text-xs rounded hover:bg-gray-200 transition text-red-600"
                title="Vymazať formátovanie"
              >
                Vymazať formát
              </button>
            </>
          )}
        </div>
        <button
          type="button"
          onClick={() => setIsSourceView(!isSourceView)}
          className="px-2 py-1 text-xs rounded bg-gray-150 hover:bg-gray-200 text-gray-800 transition font-mono font-bold"
        >
          {isSourceView ? '✍️ Editor' : '💻 HTML Kód'}
        </button>
      </div>

      {/* Editor Area */}
      {isSourceView ? (
        <textarea
          value={value || ''}
          onChange={handleTextAreaChange}
          className="w-full p-4 min-h-[350px] font-mono text-xs leading-6 outline-none bg-gray-900 text-gray-100 focus:ring-0"
          placeholder="<html>..."
        />
      ) : (
        <div
          ref={editorRef}
          contentEditable
          onInput={handleInput}
          className="p-4 min-h-[350px] max-h-[600px] overflow-y-auto outline-none prose prose-sm max-w-none text-gray-800 focus:ring-1 focus:ring-emerald-500/20"
          style={{ fontSize: '14px', lineHeight: '1.6' }}
        />
      )}
    </div>
  )
}
