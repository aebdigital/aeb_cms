import { useState, useEffect } from 'react'
import { PlusIcon, MagnifyingGlassIcon, FunnelIcon, XMarkIcon, PencilIcon, TrashIcon, PrinterIcon } from '@heroicons/react/24/outline'
import CarCard from '../components/CarCard'
import { equipmentCategories } from '../data/equipmentOptions'
import { useAuth } from '../contexts/AuthContext'
import { getCarsForSite, createCar, updateCar, deleteCar as deleteCarApi } from '../api/cars'
import { uploadCarImageOnly, deleteCarGalleryImage, deleteAllCarImagesAndAssets } from '../api/carsImages'
import { getPublicUrl } from '../api/storage'
import { ensureValidSession } from '../lib/supabaseClient'
import { compressImage } from '../lib/fileUtils'

const initialCarForm = {
  brand: '',
  model: '',
  year: new Date().getFullYear(),
  price: 0,
  mileage: 0,
  fuel: '',
  transmission: '',
  engine: '',
  power: '',
  bodyType: '',
  drivetrain: '',
  vin: '',
  description: '',
  features: [],
  // Unified image list: [{type: 'existing', data: 'path'}, {type: 'pending', data: File}]
  allImages: [],
  reservedUntil: '',
  showOnHomepage: false
}

