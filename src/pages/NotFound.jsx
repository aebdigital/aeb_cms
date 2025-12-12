import { Link } from 'react-router-dom'

export default function NotFound() {
  return (
    <div className="min-h-screen flex items-center justify-center bg-gray-50 py-12 px-4 sm:px-6 lg:px-8">
      <div className="max-w-md w-full text-center">
        <h1 className="text-9xl font-black text-gray-200">404</h1>
        <h2 className="mt-4 text-3xl font-bold text-gray-900 tracking-tight">Stránka sa nenašla</h2>
        <p className="mt-2 text-base text-gray-500">Ľutujeme, ale požadovaná stránka neexistuje.</p>
        <div className="mt-6">
          <Link
            to="/"
            className="text-base font-medium text-purple-600 hover:text-purple-500"
          >
            Späť na domovskú stránku <span aria-hidden="true">&rarr;</span>
          </Link>
        </div>
      </div>
    </div>
  )
}
