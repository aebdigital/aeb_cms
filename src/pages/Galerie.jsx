import { useState } from 'react'

const galleryImages = [
  { id: 1, src: 'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=300&h=200&fit=crop', alt: 'Mountain landscape', title: 'Krásne hory' },
  { id: 2, src: 'https://images.unsplash.com/photo-1506197603052-3cc9c3a201bd?w=300&h=200&fit=crop', alt: 'Ocean view', title: 'Oceánsky výhľad' },
  { id: 3, src: 'https://images.unsplash.com/photo-1518837695005-2083093ee35b?w=300&h=200&fit=crop', alt: 'Forest path', title: 'Lesná cesta' },
  { id: 4, src: 'https://images.unsplash.com/photo-1511593358241-7eea1f3c84e5?w=300&h=200&fit=crop', alt: 'Desert sunset', title: 'Západ slnka v púšti' },
  { id: 5, src: 'https://images.unsplash.com/photo-1469474968028-56623f02e42e?w=300&h=200&fit=crop', alt: 'Lake reflection', title: 'Odraz na jazere' },
  { id: 6, src: 'https://images.unsplash.com/photo-1441974231531-c6227db76b6e?w=300&h=200&fit=crop', alt: 'Forest trees', title: 'Lesné stromy' },
]

export default function Galerie() {
  const [selectedImage, setSelectedImage] = useState(null)

  return (
    <div>
      <div className="border-b border-gray-200 pb-5 mb-6">
        <div className="flex items-center justify-between">
          <div>
            <h1 className="text-2xl font-bold leading-7 text-gray-900 sm:text-3xl sm:truncate">
              Galéria
            </h1>
            <p className="mt-2 text-sm text-gray-500">
              Spravujte obrázky vo vašej galérii
            </p>
          </div>
          <button className="bg-indigo-600 hover:bg-indigo-700 text-white px-4 py-2 rounded-md text-sm font-medium">
            Pridať obrázok
          </button>
        </div>
      </div>

      <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-4">
        {galleryImages.map((image) => (
          <div key={image.id} className="bg-white rounded-lg shadow overflow-hidden hover:shadow-lg transition-shadow">
            <div className="aspect-w-16 aspect-h-10">
              <img
                src={image.src}
                alt={image.alt}
                className="w-full h-48 object-cover cursor-pointer"
                onClick={() => setSelectedImage(image)}
              />
            </div>
            <div className="p-4">
              <h3 className="text-sm font-medium text-gray-900">{image.title}</h3>
              <div className="mt-2 flex space-x-2">
                <button className="text-indigo-600 hover:text-indigo-900 text-xs">Upraviť</button>
                <button className="text-red-600 hover:text-red-900 text-xs">Zmazať</button>
              </div>
            </div>
          </div>
        ))}
      </div>

      {/* Modal for image preview */}
      {selectedImage && (
        <div className="fixed inset-0 z-50 overflow-y-auto" aria-labelledby="modal-title" role="dialog" aria-modal="true">
          <div className="flex items-end justify-center min-h-screen pt-4 px-4 pb-20 text-center sm:block sm:p-0">
            <div className="fixed inset-0 bg-gray-500 bg-opacity-75 transition-opacity" onClick={() => setSelectedImage(null)}></div>
            <span className="hidden sm:inline-block sm:align-middle sm:h-screen">&#8203;</span>
            <div className="inline-block align-bottom bg-white rounded-lg px-4 pt-5 pb-4 text-left overflow-hidden shadow-xl transform transition-all sm:my-8 sm:align-middle sm:max-w-lg sm:w-full sm:p-6">
              <div>
                <div className="mt-3 text-center sm:mt-5">
                  <h3 className="text-lg leading-6 font-medium text-gray-900" id="modal-title">
                    {selectedImage.title}
                  </h3>
                  <div className="mt-4">
                    <img
                      src={selectedImage.src}
                      alt={selectedImage.alt}
                      className="w-full rounded-lg"
                    />
                  </div>
                </div>
              </div>
              <div className="mt-5 sm:mt-6">
                <button
                  type="button"
                  className="inline-flex justify-center w-full rounded-md border border-transparent shadow-sm px-4 py-2 bg-indigo-600 text-base font-medium text-white hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500 sm:text-sm"
                  onClick={() => setSelectedImage(null)}
                >
                  Zavrieť
                </button>
              </div>
            </div>
          </div>
        </div>
      )}
    </div>
  )
}