export default function Vozidla() {
  const { currentSite, loading: authLoading } = useAuth()
  const [cars, setCars] = useState([])
  const [loading, setLoading] = useState(false)
  const [initialLoad, setInitialLoad] = useState(true)
  const [error, setError] = useState(null)
  const [searchTerm, setSearchTerm] = useState('')
  const [showFilters, setShowFilters] = useState(false)
  const [selectedCar, setSelectedCar] = useState(null)
  const [showAddModal, setShowAddModal] = useState(false)
  const [isEditMode, setIsEditMode] = useState(false)
  const [editingCar, setEditingCar] = useState(null)
  const [expandedCategories, setExpandedCategories] = useState([])
  const [carForm, setCarForm] = useState(initialCarForm)
  const [submitting, setSubmitting] = useState(false)
  const [uploadProgress, setUploadProgress] = useState('')
  const [filters, setFilters] = useState({
    fuel: '',
    transmission: '',
    priceMin: '',
    priceMax: '',
    yearMin: '',
    yearMax: ''
  })

  // Load cars from Supabase
  useEffect(() => {
    // Don't load if auth is still loading or no site selected
    if (authLoading || !currentSite?.id) {
      if (!authLoading && !currentSite?.id) {
        setInitialLoad(false)
      }
      return
    }

    let cancelled = false

    async function loadCarsAsync() {
      try {
        setLoading(true)
        setError(null)
        const data = await getCarsForSite(currentSite.id)
        if (!cancelled) {
          setCars(data)
        }
      } catch (err) {
        console.error('Error loading cars:', err)
        if (!cancelled) {
          setError(err.message)
        }
      } finally {
        if (!cancelled) {
          setLoading(false)
          setInitialLoad(false)
        }
      }
    }

    loadCarsAsync()

    return () => {
      cancelled = true
    }
  }, [currentSite?.id, authLoading])

  async function loadCars() {
    if (!currentSite?.id) return

    try {
      setError(null)
      const data = await getCarsForSite(currentSite.id)
      setCars(data)
    } catch (err) {
      console.error('Error loading cars:', err)
      setError(err.message)
    }
  }

  // Helper to get image URL (handles both storage paths and full URLs)
  const getImageUrl = (imagePath) => {
    if (!imagePath) return 'https://via.placeholder.com/400x300?text=No+Image'
    // If already a full URL, return as-is
    if (imagePath.startsWith('http://') || imagePath.startsWith('https://') || imagePath.startsWith('data:')) {
      return imagePath
    }
    // Otherwise it's a storage path, get public URL
    return getPublicUrl(imagePath)
  }

  // Filter cars based on search and filters
  const filteredCars = cars.filter(car => {
    const matchesSearch =
      car.brand.toLowerCase().includes(searchTerm.toLowerCase()) ||
      car.model.toLowerCase().includes(searchTerm.toLowerCase())

    const matchesFuel = !filters.fuel || car.fuel === filters.fuel
    const matchesTransmission = !filters.transmission || car.transmission === filters.transmission
    const matchesPriceMin = !filters.priceMin || car.price >= Number(filters.priceMin)
    const matchesPriceMax = !filters.priceMax || car.price <= Number(filters.priceMax)
    const matchesYearMin = !filters.yearMin || car.year >= Number(filters.yearMin)
    const matchesYearMax = !filters.yearMax || car.year <= Number(filters.yearMax)

    return matchesSearch && matchesFuel && matchesTransmission &&
           matchesPriceMin && matchesPriceMax && matchesYearMin && matchesYearMax
  })

  const clearFilters = () => {
    setFilters({
      fuel: '',
      transmission: '',
      priceMin: '',
      priceMax: '',
      yearMin: '',
      yearMax: ''
    })
    setSearchTerm('')
  }

  const handleCarClick = (car) => {
    setSelectedCar(car)
  }

  const handleCarFormChange = (field, value) => {
    setCarForm(prev => ({ ...prev, [field]: value }))
  }

  const toggleFeature = (feature) => {
    setCarForm(prev => ({
      ...prev,
      features: prev.features.includes(feature)
        ? prev.features.filter(f => f !== feature)
        : [...prev.features, feature]
    }))
  }

  const handleImageUpload = (e) => {
    const files = e.target.files
    if (files) {
      const newImages = Array.from(files).map(file => ({
        type: 'pending',
        data: file
      }))
      setCarForm(prev => ({
        ...prev,
        allImages: [...prev.allImages, ...newImages]
      }))
    }
    e.target.value = ''
  }

  // Drag and drop state
  const [draggedIndex, setDraggedIndex] = useState(null)

  const handleDragStart = (e, index) => {
    setDraggedIndex(index)
    e.dataTransfer.effectAllowed = 'move'
  }

  const handleDragOver = (e) => {
    e.preventDefault()
    e.dataTransfer.dropEffect = 'move'
  }

  const handleDragEnd = () => {
    setDraggedIndex(null)
  }

  const handleDrop = (e, dropIndex) => {
    e.preventDefault()
    if (draggedIndex === null || draggedIndex === dropIndex) {
      setDraggedIndex(null)
      return
    }

    setCarForm(prev => {
      const newImages = [...prev.allImages]
      const [draggedItem] = newImages.splice(draggedIndex, 1)
      newImages.splice(dropIndex, 0, draggedItem)
      return { ...prev, allImages: newImages }
    })
    setDraggedIndex(null)
  }

  const removeImage = (index) => {
    setCarForm(prev => ({
      ...prev,
      allImages: prev.allImages.filter((_, i) => i !== index)
    }))
  }

  const openAddModal = () => {
    setCarForm(initialCarForm)
    setIsEditMode(false)
    setEditingCar(null)
    setExpandedCategories([])
    setShowAddModal(true)
  }

  const openEditModal = (car) => {
    // Collect existing images (main + gallery) as unified list
    const allImages = []
    if (car.image) {
      allImages.push({ type: 'existing', data: car.image })
    }
    if (car.images && car.images.length > 0) {
      car.images.forEach(img => {
        if (img !== car.image) {
          allImages.push({ type: 'existing', data: img })
        }
      })
    }

    setCarForm({
      brand: car.brand,
      model: car.model,
      year: car.year,
      price: car.price,
      mileage: car.mileage,
      fuel: car.fuel,
      transmission: car.transmission,
      engine: car.engine || '',
      power: car.power || '',
      bodyType: car.bodyType || '',
      drivetrain: car.drivetrain || '',
      vin: car.vin || '',
      description: car.description || '',
      features: car.features || [],
      allImages,
      reservedUntil: car.reservedUntil || '',
      showOnHomepage: car.showOnHomepage || false
    })
    setIsEditMode(true)
    setEditingCar(car)
    setExpandedCategories([])
    setSelectedCar(null)
    setShowAddModal(true)
  }

  const closeAddModal = () => {
    setShowAddModal(false)
    setCarForm(initialCarForm)
    setIsEditMode(false)
    setEditingCar(null)
    setExpandedCategories([])
    setUploadProgress('')
  }

  // Helper to wrap promise with timeout
  const withTimeout = (promise, ms = 30000, context = 'Operation') => {
    return Promise.race([
      promise,
      new Promise((_, reject) => 
        setTimeout(() => reject(new Error(`${context} timed out after ${ms}ms`)), ms)
      )
    ])
  }

  const handleSubmitCar = async (e) => {
    e.preventDefault()

    if (!carForm.brand || !carForm.model || !carForm.fuel || !carForm.transmission) {
      alert('Prosím vyplňte všetky povinné polia (Značka, Model, Palivo, Prevodovka)')
      return
    }

    if (!currentSite?.id) {
      alert('Chyba: Nie je vybratá žiadna stránka.')
      return
    }

    setSubmitting(true)
    setUploadProgress('')

    try {
      // Try to refresh session if needed (non-blocking, best effort)
      await ensureValidSession()

      let carId = editingCar?.id
      const siteSlug = currentSite.slug

      // Get all images in their current order (unified list)
      const allImages = carForm.allImages

      // Get pending files for upload
      const pendingFiles = allImages.filter(item => item.type === 'pending').map(item => item.data)

      // Prepare initial car data (without final image order - we'll update after uploads)
      const carData = {
        brand: carForm.brand,
        model: carForm.model,
        year: carForm.year,
        price: carForm.price,
        mileage: carForm.mileage,
        fuel: carForm.fuel,
        transmission: carForm.transmission,
        features: carForm.features.length > 0 ? carForm.features : undefined,
        engine: carForm.engine || undefined,
        power: carForm.power || undefined,
        bodyType: carForm.bodyType || undefined,
        drivetrain: carForm.drivetrain || undefined,
        vin: carForm.vin || undefined,
        description: carForm.description || undefined,
        reservedUntil: carForm.reservedUntil || undefined,
        showOnHomepage: carForm.showOnHomepage,
        source: 'admin',
      }

      if (isEditMode && editingCar) {
        // Update existing car with basic data first
        await withTimeout(updateCar(editingCar.id, carData, currentSite.id), 30000, 'Updating car')
        setUploadProgress('Vozidlo aktualizované...')
      } else {
        // Create new car first to get the ID
        setUploadProgress('Vytváram vozidlo...')
        const newCar = await withTimeout(createCar(currentSite.id, carData), 30000, 'Creating car')
        carId = newCar.id
      }

      // Upload pending files and collect their paths
      const uploadedPaths = new Map() // Map File -> uploaded path
      if (pendingFiles.length > 0 && carId) {
        const totalFiles = pendingFiles.length

        for (let i = 0; i < pendingFiles.length; i++) {
          const file = pendingFiles[i]
          setUploadProgress(`Komprimujem obrázok ${i + 1}/${totalFiles}...`)

          // Compress image to max 500KB before upload
          let fileToUpload = file
          try {
            fileToUpload = await compressImage(file, 500)
          } catch (compressErr) {
            console.warn('Compression failed, uploading original:', compressErr)
          }

          setUploadProgress(`Nahrávam obrázok ${i + 1}/${totalFiles}...`)

          // Upload image only (we'll set the order later)
          // Add 3 min timeout for images as they can be large
          const { path } = await withTimeout(
            uploadCarImageOnly({
              file: fileToUpload,
              siteId: currentSite.id,
              siteSlug,
              carId,
            }),
            180000,
            `Uploading image ${i + 1}`
          )
          uploadedPaths.set(file, path)
        }
      }

      // Now build the final ordered image list
      const finalImagePaths = allImages.map(item => {
        if (item.type === 'existing') {
          return item.data // Already a path
        } else {
          return uploadedPaths.get(item.data) // Get uploaded path for this file
        }
      }).filter(Boolean) // Remove any undefined

      // Update car with final image order
      if (finalImagePaths.length > 0) {
        setUploadProgress('Ukladám poradie obrázkov...')
        await withTimeout(updateCar(carId, {
          image: finalImagePaths[0], // First image is main
          images: finalImagePaths.slice(1) // Rest are gallery
        }, currentSite.id), 30000, 'Saving image order')
      } else {
        // No images - clear them
        await withTimeout(updateCar(carId, {
          image: null,
          images: []
        }, currentSite.id), 30000, 'Clearing images')
      }

      setUploadProgress('')
      alert(isEditMode ? 'Vozidlo bolo úspešne upravené!' : 'Vozidlo bolo úspešne pridané!')
      closeAddModal()
      await loadCars()
    } catch (err) {
      console.error('Error saving car:', err)
      alert('Chyba pri ukladaní vozidla: ' + err.message)
    } finally {
      setSubmitting(false)
      setUploadProgress('')
    }
  }

  const handleDeleteCar = async (carId) => {
    if (window.confirm('Ste si istí, že chcete odstrániť toto vozidlo?')) {
      try {
        const car = cars.find(c => c.id === carId)

        // Delete all images from storage and media_assets
        if (car && currentSite?.slug) {
          await deleteAllCarImagesAndAssets({
            carId,
            siteId: currentSite.id,
            siteSlug: currentSite.slug
          })
        }

        // Delete the car record
        await deleteCarApi(carId)
        setSelectedCar(null)
        await loadCars()
      } catch (err) {
        console.error('Error deleting car:', err)
        alert('Chyba pri mazaní vozidla: ' + err.message)
      }
    }
  }

  // Print car details as PDF
  const handlePrintCar = (car) => {
    // Group features by category
    const featuresByCategory = {}
    equipmentCategories.forEach(category => {
      const categoryFeatures = car.features?.filter(f => category.options.includes(f)) || []
      if (categoryFeatures.length > 0) {
        featuresByCategory[category.name] = categoryFeatures
      }
    })

    const printContent = `
      <!DOCTYPE html>
      <html>
      <head>
        <meta charset="UTF-8">
        <title> </title>
        <style>
          * { margin: 0; padding: 0; box-sizing: border-box; }
          body { font-family: Arial, sans-serif; padding: 50px; max-width: 800px; margin: 0 auto; -webkit-print-color-adjust: exact; }
          .header { text-align: center; border: 2px solid #000; padding: 10px 15px; margin-bottom: 15px; }
          .title { font-size: 40px; font-weight: bold; }
          .subtitle { font-size: 18px; color: #666; }
          .info-box { border: 2px solid #000; padding: 15px 20px; margin-bottom: 15px; display: grid; grid-template-columns: 1fr 1fr; gap: 8px 20px; }
          .info-row { font-size: 20px; }
          .info-label { font-weight: normal; }
          .info-value { font-weight: bold; color: #000; font-size: 20px; }
          .section-title { font-weight: bold; margin: 20px 0 10px 0; font-size: 16px; border-bottom: 1px solid #000; padding-bottom: 5px; }
          .features-section { margin-bottom: 15px; }
          .features-category { font-weight: bold; margin-bottom: 5px; }
          .features-list { display: flex; flex-wrap: wrap; gap: 5px; }
          .feature-item { background: #f3f4f6; padding: 2px 8px; font-size: 12px; }
          .description { margin: 20px 0; }
          .description-title { font-weight: bold; margin-bottom: 10px; }
          .price-box { text-align: right; border: 2px solid #000; padding: 10px 15px; margin-top: 15px; }
          .price { font-size: 78px; font-weight: bold; }
          .price-note { font-size: 14px; color: #666; margin-top: 5px; }
          .footer { margin-top: 15px; padding-top: 15px; font-size: 12px; display: flex; justify-content: space-between; }
          .footer-left { line-height: 1.6; }
          .footer-right { text-align: right; line-height: 1.6; }
          .footer-bold { font-weight: bold; }
          @page { size: auto; margin: 0; }
          @media print {
            body {
              padding: 15mm;
              -webkit-print-color-adjust: exact;
            }
            .no-print {
              display: none !important;
            }
          }
        </style>
      </head>
      <body>
        <div class="header">
          <div class="title">${car.brand} ${car.model}</div>
        </div>

        <div class="info-box">
          <div class="info-row"><span class="info-label">Rok výroby:</span> <span class="info-value">${car.year}</span></div>
          <div class="info-row"><span class="info-label">Počet km:</span> <span class="info-value">${car.mileage?.toLocaleString() || 'N/A'} km</span></div>
          <div class="info-row"><span class="info-label">Palivo:</span> <span class="info-value">${car.fuel || 'N/A'}</span></div>
          <div class="info-row"><span class="info-label">Prevodovka:</span> <span class="info-value">${car.transmission || 'N/A'}</span></div>
          ${car.power ? `<div class="info-row"><span class="info-label">Výkon:</span> <span class="info-value">${car.power}</span></div>` : ''}
          ${car.bodyType ? `<div class="info-row"><span class="info-label">Karoséria:</span> <span class="info-value">${car.bodyType}</span></div>` : ''}
          ${car.drivetrain ? `<div class="info-row"><span class="info-label">Pohon:</span> <span class="info-value">${car.drivetrain}</span></div>` : ''}
          ${car.vin ? `<div class="info-row"><span class="info-label">VIN:</span> <span class="info-value">${car.vin}</span></div>` : ''}
        </div>

        ${Object.keys(featuresByCategory).length > 0 ? `
          ${Object.entries(featuresByCategory).map(([category, features]) => `
            <div class="features-section">
              <div class="features-category">${category}</div>
              <div class="features-list">
                ${features.map(f => `<span class="feature-item">${f}</span>`).join('')}
              </div>
            </div>
          `).join('')}
        ` : ''}

        <div class="price-box">
          <div class="price">${car.price?.toLocaleString() || 'N/A'} €</div>
          <div class="price-note">Možný leasing, Možný úver</div>
        </div>

        <div class="footer">
          <div class="footer-left">
            <div class="footer-bold">MT AUTOS s.r.o.</div>
            <div>29 Augusta č.2261/145,</div>
            <div>03852 Sučany, okres Martin</div>
            <div>(Sučany-Juh, pri Čerpacej stanici Orlen)</div>
          </div>
          <div class="footer-right">
            <div><span class="footer-bold">E-mail:</span> mtautossro@gmail.com</div>
            <div><span class="footer-bold">Telefón:</span> +421 915 511 111</div>
            <div><span class="footer-bold">Web:</span> www.mtautos.sk</div>
          </div>
        </div>
      </body>
      </html>
    `

    const printWindow = window.open('', '_blank')
    printWindow.document.write(printContent)
    printWindow.document.close()
    printWindow.focus()
    setTimeout(() => {
      printWindow.print()
    }, 250)
  }

  // Show loading only on initial load, not on refetches
  if (initialLoad || authLoading) {
    return (
      <div className="flex items-center justify-center min-h-[400px]">
        <div className="text-center">
          <div className="w-12 h-12 border-4 border-purple-600 border-t-transparent rounded-full animate-spin mx-auto mb-4"></div>
          <p className="text-gray-600">Načítavam vozidlá...</p>
        </div>
      </div>
    )
  }

  if (!currentSite) {
    return (
      <div className="flex items-center justify-center h-64">
        <p className="text-gray-500">Vyberte stránku pre zobrazenie vozidiel</p>
      </div>
    )
  }

  if (error) {
    return (
      <div className="bg-red-50 border border-red-200 rounded-xl p-6 text-center">
        <p className="text-red-600 mb-4">Chyba pri načítavaní vozidiel: {error}</p>
        <button
          onClick={loadCars}
          className="px-4 py-2 bg-red-600 text-white rounded-lg hover:bg-red-700"
        >
          Skúsiť znova
        </button>
      </div>
    )
  }

  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-2xl font-bold text-gray-900">Vozidlá</h1>
          <p className="mt-1 text-sm text-gray-500">
            Spravujte ponuku vozidiel
          </p>
        </div>
        <button
          onClick={openAddModal}
          className="inline-flex items-center px-4 py-2 border border-transparent shadow-sm text-sm font-medium rounded-xl text-white bg-gradient-to-r from-purple-600 to-blue-600 hover:from-purple-700 hover:to-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-purple-500 transition-all"
        >
          <PlusIcon className="-ml-1 mr-2 h-5 w-5" />
          Pridať vozidlo
        </button>
      </div>

      {/* Search and Filters */}
      <div className="bg-white rounded-xl shadow-sm border border-gray-200 p-4">
        <div className="flex flex-col md:flex-row gap-4">
          {/* Search */}
          <div className="flex-1 relative">
            <MagnifyingGlassIcon className="absolute left-3 top-1/2 transform -translate-y-1/2 h-5 w-5 text-gray-400" />
            <input
              type="text"
              placeholder="Hľadať vozidlo..."
              value={searchTerm}
              onChange={(e) => setSearchTerm(e.target.value)}
              className="w-full pl-10 pr-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-purple-500 focus:border-transparent"
            />
          </div>

          {/* Filter Toggle */}
          <button
            onClick={() => setShowFilters(!showFilters)}
            className={`inline-flex items-center px-4 py-2 border rounded-lg text-sm font-medium transition-colors ${
              showFilters
                ? 'bg-purple-100 border-purple-300 text-purple-700'
                : 'bg-white border-gray-300 text-gray-700 hover:bg-gray-50'
            }`}
          >
            <FunnelIcon className="h-5 w-5 mr-2" />
            Filtre
          </button>
        </div>

        {/* Expanded Filters */}
        {showFilters && (
          <div className="mt-4 pt-4 border-t border-gray-200">
            <div className="grid grid-cols-1 md:grid-cols-3 lg:grid-cols-6 gap-4">
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">Palivo</label>
                <select
                  value={filters.fuel}
                  onChange={(e) => setFilters({...filters, fuel: e.target.value})}
                  className="w-full border border-gray-300 rounded-lg px-3 py-2 focus:ring-2 focus:ring-purple-500"
                >
                  <option value="">Všetky</option>
                  <option value="Benzin">Benzín</option>
                  <option value="Diesel">Diesel</option>
                  <option value="Hybrid">Hybrid</option>
                  <option value="Elektro">Elektro</option>
                  <option value="LPG">LPG</option>
                </select>
              </div>

              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">Prevodovka</label>
                <select
                  value={filters.transmission}
                  onChange={(e) => setFilters({...filters, transmission: e.target.value})}
                  className="w-full border border-gray-300 rounded-lg px-3 py-2 focus:ring-2 focus:ring-purple-500"
                >
                  <option value="">Všetky</option>
                  <option value="Manualna">Manuálna</option>
                  <option value="Automaticka">Automatická</option>
                </select>
              </div>

              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">Cena od</label>
                <input
                  type="number"
                  placeholder="Min EUR"
                  value={filters.priceMin}
                  onChange={(e) => setFilters({...filters, priceMin: e.target.value})}
                  className="w-full border border-gray-300 rounded-lg px-3 py-2 focus:ring-2 focus:ring-purple-500"
                />
              </div>

              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">Cena do</label>
                <input
                  type="number"
                  placeholder="Max EUR"
                  value={filters.priceMax}
                  onChange={(e) => setFilters({...filters, priceMax: e.target.value})}
                  className="w-full border border-gray-300 rounded-lg px-3 py-2 focus:ring-2 focus:ring-purple-500"
                />
              </div>

              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">Rok od</label>
                <input
                  type="number"
                  placeholder="Min rok"
                  value={filters.yearMin}
                  onChange={(e) => setFilters({...filters, yearMin: e.target.value})}
                  className="w-full border border-gray-300 rounded-lg px-3 py-2 focus:ring-2 focus:ring-purple-500"
                />
              </div>

              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">Rok do</label>
                <input
                  type="number"
                  placeholder="Max rok"
                  value={filters.yearMax}
                  onChange={(e) => setFilters({...filters, yearMax: e.target.value})}
                  className="w-full border border-gray-300 rounded-lg px-3 py-2 focus:ring-2 focus:ring-purple-500"
                />
              </div>
            </div>

            <div className="mt-4 flex justify-end">
              <button
                onClick={clearFilters}
                className="text-sm text-gray-600 hover:text-gray-900"
              >
                Vymazať filtre
              </button>
            </div>
          </div>
        )}
      </div>

      {/* Results count */}
      <div className="text-sm text-gray-600">
        Zobrazujem {filteredCars.length} z {cars.length} vozidiel
      </div>

      {/* Cars Grid */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        {filteredCars.map((car) => (
          <CarCard key={car.id} car={car} onClick={() => handleCarClick(car)} getImageUrl={getImageUrl} />
        ))}
      </div>

      {/* Empty State */}
      {filteredCars.length === 0 && (
        <div className="text-center py-12">
          <div className="text-gray-400 text-5xl mb-4">🚗</div>
          <h3 className="text-lg font-medium text-gray-900 mb-2">Žiadne vozidlá</h3>
          <p className="text-gray-500">Skúste zmeniť filtre alebo vyhľadávanie</p>
        </div>
      )}

      {/* Car Detail Modal */}
      {selectedCar && (
        <div className="fixed inset-0 z-50 overflow-y-auto" aria-labelledby="modal-title" role="dialog" aria-modal="true">
          <div className="flex items-end justify-center min-h-screen pt-4 px-4 pb-20 text-center sm:block sm:p-0">
            <div className="fixed inset-0 bg-gray-500 bg-opacity-75 transition-opacity" onClick={() => setSelectedCar(null)} />

            <div className="inline-block align-bottom bg-white rounded-xl text-left overflow-hidden shadow-xl transform transition-all sm:my-8 sm:align-middle sm:max-w-3xl sm:w-full">
              <div className="absolute top-4 right-4 z-10 flex gap-2">
                <button
                  onClick={() => handlePrintCar(selectedCar)}
                  className="bg-white rounded-full p-2 shadow-lg hover:bg-green-50"
                  title="Tlačiť PDF"
                >
                  <PrinterIcon className="h-6 w-6 text-green-600" />
                </button>
                <button
                  onClick={() => openEditModal(selectedCar)}
                  className="bg-white rounded-full p-2 shadow-lg hover:bg-blue-50"
                  title="Upraviť"
                >
                  <PencilIcon className="h-6 w-6 text-blue-600" />
                </button>
                <button
                  onClick={() => handleDeleteCar(selectedCar.id)}
                  className="bg-white rounded-full p-2 shadow-lg hover:bg-red-50"
                  title="Odstrániť"
                >
                  <TrashIcon className="h-6 w-6 text-red-600" />
                </button>
                <button
                  onClick={() => setSelectedCar(null)}
                  className="bg-white rounded-full p-2 shadow-lg hover:bg-gray-100"
                >
                  <XMarkIcon className="h-6 w-6 text-gray-600" />
                </button>
              </div>

              <div className="relative h-64 sm:h-80">
                <img
                  src={getImageUrl(selectedCar.image)}
                  alt={`${selectedCar.brand} ${selectedCar.model}`}
                  className="w-full h-full object-cover"
                />
                <div className="absolute bottom-4 left-4 bg-gradient-to-r from-purple-600 to-blue-600 text-white px-4 py-2 rounded-lg text-xl font-bold">
                  {selectedCar.price.toLocaleString()} EUR
                </div>
                {selectedCar.source === 'admin' && (
                  <div className="absolute top-4 left-4 bg-purple-500 text-white px-3 py-1 rounded-full text-sm font-bold">
                    ADMIN
                  </div>
                )}
              </div>

              <div className="p-6">
                <h2 className="text-2xl font-bold text-gray-900 mb-4">
                  {selectedCar.brand} {selectedCar.model}
                </h2>

                <div className="grid grid-cols-2 md:grid-cols-4 gap-4 mb-6">
                  <div className="bg-gray-50 rounded-lg p-3">
                    <p className="text-sm text-gray-500">Rok</p>
                    <p className="font-semibold">{selectedCar.year}</p>
                  </div>
                  <div className="bg-gray-50 rounded-lg p-3">
                    <p className="text-sm text-gray-500">Kilometre</p>
                    <p className="font-semibold">{selectedCar.mileage.toLocaleString()} km</p>
                  </div>
                  <div className="bg-gray-50 rounded-lg p-3">
                    <p className="text-sm text-gray-500">Palivo</p>
                    <p className="font-semibold">{selectedCar.fuel}</p>
                  </div>
                  <div className="bg-gray-50 rounded-lg p-3">
                    <p className="text-sm text-gray-500">Prevodovka</p>
                    <p className="font-semibold">{selectedCar.transmission}</p>
                  </div>
                  <div className="bg-gray-50 rounded-lg p-3">
                    <p className="text-sm text-gray-500">Motor</p>
                    <p className="font-semibold">{selectedCar.engine || 'N/A'}</p>
                  </div>
                  <div className="bg-gray-50 rounded-lg p-3">
                    <p className="text-sm text-gray-500">Výkon</p>
                    <p className="font-semibold">{selectedCar.power || 'N/A'}</p>
                  </div>
                  <div className="bg-gray-50 rounded-lg p-3">
                    <p className="text-sm text-gray-500">Karoséria</p>
                    <p className="font-semibold">{selectedCar.bodyType || 'N/A'}</p>
                  </div>
                  <div className="bg-gray-50 rounded-lg p-3">
                    <p className="text-sm text-gray-500">Pohon</p>
                    <p className="font-semibold">{selectedCar.drivetrain || 'N/A'}</p>
                  </div>
                </div>

                {/* Gallery Images */}
                {selectedCar.images && selectedCar.images.length > 0 && (
                  <div className="mb-6">
                    <h3 className="text-lg font-semibold mb-3">Galéria</h3>
                    <div className="grid grid-cols-4 gap-2">
                      {selectedCar.images.map((img, index) => (
                        <img
                          key={index}
                          src={getImageUrl(img)}
                          alt={`${selectedCar.brand} ${selectedCar.model} - ${index + 1}`}
                          className="w-full h-20 object-cover rounded-lg cursor-pointer hover:opacity-80"
                        />
                      ))}
                    </div>
                  </div>
                )}

                {selectedCar.description && (
                  <div className="mb-6">
                    <h3 className="text-lg font-semibold mb-2">Popis</h3>
                    <p className="text-gray-600">{selectedCar.description}</p>
                  </div>
                )}

                {selectedCar.features && selectedCar.features.length > 0 && (
                  <div>
                    <h3 className="text-lg font-semibold mb-3">Výbava</h3>
                    <div className="flex flex-wrap gap-2">
                      {selectedCar.features.map((feature, index) => (
                        <span
                          key={index}
                          className="bg-purple-100 text-purple-800 px-3 py-1 rounded-full text-sm"
                        >
                          {feature}
                        </span>
                      ))}
                    </div>
                  </div>
                )}
              </div>
            </div>
          </div>
        </div>
      )}

      {/* Add/Edit Car Modal */}
      {showAddModal && (
        <div className="fixed inset-0 z-50 overflow-y-auto" aria-labelledby="modal-title" role="dialog" aria-modal="true">
          <div className="fixed inset-0 bg-gray-500 bg-opacity-75 transition-opacity" onClick={closeAddModal} />
          <div className="flex items-center justify-center min-h-screen p-4">
            <div className="relative bg-white rounded-xl text-left overflow-hidden shadow-xl w-[90vw] max-w-[1600px] max-h-[90vh] flex flex-col">
              <div className="sticky top-0 bg-white border-b border-gray-200 px-6 py-4 flex items-center justify-between z-10 flex-shrink-0">
                <h2 className="text-2xl font-bold text-gray-900">
                  {isEditMode ? 'Upraviť vozidlo' : 'Pridať nové vozidlo'}
                </h2>
                <button
                  type="button"
                  onClick={closeAddModal}
                  className="bg-gray-100 rounded-full p-2 hover:bg-gray-200"
                >
                  <XMarkIcon className="h-6 w-6 text-gray-600" />
                </button>
              </div>

              <form id="carForm" onSubmit={handleSubmitCar} className="p-6 space-y-6 overflow-y-auto flex-1">
                {/* Basic Info */}
                <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
                  <div>
                    <label className="block text-sm font-semibold mb-2">Značka *</label>
                    <input
                      type="text"
                      value={carForm.brand}
                      onChange={(e) => handleCarFormChange('brand', e.target.value)}
                      className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-purple-500"
                      required
                    />
                  </div>

                  <div>
                    <label className="block text-sm font-semibold mb-2">Model *</label>
                    <input
                      type="text"
                      value={carForm.model}
                      onChange={(e) => handleCarFormChange('model', e.target.value)}
                      className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-purple-500"
                      required
                    />
                  </div>

                  <div>
                    <label className="block text-sm font-semibold mb-2">Rok</label>
                    <input
                      type="number"
                      value={carForm.year}
                      onChange={(e) => handleCarFormChange('year', parseInt(e.target.value))}
                      className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-purple-500"
                      min="1900"
                      max={new Date().getFullYear() + 1}
                    />
                  </div>

                  <div>
                    <label className="block text-sm font-semibold mb-2">Cena (EUR)</label>
                    <input
                      type="number"
                      value={carForm.price}
                      onChange={(e) => handleCarFormChange('price', parseFloat(e.target.value))}
                      className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-purple-500"
                      min="0"
                    />
                  </div>

                  <div>
                    <label className="block text-sm font-semibold mb-2">Najazdené (km)</label>
                    <input
                      type="number"
                      value={carForm.mileage}
                      onChange={(e) => handleCarFormChange('mileage', parseInt(e.target.value))}
                      className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-purple-500"
                      min="0"
                    />
                  </div>

                  <div>
                    <label className="block text-sm font-semibold mb-2">Palivo *</label>
                    <select
                      value={carForm.fuel}
                      onChange={(e) => handleCarFormChange('fuel', e.target.value)}
                      className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-purple-500"
                      required
                    >
                      <option value="">Vyberte palivo</option>
                      <option value="Benzin">Benzín</option>
                      <option value="Diesel">Diesel</option>
                      <option value="Hybrid">Hybrid</option>
                      <option value="Elektro">Elektro</option>
                      <option value="LPG">LPG</option>
                      <option value="CNG">CNG</option>
                    </select>
                  </div>

                  <div>
                    <label className="block text-sm font-semibold mb-2">Prevodovka *</label>
                    <select
                      value={carForm.transmission}
                      onChange={(e) => handleCarFormChange('transmission', e.target.value)}
                      className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-purple-500"
                      required
                    >
                      <option value="">Vyberte prevodovku</option>
                      <option value="Manualna">Manuálna</option>
                      <option value="Automaticka">Automatická</option>
                      <option value="Poloautomaticka">Poloautomatická</option>
                    </select>
                  </div>

                  <div>
                    <label className="block text-sm font-semibold mb-2">Motor</label>
                    <input
                      type="text"
                      value={carForm.engine}
                      onChange={(e) => handleCarFormChange('engine', e.target.value)}
                      placeholder="napr. 2.0 TDI"
                      className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-purple-500"
                    />
                  </div>

                  <div>
                    <label className="block text-sm font-semibold mb-2">Výkon</label>
                    <input
                      type="text"
                      value={carForm.power}
                      onChange={(e) => handleCarFormChange('power', e.target.value)}
                      placeholder="napr. 150 kW"
                      className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-purple-500"
                    />
                  </div>

                  <div>
                    <label className="block text-sm font-semibold mb-2">Karoséria</label>
                    <input
                      type="text"
                      value={carForm.bodyType}
                      onChange={(e) => handleCarFormChange('bodyType', e.target.value)}
                      placeholder="napr. Hatchback"
                      className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-purple-500"
                    />
                  </div>

                  <div>
                    <label className="block text-sm font-semibold mb-2">Pohon</label>
                    <input
                      type="text"
                      value={carForm.drivetrain}
                      onChange={(e) => handleCarFormChange('drivetrain', e.target.value)}
                      placeholder="napr. Predny"
                      className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-purple-500"
                    />
                  </div>

                  <div>
                    <label className="block text-sm font-semibold mb-2">VIN</label>
                    <input
                      type="text"
                      value={carForm.vin}
                      onChange={(e) => handleCarFormChange('vin', e.target.value)}
                      className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-purple-500"
                    />
                  </div>
                </div>

                {/* Description */}
                <div>
                  <label className="block text-sm font-semibold mb-2">Popis</label>
                  <textarea
                    value={carForm.description}
                    onChange={(e) => handleCarFormChange('description', e.target.value)}
                    rows={8}
                    className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-purple-500"
                    placeholder="Detailný popis vozidla..."
                  />
                </div>

                {/* Features - Equipment Categories */}
                <div>
                  <label className="block text-sm font-semibold mb-2">Výbava</label>
                  <div className="space-y-2">
                    {equipmentCategories.map((category) => (
                      <div key={category.name} className="border border-gray-300 rounded-lg overflow-hidden">
                        <button
                          type="button"
                          onClick={() => setExpandedCategories(prev =>
                            prev.includes(category.name)
                              ? prev.filter(c => c !== category.name)
                              : [...prev, category.name]
                          )}
                          className="w-full px-4 py-3 bg-gray-50 hover:bg-gray-100 text-left font-semibold flex items-center justify-between"
                        >
                          <span>{category.name}</span>
                          <span className="text-sm text-gray-600">
                            {carForm.features.filter(f => category.options.includes(f)).length}/{category.options.length} {expandedCategories.includes(category.name) ? '▲' : '▼'}
                          </span>
                        </button>
                        {expandedCategories.includes(category.name) && (
                          <div className="p-4 bg-white grid grid-cols-2 md:grid-cols-4 gap-2">
                            {category.options.map((option) => (
                              <label key={option} className="flex items-center space-x-2 cursor-pointer hover:bg-gray-50 p-1 rounded">
                                <input
                                  type="checkbox"
                                  checked={carForm.features.includes(option)}
                                  onChange={() => toggleFeature(option)}
                                  className="w-4 h-4 text-purple-600 border-gray-300 rounded focus:ring-2 focus:ring-purple-500"
                                />
                                <span className="text-sm">{option}</span>
                              </label>
                            ))}
                          </div>
                        )}
                      </div>
                    ))}
                  </div>
                </div>

                {/* Images */}
                <div>
                  <label className="block text-sm font-semibold mb-2">Fotografie</label>
                  <div className="mb-4">
                    <input
                      type="file"
                      multiple
                      accept="image/*"
                      onChange={handleImageUpload}
                      className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-purple-500 file:mr-4 file:py-2 file:px-4 file:rounded-lg file:border-0 file:text-sm file:font-semibold file:bg-purple-50 file:text-purple-700 hover:file:bg-purple-100"
                    />
                    <p className="text-sm text-gray-500 mt-2">Vyberte jeden alebo viacero obrázkov (JPG, PNG, GIF). Obrázky sa nahrajú do Supabase Storage.</p>
                  </div>

                  {/* Unified Image Grid (existing + pending) */}
                  {carForm.allImages.length > 0 && (
                    <div>
                      <p className="text-sm font-medium text-gray-700 mb-2">
                        Všetky obrázky (presuňte pre zmenu poradia):
                      </p>
                      <div className="grid grid-cols-4 md:grid-cols-6 lg:grid-cols-8 gap-2">
                        {carForm.allImages.map((item, index) => (
                          <div
                            key={`image-${index}-${item.type}`}
                            className={`relative cursor-grab active:cursor-grabbing ${
                              draggedIndex === index ? 'opacity-50 scale-95' : ''
                            }`}
                            draggable
                            onDragStart={(e) => handleDragStart(e, index)}
                            onDragOver={handleDragOver}
                            onDrop={(e) => handleDrop(e, index)}
                            onDragEnd={handleDragEnd}
                          >
                            <img
                              src={item.type === 'existing' ? getImageUrl(item.data) : URL.createObjectURL(item.data)}
                              alt={`Obrázok ${index + 1}`}
                              className={`w-full h-24 object-cover rounded-lg ${
                                item.type === 'pending' ? 'border-2 border-dashed border-green-400' : ''
                              }`}
                            />
                            <button
                              type="button"
                              onClick={() => removeImage(index)}
                              className="absolute top-1 right-1 bg-red-600 text-white rounded-full w-5 h-5 flex items-center justify-center text-xs hover:bg-red-700"
                            >
                              ×
                            </button>
                            {index === 0 && (
                              <span className="absolute bottom-1 left-1 bg-purple-600 text-white text-xs px-1 rounded">
                                Hlavná
                              </span>
                            )}
                            <span className="absolute top-1 left-1 bg-gray-800 bg-opacity-60 text-white text-xs px-1 rounded">
                              {index + 1}
                            </span>
                            {item.type === 'pending' && (
                              <span className="absolute bottom-1 right-1 bg-green-600 text-white text-xs px-1 rounded">
                                Nové
                              </span>
                            )}
                          </div>
                        ))}
                      </div>
                    </div>
                  )}
                </div>

                {/* Reservation Date */}
                <div>
                  <label className="block text-sm font-semibold mb-2">Rezervované do</label>
                  <input
                    type="date"
                    value={carForm.reservedUntil}
                    onChange={(e) => handleCarFormChange('reservedUntil', e.target.value)}
                    className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-purple-500"
                  />
                  <p className="text-sm text-gray-500 mt-1">Ak je vozidlo rezervované, vyberte dátum do kedy</p>
                </div>

                {/* Show on Homepage */}
                <div className="flex items-center p-4 bg-purple-50 rounded-lg border border-purple-200">
                  <input
                    type="checkbox"
                    id="showOnHomepage"
                    checked={carForm.showOnHomepage}
                    onChange={(e) => handleCarFormChange('showOnHomepage', e.target.checked)}
                    className="w-5 h-5 text-purple-600 rounded focus:ring-2 focus:ring-purple-500"
                  />
                  <label htmlFor="showOnHomepage" className="ml-3 text-sm font-semibold text-purple-900">
                    Zobraziť na domovskej stránke v sekcii "Najnovšie vozidlá"
                  </label>
                </div>

                {/* Upload Progress */}
                {uploadProgress && (
                  <div className="p-4 bg-blue-50 rounded-lg border border-blue-200">
                    <div className="flex items-center">
                      <div className="w-5 h-5 border-2 border-blue-600 border-t-transparent rounded-full animate-spin mr-3"></div>
                      <span className="text-blue-700 font-medium">{uploadProgress}</span>
                    </div>
                  </div>
                )}
              </form>

              {/* Fixed Footer with Buttons */}
              <div className="flex-shrink-0 bg-white border-t border-gray-200 px-6 py-4">
                <div className="flex gap-4">
                  <button
                    type="button"
                    onClick={closeAddModal}
                    className="flex-1 px-6 py-3 border border-gray-300 rounded-lg font-semibold text-gray-700 hover:bg-gray-50 transition-colors"
                    disabled={submitting}
                  >
                    Zrušiť
                  </button>
                  <button
                    type="submit"
                    form="carForm"
                    disabled={submitting}
                    className="flex-1 bg-gradient-to-r from-purple-600 to-blue-600 hover:from-purple-700 hover:to-blue-700 text-white py-3 px-6 rounded-lg font-bold text-lg transition-colors disabled:opacity-50"
                  >
                    {submitting ? (
                      <span className="flex items-center justify-center">
                        <svg className="animate-spin -ml-1 mr-3 h-5 w-5 text-white" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                          <circle className="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="4"></circle>
                          <path className="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
                        </svg>
                        Ukladám...
                      </span>
                    ) : (
                      isEditMode ? 'Upraviť vozidlo' : 'Pridať vozidlo'
                    )}
                  </button>
                </div>
              </div>
            </div>
          </div>
        </div>
      )}
    </div>
  )
}