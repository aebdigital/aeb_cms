import { useState } from 'react'
import { EnvelopeIcon, ClockIcon, CheckCircleIcon, ChevronDownIcon, ChevronUpIcon } from '@heroicons/react/24/outline'

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
  const [expandedMessage, setExpandedMessage] = useState(null)

  const toggleMessage = (messageId) => {
    setExpandedMessage(expandedMessage === messageId ? null : messageId)
  }

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
          <div className="bg-white overflow-hidden shadow-lg rounded-xl border border-gray-100">
            <div className="p-6">
              <div className="flex items-center">
                <div className="flex-shrink-0">
                  <div className="w-12 h-12 bg-gradient-to-r from-blue-500 to-indigo-600 rounded-xl flex items-center justify-center shadow-lg">
                    <EnvelopeIcon className="w-6 h-6 text-white" />
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

          <div className="bg-white overflow-hidden shadow-lg rounded-xl border border-gray-100">
            <div className="p-6">
              <div className="flex items-center">
                <div className="flex-shrink-0">
                  <div className="w-12 h-12 bg-gradient-to-r from-amber-500 to-yellow-600 rounded-xl flex items-center justify-center shadow-lg">
                    <ClockIcon className="w-6 h-6 text-white" />
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

          <div className="bg-white overflow-hidden shadow-lg rounded-xl border border-gray-100">
            <div className="p-6">
              <div className="flex items-center">
                <div className="flex-shrink-0">
                  <div className="w-12 h-12 bg-gradient-to-r from-emerald-500 to-green-600 rounded-xl flex items-center justify-center shadow-lg">
                    <CheckCircleIcon className="w-6 h-6 text-white" />
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

      <div className="bg-white shadow-lg overflow-hidden rounded-xl border border-gray-100">
        <div className="space-y-3">
          {messages.map((message) => (
            <div key={message.id} className="bg-white border border-gray-200 rounded-lg shadow-sm">
              <div 
                className="px-6 py-4 cursor-pointer hover:bg-gray-50 transition-colors"
                onClick={() => toggleMessage(message.id)}
              >
                <div className="flex items-center justify-between">
                  <div className="flex items-center space-x-4">
                    <span className={`inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium ${
                      message.status === 'new' 
                        ? 'bg-yellow-100 text-yellow-800' 
                        : 'bg-green-100 text-green-800'
                    }`}>
                      {message.status === 'new' ? 'Nová' : 'Zodpovedaná'}
                    </span>
                    <div>
                      <p className="text-sm font-medium text-gray-900">
                        {message.name} ({message.email})
                      </p>
                      <p className="text-sm text-gray-500">
                        {message.subject}
                      </p>
                    </div>
                  </div>
                  <div className="flex items-center space-x-3">
                    <span className="text-sm text-gray-500">
                      {new Date(message.date).toLocaleDateString('sk-SK')}
                    </span>
                    <button className="text-red-600 hover:text-red-900 text-sm">
                      Zmazať
                    </button>
                    {expandedMessage === message.id ? (
                      <ChevronUpIcon className="w-5 h-5 text-gray-400" />
                    ) : (
                      <ChevronDownIcon className="w-5 h-5 text-gray-400" />
                    )}
                  </div>
                </div>
              </div>
              
              {expandedMessage === message.id && (
                <div className="px-6 py-4 border-t border-gray-200 bg-gray-50">
                  <div className="space-y-3">
                    <div>
                      <label className="block text-sm font-medium text-gray-700">Odosielateľ</label>
                      <p className="mt-1 text-sm text-gray-900">{message.name} ({message.email})</p>
                    </div>
                    <div>
                      <label className="block text-sm font-medium text-gray-700">Predmet</label>
                      <p className="mt-1 text-sm text-gray-900">{message.subject}</p>
                    </div>
                    <div>
                      <label className="block text-sm font-medium text-gray-700">Dátum</label>
                      <p className="mt-1 text-sm text-gray-900">{new Date(message.date).toLocaleDateString('sk-SK')}</p>
                    </div>
                    <div>
                      <label className="block text-sm font-medium text-gray-700">Správa</label>
                      <div className="mt-1 p-3 bg-white border border-gray-200 rounded-md">
                        <p className="text-sm text-gray-900 whitespace-pre-wrap">{message.message}</p>
                      </div>
                    </div>
                    <div>
                      <label className="block text-sm font-medium text-gray-700">Stav</label>
                      <p className="mt-1">
                        <span className={`inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium ${
                          message.status === 'new' 
                            ? 'bg-yellow-100 text-yellow-800' 
                            : 'bg-green-100 text-green-800'
                        }`}>
                          {message.status === 'new' ? 'Nová správa' : 'Zodpovedaná správa'}
                        </span>
                      </p>
                    </div>
                  </div>
                </div>
              )}
            </div>
          ))}
        </div>
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