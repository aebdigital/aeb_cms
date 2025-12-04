import { useState } from 'react'
import { PhotoIcon, PlusIcon, XMarkIcon } from '@heroicons/react/24/outline'

const sampleProjects = [
  {
    id: 1,
    title: 'Moderná webová aplikácia',
    year: 2024,
    category: 'Web Development',
    text: 'Kompletná webová aplikácia vyvinutá pomocou moderných technológií...',
    previewPhoto: 'https://images.unsplash.com/photo-1547658719-da2b51169166?w=400&h=300&fit=crop',
    photos: [
      'https://images.unsplash.com/photo-1547658719-da2b51169166?w=400&h=300&fit=crop',
      'https://images.unsplash.com/photo-1555949963-aa79dcee981c?w=400&h=300&fit=crop'
    ]
  },
  {
    id: 2,
    title: 'Mobilná aplikácia',
    year: 2023,
    category: 'Mobile Development',
    text: 'Cross-platform mobilná aplikácia pre iOS a Android...',
    previewPhoto: 'https://images.unsplash.com/photo-1512941937669-90a1b58e7e9c?w=400&h=300&fit=crop',
    photos: [
      'https://images.unsplash.com/photo-1512941937669-90a1b58e7e9c?w=400&h=300&fit=crop'
    ]
  }
]

