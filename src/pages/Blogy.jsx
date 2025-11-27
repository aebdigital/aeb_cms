const blogPosts = [
  {
    id: 1,
    title: 'Moderné webové technológie v roku 2024',
    excerpt: 'Prehľad najnovších trendov a technológií, ktoré formujú budúcnosť webového vývoja.',
    author: 'Admin',
    date: '2024-11-20',
    status: 'published',
    category: 'Technológie'
  },
  {
    id: 2,
    title: 'Optimalizácia výkonu webových stránok',
    excerpt: 'Praktické tipy a triky pre zrýchlenie načítania vašich webových stránok.',
    author: 'Admin',
    date: '2024-11-15',
    status: 'published',
    category: 'SEO'
  },
  {
    id: 3,
    title: 'React vs Vue.js: Ktorý framework vybrať?',
    excerpt: 'Porovnanie dvoch populárnych JavaScript frameworkov a ich výhod.',
    author: 'Admin',
    date: '2024-11-10',
    status: 'draft',
    category: 'Frontend'
  },
  {
    id: 4,
    title: 'Bezpečnosť webových aplikácií',
    excerpt: 'Základné princípy zabezpečenia webových aplikácií proti kybernetickým útokom.',
    author: 'Admin',
    date: '2024-11-05',
    status: 'published',
    category: 'Bezpečnosť'
  },
]

export default function Blogy() {
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
          <button className="bg-indigo-600 hover:bg-indigo-700 text-white px-4 py-2 rounded-md text-sm font-medium">
            Nový článok
          </button>
        </div>
      </div>

      <div className="bg-white shadow overflow-hidden sm:rounded-md">
        <ul className="divide-y divide-gray-200">
          {blogPosts.map((post) => (
            <li key={post.id}>
              <div className="px-4 py-4 flex items-center justify-between hover:bg-gray-50">
                <div className="flex items-center">
                  <div className="flex-shrink-0">
                    <span className={`inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium ${
                      post.status === 'published' 
                        ? 'bg-green-100 text-green-800' 
                        : 'bg-yellow-100 text-yellow-800'
                    }`}>
                      {post.status === 'published' ? 'Publikovaný' : 'Koncept'}
                    </span>
                  </div>
                  <div className="ml-4 flex-1 min-w-0">
                    <div className="flex items-center justify-between">
                      <p className="text-sm font-medium text-indigo-600 truncate">
                        {post.title}
                      </p>
                      <div className="ml-2 flex-shrink-0 flex">
                        <span className="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-gray-100 text-gray-800">
                          {post.category}
                        </span>
                      </div>
                    </div>
                    <p className="text-sm text-gray-500 mt-1">
                      {post.excerpt}
                    </p>
                    <div className="flex items-center text-sm text-gray-500 mt-2">
                      <span>{post.author}</span>
                      <span className="mx-2">•</span>
                      <span>{new Date(post.date).toLocaleDateString('sk-SK')}</span>
                    </div>
                  </div>
                </div>
                <div className="flex space-x-2">
                  <button className="text-indigo-600 hover:text-indigo-900 text-sm">
                    Upraviť
                  </button>
                  <button className="text-gray-600 hover:text-gray-900 text-sm">
                    Náhľad
                  </button>
                  <button className="text-red-600 hover:text-red-900 text-sm">
                    Zmazať
                  </button>
                </div>
              </div>
            </li>
          ))}
        </ul>
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