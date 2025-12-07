import { Fragment } from 'react'
import { useAuth } from '../contexts/AuthContext'
import { ChevronDownIcon, BuildingOfficeIcon } from '@heroicons/react/24/outline'

export default function SiteSelector() {
  const { memberships, currentSite, selectSite } = useAuth()

  if (!memberships || memberships.length === 0) {
    return null
  }

  // If only one site, just show the name
  if (memberships.length === 1) {
    return (
      <div className="flex items-center px-4 py-2 bg-white/10 rounded-lg">
        <BuildingOfficeIcon className="h-5 w-5 text-purple-300 mr-2" />
        <span className="text-white font-medium">{currentSite?.name}</span>
      </div>
    )
  }

  return (
    <div className="relative group">
      <button className="flex items-center px-4 py-2 bg-white/10 hover:bg-white/20 rounded-lg transition-colors">
        <BuildingOfficeIcon className="h-5 w-5 text-purple-300 mr-2" />
        <span className="text-white font-medium">{currentSite?.name || 'Vyberte stranku'}</span>
        <ChevronDownIcon className="h-4 w-4 text-gray-300 ml-2" />
      </button>

      {/* Dropdown */}
      <div className="absolute top-full left-0 mt-2 w-64 bg-white rounded-lg shadow-xl opacity-0 invisible group-hover:opacity-100 group-hover:visible transition-all z-50">
        <div className="py-2">
          {memberships.map((membership) => (
            <button
              key={membership.sites.id}
              onClick={() => selectSite(membership.sites)}
              className={`w-full px-4 py-3 text-left hover:bg-gray-50 transition-colors ${
                currentSite?.id === membership.sites.id ? 'bg-purple-50' : ''
              }`}
            >
              <div className="flex items-center justify-between">
                <div>
                  <p className="font-medium text-gray-900">{membership.sites.name}</p>
                  <p className="text-sm text-gray-500">{membership.sites.domain || membership.sites.slug}</p>
                </div>
                <span className="text-xs px-2 py-1 bg-gray-100 text-gray-600 rounded-full">
                  {membership.role}
                </span>
              </div>
            </button>
          ))}
        </div>
      </div>
    </div>
  )
}
