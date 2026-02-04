import { useState, useEffect } from 'react'
import { PlusIcon, MagnifyingGlassIcon, FunnelIcon, XMarkIcon, PencilIcon, TrashIcon, PrinterIcon, ArrowPathIcon } from '@heroicons/react/24/outline'
import CarCard from '../components/CarCard'
import { equipmentCategories } from '../data/equipmentOptions'
import { useAuth } from '../contexts/AuthContext'
import { useTranslation, tCategory as translateCategory, tEquipment as translateEquipment } from '../i18n'
import { getCarsForSite, createCar, updateCar, deleteCar as deleteCarApi, getAllCarsForSite, restoreCar, permanentlyDeleteCar } from '../api/cars'
import { uploadCarImageOnly, deleteCarGalleryImage, deleteAllCarImagesAndAssets } from '../api/carsImages'
import { getPublicUrl, uploadCarPdf } from '../api/storage'
import { ensureValidSession } from '../lib/supabaseClient'
import { compressImage } from '../lib/fileUtils'
import logo from '../logo.png'

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
  stkValidUntil: '',
  drivetrain: '',
  vin: '',
  description: '',
  features: [],
  // Unified image list: [{type: 'existing', data: 'path'}, {type: 'pending', data: File}]
  allImages: [],
  reservedUntil: '',
  showOnHomepage: false,
  // New fields
  doors: '',
  color: '',
  countryOfOrigin: '',
  reserved: false,
  month: '',
  vatDeductible: false,
  priceWithoutVat: 0,
  transmissionGears: '',
  airbagCount: '',
  radioCd: false,
  radioCdMp3: false,
  androidAuto: false,
  acType: '',
  acZones: '',
  parkingSensors: '',
  electricWindows: '',
  heatedSeats: '',
  // PDF documents
  serviceBookPdf: null, // existing path or null
  cebiaProtocolPdf: null, // existing path or null
  pendingServiceBookPdf: null, // File object for new upload
  pendingCebiaProtocolPdf: null // File object for new upload
}

