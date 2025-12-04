import { useState } from 'react'
import { PlusIcon, XMarkIcon, PencilIcon, TrashIcon } from '@heroicons/react/24/outline'

const categories = ['Všetky', 'Príroda', 'Architektura', 'Ľudia', 'Zvieratá', 'Ostatné']

const galleryImages = [
  { id: 1, src: 'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=300&h=200&fit=crop', alt: 'Mountain landscape', title: 'Krásne hory', category: 'Príroda' },
  { id: 2, src: 'https://images.unsplash.com/photo-1506197603052-3cc9c3a201bd?w=300&h=200&fit=crop', alt: 'Ocean view', title: 'Oceánsky výhľad', category: 'Príroda' },
  { id: 3, src: 'https://images.unsplash.com/photo-1518837695005-2083093ee35b?w=300&h=200&fit=crop', alt: 'Forest path', title: 'Lesná cesta', category: 'Príroda' },
  { id: 4, src: 'https://images.unsplash.com/photo-1511593358241-7eea1f3c84e5?w=300&h=200&fit=crop', alt: 'Desert sunset', title: 'Západ slnka v púšti', category: 'Príroda' },
  { id: 5, src: 'https://images.unsplash.com/photo-1469474968028-56623f02e42e?w=300&h=200&fit=crop', alt: 'Lake reflection', title: 'Odraz na jazere', category: 'Príroda' },
  { id: 6, src: 'https://images.unsplash.com/photo-1441974231531-c6227db76b6e?w=300&h=200&fit=crop', alt: 'Forest trees', title: 'Lesné stromy', category: 'Príroda' },
]

