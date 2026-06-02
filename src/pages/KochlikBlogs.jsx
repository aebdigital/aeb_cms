import { useCallback, useEffect, useState, useRef } from 'react'
import { createPortal } from 'react-dom'
import {
  BoldIcon,
  CodeBracketIcon,
  DocumentPlusIcon,
  EyeIcon,
  ItalicIcon,
  LinkIcon,
  ListBulletIcon,
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

const PREVIEW_ORIGIN = import.meta.env.VITE_KOCHLIK_SITE_URL
  || (typeof window !== 'undefined' && window.location.hostname === 'localhost'
    ? 'http://localhost:3001'
    : 'https://kochlik.sk')

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
  const [isModalOpen, setIsModalOpen] = useState(false)

  const hasAccess = user?.id === KOCHLIK_OWNER_ID
    || user?.email === 'info@kochlik.eu'
    || user?.email === 'alexander.hidveghy@gmail.com'
  const generatedPostSlug = postForm.slug || slugify(postForm.title)
  const generatedPostUrl = generatedPostSlug
    ? `https://kochlik.sk/blog/${generatedPostSlug}`
    : 'https://kochlik.sk/blog'

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
    setPostForm(EMPTY_POST)
    setIsModalOpen(true)
  }

  function openEditModal(post) {
    setEditingPost(post)
    setPostForm({
      title: post.title || '',
      slug: slugify(post.title || post.slug || ''),
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
    setPostForm(EMPTY_POST)
    setIsModalOpen(false)
  }

  function updateTitle(value) {
    setPostForm(prev => ({
      ...prev,
      title: value,
      slug: slugify(value),
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

  async function uploadEditorImage(file) {
    return uploadKochlikBlogImage(file, editingPost?.id || `inline-${Date.now()}`)
  }

  function buildPayload() {
    const isPublished = Boolean(postForm.is_published)
    const publishedAt = fromDateTimeLocal(postForm.published_at)

    return {
      title: postForm.title.trim(),
      slug: slugify(postForm.title).trim(),
      excerpt: postForm.excerpt.trim() || null,
      category: 'Blog',
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
      showNotification('Vyplňte názov článku', 'error')
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
        setEditingPost(created)
        showNotification('Článok bol pridaný', 'success')
      }
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
                  <p className="text-xs font-bold uppercase tracking-wider text-gray-400">{formatDate(post.published_at)}</p>
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
        <div className="fixed inset-0 z-50 flex items-center justify-center overflow-y-auto bg-gray-900/50 px-3 py-6 backdrop-blur-sm sm:px-4">
          <div className="relative max-h-[92vh] w-full max-w-[1760px] overflow-y-auto rounded-3xl bg-white shadow-2xl">
            <div className="sticky top-0 z-10 flex items-center justify-between border-b border-gray-100 bg-white px-6 py-4">
              <h2 className="text-xl font-bold text-gray-950">{editingPost ? 'Upraviť článok' : 'Nový článok'}</h2>
              <button onClick={closeModal} className="rounded-full p-2 text-gray-400 transition hover:bg-gray-100 hover:text-gray-600">
                <XMarkIcon className="h-6 w-6" />
              </button>
            </div>

            <form onSubmit={handleSubmit} className="space-y-6 p-6">
              <div className="grid gap-6 xl:grid-cols-[minmax(0,1fr)_520px]">
                <div className="space-y-4">
                  <label className="block">
                    <span className="text-xs font-bold uppercase tracking-wider text-gray-600">Názov</span>
                    <input
                      value={postForm.title}
                      onChange={(event) => updateTitle(event.target.value)}
                      className="mt-1 w-full rounded-xl border border-gray-200 px-3 py-2 text-sm outline-none focus:border-emerald-500 focus:ring-1 focus:ring-emerald-500"
                      required
                    />
                    <a
                      href={generatedPostUrl}
                      target="_blank"
                      rel="noopener noreferrer"
                      className="mt-2 block break-all text-xs font-mono text-blue-600 transition hover:text-blue-800 hover:underline"
                    >
                      /blog/{generatedPostSlug || 'url-clanku'}
                    </a>
                  </label>
                  <div className="grid gap-4 md:grid-cols-2">
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
                  <label className="block">
                    <span className="text-xs font-bold uppercase tracking-wider text-gray-600">Krátky popis</span>
                    <textarea
                      rows={4}
                      value={postForm.excerpt}
                      onChange={(event) => setPostForm(prev => ({ ...prev, excerpt: event.target.value }))}
                      className="mt-1 w-full rounded-xl border border-gray-200 px-3 py-2 text-sm outline-none focus:border-emerald-500 focus:ring-1 focus:ring-emerald-500"
                    />
                  </label>
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
                      rows={6}
                      value={postForm.seo_description}
                      onChange={(event) => setPostForm(prev => ({ ...prev, seo_description: event.target.value }))}
                      className="mt-1 w-full rounded-xl border border-gray-200 px-3 py-2 text-sm outline-none focus:border-emerald-500 focus:ring-1 focus:ring-emerald-500"
                    />
                  </label>
                </div>

                <div className="space-y-4 rounded-2xl bg-gray-50 p-4">
                  <div className="grid gap-4 sm:grid-cols-[180px_minmax(0,1fr)] xl:grid-cols-1">
                    <div>
                      <span className="text-xs font-bold uppercase tracking-wider text-gray-600">Úvodný obrázok</span>
                      <label className={`group relative mt-2 flex aspect-[16/10] cursor-pointer overflow-hidden rounded-2xl bg-gray-100 ring-1 ring-gray-200 transition hover:ring-emerald-400 ${uploading ? 'pointer-events-none opacity-70' : ''}`}>
                        {postForm.cover_image ? (
                          <>
                            <img src={resolveImage(postForm.cover_image)} alt="" className="h-full w-full object-cover" />
                            <span className="absolute inset-0 flex items-center justify-center bg-black/40 text-sm font-bold text-white opacity-0 transition group-hover:opacity-100">
                              {uploading ? 'Nahrávam...' : 'Kliknite pre zmenu obrázka'}
                            </span>
                            <button
                              type="button"
                              onClick={(event) => {
                                event.preventDefault()
                                event.stopPropagation()
                                setPostForm(prev => ({ ...prev, cover_image: '' }))
                              }}
                              className="absolute right-3 top-3 inline-flex h-9 w-9 items-center justify-center rounded-full bg-white/95 text-red-600 opacity-0 shadow-lg ring-1 ring-black/10 transition group-hover:opacity-100 hover:bg-red-600 hover:text-white"
                              title="Odstrániť obrázok"
                            >
                              <XMarkIcon className="h-5 w-5" />
                            </button>
                          </>
                        ) : (
                          <div className="flex h-full w-full flex-col items-center justify-center gap-2 text-gray-300 transition group-hover:text-emerald-600">
                            <PhotoIcon className="h-12 w-12" />
                            <span className="text-sm font-bold text-gray-500 group-hover:text-emerald-700">
                              {uploading ? 'Nahrávam...' : 'Nahrať obrázok'}
                            </span>
                          </div>
                        )}
                        <input type="file" accept="image/*" className="hidden" disabled={uploading} onChange={handleCoverUpload} />
                      </label>
                    </div>
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
                </div>
              </div>

              <div className="block">
                <span className="text-xs font-bold uppercase tracking-wider text-gray-600">Obsah článku</span>
                <RichTextEditor
                  value={postForm.content_html}
                  onChange={(val) => setPostForm(prev => ({ ...prev, content_html: val }))}
                  title={postForm.title}
                  excerpt={postForm.excerpt}
                  dateLabel={formatDate(fromDateTimeLocal(postForm.published_at) || postForm.published_at || new Date().toISOString())}
                  onUploadImage={uploadEditorImage}
                />
              </div>

              <div className="sticky bottom-0 z-10 -mx-6 -mb-6 flex justify-end gap-3 border-t border-gray-100 bg-white/95 px-6 py-4 backdrop-blur">
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
            </form>
          </div>
        </div>,
        document.body
      )}
    </div>
  )
}

function RichTextEditor({ value, onChange, title, excerpt, dateLabel, onUploadImage }) {
  const editorRef = useRef(null)
  const imageInputRef = useRef(null)
  const replaceImageInputRef = useRef(null)
  const selectedImageRef = useRef(null)
  const selectionRef = useRef(null)
  const resizeRef = useRef(null)
  const [isSourceView, setIsSourceView] = useState(false)
  const [uploadingInlineImage, setUploadingInlineImage] = useState(false)
  const [imageControl, setImageControl] = useState(null)

  useEffect(() => {
    if (editorRef.current && !isSourceView && editorRef.current.innerHTML !== value) {
      editorRef.current.innerHTML = value || '<p><br></p>'
    }
  }, [value, isSourceView])

  function saveSelection() {
    const selection = window.getSelection()
    if (!selection || selection.rangeCount === 0) return
    if (!editorRef.current?.contains(selection.anchorNode)) return
    selectionRef.current = selection.getRangeAt(0).cloneRange()
  }

  function restoreSelection() {
    const selection = window.getSelection()
    const range = selectionRef.current
    if (!selection || !range) return
    selection.removeAllRanges()
    selection.addRange(range)
  }

  const handleInput = () => {
    if (editorRef.current) {
      onChange(editorRef.current.innerHTML)
    }
  }

  const handleTextAreaChange = (e) => {
    onChange(e.target.value)
  }

  const execCmd = (command, val = null) => {
    restoreSelection()
    document.execCommand(command, false, val)
    handleInput()
    editorRef.current?.focus()
    saveSelection()
  }

  const insertHtml = (html) => {
    restoreSelection()
    document.execCommand('insertHTML', false, html)
    handleInput()
    editorRef.current?.focus()
    saveSelection()
  }

  const insertImage = (url) => {
    const safeUrl = String(url || '').replace(/"/g, '&quot;')
    insertHtml(`<figure><img src="${safeUrl}" alt="" /></figure><p><br></p>`)
  }

  const handleInlineImageUpload = async (event) => {
    const file = event.target.files?.[0]
    event.target.value = ''
    if (!file || !file.type.startsWith('image/')) return

    setUploadingInlineImage(true)
    try {
      const url = await onUploadImage(file)
      insertImage(url)
    } catch (err) {
      console.error('Kochlik inline blog image upload error:', err)
      alert('Obrázok sa nepodarilo nahrať.')
    } finally {
      setUploadingInlineImage(false)
    }
  }

  const handleReplaceImageUpload = async (event) => {
    const file = event.target.files?.[0]
    event.target.value = ''
    if (!file || !file.type.startsWith('image/')) return

    const img = selectedImageRef.current || imageControl?.node
    if (!img) return

    setUploadingInlineImage(true)
    try {
      const url = await onUploadImage(file)
      img.src = url
      updateImageControl(img)
      handleInput()
    } catch (err) {
      console.error('Kochlik inline blog image replace error:', err)
      alert('Obrázok sa nepodarilo vymeniť.')
    } finally {
      setUploadingInlineImage(false)
    }
  }

  const updateImageControl = (img) => {
    const wrapper = editorRef.current?.parentElement
    if (!wrapper || !img) return

    const imgRect = img.getBoundingClientRect()
    const wrapperRect = wrapper.getBoundingClientRect()
    selectedImageRef.current = img
    setImageControl({
      node: img,
      top: imgRect.top - wrapperRect.top + wrapper.scrollTop + 10,
      left: imgRect.right - wrapperRect.left + wrapper.scrollLeft - 108,
      handleTop: imgRect.bottom - wrapperRect.top + wrapper.scrollTop - 12,
      handleLeft: imgRect.left - wrapperRect.left + wrapper.scrollLeft + (imgRect.width / 2) - 32,
      height: Math.round(imgRect.height),
    })
  }

  const handleEditorMouseOver = (event) => {
    if (event.target?.tagName === 'IMG') {
      updateImageControl(event.target)
    }
  }

  const handleEditorClick = (event) => {
    if (event.target?.tagName !== 'IMG') return

    updateImageControl(event.target)
    replaceImageInputRef.current?.click()
  }

  const removeImage = () => {
    const img = imageControl?.node
    if (!img) return

    const parent = img.parentElement
    if (parent?.tagName === 'FIGURE') {
      parent.remove()
    } else {
      img.remove()
    }

    setImageControl(null)
    selectedImageRef.current = null
    handleInput()
  }

  const startImageResize = (event) => {
    event.preventDefault()
    event.stopPropagation()

    const img = imageControl?.node
    if (!img) return

    resizeRef.current = {
      img,
      startY: event.clientY,
      startHeight: img.getBoundingClientRect().height,
    }

    document.body.style.cursor = 'ns-resize'

    const handleMove = (moveEvent) => {
      const resize = resizeRef.current
      if (!resize?.img) return

      const nextHeight = Math.max(120, Math.round(resize.startHeight + moveEvent.clientY - resize.startY))
      resize.img.style.width = '100%'
      resize.img.style.maxWidth = '100%'
      resize.img.style.height = `${nextHeight}px`
      resize.img.style.objectFit = 'cover'
      resize.img.style.display = 'block'
      updateImageControl(resize.img)
    }

    const handleUp = () => {
      const resize = resizeRef.current
      window.removeEventListener('mousemove', handleMove)
      window.removeEventListener('mouseup', handleUp)
      document.body.style.cursor = ''
      resizeRef.current = null

      if (resize?.img) {
        updateImageControl(resize.img)
        handleInput()
      }
    }

    window.addEventListener('mousemove', handleMove)
    window.addEventListener('mouseup', handleUp)
  }

  return (
    <div className="mt-1 overflow-visible rounded-xl border border-gray-200 bg-white">
      <style>{KOCHLIK_BLOG_EDITOR_CSS}</style>
      {/* Toolbar */}
      <div className="sticky top-[73px] z-30 flex flex-wrap items-center justify-between gap-1 rounded-t-xl border-b border-gray-150 bg-gray-50/95 p-2 shadow-sm backdrop-blur">
        <div className="flex flex-wrap gap-1 items-center">
          {!isSourceView && (
            <>
              <button
                type="button"
                onClick={() => execCmd('bold')}
                className="inline-flex h-8 w-8 items-center justify-center rounded text-gray-700 transition hover:bg-gray-200"
                title="Tučné"
              >
                <BoldIcon className="h-4 w-4" />
              </button>
              <button
                type="button"
                onClick={() => execCmd('italic')}
                className="inline-flex h-8 w-8 items-center justify-center rounded text-gray-700 transition hover:bg-gray-200"
                title="Kurzíva"
              >
                <ItalicIcon className="h-4 w-4" />
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
                className="inline-flex h-8 w-8 items-center justify-center rounded text-gray-700 transition hover:bg-gray-200"
                title="Odrážky"
              >
                <ListBulletIcon className="h-4 w-4" />
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
                <LinkIcon className="h-4 w-4" />
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
                onMouseDown={saveSelection}
                onClick={() => imageInputRef.current?.click()}
                className="inline-flex h-8 items-center gap-1 rounded px-2 text-xs font-bold text-gray-700 transition hover:bg-gray-200 disabled:opacity-50"
                title="Vložiť obrázok"
                disabled={uploadingInlineImage}
              >
                <PhotoIcon className="h-4 w-4" />
                {uploadingInlineImage ? 'Nahrávam' : 'Obrázok'}
              </button>
              <input
                ref={imageInputRef}
                type="file"
                accept="image/*"
                className="hidden"
                onChange={handleInlineImageUpload}
              />
              <input
                ref={replaceImageInputRef}
                type="file"
                accept="image/*"
                className="hidden"
                onChange={handleReplaceImageUpload}
              />
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
          className="inline-flex items-center gap-1 rounded bg-gray-100 px-2 py-1 text-xs font-bold text-gray-800 transition hover:bg-gray-200"
        >
          <CodeBracketIcon className="h-4 w-4" />
          {isSourceView ? 'Editor' : 'HTML'}
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
        <div className="kochlik-site-preview bg-white">
          <div className="kochlik-preview-header" aria-hidden="true">
            <div className="kochlik-preview-topbar">
              <div className="kochlik-preview-container kochlik-preview-topbar-inner">
                <span>+421 905 587 986</span>
                <span>kochlik@kochlik.sk</span>
                <span>Ulica 29. augusta 28, 811 09 Bratislava</span>
              </div>
            </div>
            <div className="kochlik-preview-container kochlik-preview-nav">
              <img src={resolveImage('/legacy/logo.svg')} alt="KOCHLIK" className="kochlik-preview-logo" />
              <div className="kochlik-preview-links">
                <span>Pre koho</span>
                <span>O nás</span>
                <span>Blog</span>
                <span>FAQ</span>
                <span>Kontakt</span>
                <span className="kochlik-preview-search">Hľadať</span>
                <span className="kochlik-preview-project">Môj projekt</span>
              </div>
            </div>
          </div>

          <div className="kochlik-preview-categorybar" aria-hidden="true">
            <div className="kochlik-preview-container">
              <div className="kochlik-preview-categories">
                <span>Dizajnové</span>
                <span>Moderné</span>
                <span>Klasické</span>
                <span>Svietiace</span>
                <span>Nábytok</span>
                <span>Doplnky</span>
              </div>
            </div>
          </div>

          <div className="kochlik-blog-preview bg-white">
            <article className="kochlik-blog-article">
              <h1 className="kochlik-blog-title">
                {title || 'Názov článku'}
              </h1>

              {excerpt && (
                <p className="kochlik-blog-excerpt">
                  {excerpt}
                </p>
              )}

              <div className="kochlik-blog-meta">
                <span className="kochlik-blog-meta-line" />
                <span>{dateLabel || 'Nezverejnené'}</span>
              </div>

            <div className="relative" onMouseLeave={() => {
              if (!resizeRef.current) setImageControl(null)
            }}>
                <div
                  ref={editorRef}
                  contentEditable
                  onInput={handleInput}
                  onBlur={saveSelection}
                  onKeyUp={saveSelection}
                  onMouseUp={saveSelection}
                  onMouseOver={handleEditorMouseOver}
                  onClick={handleEditorClick}
                  className="kochlik-blog-content min-h-[420px] outline-none"
                  data-placeholder="Začnite písať obsah článku..."
                />
              {imageControl && (
                <>
                  <button
                    type="button"
                    onMouseEnter={() => updateImageControl(imageControl.node)}
                    onClick={removeImage}
                    className="absolute z-20 inline-flex h-8 items-center justify-center gap-1 rounded-full bg-white/95 px-3 text-xs font-bold text-red-600 opacity-95 shadow-lg ring-1 ring-black/10 transition hover:bg-red-600 hover:text-white"
                    style={{ top: imageControl.top, left: imageControl.left }}
                    title="Vymazať obrázok"
                  >
                    <XMarkIcon className="h-4 w-4" />
                    Vymazať
                  </button>
                  <button
                    type="button"
                    onMouseDown={startImageResize}
                    className="absolute z-20 inline-flex h-6 min-w-16 cursor-ns-resize items-center justify-center rounded-full bg-white/95 px-2 text-[10px] font-bold text-gray-700 shadow-lg ring-1 ring-black/10 transition hover:bg-emerald-600 hover:text-white"
                    style={{ top: imageControl.handleTop, left: imageControl.handleLeft }}
                    title="Potiahnite pre zmenu výšky obrázka"
                  >
                    Ťahať výšku · {imageControl.height}px
                  </button>
                </>
              )}
              </div>
            </article>
          </div>

          <footer className="kochlik-preview-footer" aria-hidden="true">
            <div className="kochlik-preview-container kochlik-preview-footer-grid">
              <div>
                <h3>Kontakt</h3>
                <p>Ulica 29. augusta 28</p>
                <p>811 09 Bratislava</p>
                <p>+421 905 587 986</p>
                <p>kochlik@kochlik.sk</p>
              </div>
              <div>
                <h3>Otváracie hodiny</h3>
                <p>Na objednávku nakoľko pracujeme aj v teréne</p>
                <p>Stretnutie v predajni si prosím dohodnite telefonicky.</p>
              </div>
              <div>
                <h3>Kategórie</h3>
                <p>Dizajnové kvetináče</p>
                <p>Moderné kvetináče</p>
                <p>Klasické kvetináče</p>
                <p>Svietiace kvetináče</p>
                <p>Nábytok</p>
                <p>Doplnky</p>
              </div>
              <div>
                <h3>Právne</h3>
                <p>Ochrana osobných údajov</p>
                <p>Všeobecné obchodné podmienky</p>
                <p>Cookies</p>
              </div>
            </div>
            <div className="kochlik-preview-container kochlik-preview-footer-bottom">
              <p>© 2026 KOCHLIK s.r.o.</p>
              <p>Tvorba webu - AEB Digital</p>
            </div>
          </footer>
        </div>
      )}
    </div>
  )
}

const KOCHLIK_BLOG_EDITOR_CSS = `
@import url('https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;700;800&display=swap');

.kochlik-blog-preview {
  --color-brand: #88b23f;
  --color-brand-dark: #6f9431;
  --color-brown: #331f1e;
  color: rgb(45, 45, 45);
  font-family: 'Montserrat', ui-sans-serif, system-ui, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

.kochlik-site-preview {
  --color-brand: #88b23f;
  --color-brand-dark: #6f9431;
  --color-brown: #331f1e;
  color: rgb(45, 45, 45);
  font-family: 'Montserrat', ui-sans-serif, system-ui, sans-serif;
}

.kochlik-preview-container {
  width: min(85vw, 1440px);
  max-width: min(85vw, 1440px);
  margin-inline: auto;
}

.kochlik-preview-header,
.kochlik-preview-categorybar,
.kochlik-preview-footer {
  pointer-events: none;
  user-select: none;
}

.kochlik-preview-header {
  background: #fff;
  box-shadow: 0 1px 0 rgba(0, 0, 0, 0.06);
}

.kochlik-preview-topbar {
  border-bottom: 1px solid #eee;
  background: #ebe9e9;
  color: #555;
  font-size: 13px;
}

.kochlik-preview-topbar-inner {
  display: flex;
  min-height: 2rem;
  align-items: center;
  justify-content: space-between;
  gap: 1rem;
}

.kochlik-preview-nav {
  display: flex;
  min-height: 5rem;
  align-items: center;
  justify-content: space-between;
  gap: 2rem;
}

.kochlik-preview-logo {
  height: 38px;
  width: auto;
}

.kochlik-preview-links {
  display: flex;
  align-items: center;
  gap: 2rem;
  color: #5f5f5f;
  font-size: 17px;
  font-weight: 300;
}

.kochlik-preview-search {
  color: #282828;
}

.kochlik-preview-project {
  background: var(--color-brand);
  color: white;
  font-size: 16px;
  font-weight: 700;
  padding: 0.75rem 1.5rem;
}

.kochlik-preview-categorybar {
  overflow-x: auto;
  background: var(--color-brown);
}

.kochlik-preview-categories {
  display: flex;
  min-width: max-content;
  align-items: center;
  justify-content: center;
  gap: 5rem;
  white-space: nowrap;
}

.kochlik-preview-categories span {
  display: block;
  color: white;
  font-size: 18px;
  font-weight: 800;
  letter-spacing: 0;
  padding: 0.875rem 1.25rem;
  text-transform: uppercase;
}

.kochlik-preview-footer {
  background: var(--color-brown);
  color: rgba(255, 255, 255, 0.8);
  padding: 4rem 0 2rem;
}

.kochlik-preview-footer-grid {
  display: grid;
  grid-template-columns: repeat(4, minmax(0, 1fr));
  gap: 4rem;
}

.kochlik-preview-footer h3 {
  color: #fff;
  font-size: 22px;
  font-weight: 800;
  margin: 0 0 1.5rem;
}

.kochlik-preview-footer p {
  font-size: 16px;
  font-weight: 300;
  line-height: 1.5;
  margin: 0 0 0.75rem;
}

.kochlik-preview-footer-bottom {
  display: flex;
  justify-content: space-between;
  gap: 1rem;
  border-top: 1px solid rgba(255, 255, 255, 0.1);
  margin-top: 3.5rem;
  padding-top: 1.5rem;
  color: rgba(255, 255, 255, 0.5);
}

.kochlik-blog-preview :where(h1, h2, h3, h4, h5, h6, p, a, li, blockquote, figcaption) {
  font-family: 'Montserrat', ui-sans-serif, system-ui, sans-serif;
}

.kochlik-blog-article {
  width: 100%;
  max-width: min(50vw, 900px);
  margin-inline: auto;
  padding: 5rem 0;
}

@media (max-width: 1023px) {
  .kochlik-preview-container {
    width: min(90vw, 1440px);
    max-width: min(90vw, 1440px);
  }

  .kochlik-preview-topbar {
    display: none;
  }

  .kochlik-preview-nav {
    min-height: 5rem;
  }

  .kochlik-preview-links {
    display: none;
  }

  .kochlik-preview-categories {
    justify-content: flex-start;
    gap: 0.75rem;
  }

  .kochlik-preview-categories span {
    font-size: 15px;
    padding-inline: 0.75rem;
  }

  .kochlik-preview-footer-grid {
    grid-template-columns: repeat(2, minmax(0, 1fr));
    gap: 2.5rem;
  }

  .kochlik-preview-footer-bottom {
    flex-direction: column;
  }

  .kochlik-blog-article {
    max-width: 90vw;
    padding-block: 4rem;
  }
}

@media (max-width: 640px) {
  .kochlik-preview-footer-grid {
    grid-template-columns: 1fr;
  }
}

.kochlik-blog-title {
  max-width: 900px;
  margin: 0 0 1.5rem;
  color: var(--color-brown);
  font-family: 'Montserrat', ui-sans-serif, system-ui, sans-serif;
  font-size: clamp(36px, 4vw, 48px);
  font-weight: 800;
  line-height: 1.15;
  letter-spacing: 0;
}

.kochlik-blog-excerpt {
  margin: 0 0 2rem;
  color: #666;
  font-size: 22px;
  font-weight: 300;
  line-height: 1.5;
}

.kochlik-blog-meta {
  display: flex;
  align-items: center;
  gap: 1.25rem;
  margin-bottom: 2.5rem;
  color: #aaa;
  font-size: 15px;
  font-weight: 300;
}

.kochlik-blog-meta-line {
  width: 2.5rem;
  height: 1px;
  background: #dedede;
}

.kochlik-blog-content {
  font-size: 18px;
  font-weight: 300;
  line-height: 1.55;
}

.kochlik-blog-content:empty::before {
  content: attr(data-placeholder);
  color: #b9b9b9;
}

.kochlik-blog-content > * + * {
  margin-top: 1.25em;
}

.kochlik-blog-content p {
  margin: 0;
}

.kochlik-blog-content h2 {
  color: var(--color-brown);
  font-family: 'Montserrat', ui-sans-serif, system-ui, sans-serif;
  font-size: 1.6em;
  font-weight: 800;
  line-height: 1.25;
  margin: 2em 0 0.4em;
}

.kochlik-blog-content h3 {
  color: var(--color-brown);
  font-family: 'Montserrat', ui-sans-serif, system-ui, sans-serif;
  font-size: 1.3em;
  font-weight: 800;
  line-height: 1.3;
  margin: 1.6em 0 0.4em;
}

.kochlik-blog-content :where(h1, h2, h3, h4, h5, h6) :where(b, strong) {
  font-weight: inherit;
}

.kochlik-blog-content a {
  color: var(--color-brand);
  text-decoration: underline;
  text-underline-offset: 3px;
}

.kochlik-blog-content a:hover {
  color: var(--color-brand-dark);
}

.kochlik-blog-content strong {
  color: var(--color-brown);
  font-weight: 700;
}

.kochlik-blog-content ul,
.kochlik-blog-content ol {
  padding-left: 1.5em;
}

.kochlik-blog-content ul { list-style: disc; }
.kochlik-blog-content ol { list-style: decimal; }

.kochlik-blog-content li + li {
  margin-top: 0.4em;
}

.kochlik-blog-content figure {
  width: 100%;
  margin: 2em 0;
}

.kochlik-blog-content img {
  display: block;
  width: 100%;
  max-width: 100%;
  height: auto;
  margin: 2em 0;
  cursor: pointer;
}

.kochlik-blog-content figure img {
  margin: 0;
}

.kochlik-blog-content blockquote {
  border-left: 3px solid var(--color-brand);
  color: #777;
  font-style: italic;
  padding-left: 1.25em;
}

.kochlik-blog-content figcaption {
  color: #999;
  font-size: 0.85em;
  margin-top: 0.5em;
  text-align: center;
}
`
