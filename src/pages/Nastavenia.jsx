import { useState } from 'react'

export default function Nastavenia() {
  const [settings, setSettings] = useState({
    siteName: 'Moja webová stránka',
    siteDescription: 'Moderná webová stránka s CMS',
    adminEmail: 'admin@example.com',
    enableComments: true,
    enableRegistration: false,
    maintenanceMode: false,
    language: 'sk',
    timezone: 'Europe/Bratislava'
  })

  const handleChange = (field, value) => {
    setSettings(prev => ({ ...prev, [field]: value }))
  }

  const handleSave = () => {
    console.log('Uloženie nastavení:', settings)
    alert('Nastavenia boli úspešne uložené!')
  }

  return (
    <div>
      <div className="border-b border-gray-200 pb-5 mb-6">
        <h1 className="text-2xl font-bold leading-7 text-gray-900 sm:text-3xl sm:truncate">
          Nastavenia
        </h1>
        <p className="mt-2 text-sm text-gray-500">
          Upravte základné nastavenia vašej webové stránky
        </p>
      </div>

      <div className="space-y-6">
        {/* Základné nastavenia */}
        <div className="bg-white shadow px-4 py-5 sm:rounded-lg sm:p-6">
          <div className="md:grid md:grid-cols-3 md:gap-6">
            <div className="md:col-span-1">
              <h3 className="text-lg font-medium leading-6 text-gray-900">Základné informácie</h3>
              <p className="mt-1 text-sm text-gray-500">
                Základné nastavenia vašej webovej stránky
              </p>
            </div>
            <div className="mt-5 md:mt-0 md:col-span-2">
              <div className="grid grid-cols-6 gap-6">
                <div className="col-span-6">
                  <label className="block text-sm font-medium text-gray-700">
                    Názov stránky
                  </label>
                  <input
                    type="text"
                    value={settings.siteName}
                    onChange={(e) => handleChange('siteName', e.target.value)}
                    className="mt-1 focus:ring-indigo-500 focus:border-indigo-500 block w-full shadow-sm sm:text-sm border-gray-300 rounded-md"
                  />
                </div>

                <div className="col-span-6">
                  <label className="block text-sm font-medium text-gray-700">
                    Popis stránky
                  </label>
                  <textarea
                    rows={3}
                    value={settings.siteDescription}
                    onChange={(e) => handleChange('siteDescription', e.target.value)}
                    className="mt-1 focus:ring-indigo-500 focus:border-indigo-500 block w-full shadow-sm sm:text-sm border-gray-300 rounded-md"
                  />
                </div>

                <div className="col-span-6 sm:col-span-3">
                  <label className="block text-sm font-medium text-gray-700">
                    Admin email
                  </label>
                  <input
                    type="email"
                    value={settings.adminEmail}
                    onChange={(e) => handleChange('adminEmail', e.target.value)}
                    className="mt-1 focus:ring-indigo-500 focus:border-indigo-500 block w-full shadow-sm sm:text-sm border-gray-300 rounded-md"
                  />
                </div>

                <div className="col-span-6 sm:col-span-3">
                  <label className="block text-sm font-medium text-gray-700">
                    Jazyk
                  </label>
                  <select
                    value={settings.language}
                    onChange={(e) => handleChange('language', e.target.value)}
                    className="mt-1 block w-full py-2 px-3 border border-gray-300 bg-white rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm"
                  >
                    <option value="sk">Slovenčina</option>
                    <option value="cs">Čeština</option>
                    <option value="en">English</option>
                  </select>
                </div>
              </div>
            </div>
          </div>
        </div>

        {/* Funkcionality */}
        <div className="bg-white shadow px-4 py-5 sm:rounded-lg sm:p-6">
          <div className="md:grid md:grid-cols-3 md:gap-6">
            <div className="md:col-span-1">
              <h3 className="text-lg font-medium leading-6 text-gray-900">Funkcionality</h3>
              <p className="mt-1 text-sm text-gray-500">
                Zapnite alebo vypnite rôzne funkcie stránky
              </p>
            </div>
            <div className="mt-5 md:mt-0 md:col-span-2">
              <div className="space-y-6">
                <div className="flex items-start">
                  <div className="flex items-center h-5">
                    <input
                      type="checkbox"
                      checked={settings.enableComments}
                      onChange={(e) => handleChange('enableComments', e.target.checked)}
                      className="focus:ring-indigo-500 h-4 w-4 text-indigo-600 border-gray-300 rounded"
                    />
                  </div>
                  <div className="ml-3 text-sm">
                    <label className="font-medium text-gray-700">
                      Povoliť komentáre
                    </label>
                    <p className="text-gray-500">Návštevníci môžu pridávať komentáre k článkom</p>
                  </div>
                </div>

                <div className="flex items-start">
                  <div className="flex items-center h-5">
                    <input
                      type="checkbox"
                      checked={settings.enableRegistration}
                      onChange={(e) => handleChange('enableRegistration', e.target.checked)}
                      className="focus:ring-indigo-500 h-4 w-4 text-indigo-600 border-gray-300 rounded"
                    />
                  </div>
                  <div className="ml-3 text-sm">
                    <label className="font-medium text-gray-700">
                      Povoliť registráciu
                    </label>
                    <p className="text-gray-500">Noví používatelia sa môžu registrovať</p>
                  </div>
                </div>

                <div className="flex items-start">
                  <div className="flex items-center h-5">
                    <input
                      type="checkbox"
                      checked={settings.maintenanceMode}
                      onChange={(e) => handleChange('maintenanceMode', e.target.checked)}
                      className="focus:ring-indigo-500 h-4 w-4 text-indigo-600 border-gray-300 rounded"
                    />
                  </div>
                  <div className="ml-3 text-sm">
                    <label className="font-medium text-gray-700">
                      Režim údržby
                    </label>
                    <p className="text-gray-500">Stránka bude nedostupná pre návštevníkov</p>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>

        {/* Uloženie */}
        <div className="flex justify-end">
          <button
            type="button"
            className="bg-white py-2 px-4 border border-gray-300 rounded-md shadow-sm text-sm font-medium text-gray-700 hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500"
          >
            Zrušiť
          </button>
          <button
            type="button"
            onClick={handleSave}
            className="ml-3 inline-flex justify-center py-2 px-4 border border-transparent shadow-sm text-sm font-medium rounded-md text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500"
          >
            Uložiť nastavenia
          </button>
        </div>
      </div>
    </div>
  )
}