export default function Vozidla() {
  const { currentSite, loading: authLoading } = useAuth()
  const { t, tCategory, tEquipment } = useTranslation()
  const isAutocentrumMaxi = currentSite?.slug === 'autocentrummaxi'

  // Helper for translating transmission value
  const getTranslatedTransmission = (val, langCode) => {
    if (!val) return ''
    if (langCode === 'cs') {
      if (val === 'Manuálna') return 'Manuální'
      if (val === 'Automatická') return 'Automatická'
    }
    return val
  }

  const [cars, setCars] = useState([])
  const [archivedCars, setArchivedCars] = useState([])
  const [activeTab, setActiveTab] = useState('ponuka') // 'ponuka' or 'archiv'
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

  // Load cars from Supabase (both active and archived)
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
        // Load all cars including deleted
        const allData = await getAllCarsForSite(currentSite.id, true)
        if (!cancelled) {
          // Split into active and archived
          setCars(allData.filter(c => !c.deletedAt))
          setArchivedCars(allData.filter(c => c.deletedAt))
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
      const allData = await getAllCarsForSite(currentSite.id, true)
      setCars(allData.filter(c => !c.deletedAt))
      setArchivedCars(allData.filter(c => c.deletedAt))
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

  // Get current cars based on active tab
  const currentCars = activeTab === 'ponuka' ? cars : archivedCars

  // Filter cars based on search and filters
  const filteredCars = currentCars.filter(car => {
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
      stkValidUntil: car.stkValidUntil || '',
      drivetrain: car.drivetrain || '',
      vin: car.vin || '',
      description: car.description || '',
      features: car.features || [],
      allImages,
      reservedUntil: car.reservedUntil || '',
      showOnHomepage: car.showOnHomepage || false,
      // New fields
      doors: car.doors || '',
      color: car.color || '',
      countryOfOrigin: car.countryOfOrigin || '',
      reserved: car.reserved || false,
      month: car.month || '',
      vatDeductible: car.vatDeductible || false,
      priceWithoutVat: car.priceWithoutVat || 0,
      transmissionGears: car.transmissionGears || '',
      airbagCount: car.airbagCount || '',
      radioCd: car.radioCd || false,
      radioCdMp3: car.radioCdMp3 || false,
      androidAuto: car.androidAuto || false,
      acType: car.acType || '',
      acZones: car.acZones || '',
      parkingSensors: car.parkingSensors || '',
      electricWindows: car.electricWindows || '',
      heatedSeats: car.heatedSeats || '',
      // PDF documents
      serviceBookPdf: car.serviceBookPdf || null,
      cebiaProtocolPdf: car.cebiaProtocolPdf || null,
      pendingServiceBookPdf: null,
      pendingCebiaProtocolPdf: null
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
      alert(t('prosimVyplnte'))
      return
    }

    if (!currentSite?.id) {
      alert(t('chybaNieJeStranka'))
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
        stkValidUntil: carForm.stkValidUntil || undefined,
        drivetrain: carForm.drivetrain || undefined,
        vin: carForm.vin || undefined,
        description: carForm.description || undefined,
        reservedUntil: carForm.reservedUntil || undefined,
        showOnHomepage: carForm.showOnHomepage,
        source: 'admin',
        // New fields
        doors: carForm.doors || undefined,
        color: carForm.color || undefined,
        countryOfOrigin: carForm.countryOfOrigin || undefined,
        reserved: carForm.reserved,
        month: carForm.month ? parseInt(carForm.month) : undefined,
        vatDeductible: carForm.vatDeductible,
        priceWithoutVat: carForm.vatDeductible && carForm.price ? Math.round(carForm.price / (isAutocentrumMaxi ? 1.21 : 1.23)) : undefined,
        transmissionGears: carForm.transmissionGears || undefined,
        airbagCount: carForm.airbagCount ? parseInt(carForm.airbagCount) : undefined,
        radioCd: carForm.radioCd,
        radioCdMp3: carForm.radioCdMp3,
        androidAuto: carForm.androidAuto,
        acType: carForm.acType || undefined,
        acZones: carForm.acZones || undefined,
        parkingSensors: carForm.parkingSensors || undefined,
        electricWindows: carForm.electricWindows || undefined,
        heatedSeats: carForm.heatedSeats || undefined,
      }

      if (isEditMode && editingCar) {
        // Update existing car with basic data first
        await withTimeout(updateCar(editingCar.id, carData, currentSite.id), 30000, 'Updating car')
        setUploadProgress(t('vozidloAktualizovane'))
      } else {
        // Create new car first to get the ID
        setUploadProgress(t('vytvaramVozidlo'))
        const newCar = await withTimeout(createCar(currentSite.id, carData), 30000, 'Creating car')
        carId = newCar.id
      }

      // Upload pending files and collect their paths
      const uploadedPaths = new Map() // Map File -> uploaded path
      if (pendingFiles.length > 0 && carId) {
        const totalFiles = pendingFiles.length

        for (let i = 0; i < pendingFiles.length; i++) {
          const file = pendingFiles[i]
          setUploadProgress(`${t('komprimujemObrazok')} ${i + 1}/${totalFiles}...`)

          // Compress image to max 500KB before upload
          let fileToUpload = file
          try {
            fileToUpload = await compressImage(file, 500)
          } catch (compressErr) {
            console.warn('Compression failed, uploading original:', compressErr)
          }

          setUploadProgress(`${t('nahravamObrazok')} ${i + 1}/${totalFiles}...`)

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

      // Upload PDF files if provided
      let serviceBookPdfPath = carForm.serviceBookPdf
      let cebiaProtocolPdfPath = carForm.cebiaProtocolPdf

      if (carForm.pendingServiceBookPdf && carId) {
        setUploadProgress('Nahrávam servisnú knižku...')
        const { path } = await withTimeout(
          uploadCarPdf({
            file: carForm.pendingServiceBookPdf,
            siteSlug,
            carId,
            pdfType: 'service-book'
          }),
          60000,
          'Uploading service book PDF'
        )
        serviceBookPdfPath = path
      }

      if (carForm.pendingCebiaProtocolPdf && carId) {
        setUploadProgress('Nahrávam Cebia protokol...')
        const { path } = await withTimeout(
          uploadCarPdf({
            file: carForm.pendingCebiaProtocolPdf,
            siteSlug,
            carId,
            pdfType: 'cebia-protocol'
          }),
          60000,
          'Uploading Cebia protocol PDF'
        )
        cebiaProtocolPdfPath = path
      }

      // Update car with final image order and PDF paths
      const updateData = {
        serviceBookPdf: serviceBookPdfPath,
        cebiaProtocolPdf: cebiaProtocolPdfPath
      }

      if (finalImagePaths.length > 0) {
        setUploadProgress(t('ukladamPoradieObrazkov'))
        await withTimeout(updateCar(carId, {
          image: finalImagePaths[0], // First image is main
          images: finalImagePaths.slice(1), // Rest are gallery
          ...updateData
        }, currentSite.id), 30000, 'Saving image order')
      } else {
        // No images - clear them but keep PDFs
        await withTimeout(updateCar(carId, {
          image: null,
          images: [],
          ...updateData
        }, currentSite.id), 30000, 'Clearing images')
      }

      setUploadProgress('')
      alert(isEditMode ? t('vozidloUspesneUpravene') : t('vozidloUspesnePridane'))
      closeAddModal()
      await loadCars()
    } catch (err) {
      console.error('Error saving car:', err)
      alert(t('chybaPriUkladani') + err.message)
    } finally {
      setSubmitting(false)
      setUploadProgress('')
    }
  }

  const handleDeleteCar = async (carId) => {
    if (window.confirm(t('steIsti'))) {
      try {
        // Soft delete - just marks deleted_at, doesn't remove images
        await deleteCarApi(carId)
        setSelectedCar(null)
        await loadCars()
      } catch (err) {
        console.error('Error deleting car:', err)
        alert(t('chybaPriMazani') + err.message)
      }
    }
  }

  // Restore a soft-deleted car
  const handleRestoreCar = async (carId) => {
    if (window.confirm('Chcete obnoviť toto vozidlo?')) {
      try {
        await restoreCar(carId)
        setSelectedCar(null)
        await loadCars()
      } catch (err) {
        console.error('Error restoring car:', err)
        alert('Chyba pri obnovovaní vozidla: ' + err.message)
      }
    }
  }

  // Permanently delete a car (from archive)
  const handlePermanentDelete = async (carId) => {
    if (window.confirm('Ste si istí, že chcete NATRVALO odstrániť toto vozidlo? Táto akcia je nevratná!')) {
      try {
        const car = archivedCars.find(c => c.id === carId)

        // Delete all images from storage and media_assets
        if (car && currentSite?.slug) {
          await deleteAllCarImagesAndAssets({
            carId,
            siteId: currentSite.id,
            siteSlug: currentSite.slug
          })
        }

        // Permanently delete the car record
        await permanentlyDeleteCar(carId)
        setSelectedCar(null)
        await loadCars()
      } catch (err) {
        console.error('Error permanently deleting car:', err)
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

    // Check if current site is autocentrummaxi (Czech site)
    // const isAutocentrumMaxi = currentSite?.slug === 'autocentrummaxi' // Already defined at component level
    const pdfLang = isAutocentrumMaxi ? 'cs' : 'sk'

    // Format price based on site (autocentrummaxi prices are already in CZK)
    const formatPrice = (price) => {
      if (!price) return 'N/A'
      if (isAutocentrumMaxi) {
        return `${price.toLocaleString('cs-CZ')} Kč`
      }
      return `${price.toLocaleString()} €`
    }

    // Translate labels for Czech
    const labels = isAutocentrumMaxi ? {
      rokVyroby: 'Rok výroby',
      pocetKm: 'Počet km',
      palivo: 'Palivo',
      prevodovka: 'Převodovka',
      vykon: 'Výkon',
      karoserie: 'Karoserie',
      platnostStk: 'Platnost STK/EK',
      pohon: 'Pohon',
      vin: 'VIN',
      priceNote: 'Možný leasing, Možný úvěr'
    } : {
      rokVyroby: 'Rok výroby',
      pocetKm: 'Počet km',
      palivo: 'Palivo',
      prevodovka: 'Prevodovka',
      vykon: 'Výkon',
      karoserie: 'Karoséria',
      platnostStk: 'Platnosť STK/EK',
      pohon: 'Pohon',
      vin: 'VIN',
      priceNote: 'Možný leasing, Možný úver'
    }

    // Helper to format date
    const formatDate = (dateString) => {
      if (!dateString) return 'N/A'
      const date = new Date(dateString)
      const month = (date.getMonth() + 1).toString().padStart(2, '0')
      const year = date.getFullYear()
      return `${month}/${year}`
    }

    const isMtAutos = currentSite?.slug === 'cars'

    const printContent = `
      <!DOCTYPE html>
      <html>
      <head>
        <meta charset="UTF-8">
        <title> </title>
        <style>
          * { margin: 0; padding: 0; box-sizing: border-box; }
          html, body { height: 100%; }
          body { font-family: Arial, sans-serif; padding: 50px; max-width: 800px; margin: 0 auto; -webkit-print-color-adjust: exact; display: flex; flex-direction: column; }
          .content { flex: 1; }
          .logo-container {
            width: 200px;
            margin-bottom: 20px;
          }
          .logo-img {
            max-width: 100%;
            height: auto;
          }
          .header { text-align: center; border: 2px solid #000; padding: 10px 15px; margin-bottom: 15px; }
          .title { font-size: 52px; font-weight: bold; }
          .subtitle { font-size: 18px; color: #666; }
          .info-box { border: 2px solid #000; padding: 15px 20px; margin-bottom: 15px; display: grid; grid-template-columns: 1.2fr 1.8fr; gap: 8px 10px; }
          .info-row { font-size: 26px; }
          .info-label { font-weight: normal; }
          .info-value { font-weight: bold; color: #000; font-size: 26px; }
          .section-title { font-weight: bold; margin: 20px 0 10px 0; font-size: 16px; border-bottom: 1px solid #000; padding-bottom: 5px; }
          .features-section { margin-bottom: 15px; }
          .features-category { font-weight: bold; margin-bottom: 5px; font-size: 15px; }
          .features-list { display: flex; flex-wrap: wrap; gap: 6px; }
          .feature-item { background: #f3f4f6; padding: 3px 10px; font-size: 14px; }
          .description { margin: 20px 0; }
          .description-title { font-weight: bold; margin-bottom: 10px; }
          .price-box { text-align: right; border: 2px solid #000; padding: 10px 15px; margin-top: auto; }
          .price { font-size: 78px; font-weight: bold; }
          .price-note { font-size: 14px; color: #666; margin-top: 5px; }
          @page { size: auto; margin: 0; }
          @media print {
            html, body { height: 100%; }
            body {
              padding: 15mm;
              -webkit-print-color-adjust: exact;
              display: flex;
              flex-direction: column;
            }
            .content { flex: 1; }
            .price-box { margin-top: auto; }
            .no-print {
              display: none !important;
            }
          }
        </style>
      </head>
      <body>
        ${!isAutocentrumMaxi ? `
        <div class="logo-container">
          <img src="${logo}" alt="Logo" class="logo-img"/>
        </div>
        ` : ''}
        <div class="content">
          <div class="header">
            <div class="title">${car.brand} ${car.model}</div>
          </div>

          <div class="info-box">
            <div class="info-row"><span class="info-label">${labels.rokVyroby}:</span> <span class="info-value">${car.year}</span></div>
            <div class="info-row"><span class="info-label">${labels.pocetKm}:</span> <span class="info-value">${car.mileage?.toLocaleString() || 'N/A'} km</span></div>
            <div class="info-row"><span class="info-label">${labels.palivo}:</span> <span class="info-value">${car.fuel || 'N/A'}</span></div>
            <div class="info-row"><span class="info-label">${labels.prevodovka}:</span> <span class="info-value">${getTranslatedTransmission(car.transmission, pdfLang) || 'N/A'}</span></div>
            ${car.power ? `<div class="info-row"><span class="info-label">${labels.vykon}:</span> <span class="info-value">${car.power}</span></div>` : ''}
            ${isMtAutos ?
        `<div class="info-row"><span class="info-label">${labels.platnostStk}:</span> <span class="info-value">${formatDate(car.stkValidUntil)}</span></div>` :
        (car.bodyType ? `<div class="info-row"><span class="info-label">${labels.karoserie}:</span> <span class="info-value">${car.bodyType}</span></div>` : '')
      }
            ${car.drivetrain ? `<div class="info-row"><span class="info-label">${labels.pohon}:</span> <span class="info-value">${car.drivetrain}</span></div>` : ''}
            ${car.vin ? `<div class="info-row"><span class="info-label">${labels.vin}:</span> <span class="info-value">${car.vin}</span></div>` : ''}
          </div>

          ${Object.keys(featuresByCategory).length > 0 ? `
            ${Object.entries(featuresByCategory).map(([category, features]) => `
              <div class="features-section">
                <div class="features-category">${translateCategory(category, pdfLang)}</div>
                <div class="features-list">
                  ${features.map(f => `<span class="feature-item">${translateEquipment(f, pdfLang)}</span>`).join('')}
                </div>
              </div>
            `).join('')}
          ` : ''}
        </div>

        <div class="price-box">
          <div class="price">${formatPrice(car.price)}</div>
          <div class="price-note">${labels.priceNote}</div>
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
          <p className="text-gray-600">{t('nacitavamVozidla')}</p>
        </div>
      </div>
    )
  }

  if (!currentSite) {
    return (
      <div className="flex items-center justify-center h-64">
        <p className="text-gray-500">{t('vyberteStrankuPre')}</p>
      </div>
    )
  }

  if (error) {
    return (
      <div className="bg-red-50 border border-red-200 rounded-xl p-6 text-center">
        <p className="text-red-600 mb-4">{t('chybaPriNacitavani')}{error}</p>
        <button
          onClick={loadCars}
          className="px-4 py-2 bg-red-600 text-white rounded-lg hover:bg-red-700"
        >
          {t('skusitZnova')}
        </button>
      </div>
    )
  }

  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-2xl font-bold text-gray-900">{t('vozidla')}</h1>
          <p className="mt-1 text-sm text-gray-500">
            {t('spravujtePonuku')}
          </p>
        </div>
        <button
          onClick={openAddModal}
          className="inline-flex items-center px-4 py-2 border border-transparent shadow-sm text-sm font-medium rounded-xl text-white bg-gradient-to-r from-purple-600 to-blue-600 hover:from-purple-700 hover:to-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-purple-500 transition-all"
        >
          <PlusIcon className="-ml-1 mr-2 h-5 w-5" />
          {t('pridatVozidlo')}
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
              placeholder={t('hladatVozidlo')}
              value={searchTerm}
              onChange={(e) => setSearchTerm(e.target.value)}
              className="w-full pl-10 pr-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-purple-500 focus:border-transparent"
            />
          </div>

          {/* Filter Toggle */}
          <button
            onClick={() => setShowFilters(!showFilters)}
            className={`inline-flex items-center px-4 py-2 border rounded-lg text-sm font-medium transition-colors ${showFilters
              ? 'bg-purple-100 border-purple-300 text-purple-700'
              : 'bg-white border-gray-300 text-gray-700 hover:bg-gray-50'
              }`}
          >
            <FunnelIcon className="h-5 w-5 mr-2" />
            {t('filtre')}
          </button>
        </div>

        {/* Expanded Filters */}
        {showFilters && (
          <div className="mt-4 pt-4 border-t border-gray-200">
            <div className="grid grid-cols-1 md:grid-cols-3 lg:grid-cols-6 gap-4">
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">{t('palivo')}</label>
                <select
                  value={filters.fuel}
                  onChange={(e) => setFilters({ ...filters, fuel: e.target.value })}
                  className="w-full border border-gray-300 rounded-lg px-3 py-2 focus:ring-2 focus:ring-purple-500"
                >
                  <option value="">{t('vsetky')}</option>
                  <option value="Benzín">{t('benzin')}</option>
                  <option value="Diesel">{t('diesel')}</option>
                  <option value="Hybrid">{t('hybrid')}</option>
                  <option value="Elektro">{t('elektro')}</option>
                  <option value="LPG">{t('lpg')}</option>
                  <option value="Benzín + LPG">Benzín + LPG</option>
                  <option value="CNG">{t('cng')}</option>
                </select>
              </div>

              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">{t('prevodovka')}</label>
                <select
                  value={filters.transmission}
                  onChange={(e) => setFilters({ ...filters, transmission: e.target.value })}
                  className="w-full border border-gray-300 rounded-lg px-3 py-2 focus:ring-2 focus:ring-purple-500"
                >
                  <option value="">{t('vsetky')}</option>
                  <option value="Manuálna">{t('manualna')}</option>
                  <option value="Automatická">{t('automaticka')}</option>
                </select>
              </div>

              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">{t('cenaOd')}</label>
                <input
                  type="number"
                  placeholder={t('minEur')}
                  value={filters.priceMin}
                  onChange={(e) => setFilters({ ...filters, priceMin: e.target.value })}
                  className="w-full border border-gray-300 rounded-lg px-3 py-2 focus:ring-2 focus:ring-purple-500"
                />
              </div>

              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">{t('cenaDo')}</label>
                <input
                  type="number"
                  placeholder={t('maxEur')}
                  value={filters.priceMax}
                  onChange={(e) => setFilters({ ...filters, priceMax: e.target.value })}
                  className="w-full border border-gray-300 rounded-lg px-3 py-2 focus:ring-2 focus:ring-purple-500"
                />
              </div>

              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">{t('rokOd')}</label>
                <input
                  type="number"
                  placeholder={t('minRok')}
                  value={filters.yearMin}
                  onChange={(e) => setFilters({ ...filters, yearMin: e.target.value })}
                  className="w-full border border-gray-300 rounded-lg px-3 py-2 focus:ring-2 focus:ring-purple-500"
                />
              </div>

              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">{t('rokDo')}</label>
                <input
                  type="number"
                  placeholder={t('maxRok')}
                  value={filters.yearMax}
                  onChange={(e) => setFilters({ ...filters, yearMax: e.target.value })}
                  className="w-full border border-gray-300 rounded-lg px-3 py-2 focus:ring-2 focus:ring-purple-500"
                />
              </div>
            </div>

            <div className="mt-4 flex justify-end">
              <button
                onClick={clearFilters}
                className="text-sm text-gray-600 hover:text-gray-900"
              >
                {t('vymazatFiltre')}
              </button>
            </div>
          </div>
        )}
      </div>

      {/* Tabs and Results count */}
      <div className="flex items-center justify-between">
        {/* Tabs */}
        <div className="flex items-end">
          <button
            onClick={() => setActiveTab('ponuka')}
            className={`relative px-6 py-2 text-sm font-semibold transition-all ${activeTab === 'ponuka'
              ? 'bg-white text-purple-700 rounded-t-lg shadow-sm z-10'
              : 'bg-gray-100 text-gray-500 hover:text-gray-700 rounded-t-lg -mr-1 translate-y-0.5'
              }`}
            style={activeTab === 'ponuka' ? { boxShadow: '0 -2px 4px rgba(0,0,0,0.05)' } : {}}
          >
            Ponuka
            <span className={`ml-2 px-2 py-0.5 rounded-full text-xs ${activeTab === 'ponuka' ? 'bg-purple-100 text-purple-700' : 'bg-gray-200 text-gray-600'
              }`}>
              {cars.length}
            </span>
          </button>
          <button
            onClick={() => setActiveTab('archiv')}
            className={`relative px-6 py-2 text-sm font-semibold transition-all ${activeTab === 'archiv'
              ? 'bg-white text-red-700 rounded-t-lg shadow-sm z-10'
              : 'bg-gray-100 text-gray-500 hover:text-gray-700 rounded-t-lg -ml-1 translate-y-0.5'
              }`}
            style={activeTab === 'archiv' ? { boxShadow: '0 -2px 4px rgba(0,0,0,0.05)' } : {}}
          >
            Archív
            <span className={`ml-2 px-2 py-0.5 rounded-full text-xs ${activeTab === 'archiv' ? 'bg-red-100 text-red-700' : 'bg-gray-200 text-gray-600'
              }`}>
              {archivedCars.length}
            </span>
          </button>
        </div>
        {/* Results count */}
        <div className="text-sm text-gray-600">
          {t('zobrazujem')} {filteredCars.length} {t('z')} {currentCars.length} {t('vozidiel')}
        </div>
      </div>

      {/* Cars Grid */}
      <div className={`grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6 ${activeTab === 'archiv' ? 'bg-gray-50 p-4 rounded-lg -mt-2 pt-6' : ''}`}>
        {filteredCars.map((car) => (
          <div key={car.id} className="relative">
            {activeTab === 'archiv' && (
              <div className="absolute top-2 left-2 z-10 bg-red-600 text-white px-2 py-1 rounded-lg text-xs font-bold">
                VYMAZANÉ
              </div>
            )}
            <div className={activeTab === 'archiv' ? 'opacity-75' : ''}>
              <CarCard car={car} onClick={() => handleCarClick(car)} getImageUrl={getImageUrl} currency={currentSite?.slug === 'autocentrummaxi' ? 'Kč' : 'EUR'} />
            </div>
          </div>
        ))}
      </div>

      {/* Empty State */}
      {filteredCars.length === 0 && (
        <div className="text-center py-12">
          <div className="text-gray-400 text-5xl mb-4">🚗</div>
          <h3 className="text-lg font-medium text-gray-900 mb-2">{t('ziadneVozidla')}</h3>
          <p className="text-gray-500">{t('skusteZmenit')}</p>
        </div>
      )}

      {/* Car Detail Modal */}
      {selectedCar && (
        <div className="fixed inset-0 z-50 overflow-y-auto" aria-labelledby="modal-title" role="dialog" aria-modal="true">
          <div className="flex items-end justify-center min-h-screen pt-4 px-4 pb-20 text-center sm:block sm:p-0">
            <div className="fixed inset-0 bg-gray-500 bg-opacity-75 transition-opacity" onClick={() => setSelectedCar(null)} />

            <div className="inline-block align-bottom bg-white rounded-xl text-left overflow-hidden shadow-xl transform transition-all sm:my-8 sm:align-middle sm:max-w-3xl sm:w-full">
              <div className="absolute top-4 right-4 z-10 flex gap-2">
                {selectedCar.deletedAt ? (
                  <>
                    <button
                      onClick={() => handleRestoreCar(selectedCar.id)}
                      className="bg-white rounded-full p-2 shadow-lg hover:bg-green-50"
                      title="Obnoviť"
                    >
                      <ArrowPathIcon className="h-6 w-6 text-green-600" />
                    </button>
                    <button
                      onClick={() => handlePermanentDelete(selectedCar.id)}
                      className="bg-white rounded-full p-2 shadow-lg hover:bg-red-50"
                      title="Natrvalo odstrániť"
                    >
                      <TrashIcon className="h-6 w-6 text-red-600" />
                    </button>
                  </>
                ) : (
                  <>
                    <button
                      onClick={() => handlePrintCar(selectedCar)}
                      className="bg-white rounded-full p-2 shadow-lg hover:bg-green-50"
                      title={t('tlacitPdf')}
                    >
                      <PrinterIcon className="h-6 w-6 text-green-600" />
                    </button>
                    <button
                      onClick={() => openEditModal(selectedCar)}
                      className="bg-white rounded-full p-2 shadow-lg hover:bg-blue-50"
                      title={t('upravit')}
                    >
                      <PencilIcon className="h-6 w-6 text-blue-600" />
                    </button>
                    <button
                      onClick={() => handleDeleteCar(selectedCar.id)}
                      className="bg-white rounded-full p-2 shadow-lg hover:bg-red-50"
                      title={t('odstranit')}
                    >
                      <TrashIcon className="h-6 w-6 text-red-600" />
                    </button>
                  </>
                )}
                <button
                  onClick={() => setSelectedCar(null)}
                  className="bg-white rounded-full p-2 shadow-lg hover:bg-gray-100"
                >
                  <XMarkIcon className="h-6 w-6 text-gray-600" />
                </button>
              </div>

              {selectedCar.deletedAt && (
                <div className="bg-red-600 text-white text-center py-2 font-bold">
                  VYMAZANÉ - {new Date(selectedCar.deletedAt).toLocaleDateString('sk-SK')}
                </div>
              )}

              <div className="relative h-64 sm:h-80">
                <img
                  src={getImageUrl(selectedCar.image)}
                  alt={`${selectedCar.brand} ${selectedCar.model}`}
                  className={`w-full h-full object-cover ${selectedCar.deletedAt ? 'grayscale' : ''}`}
                />
                <div className="absolute bottom-4 left-4 bg-gradient-to-r from-purple-600 to-blue-600 text-white px-4 py-2 rounded-lg text-xl font-bold">
                  {selectedCar.price?.toLocaleString()} {currentSite?.slug === 'autocentrummaxi' ? 'Kč' : 'EUR'}
                </div>
                {selectedCar.source === 'admin' && !selectedCar.deletedAt && (
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
                    <p className="text-sm text-gray-500">{t('rok')}</p>
                    <p className="font-semibold">{selectedCar.year}</p>
                  </div>
                  <div className="bg-gray-50 rounded-lg p-3">
                    <p className="text-sm text-gray-500">{t('kilometre')}</p>
                    <p className="font-semibold">{selectedCar.mileage.toLocaleString()} km</p>
                  </div>
                  <div className="bg-gray-50 rounded-lg p-3">
                    <p className="text-sm text-gray-500">{t('palivo')}</p>
                    <p className="font-semibold">{selectedCar.fuel}</p>
                  </div>
                  <div className="bg-gray-50 rounded-lg p-3">
                    <p className="text-sm text-gray-500">{t('prevodovka')}</p>
                    <p className="font-semibold">{getTranslatedTransmission(selectedCar.transmission, isAutocentrumMaxi ? 'cs' : 'sk')}</p>
                  </div>
                  <div className="bg-gray-50 rounded-lg p-3">
                    <p className="text-sm text-gray-500">{t('motor')}</p>
                    <p className="font-semibold">{selectedCar.engine || 'N/A'}</p>
                  </div>
                  <div className="bg-gray-50 rounded-lg p-3">
                    <p className="text-sm text-gray-500">{t('vykon')}</p>
                    <p className="font-semibold">{selectedCar.power || 'N/A'}</p>
                  </div>
                  <div className="bg-gray-50 rounded-lg p-3">
                    <p className="text-sm text-gray-500">{t('karoseria')}</p>
                    <p className="font-semibold">{selectedCar.bodyType || 'N/A'}</p>
                  </div>
                  <div className="bg-gray-50 rounded-lg p-3">
                    <p className="text-sm text-gray-500">{t('pohon')}</p>
                    <p className="font-semibold">{selectedCar.drivetrain || 'N/A'}</p>
                  </div>
                </div>

                {/* Gallery Images */}
                {selectedCar.images && selectedCar.images.length > 0 && (
                  <div className="mb-6">
                    <h3 className="text-lg font-semibold mb-3">{t('galeria')}</h3>
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
                    <h3 className="text-lg font-semibold mb-2">{t('popis')}</h3>
                    <p className="text-gray-600">{selectedCar.description}</p>
                  </div>
                )}

                {selectedCar.features && selectedCar.features.length > 0 && (
                  <div>
                    <h3 className="text-lg font-semibold mb-3">{t('vybava')}</h3>
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
                  {isEditMode ? t('upravitVozidlo') : t('pridatNoveVozidlo')}
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
                    <label className="block text-sm font-semibold mb-2">{t('znacka')} *</label>
                    <input
                      type="text"
                      value={carForm.brand}
                      onChange={(e) => handleCarFormChange('brand', e.target.value)}
                      className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-purple-500"
                      required
                    />
                  </div>

                  <div>
                    <label className="block text-sm font-semibold mb-2">{t('model')} *</label>
                    <input
                      type="text"
                      value={carForm.model}
                      onChange={(e) => handleCarFormChange('model', e.target.value)}
                      className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-purple-500"
                      required
                    />
                  </div>

                  <div>
                    <label className="block text-sm font-semibold mb-2">{t('rok')}</label>
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
                    <label className="block text-sm font-semibold mb-2">{t('mesiacVyroby')}</label>
                    <select
                      value={carForm.month}
                      onChange={(e) => handleCarFormChange('month', e.target.value)}
                      className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-purple-500"
                    >
                      <option value="">{t('vyberteMessiac')}</option>
                      <option value="1">{t('januar')}</option>
                      <option value="2">{t('februar')}</option>
                      <option value="3">{t('marec')}</option>
                      <option value="4">{t('april')}</option>
                      <option value="5">{t('maj')}</option>
                      <option value="6">{t('jun')}</option>
                      <option value="7">{t('jul')}</option>
                      <option value="8">{t('august')}</option>
                      <option value="9">{t('september')}</option>
                      <option value="10">{t('oktober')}</option>
                      <option value="11">{t('november')}</option>
                      <option value="12">{t('december')}</option>
                    </select>
                  </div>

                  <div>
                    <label className="block text-sm font-semibold mb-2">{t('cenaEur')}</label>
                    <input
                      type="number"
                      value={carForm.price}
                      onChange={(e) => handleCarFormChange('price', parseFloat(e.target.value))}
                      className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-purple-500"
                      min="0"
                    />
                  </div>

                  <div className="flex items-end">
                    <label className="flex items-center space-x-2 cursor-pointer hover:bg-gray-50 p-2 rounded h-[42px]">
                      <input
                        type="checkbox"
                        checked={carForm.vatDeductible}
                        onChange={(e) => handleCarFormChange('vatDeductible', e.target.checked)}
                        className="w-4 h-4 text-purple-600 border-gray-300 rounded focus:ring-2 focus:ring-purple-500"
                      />
                      <span className="text-sm font-semibold">{t('odpocetDph')}</span>
                    </label>
                  </div>

                  {carForm.vatDeductible && (
                    <div>
                      <label className="block text-sm font-semibold mb-2">{t('cenaBezDph')}</label>
                      <input
                        type="number"
                        value={carForm.price ? Math.round(carForm.price / (isAutocentrumMaxi ? 1.21 : 1.23)) : ''}
                        readOnly
                        className="w-full px-3 py-2 border border-green-300 rounded-lg bg-green-50 text-green-700 font-semibold cursor-not-allowed"
                      />
                    </div>
                  )}

                  <div>
                    <label className="block text-sm font-semibold mb-2">{t('najazdenekm')}</label>
                    <input
                      type="number"
                      value={carForm.mileage}
                      onChange={(e) => handleCarFormChange('mileage', parseInt(e.target.value))}
                      className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-purple-500"
                      min="0"
                    />
                  </div>

                  <div>
                    <label className="block text-sm font-semibold mb-2">{t('palivo')} *</label>
                    <select
                      value={carForm.fuel}
                      onChange={(e) => handleCarFormChange('fuel', e.target.value)}
                      className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-purple-500"
                      required
                    >
                      <option value="">{t('vybertePalivo')}</option>
                      <option value="Benzín">{t('benzin')}</option>
                      <option value="Diesel">{t('diesel')}</option>
                      <option value="Hybrid">{t('hybrid')}</option>
                      <option value="Elektro">{t('elektro')}</option>
                      <option value="LPG">{t('lpg')}</option>
                      <option value="Benzín + LPG">Benzín + LPG</option>
                      <option value="CNG">{t('cng')}</option>
                    </select>
                  </div>

                  <div>
                    <label className="block text-sm font-semibold mb-2">{t('prevodovka')} *</label>
                    <select
                      value={carForm.transmission}
                      onChange={(e) => handleCarFormChange('transmission', e.target.value)}
                      className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-purple-500"
                      required
                    >
                      <option value="">{t('vybertePrevodovku')}</option>
                      <option value="Manuálna">{t('manualna')}</option>
                      <option value="Automatická">{t('automaticka')}</option>
                    </select>
                  </div>

                  <div>
                    <label className="block text-sm font-semibold mb-2">{t('pocetStupnov')}</label>
                    <input
                      type="text"
                      value={carForm.transmissionGears}
                      onChange={(e) => handleCarFormChange('transmissionGears', e.target.value)}
                      placeholder={t('napr6')}
                      className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-purple-500"
                    />
                  </div>

                  <div>
                    <label className="block text-sm font-semibold mb-2">{t('motor')}</label>
                    <input
                      type="text"
                      value={carForm.engine}
                      onChange={(e) => handleCarFormChange('engine', e.target.value)}
                      placeholder={t('napr20TDI')}
                      className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-purple-500"
                    />
                  </div>

                  <div>
                    <label className="block text-sm font-semibold mb-2">{t('vykon')}</label>
                    <input
                      type="text"
                      value={carForm.power}
                      onChange={(e) => handleCarFormChange('power', e.target.value)}
                      placeholder={t('napr150kW')}
                      className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-purple-500"
                    />
                  </div>

                  <div>
                    <label className="block text-sm font-semibold mb-2">{t('karoseria')}</label>
                    <input
                      type="text"
                      value={carForm.bodyType}
                      onChange={(e) => handleCarFormChange('bodyType', e.target.value)}
                      placeholder={t('naprHatchback')}
                      className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-purple-500"
                    />
                  </div>

                  <div>
                    <label className="block text-sm font-semibold mb-2 flex justify-between">
                      <span>{t('platnostSTK')}</span>
                      {carForm.stkValidUntil && (
                        <span className="text-purple-600 font-bold">
                          {(() => {
                            const d = new Date(carForm.stkValidUntil);
                            const m = (d.getMonth() + 1).toString().padStart(2, '0');
                            const y = d.getFullYear();
                            return `${m}/${y}`;
                          })()}
                        </span>
                      )}
                    </label>
                    <input
                      type="date"
                      value={carForm.stkValidUntil}
                      onChange={(e) => handleCarFormChange('stkValidUntil', e.target.value)}
                      className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-purple-500"
                    />
                  </div>

                  <div>
                    <label className="block text-sm font-semibold mb-2">{t('pohon')}</label>
                    <input
                      type="text"
                      value={carForm.drivetrain}
                      onChange={(e) => handleCarFormChange('drivetrain', e.target.value)}
                      placeholder={t('naprPredny')}
                      className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-purple-500"
                    />
                  </div>

                  <div>
                    <label className="block text-sm font-semibold mb-2">{t('vin')}</label>
                    <input
                      type="text"
                      value={carForm.vin}
                      onChange={(e) => handleCarFormChange('vin', e.target.value)}
                      className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-purple-500"
                    />
                  </div>

                  <div>
                    <label className="block text-sm font-semibold mb-2">{t('dvere')}</label>
                    <input
                      type="text"
                      value={carForm.doors}
                      onChange={(e) => handleCarFormChange('doors', e.target.value)}
                      placeholder={t('napr5')}
                      className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-purple-500"
                    />
                  </div>

                  <div>
                    <label className="block text-sm font-semibold mb-2">{t('farba')}</label>
                    <input
                      type="text"
                      value={carForm.color}
                      onChange={(e) => handleCarFormChange('color', e.target.value)}
                      placeholder={t('naprCiernaMetaliza')}
                      className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-purple-500"
                    />
                  </div>

                  <div>
                    <label className="block text-sm font-semibold mb-2">{t('krajinaPovodu')}</label>
                    <select
                      value={carForm.countryOfOrigin}
                      onChange={(e) => handleCarFormChange('countryOfOrigin', e.target.value)}
                      className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-purple-500"
                    >
                      <option value="">{t('vyberteKrajinu')}</option>
                      <option value="SK">Slovensko</option>
                      <option value="CZ">Česko</option>
                      <option value="DE">Nemecko</option>
                      <option value="AT">Rakúsko</option>
                      <option value="PL">Poľsko</option>
                      <option value="HU">Maďarsko</option>
                      <option value="NL">Holandsko</option>
                      <option value="BE">Belgicko</option>
                      <option value="FR">Francúzsko</option>
                      <option value="IT">Taliansko</option>
                      <option value="ES">Španielsko</option>
                      <option value="PT">Portugalsko</option>
                      <option value="GB">Veľká Británia</option>
                      <option value="IE">Írsko</option>
                      <option value="DK">Dánsko</option>
                      <option value="SE">Švédsko</option>
                      <option value="NO">Nórsko</option>
                      <option value="FI">Fínsko</option>
                      <option value="CH">Švajčiarsko</option>
                      <option value="LU">Luxembursko</option>
                      <option value="SI">Slovinsko</option>
                      <option value="HR">Chorvátsko</option>
                      <option value="RO">Rumunsko</option>
                      <option value="BG">Bulharsko</option>
                      <option value="GR">Grécko</option>
                      <option value="LT">Litva</option>
                      <option value="LV">Lotyšsko</option>
                      <option value="EE">Estónsko</option>
                      <option value="UA">Ukrajina</option>
                      <option value="US">USA</option>
                    </select>
                  </div>

                </div>

                {/* Description */}
                <div>
                  <label className="block text-sm font-semibold mb-2">{t('popis')}</label>
                  <textarea
                    value={carForm.description}
                    onChange={(e) => handleCarFormChange('description', e.target.value)}
                    rows={8}
                    className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-purple-500"
                    placeholder={t('detailnyPopisVozidla')}
                  />
                </div>

                {/* Features - Equipment Categories */}
                <div>
                  <label className="block text-sm font-semibold mb-2">{t('vybava')}</label>
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
                          <span>{tCategory(category.name)}</span>
                          <span className="text-sm text-gray-600">
                            {carForm.features.filter(f => category.options.includes(f)).length}/{category.options.length} {expandedCategories.includes(category.name) ? '▲' : '▼'}
                          </span>
                        </button>
                        {expandedCategories.includes(category.name) && (
                          <div className="p-4 bg-white">
                            {/* Special dropdown for Bezpečnosť category */}
                            {category.name === 'Bezpečnosť' && (
                              <div className="grid grid-cols-2 md:grid-cols-4 gap-4 mb-4 pb-4 border-b border-gray-200">
                                <div>
                                  <label className="block text-xs font-semibold mb-1 text-purple-700">{t('pocetAirbagov')}</label>
                                  <input
                                    type="number"
                                    value={carForm.airbagCount}
                                    onChange={(e) => handleCarFormChange('airbagCount', e.target.value)}
                                    placeholder={t('napr6')}
                                    min="0"
                                    className="w-full px-2 py-1.5 text-sm border border-purple-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-purple-500 bg-purple-50"
                                  />
                                </div>
                              </div>
                            )}
                            {/* Special dropdowns for Komfort category */}
                            {category.name === 'Komfort' && (
                              <div className="grid grid-cols-2 md:grid-cols-5 gap-4 mb-4 pb-4 border-b border-gray-200">
                                <div>
                                  <label className="block text-xs font-semibold mb-1 text-purple-700">{t('klimatizacia')}</label>
                                  <select
                                    value={carForm.acType}
                                    onChange={(e) => {
                                      handleCarFormChange('acType', e.target.value);
                                      if (e.target.value !== 'automatic') {
                                        handleCarFormChange('acZones', '');
                                      }
                                    }}
                                    className="w-full px-2 py-1.5 text-sm border border-purple-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-purple-500 bg-purple-50"
                                  >
                                    <option value="">{t('ziadna')}</option>
                                    <option value="manual">{t('manualnaKlima')}</option>
                                    <option value="automatic">{t('automatickaKlima')}</option>
                                  </select>
                                </div>
                                {carForm.acType === 'automatic' && (
                                  <div>
                                    <label className="block text-xs font-semibold mb-1 text-purple-700">{t('pocetZon')}</label>
                                    <select
                                      value={carForm.acZones}
                                      onChange={(e) => handleCarFormChange('acZones', e.target.value)}
                                      className="w-full px-2 py-1.5 text-sm border border-purple-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-purple-500 bg-purple-50"
                                    >
                                      <option value="">{t('vyberte')}</option>
                                      <option value="single">{t('jednozonova')}</option>
                                      <option value="dual">{t('dvojzonova')}</option>
                                      <option value="triple">{t('trojzonova')}</option>
                                      <option value="quad">{t('stvorzonova')}</option>
                                    </select>
                                  </div>
                                )}
                                <div>
                                  <label className="block text-xs font-semibold mb-1 text-purple-700">{t('parkovacieSenzory')}</label>
                                  <select
                                    value={carForm.parkingSensors}
                                    onChange={(e) => handleCarFormChange('parkingSensors', e.target.value)}
                                    className="w-full px-2 py-1.5 text-sm border border-purple-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-purple-500 bg-purple-50"
                                  >
                                    <option value="">{t('ziadne')}</option>
                                    <option value="front">{t('predne')}</option>
                                    <option value="rear">{t('zadne')}</option>
                                    <option value="front_rear">{t('predneZadne')}</option>
                                  </select>
                                </div>
                                <div>
                                  <label className="block text-xs font-semibold mb-1 text-purple-700">{t('elektrickeOkna')}</label>
                                  <select
                                    value={carForm.electricWindows}
                                    onChange={(e) => handleCarFormChange('electricWindows', e.target.value)}
                                    className="w-full px-2 py-1.5 text-sm border border-purple-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-purple-500 bg-purple-50"
                                  >
                                    <option value="">{t('ziadne')}</option>
                                    <option value="2">{t('dvaXPredne')}</option>
                                    <option value="4">{t('styriXVsetky')}</option>
                                  </select>
                                </div>
                                <div>
                                  <label className="block text-xs font-semibold mb-1 text-purple-700">{t('vyhrievaneSedadla')}</label>
                                  <select
                                    value={carForm.heatedSeats}
                                    onChange={(e) => handleCarFormChange('heatedSeats', e.target.value)}
                                    className="w-full px-2 py-1.5 text-sm border border-purple-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-purple-500 bg-purple-50"
                                  >
                                    <option value="">{t('ziadne')}</option>
                                    <option value="front">{t('predne')}</option>
                                    <option value="rear">{t('zadne')}</option>
                                    <option value="front_rear">{t('predneZadne')}</option>
                                  </select>
                                </div>
                              </div>
                            )}
                            {/* Audio section for Komfort category */}
                            {category.name === 'Komfort' && (
                              <div className="mb-4 pb-4 border-b border-gray-200">
                                <label className="block text-xs font-semibold mb-2 text-purple-700">{t('audioAZabava')}</label>
                                <div className="flex flex-wrap gap-4">
                                  <label className="flex items-center space-x-2 cursor-pointer hover:bg-purple-50 p-1 rounded">
                                    <input
                                      type="checkbox"
                                      checked={carForm.radioCd}
                                      onChange={(e) => handleCarFormChange('radioCd', e.target.checked)}
                                      className="w-4 h-4 text-purple-600 border-purple-300 rounded focus:ring-2 focus:ring-purple-500"
                                    />
                                    <span className="text-sm">{t('autoradioCd')}</span>
                                  </label>
                                  <label className="flex items-center space-x-2 cursor-pointer hover:bg-purple-50 p-1 rounded">
                                    <input
                                      type="checkbox"
                                      checked={carForm.radioCdMp3}
                                      onChange={(e) => handleCarFormChange('radioCdMp3', e.target.checked)}
                                      className="w-4 h-4 text-purple-600 border-purple-300 rounded focus:ring-2 focus:ring-purple-500"
                                    />
                                    <span className="text-sm">{t('autoradioCdMp3')}</span>
                                  </label>
                                  <label className="flex items-center space-x-2 cursor-pointer hover:bg-purple-50 p-1 rounded">
                                    <input
                                      type="checkbox"
                                      checked={carForm.androidAuto}
                                      onChange={(e) => handleCarFormChange('androidAuto', e.target.checked)}
                                      className="w-4 h-4 text-purple-600 border-purple-300 rounded focus:ring-2 focus:ring-purple-500"
                                    />
                                    <span className="text-sm">{t('androidAuto')}</span>
                                  </label>
                                </div>
                              </div>
                            )}
                            <div className="grid grid-flow-col grid-rows-[repeat(auto-fill,minmax(0,1fr))] md:grid-rows-7 gap-2" style={{ gridTemplateRows: `repeat(${Math.ceil(category.options.length / 4)}, minmax(0, 1fr))` }}>
                              {category.options.map((option) => (
                                <label key={option} className="flex items-center space-x-2 cursor-pointer hover:bg-gray-50 p-1 rounded">
                                  <input
                                    type="checkbox"
                                    checked={carForm.features.includes(option)}
                                    onChange={() => toggleFeature(option)}
                                    className="w-4 h-4 text-purple-600 border-gray-300 rounded focus:ring-2 focus:ring-purple-500"
                                  />
                                  <span className="text-sm">{tEquipment(option)}</span>
                                </label>
                              ))}
                            </div>
                          </div>
                        )}
                      </div>
                    ))}
                  </div>
                </div>

                {/* Images */}
                <div>
                  <label className="block text-sm font-semibold mb-2">{t('fotografie')}</label>
                  <div className="mb-4">
                    <input
                      type="file"
                      multiple
                      accept="image/*"
                      onChange={handleImageUpload}
                      className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-purple-500 file:mr-4 file:py-2 file:px-4 file:rounded-lg file:border-0 file:text-sm file:font-semibold file:bg-purple-50 file:text-purple-700 hover:file:bg-purple-100"
                    />
                    <p className="text-sm text-gray-500 mt-2">{t('vyberteObrazky')}</p>
                  </div>

                  {/* Unified Image Grid (existing + pending) */}
                  {carForm.allImages.length > 0 && (
                    <div>
                      <p className="text-sm font-medium text-gray-700 mb-2">
                        {t('vsetkyObrazky')}
                      </p>
                      <div className="grid grid-cols-4 md:grid-cols-6 lg:grid-cols-8 gap-2">
                        {carForm.allImages.map((item, index) => (
                          <div
                            key={`image-${index}-${item.type}`}
                            className={`relative cursor-grab active:cursor-grabbing ${draggedIndex === index ? 'opacity-50 scale-95' : ''
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
                              className={`w-full h-24 object-cover rounded-lg ${item.type === 'pending' ? 'border-2 border-dashed border-green-400' : ''
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
                                {t('hlavna')}
                              </span>
                            )}
                            <span className="absolute top-1 left-1 bg-gray-800 bg-opacity-60 text-white text-xs px-1 rounded">
                              {index + 1}
                            </span>
                            {item.type === 'pending' && (
                              <span className="absolute bottom-1 right-1 bg-green-600 text-white text-xs px-1 rounded">
                                {t('nove')}
                              </span>
                            )}
                          </div>
                        ))}
                      </div>
                    </div>
                  )}
                </div>

                {/* PDF Documents */}
                <div className="bg-blue-50 rounded-lg border border-blue-200 p-4">
                  <label className="block text-sm font-semibold mb-4 text-blue-900">PDF Dokumenty</label>
                  <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                    {/* Service Book PDF */}
                    <div>
                      <label className="block text-sm font-medium mb-2 text-blue-800">Servisná knižka</label>
                      {carForm.serviceBookPdf && !carForm.pendingServiceBookPdf && (
                        <div className="flex items-center gap-2 mb-2 p-2 bg-white rounded border border-blue-200">
                          <span className="text-green-600">✓</span>
                          <span className="text-sm text-gray-700 truncate flex-1">Nahraté</span>
                          <a
                            href={getImageUrl(carForm.serviceBookPdf)}
                            target="_blank"
                            rel="noopener noreferrer"
                            className="text-blue-600 hover:text-blue-800 text-sm underline"
                          >
                            Zobraziť
                          </a>
                          <button
                            type="button"
                            onClick={() => handleCarFormChange('serviceBookPdf', null)}
                            className="text-red-500 hover:text-red-700 text-sm"
                          >
                            Odstrániť
                          </button>
                        </div>
                      )}
                      {carForm.pendingServiceBookPdf && (
                        <div className="flex items-center gap-2 mb-2 p-2 bg-green-50 rounded border border-green-200">
                          <span className="text-green-600">📄</span>
                          <span className="text-sm text-gray-700 truncate flex-1">{carForm.pendingServiceBookPdf.name}</span>
                          <button
                            type="button"
                            onClick={() => handleCarFormChange('pendingServiceBookPdf', null)}
                            className="text-red-500 hover:text-red-700 text-sm"
                          >
                            Zrušiť
                          </button>
                        </div>
                      )}
                      <input
                        type="file"
                        accept="application/pdf"
                        onChange={(e) => {
                          if (e.target.files?.[0]) {
                            handleCarFormChange('pendingServiceBookPdf', e.target.files[0])
                          }
                          e.target.value = ''
                        }}
                        className="w-full px-3 py-2 border border-blue-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 file:mr-4 file:py-1 file:px-3 file:rounded-lg file:border-0 file:text-sm file:font-semibold file:bg-blue-100 file:text-blue-700 hover:file:bg-blue-200 text-sm"
                      />
                    </div>

                    {/* Cebia Protocol PDF */}
                    <div>
                      <label className="block text-sm font-medium mb-2 text-blue-800">Cebia protokol</label>
                      {carForm.cebiaProtocolPdf && !carForm.pendingCebiaProtocolPdf && (
                        <div className="flex items-center gap-2 mb-2 p-2 bg-white rounded border border-blue-200">
                          <span className="text-green-600">✓</span>
                          <span className="text-sm text-gray-700 truncate flex-1">Nahraté</span>
                          <a
                            href={getImageUrl(carForm.cebiaProtocolPdf)}
                            target="_blank"
                            rel="noopener noreferrer"
                            className="text-blue-600 hover:text-blue-800 text-sm underline"
                          >
                            Zobraziť
                          </a>
                          <button
                            type="button"
                            onClick={() => handleCarFormChange('cebiaProtocolPdf', null)}
                            className="text-red-500 hover:text-red-700 text-sm"
                          >
                            Odstrániť
                          </button>
                        </div>
                      )}
                      {carForm.pendingCebiaProtocolPdf && (
                        <div className="flex items-center gap-2 mb-2 p-2 bg-green-50 rounded border border-green-200">
                          <span className="text-green-600">📄</span>
                          <span className="text-sm text-gray-700 truncate flex-1">{carForm.pendingCebiaProtocolPdf.name}</span>
                          <button
                            type="button"
                            onClick={() => handleCarFormChange('pendingCebiaProtocolPdf', null)}
                            className="text-red-500 hover:text-red-700 text-sm"
                          >
                            Zrušiť
                          </button>
                        </div>
                      )}
                      <input
                        type="file"
                        accept="application/pdf"
                        onChange={(e) => {
                          if (e.target.files?.[0]) {
                            handleCarFormChange('pendingCebiaProtocolPdf', e.target.files[0])
                          }
                          e.target.value = ''
                        }}
                        className="w-full px-3 py-2 border border-blue-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 file:mr-4 file:py-1 file:px-3 file:rounded-lg file:border-0 file:text-sm file:font-semibold file:bg-blue-100 file:text-blue-700 hover:file:bg-blue-200 text-sm"
                      />
                    </div>
                  </div>
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
                    {t('zobrazitNaDomovskej')}
                  </label>
                </div>

                {/* Reserved toggle */}
                <div className="flex items-center p-4 bg-orange-50 rounded-lg border border-orange-200">
                  <input
                    type="checkbox"
                    id="reserved"
                    checked={carForm.reserved}
                    onChange={(e) => handleCarFormChange('reserved', e.target.checked)}
                    className="w-5 h-5 text-orange-600 rounded focus:ring-2 focus:ring-orange-500"
                  />
                  <label htmlFor="reserved" className="ml-3 text-sm font-semibold text-orange-900">
                    {t('rezervovane')}
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
                    {t('zrusit')}
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
                        {t('ukladam')}
                      </span>
                    ) : (
                      isEditMode ? t('upravitVozidlo') : t('pridatVozidlo')
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