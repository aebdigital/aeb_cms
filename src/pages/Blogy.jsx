import { useState } from 'react'
import { PlusIcon, PencilIcon, TrashIcon, EyeIcon } from '@heroicons/react/24/outline'

const blogPosts = [
  {
    id: 1,
    title: 'Moderné webové technológie v roku 2024',
    excerpt: 'Prehľad najnovších trendov a technológií, ktoré formujú budúcnosť webového vývoja.',
    author: 'Admin',
    date: '2024-11-20',
    status: 'published',
    category: 'Technológie',
    previewImage: 'https://images.unsplash.com/photo-1555949963-aa79dcee981c?w=400&h=300&fit=crop'
  },
  {
    id: 2,
    title: 'Optimalizácia výkonu webových stránok',
    excerpt: 'Praktické tipy a triky pre zrýchlenie načítania vašich webových stránok.',
    author: 'Admin',
    date: '2024-11-15',
    status: 'published',
    category: 'SEO',
    previewImage: 'https://images.unsplash.com/photo-1460925895917-afdab827c52f?w=400&h=300&fit=crop'
  },
  {
    id: 3,
    title: 'React vs Vue.js: Ktorý framework vybrať?',
    excerpt: 'Porovnanie dvoch populárnych JavaScript frameworkov a ich výhôd.',
    author: 'Admin',
    date: '2024-11-10',
    status: 'draft',
    category: 'Frontend',
    previewImage: 'https://images.unsplash.com/photo-1593720219276-0b1eacd0aef4?w=400&h=300&fit=crop'
  },
  {
    id: 4,
    title: 'Bezpečnosť webových aplikácií',
    excerpt: 'Základné princípy zabezpečenia webových aplikácií proti kybernetickým útokom.',
    author: 'Admin',
    date: '2024-11-05',
    status: 'published',
    category: 'Bezpečnosť',
    previewImage: 'https://images.unsplash.com/photo-1563986768609-322da13575f3?w=400&h=300&fit=crop'
  },
]

export default function Blogy() {
  const [deleteMode, setDeleteMode] = useState(false)

  return (
    <div>
      <div className="border-b border-gray-200 pb-5 mb-6">
        <div className="flex items-center justify-between">
          <div>
            <h1 className="text-2xl font-bold leading-7 text-gray-900 sm:text-3xl sm:truncate">
              Blog články
            </h1>
            <p className="mt-2 text-sm text-gray-500">
              Spravujte vaše blog príspevky a články
            </p>
          </div>
          <div className="flex items-center space-x-3">
            <button 
              onClick={() => setDeleteMode(!deleteMode)}
              className={`px-4 py-2 rounded-md text-sm font-medium flex items-center transition-colors ${
                deleteMode 
                  ? 'bg-red-600 hover:bg-red-700 text-white' 
                  : 'bg-gray-200 hover:bg-gray-300 text-gray-700'
              }`}
            >
              <TrashIcon className="w-4 h-4 mr-2" />
              {deleteMode ? 'Zrušiť mazanie' : 'Maž režim'}
            </button>
            <button className="bg-indigo-600 hover:bg-indigo-700 text-white px-4 py-2 rounded-md text-sm font-medium flex items-center">
              <PlusIcon className="w-4 h-4 mr-2" />
              Nový článok
            </button>
          </div>
        </div>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        {blogPosts.map((post) => (
          <div key={post.id} className="bg-white rounded-lg shadow-md overflow-hidden hover:shadow-lg transition-shadow">
            <div className="relative">
              <img
                src={post.previewImage}
                alt={post.title}
                className="w-full h-48 object-cover"
              />
              <div className="absolute top-2 right-2 flex space-x-1">
                {deleteMode ? (
                  <button className="p-2 bg-red-600 hover:bg-red-700 text-white rounded-full shadow-md transition-colors">
                    <TrashIcon className="w-4 h-4" />
                  </button>
                ) : (
                  <>
                    <button className="p-2 bg-white hover:bg-gray-50 text-gray-700 rounded-full shadow-md transition-colors">
                      <PencilIcon className="w-4 h-4" />
                    </button>
                    <button className="p-2 bg-white hover:bg-gray-50 text-gray-700 rounded-full shadow-md transition-colors">
                      <EyeIcon className="w-4 h-4" />
                    </button>
                  </>
                )}
              </div>
              <div className="absolute top-2 left-2">
                <span className={`inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium ${
                  post.status === 'published' 
                    ? 'bg-green-100 text-green-800' 
                    : 'bg-yellow-100 text-yellow-800'
                }`}>
                  {post.status === 'published' ? 'Publikovaný' : 'Koncept'}
                </span>
              </div>
            </div>
            <div className="p-6">
              <div className="flex items-center justify-between mb-2">
                <span className="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-gray-100 text-gray-800">
                  {post.category}
                </span>
                <span className="text-xs text-gray-500">
                  {new Date(post.date).toLocaleDateString('sk-SK')}
                </span>
              </div>
              <h3 className="text-lg font-medium text-gray-900 mb-2 line-clamp-2">
                {post.title}
              </h3>
              <p className="text-sm text-gray-600 mb-3 line-clamp-3">
                {post.excerpt}
              </p>
              <div className="flex items-center text-xs text-gray-500">
                <span>Autor: {post.author}</span>
              </div>
            </div>
          </div>
        ))}
      </div>

      <div className="mt-6 flex justify-between items-center">
        <div className="text-sm text-gray-500">
          Zobrazených 4 z 4 článkov
        </div>
        <nav className="flex space-x-2">
          <button className="px-3 py-2 text-sm text-gray-500 hover:text-gray-700">
            Predchádzajúca
          </button>
          <button className="px-3 py-2 text-sm bg-indigo-600 text-white rounded">
            1
          </button>
          <button className="px-3 py-2 text-sm text-gray-500 hover:text-gray-700">
            Ďalšia
          </button>
        </nav>
      </div>
    </div>
  )
}