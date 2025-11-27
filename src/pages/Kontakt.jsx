const messages = [
  {
    id: 1,
    name: 'Ján Novák',
    email: 'jan.novak@email.com',
    subject: 'Otázka ohľadom služieb',
    message: 'Dobrý deň, rád by som sa informoval o vašich službách...',
    date: '2024-11-25',
    status: 'new'
  },
  {
    id: 2,
    name: 'Mária Svobodová',
    email: 'maria.svobodova@email.com',
    subject: 'Technická podpora',
    message: 'Mám problém s načítaním stránky...',
    date: '2024-11-24',
    status: 'responded'
  },
  {
    id: 3,
    name: 'Peter Kováč',
    email: 'peter.kovac@email.com',
    subject: 'Spolupráca',
    message: 'Zaujíma ma možnosť spolupráce na projekte...',
    date: '2024-11-23',
    status: 'new'
  },
]

export default function Kontakt() {
  return (
    <div>
      <div className="border-b border-gray-200 pb-5 mb-6">
        <h1 className="text-2xl font-bold leading-7 text-gray-900 sm:text-3xl sm:truncate">
          Kontaktné správy
        </h1>
        <p className="mt-2 text-sm text-gray-500">
          Spravujte prichádzajúce správy od návštevníkov
        </p>
      </div>

      <div className="mb-6">
        <div className="grid grid-cols-1 gap-4 sm:grid-cols-3">
          <div className="bg-white overflow-hidden shadow rounded-lg">
            <div className="p-5">
              <div className="flex items-center">
                <div className="flex-shrink-0">
                  <div className="w-8 h-8 bg-blue-500 rounded-md flex items-center justify-center">
                    <span className="text-white text-sm font-medium">📧</span>
                  </div>
                </div>
                <div className="ml-5 w-0 flex-1">
                  <dl>
                    <dt className="text-sm font-medium text-gray-500 truncate">Celkové správy</dt>
                    <dd className="text-lg font-medium text-gray-900">{messages.length}</dd>
                  </dl>
                </div>
              </div>
            </div>
          </div>

          <div className="bg-white overflow-hidden shadow rounded-lg">
            <div className="p-5">
              <div className="flex items-center">
                <div className="flex-shrink-0">
                  <div className="w-8 h-8 bg-yellow-500 rounded-md flex items-center justify-center">
                    <span className="text-white text-sm font-medium">⏳</span>
                  </div>
                </div>
                <div className="ml-5 w-0 flex-1">
                  <dl>
                    <dt className="text-sm font-medium text-gray-500 truncate">Nové správy</dt>
                    <dd className="text-lg font-medium text-gray-900">{messages.filter(m => m.status === 'new').length}</dd>
                  </dl>
                </div>
              </div>
            </div>
          </div>

          <div className="bg-white overflow-hidden shadow rounded-lg">
            <div className="p-5">
              <div className="flex items-center">
                <div className="flex-shrink-0">
                  <div className="w-8 h-8 bg-green-500 rounded-md flex items-center justify-center">
                    <span className="text-white text-sm font-medium">✅</span>
                  </div>
                </div>
                <div className="ml-5 w-0 flex-1">
                  <dl>
                    <dt className="text-sm font-medium text-gray-500 truncate">Zodpovedané</dt>
                    <dd className="text-lg font-medium text-gray-900">{messages.filter(m => m.status === 'responded').length}</dd>
                  </dl>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

      <div className="bg-white shadow overflow-hidden sm:rounded-md">
        <ul className="divide-y divide-gray-200">
          {messages.map((message) => (
            <li key={message.id}>
              <div className="px-4 py-4 hover:bg-gray-50">
                <div className="flex items-center justify-between">
                  <div className="flex items-center">
                    <div className="flex-shrink-0">
                      <span className={`inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium ${
                        message.status === 'new' 
                          ? 'bg-yellow-100 text-yellow-800' 
                          : 'bg-green-100 text-green-800'
                      }`}>
                        {message.status === 'new' ? 'Nová' : 'Zodpovedaná'}
                      </span>
                    </div>
                    <div className="ml-4 flex-1 min-w-0">
                      <div className="flex items-center justify-between">
                        <p className="text-sm font-medium text-gray-900">
                          {message.name}
                        </p>
                        <div className="ml-2 flex-shrink-0">
                          <p className="text-sm text-gray-500">{new Date(message.date).toLocaleDateString('sk-SK')}</p>
                        </div>
                      </div>
                      <p className="text-sm text-gray-500">{message.email}</p>
                      <p className="text-sm font-medium text-gray-900 mt-1">{message.subject}</p>
                      <p className="text-sm text-gray-500 mt-1 line-clamp-2">{message.message}</p>
                    </div>
                  </div>
                  <div className="flex flex-col space-y-2 ml-4">
                    <button className="text-indigo-600 hover:text-indigo-900 text-sm">
                      Zobraziť
                    </button>
                    <button className="text-green-600 hover:text-green-900 text-sm">
                      Odpovedať
                    </button>
                    <button className="text-red-600 hover:text-red-900 text-sm">
                      Zmazať
                    </button>
                  </div>
                </div>
              </div>
            </li>
          ))}
        </ul>
      </div>

      <div className="mt-6 flex justify-between items-center">
        <div className="text-sm text-gray-500">
          Zobrazených {messages.length} z {messages.length} správ
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