export default function Projekty() {
  const [projects, setProjects] = useState(sampleProjects)
  const [selectedProject, setSelectedProject] = useState(null)
  const [showAddForm, setShowAddForm] = useState(false)
  const [newProject, setNewProject] = useState({
    title: '',
    year: new Date().getFullYear(),
    category: '',
    text: '',
    previewPhoto: '',
    photos: []
  })

  const handleAddProject = () => {
    if (newProject.title && newProject.category) {
      const project = {
        ...newProject,
        id: Date.now(),
        photos: newProject.photos.filter(photo => photo.trim() !== '')
      }
      setProjects([project, ...projects])
      setNewProject({
        title: '',
        year: new Date().getFullYear(),
        category: '',
        text: '',
        previewPhoto: '',
        photos: []
      })
      setShowAddForm(false)
    }
  }

  const handleDeleteProject = (projectId) => {
    setProjects(projects.filter(project => project.id !== projectId))
  }

  const addPhotoToNewProject = () => {
    setNewProject({
      ...newProject,
      photos: [...newProject.photos, '']
    })
  }

  const updateProjectPhoto = (index, url) => {
    const updatedPhotos = [...newProject.photos]
    updatedPhotos[index] = url
    setNewProject({
      ...newProject,
      photos: updatedPhotos
    })
  }

  const removeProjectPhoto = (index) => {
    const updatedPhotos = newProject.photos.filter((_, i) => i !== index)
    setNewProject({
      ...newProject,
      photos: updatedPhotos
    })
  }

  return (
    <div>
      <div className="border-b border-gray-200 pb-5 mb-6">
        <div className="flex items-center justify-between">
          <div>
            <h1 className="text-2xl font-bold leading-7 text-gray-900 sm:text-3xl sm:truncate">
              Projekty
            </h1>
            <p className="mt-2 text-sm text-gray-500">
              Spravujte svoje projekty s fotografiami a popismi
            </p>
          </div>
          <button 
            onClick={() => setShowAddForm(true)}
            className="bg-indigo-600 hover:bg-indigo-700 text-white px-4 py-2 rounded-md text-sm font-medium flex items-center"
          >
            <PlusIcon className="w-4 h-4 mr-2" />
            Pridať projekt
          </button>
        </div>
      </div>

      {/* Add Project Form */}
      {showAddForm && (
        <div className="bg-white shadow rounded-lg mb-6 p-6">
          <h3 className="text-lg font-medium text-gray-900 mb-4">Nový projekt</h3>
          
          <div className="space-y-4">
            <div>
              <label className="block text-sm font-medium text-gray-700">Názov projektu</label>
              <input
                type="text"
                value={newProject.title}
                onChange={(e) => setNewProject({...newProject, title: e.target.value})}
                className="mt-1 block w-full border border-gray-300 rounded-md px-3 py-2 focus:outline-none focus:ring-indigo-500 focus:border-indigo-500"
              />
            </div>

            <div className="grid grid-cols-2 gap-4">
              <div>
                <label className="block text-sm font-medium text-gray-700">Rok</label>
                <input
                  type="number"
                  value={newProject.year}
                  onChange={(e) => setNewProject({...newProject, year: parseInt(e.target.value)})}
                  className="mt-1 block w-full border border-gray-300 rounded-md px-3 py-2 focus:outline-none focus:ring-indigo-500 focus:border-indigo-500"
                />
              </div>
              <div>
                <label className="block text-sm font-medium text-gray-700">Kategória</label>
                <input
                  type="text"
                  value={newProject.category}
                  onChange={(e) => setNewProject({...newProject, category: e.target.value})}
                  className="mt-1 block w-full border border-gray-300 rounded-md px-3 py-2 focus:outline-none focus:ring-indigo-500 focus:border-indigo-500"
                />
              </div>
            </div>

            <div>
              <label className="block text-sm font-medium text-gray-700">Preview fotografia (URL)</label>
              <input
                type="url"
                value={newProject.previewPhoto}
                onChange={(e) => setNewProject({...newProject, previewPhoto: e.target.value})}
                className="mt-1 block w-full border border-gray-300 rounded-md px-3 py-2 focus:outline-none focus:ring-indigo-500 focus:border-indigo-500"
                placeholder="https://example.com/image.jpg"
              />
            </div>

            <div>
              <label className="block text-sm font-medium text-gray-700">Text projektu</label>
              <textarea
                value={newProject.text}
                onChange={(e) => setNewProject({...newProject, text: e.target.value})}
                rows={4}
                className="mt-1 block w-full border border-gray-300 rounded-md px-3 py-2 focus:outline-none focus:ring-indigo-500 focus:border-indigo-500"
              />
            </div>

            <div>
              <div className="flex items-center justify-between mb-2">
                <label className="block text-sm font-medium text-gray-700">Dodatočné fotografie</label>
                <button
                  type="button"
                  onClick={addPhotoToNewProject}
                  className="text-indigo-600 hover:text-indigo-900 text-sm"
                >
                  + Pridať fotografiu
                </button>
              </div>
              {newProject.photos.map((photo, index) => (
                <div key={index} className="flex items-center space-x-2 mb-2">
                  <input
                    type="url"
                    value={photo}
                    onChange={(e) => updateProjectPhoto(index, e.target.value)}
                    placeholder="https://example.com/image.jpg"
                    className="flex-1 border border-gray-300 rounded-md px-3 py-2 focus:outline-none focus:ring-indigo-500 focus:border-indigo-500"
                  />
                  <button
                    type="button"
                    onClick={() => removeProjectPhoto(index)}
                    className="text-red-600 hover:text-red-900"
                  >
                    <XMarkIcon className="w-5 h-5" />
                  </button>
                </div>
              ))}
            </div>
          </div>

          <div className="mt-6 flex justify-end space-x-3">
            <button
              onClick={() => setShowAddForm(false)}
              className="px-4 py-2 border border-gray-300 rounded-md text-sm font-medium text-gray-700 hover:bg-gray-50"
            >
              Zrušiť
            </button>
            <button
              onClick={handleAddProject}
              className="px-4 py-2 bg-indigo-600 border border-transparent rounded-md text-sm font-medium text-white hover:bg-indigo-700"
            >
              Pridať projekt
            </button>
          </div>
        </div>
      )}

      {/* Projects Grid */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        {projects.map((project) => (
          <div key={project.id} className="bg-white rounded-lg shadow overflow-hidden hover:shadow-lg transition-shadow">
            <div className="aspect-w-16 aspect-h-10">
              {project.previewPhoto ? (
                <img
                  src={project.previewPhoto}
                  alt={project.title}
                  className="w-full h-48 object-cover cursor-pointer"
                  onClick={() => setSelectedProject(project)}
                />
              ) : (
                <div className="w-full h-48 bg-gray-200 flex items-center justify-center cursor-pointer"
                     onClick={() => setSelectedProject(project)}>
                  <PhotoIcon className="w-12 h-12 text-gray-400" />
                </div>
              )}
            </div>
            <div className="p-6">
              <div className="flex justify-between items-start mb-2">
                <h3 className="text-lg font-medium text-gray-900">{project.title}</h3>
                <span className="text-sm text-gray-500">{project.year}</span>
              </div>
              <p className="text-sm text-indigo-600 mb-2">{project.category}</p>
              <p className="text-sm text-gray-600 line-clamp-3">{project.text}</p>
              <div className="mt-4 flex justify-between items-center">
                <span className="text-xs text-gray-500">
                  {project.photos.length} fotografií
                </span>
                <button 
                  onClick={() => handleDeleteProject(project.id)}
                  className="text-red-600 hover:text-red-900 text-sm"
                >
                  Zmazať
                </button>
              </div>
            </div>
          </div>
        ))}
      </div>

      {/* Project Detail Modal */}
      {selectedProject && (
        <div className="fixed inset-0 z-50 overflow-y-auto" role="dialog" aria-modal="true">
          <div className="flex items-end justify-center min-h-screen pt-4 px-4 pb-20 text-center sm:block sm:p-0">
            <div className="fixed inset-0 bg-gray-500 bg-opacity-75 transition-opacity" onClick={() => setSelectedProject(null)}></div>
            <span className="hidden sm:inline-block sm:align-middle sm:h-screen">&#8203;</span>
            <div className="inline-block align-bottom bg-white rounded-lg px-4 pt-5 pb-4 text-left overflow-hidden shadow-xl transform transition-all sm:my-8 sm:align-middle sm:max-w-4xl sm:w-full sm:p-6">
              <div>
                <div className="flex justify-between items-start mb-4">
                  <div>
                    <h3 className="text-xl font-medium text-gray-900">{selectedProject.title}</h3>
                    <p className="text-sm text-indigo-600">{selectedProject.category} • {selectedProject.year}</p>
                  </div>
                  <button
                    onClick={() => setSelectedProject(null)}
                    className="text-gray-400 hover:text-gray-600"
                  >
                    <XMarkIcon className="w-6 h-6" />
                  </button>
                </div>
                
                <div className="mb-4">
                  <p className="text-gray-700">{selectedProject.text}</p>
                </div>

                {selectedProject.photos.length > 0 && (
                  <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
                    {selectedProject.photos.map((photo, index) => (
                      <img
                        key={index}
                        src={photo}
                        alt={`${selectedProject.title} ${index + 1}`}
                        className="w-full rounded-lg object-cover"
                      />
                    ))}
                  </div>
                )}
              </div>
            </div>
          </div>
        </div>
      )}
    </div>
  )
}