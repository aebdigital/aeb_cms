import { useEffect, useState } from 'react'
import { useNavigate } from 'react-router-dom'
import {
  PlusIcon,
  PencilIcon,
  TrashIcon,
  EyeIcon,
  DocumentPlusIcon,
} from '@heroicons/react/24/outline'
import { listBlogPosts, deleteBlogPost, togglePublishBlogPost } from '../api/blogs'

const PREVIEW_ORIGIN = 'http://localhost:3006'

export default function BlogsList() {
  const navigate = useNavigate()
  const [posts, setPosts] = useState([])
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState(null)

  useEffect(() => { load() }, [])

  async function load() {
    try {
      setLoading(true)
      setError(null)
      setPosts(await listBlogPosts())
    } catch (err) {
      setError(err.message)
    } finally {
      setLoading(false)
    }
  }

  async function handleDelete(post, e) {
    e.stopPropagation()
    if (!confirm(`Naozaj odstrániť článok "${post.title}"?`)) return
    try {
      await deleteBlogPost(post.id)
      setPosts(prev => prev.filter(p => p.id !== post.id))
    } catch (err) {
      alert('Chyba pri mazaní: ' + err.message)
    }
  }

  async function handleTogglePublish(post, e) {
    e.stopPropagation()
    try {
      const updated = await togglePublishBlogPost(post.id, !post.is_published)
      setPosts(prev => prev.map(p => p.id === post.id ? updated : p))
    } catch (err) {
      alert('Chyba: ' + err.message)
    }
  }

  function handlePreview(post, e) {
    e.stopPropagation()
    const url = `${PREVIEW_ORIGIN}/blog/${post.slug}${post.is_published ? '' : '?preview=1'}`
    window.open(url, '_blank', 'noopener,noreferrer')
  }

  return (
    <div>
      <div className="flex items-center justify-between mb-6">
        <div>
          <h1 className="text-2xl font-bold text-gray-900">Espron blog</h1>
          <p className="text-sm text-gray-500 mt-0.5">
            Píšte články s 1:1 náhľadom podľa dizajnu espron.sk.
          </p>
        </div>
        <button
          onClick={() => navigate('/espron-blog/edit/new')}
          className="flex items-center gap-2 px-4 py-2 bg-gradient-to-r from-indigo-600 to-purple-600 text-white rounded-lg hover:from-indigo-700 hover:to-purple-700 transition-all text-sm shadow-sm"
        >
          <PlusIcon className="h-4 w-4" />
          Nový článok
        </button>
      </div>

      {error && (
        <div className="bg-red-50 border border-red-200 rounded-xl p-4 mb-4 text-sm text-red-700">
          {error}
        </div>
      )}

      {loading ? (
        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-5">
          {[1, 2, 3].map(i => (
            <div key={i} className="aspect-[4/3] bg-white rounded-xl border border-gray-200 animate-pulse" />
          ))}
        </div>
      ) : posts.length === 0 ? (
        <div className="bg-white rounded-xl border-2 border-dashed border-gray-200 p-12 text-center">
          <DocumentPlusIcon className="h-12 w-12 text-gray-300 mx-auto mb-3" />
          <p className="text-gray-500 font-medium">Žiadne články</p>
          <p className="text-gray-400 text-sm mt-1">Kliknite na „Nový článok" pre začatie.</p>
        </div>
      ) : (
        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-5">
          {posts.map(post => (
            <div
              key={post.id}
              onClick={() => navigate(`/espron-blog/edit/${post.id}`)}
              className="group bg-white rounded-xl border border-gray-200 overflow-hidden cursor-pointer hover:border-indigo-300 hover:shadow-lg transition-all flex flex-col"
            >
              <div className="relative aspect-[16/10] bg-gradient-to-br from-indigo-50 to-purple-50 overflow-hidden">
                {post.cover_image ? (
                  <img
                    src={post.cover_image}
                    alt={post.title}
                    className="absolute inset-0 w-full h-full object-cover"
                  />
                ) : (
                  <div className="absolute inset-0 flex items-center justify-center text-gray-300">
                    <DocumentPlusIcon className="h-10 w-10" />
                  </div>
                )}
                <span className="absolute left-3 top-3 rounded-full bg-indigo-600/90 text-white text-[10px] font-semibold uppercase tracking-wider px-2.5 py-1 backdrop-blur-sm">
                  {post.category || 'Blog'}
                </span>
                <div className="absolute inset-0 bg-gradient-to-t from-black/50 via-black/0 to-black/0 opacity-0 group-hover:opacity-100 transition-opacity" />
                <div className="absolute top-2 right-2 flex items-center gap-1 opacity-0 group-hover:opacity-100 transition-opacity">
                  <button
                    onClick={(e) => handlePreview(post, e)}
                    className="p-1.5 bg-white/95 backdrop-blur text-gray-700 hover:text-indigo-600 rounded-lg shadow-sm"
                    title="Otvoriť v novej karte"
                  >
                    <EyeIcon className="h-4 w-4" />
                  </button>
                  <button
                    onClick={(e) => { e.stopPropagation(); navigate(`/espron-blog/edit/${post.id}`) }}
                    className="p-1.5 bg-white/95 backdrop-blur text-gray-700 hover:text-indigo-600 rounded-lg shadow-sm"
                    title="Upraviť"
                  >
                    <PencilIcon className="h-4 w-4" />
                  </button>
                  <button
                    onClick={(e) => handleDelete(post, e)}
                    className="p-1.5 bg-white/95 backdrop-blur text-gray-700 hover:text-red-600 rounded-lg shadow-sm"
                    title="Odstrániť"
                  >
                    <TrashIcon className="h-4 w-4" />
                  </button>
                </div>
              </div>
              <div className="flex items-center justify-between gap-3 px-4 py-3">
                <div className="min-w-0 flex-1">
                  <p className="font-medium text-gray-900 text-sm truncate">{post.title}</p>
                  <p className="text-xs text-gray-400 truncate">/blog/{post.slug}</p>
                </div>
                <button
                  onClick={(e) => handleTogglePublish(post, e)}
                  className={`text-[10px] px-2 py-1 rounded-full font-semibold flex-shrink-0 ${
                    post.is_published
                      ? 'bg-green-100 text-green-700 hover:bg-green-200'
                      : 'bg-gray-100 text-gray-500 hover:bg-gray-200'
                  }`}
                  title={post.is_published ? 'Kliknite na zneplatnenie' : 'Kliknite na publikovanie'}
                >
                  {post.is_published ? 'PUBLIKOVANÝ' : 'DRAFT'}
                </button>
              </div>
            </div>
          ))}
        </div>
      )}
    </div>
  )
}