export default function Galerie() {
  const [selectedImage, setSelectedImage] = useState(null)
  const [selectedCategory, setSelectedCategory] = useState('Všetky')
  const [showAddForm, setShowAddForm] = useState(false)
  const [editingImage, setEditingImage] = useState(null)
  const [newImage, setNewImage] = useState({
    title: '',
    src: '',
    alt: '',
    category: 'Príroda'
  })

  const filteredImages = selectedCategory === 'Všetky' 
    ? galleryImages 
    : galleryImages.filter(img => img.category === selectedCategory)

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
          <button 
            onClick={() => setShowAddForm(true)}
            className="bg-indigo-600 hover:bg-indigo-700 text-white px-4 py-2 rounded-md text-sm font-medium flex items-center"
          >
            <PlusIcon className="w-4 h-4 mr-2" />
            Pridať obrázok
          </button>
        </div>
      </div>

      {/* Category Filter */}
      <div className="mb-6">
        <div className="flex flex-wrap gap-2">
          {categories.map((category) => (
            <button
              key={category}
              onClick={() => setSelectedCategory(category)}
              className={`px-4 py-2 rounded-full text-sm font-medium transition-colors ${
                selectedCategory === category
                  ? 'bg-indigo-600 text-white'
                  : 'bg-gray-200 text-gray-700 hover:bg-gray-300'
              }`}
            >
              {category}
            </button>
          ))}
        </div>
      </div>

      <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-4">
        {filteredImages.map((image) => (
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
              <p className="text-xs text-gray-500 mt-1">{image.category}</p>
              <div className="mt-2 flex space-x-2">
                <button 
                  onClick={() => setEditingImage(image)}
                  className="text-indigo-600 hover:text-indigo-900 text-xs flex items-center"
                >
                  <PencilIcon className="w-3 h-3 mr-1" />
                  Upraviť
                </button>
                <button className="text-red-600 hover:text-red-900 text-xs flex items-center">
                  <TrashIcon className="w-3 h-3 mr-1" />
                  Zmazať
                </button>
              </div>
            </div>
          </div>
        ))}
      </div>

      {/* Add/Edit Image Modal */}
      {(showAddForm || editingImage) && (
        <div className="fixed inset-0 z-50 overflow-y-auto" role="dialog" aria-modal="true">
          <div className="flex items-center justify-center min-h-screen pt-4 px-4 pb-20 text-center">
            <div className="fixed inset-0 bg-gray-500 bg-opacity-75 transition-opacity" onClick={() => {
              setShowAddForm(false)
              setEditingImage(null)
              setNewImage({ title: '', src: '', alt: '', category: 'Príroda' })
            }}></div>
            <div className="inline-block bg-white rounded-lg px-6 pt-5 pb-4 text-left overflow-hidden shadow-xl transform transition-all max-w-lg w-full">
              <div className="flex justify-between items-center mb-4">
                <h3 className="text-lg font-medium text-gray-900">
                  {editingImage ? 'Upraviť obrázok' : 'Pridať nový obrázok'}
                </h3>
                <button
                  onClick={() => {
                    setShowAddForm(false)
                    setEditingImage(null)
                    setNewImage({ title: '', src: '', alt: '', category: 'Príroda' })
                  }}
                  className="text-gray-400 hover:text-gray-600"
                >
                  <XMarkIcon className="w-6 h-6" />
                </button>
              </div>
              <div className="space-y-4">
                <div>
                  <label className="block text-sm font-medium text-gray-700">Názov</label>
                  <input
                    type="text"
                    value={editingImage ? editingImage.title : newImage.title}
                    onChange={(e) => editingImage 
                      ? setEditingImage({...editingImage, title: e.target.value})
                      : setNewImage({...newImage, title: e.target.value})
                    }
                    className="mt-1 block w-full border border-gray-300 rounded-md px-3 py-2 focus:outline-none focus:ring-indigo-500 focus:border-indigo-500"
                  />
                </div>
                <div>
                  <label className="block text-sm font-medium text-gray-700">URL obrázka</label>
                  <input
                    type="url"
                    value={editingImage ? editingImage.src : newImage.src}
                    onChange={(e) => editingImage 
                      ? setEditingImage({...editingImage, src: e.target.value})
                      : setNewImage({...newImage, src: e.target.value})
                    }
                    className="mt-1 block w-full border border-gray-300 rounded-md px-3 py-2 focus:outline-none focus:ring-indigo-500 focus:border-indigo-500"
                    placeholder="https://example.com/image.jpg"
                  />
                </div>
                <div>
                  <label className="block text-sm font-medium text-gray-700">Alt text</label>
                  <input
                    type="text"
                    value={editingImage ? editingImage.alt : newImage.alt}
                    onChange={(e) => editingImage 
                      ? setEditingImage({...editingImage, alt: e.target.value})
                      : setNewImage({...newImage, alt: e.target.value})
                    }
                    className="mt-1 block w-full border border-gray-300 rounded-md px-3 py-2 focus:outline-none focus:ring-indigo-500 focus:border-indigo-500"
                  />
                </div>
                <div>
                  <label className="block text-sm font-medium text-gray-700">Kategória</label>
                  <select
                    value={editingImage ? editingImage.category : newImage.category}
                    onChange={(e) => editingImage 
                      ? setEditingImage({...editingImage, category: e.target.value})
                      : setNewImage({...newImage, category: e.target.value})
                    }
                    className="mt-1 block w-full border border-gray-300 rounded-md px-3 py-2 focus:outline-none focus:ring-indigo-500 focus:border-indigo-500"
                  >
                    {categories.filter(cat => cat !== 'Všetky').map((category) => (
                      <option key={category} value={category}>
                        {category}
                      </option>
                    ))}
                  </select>
                </div>
              </div>
              <div className="mt-6 flex justify-end space-x-3">
                <button
                  onClick={() => {
                    setShowAddForm(false)
                    setEditingImage(null)
                    setNewImage({ title: '', src: '', alt: '', category: 'Príroda' })
                  }}
                  className="px-4 py-2 border border-gray-300 rounded-md text-sm font-medium text-gray-700 hover:bg-gray-50"
                >
                  Zrušiť
                </button>
                <button
                  className="px-4 py-2 bg-indigo-600 border border-transparent rounded-md text-sm font-medium text-white hover:bg-indigo-700"
                >
                  {editingImage ? 'Uložiť zmeny' : 'Pridať obrázok'}
                </button>
              </div>
            </div>
          </div>
        </div>
      )}

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
                  <p className="text-sm text-gray-500 mt-1">{selectedImage.category}</p>
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