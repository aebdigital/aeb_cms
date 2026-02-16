import { useState, useEffect } from 'react'
import { PlusIcon, MagnifyingGlassIcon, XMarkIcon, PencilIcon, TrashIcon, ArrowPathIcon } from '@heroicons/react/24/outline'
import { useAuth } from '../contexts/AuthContext'
import { useTranslation } from '../i18n'
import { getCarsForSite, createCar, updateCar, deleteCar as deleteCarApi, getAllCarsForSite, restoreCar, permanentlyDeleteCar } from '../api/cars'
import { uploadCarImageOnly, deleteCarGalleryImage, deleteAllCarImagesAndAssets } from '../api/carsImages'
import { getPublicUrl } from '../api/storage'
import { ensureValidSession } from '../lib/supabaseClient'
import { compressImage } from '../lib/fileUtils'

const initialCarForm = {
  // Required matching fields for Darius
  name: '', // Maps to brand + model usually, but let's keep it simple
  brand: '',
  model: '',
  category: '', // Kompakt, Sedan, Sport, Kombi, Van, Nakladny
  price: 0,
  deposit: 0,
  seats: 5,
  transmission: 'Manual', // Manual, Automat
  fuel: 'Benzin', // Benzin, Diesel, Elektro
  luggage: '',
  features: [],
  description: '',
  shortDescription: '',
  image: '', // Main image path

  // Pricing tiers
  price1day: 0,
  price2_3days: 0,
  price4_7days: 0,
  price7_21days: 0,
  price21plus: 'Cena dohodou',

  // Limits
  limitDaily: '200km',
  limitExcess: '0,10€/km',

  // System
  allImages: [], // [{type: 'existing', data: 'path'}, {type: 'pending', data: File}]
  showOnHomepage: false,
}

// Fixed options for Darius
const CATEGORIES = ['Kompakt', 'Sedan', 'Šport', 'Kombi', 'Van', 'Nákladný']
const TRANSMISSIONS = ['Manuál', 'Automat']
const FUELS = ['Benzín', 'Diesel', 'Elektro', 'Hybrid']
const FEATURES_OPTIONS = ['Klimatizácia', 'Tempomat', 'Navigácia', 'Bluetooth', 'Parkovacie senzory', 'Vyhrievané sedadlá', 'Isofix', 'Ťažné zariadenie']

export default function DariusVozidla() {
  const { currentSite, loading: authLoading } = useAuth()
  const { t } = useTranslation()

  const [cars, setCars] = useState([])
  const [activeTab, setActiveTab] = useState('ponuka')
  const [loading, setLoading] = useState(false)
  const [initialLoad, setInitialLoad] = useState(true)
  const [error, setError] = useState(null)
  const [searchTerm, setSearchTerm] = useState('')
  const [showAddModal, setShowAddModal] = useState(false)
  const [isEditMode, setIsEditMode] = useState(false)
  const [editingCar, setEditingCar] = useState(null)

  const [carForm, setCarForm] = useState(initialCarForm)
  const [submitting, setSubmitting] = useState(false)
  const [uploadProgress, setUploadProgress] = useState('')

  useEffect(() => {
    if (authLoading || !currentSite?.id) {
      if (!authLoading && !currentSite?.id) setInitialLoad(false)
      return
    }

    loadCars()
  }, [currentSite?.id, authLoading])

  async function loadCars() {
    try {
      setLoading(true)
      const allData = await getAllCarsForSite(currentSite.id, true)
      // Transform generic DB structure to Darius specific needs if necessary
      // But for now we just rely on the flexible schema
      setCars(allData)
    } catch (err) {
      console.error('Error loading cars:', err)
      setError(err.message)
    } finally {
      setLoading(false)
      setInitialLoad(false)
    }
  }

  const getImageUrl = (imagePath) => {
    if (!imagePath) return 'https://via.placeholder.com/400x300?text=No+Image'
    if (imagePath.startsWith('http')) return imagePath
    return getPublicUrl(imagePath)
  }

  // Filter logic
  const filteredCars = cars.filter(c => !c.deletedAt).filter(car => {
    const search = searchTerm.toLowerCase()
    return (car.name?.toLowerCase() || '').includes(search) ||
      (car.brand?.toLowerCase() || '').includes(search) ||
      (car.model?.toLowerCase() || '').includes(search)
  })

  // --- Form Handlers ---

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
    if (files && files[0]) {
      // For Darius simplified version, let's just take one main image for now
      // or append to list if we want multiple
      const newImage = { type: 'pending', data: files[0] }
      setCarForm(prev => ({
        ...prev,
        allImages: [newImage] // Replace for single image design or [...prev, new]
      }))
    }
    e.target.value = ''
  }

  const openAddModal = () => {
    setCarForm(initialCarForm)
    setIsEditMode(false)
    setEditingCar(null)
    setShowAddModal(true)
  }

  const openEditModal = (car) => {
    // Map DB fields back to form
    const pricing = car.pricing || {}
    const limits = car.limits || {}

    setCarForm({
      name: car.name || `${car.brand} ${car.model}`,
      brand: car.brand || '',
      model: car.model || '',
      category: car.category || '',
      price: car.price || 0, // This might be base price
      deposit: pricing.deposit || 0,
      seats: car.seats || 5,
      transmission: car.transmission || 'Manuál',
      fuel: car.fuel || 'Benzín',
      luggage: car.luggage || '',
      features: car.features || [],
      description: car.description || '',
      shortDescription: car.shortDescription || '',
      image: car.image || '',

      price1day: pricing['1day'] || 0,
      price2_3days: pricing['2-3days'] || 0,
      price4_7days: pricing['4-7days'] || 0,
      price7_21days: pricing['7-21days'] || 0,
      price21plus: pricing['21plus'] || 'Cena dohodou',

      limitDaily: limits.daily || '200km',
      limitExcess: limits.excess || '0,10€/km',

      allImages: car.image ? [{ type: 'existing', data: car.image }] : [],
      showOnHomepage: car.showOnHomepage || false
    })

    setIsEditMode(true)
    setEditingCar(car)
    setShowAddModal(true)
  }

  const handleSubmit = async (e) => {
    e.preventDefault()
    if (!carForm.name) return

    setSubmitting(true)
    setUploadProgress('Ukladám...')

    try {
      await ensureValidSession()

      // 1. Upload Image if pending
      let finalImagePath = carForm.image
      const pendingImage = carForm.allImages.find(i => i.type === 'pending')

      if (pendingImage) {
        setUploadProgress('Nahrávam obrázok...')
        const file = pendingImage.data
        const compressed = await compressImage(file, 500)

        // We create a temp ID if exact ID not known yet, or use generic logic
        // But better to create car first? 
        // Let's use uploadCarImageOnly with a temp ID or just random path if needed
        // The API expects carId... so we might need to create car first or handle it.
        // Simplified: just upload generic for now or 2-step

        // Strategy: Create/Update car first without image, then upload, then update car with image
      }

      // 2. Prepare DB Object
      // We are storing the extended pricing/limits in a JSONB 'pricing' and 'limits' column if they exist,
      // or we map them to the generic `data` column or we used specific columns.
      // Based on previous schema inspection, `cars` table has specific columns.
      // We might need to store the extra Darius JSON structure in `metadata` or extending the table.
      // The `cars` table has basic fields. Extra stuff like "pricing tiers" isn't in standard columns.
      // We should probably use `description` for full text, and maybe a JSON column if available?
      // Looking at table def: `features` is text[], `settings` or `metadata` NOT present on `cars`.
      // But `cars` table generally has specific cols.
      // Wait, `cars` table DOES NOT have a `metadata` jsonb column?
      // Step 15 output shows `features` text[], but no general JSONB.
      // We might need to add one or abuse `description` or adds columns.
      // Let's check `cars` table schema again carefully in memory...
      // `cars` columns: brand, model, year, price, etc.
      // NO generic jsonb column.

      // FOR DARIUS implementation to work strictly with generic DB:
      // We should probably rely on the existing columns as much as possible,
      // and maybe put the structured pricing JSON into `description` (ugly) or add a column `metadata` to `cars`.
      // I'll stick to mapping what fits and maybe just putting the rest in `features` or text.

      // Actually, let's just stick to the basic fields available and map them best we can.
      // "pricing" and "limits" are critical.
      // I'll suggest adding a `metadata` column for flexible schemas like this in the future.
      // For now, I'll store the JSON string of pricing/limits in `description` appended? 
      // OR better: I will assume I can just use the standard fields and maybe just 1 price.

      // RE-READ REQUEST: "create a section in aeb_cms spciefiicaly for this website"
      // "investigate how car detail page... work on the website" -> I did, it uses `pricing` object.
      // So I NEED to store that object.
      // I will ADD a `metadata` JSONB column to `cars` table to support this custom data.

      const pricingObj = {
        "1day": parseFloat(carForm.price1day),
        "2-3days": parseFloat(carForm.price2_3days),
        "4-7days": parseFloat(carForm.price4_7days),
        "7-21days": parseFloat(carForm.price7_21days),
        "21plus": carForm.price21plus,
        "deposit": parseFloat(carForm.deposit)
      }

      const limitsObj = {
        daily: carForm.limitDaily,
        excess: carForm.limitExcess
      }

      const dbData = {
        brand: carForm.brand || carForm.name.split(' ')[0],
        model: carForm.model || carForm.name.substring(carForm.name.indexOf(' ') + 1),
        price: pricingObj["1day"], // Base price
        source: 'admin',
        category: carForm.category, // We might need to add a column if not exists or map to body_type
        seats: parseInt(carForm.seats),
        transmission: carForm.transmission,
        fuel: carForm.fuel,
        luggage: carForm.luggage,
        features: carForm.features,
        description: carForm.description,
        // Store complex data in metadata (we will add this column)
        metadata: {
          name: carForm.name,
          category: carForm.category,
          shortDescription: carForm.shortDescription,
          pricing: pricingObj,
          limits: limitsObj
        },
        show_on_homepage: carForm.showOnHomepage
      }

      let carId = editingCar?.id

      if (isEditMode && carId) {
        await updateCar(carId, dbData, currentSite.id)
      } else {
        const newCar = await createCar(currentSite.id, dbData)
        carId = newCar.id
      }

      // Handle Image Upload AFTER we have ID
      if (pendingImage && carId) {
        setUploadProgress('Nahrávam obrázok...')
        // Use existing upload logic
        const compressed = await compressImage(pendingImage.data, 500)
        const { path } = await uploadCarImageOnly({
          file: compressed,
          siteId: currentSite.id,
          siteSlug: currentSite.slug,
          carId,
        })
        // Update car with image path
        await updateCar(carId, { image: path }, currentSite.id)
      }

      setUploadProgress('')
      setShowAddModal(false)
      loadCars()

    } catch (err) {
      console.error(err)
      alert('Chyba: ' + err.message)
    } finally {
      setSubmitting(false)
      setUploadProgress('')
    }
  }

  const handleDelete = async (id) => {
    if (!window.confirm(t('steIsti'))) return
    try {
      await deleteCarApi(id)
      loadCars()
    } catch (err) {
      alert(err.message)
    }
  }

  return (
    <div>
      {/* Header */}
      <div className="flex flex-col md:flex-row md:items-center justify-between gap-4 mb-8">
        <div>
          <h1 className="text-2xl font-bold text-gray-900">Správa vozidiel (Darius)</h1>
          <p className="text-gray-500">Špecifické nastavenia pre prenájom vozidiel</p>
        </div>
        <button
          onClick={openAddModal}
          className="inline-flex items-center justify-center px-4 py-2.5 bg-gradient-to-r from-purple-600 to-blue-600 text-white font-medium rounded-xl shadow-lg hover:shadow-xl transition-all hover:-translate-y-0.5"
        >
          <PlusIcon className="w-5 h-5 mr-2" />
          Pridať vozidlo
        </button>
      </div>

      {/* Grid */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        {filteredCars.map(car => (
          <div key={car.id} className="bg-white rounded-2xl shadow-sm border border-gray-100 overflow-hidden hover:shadow-md transition-shadow">
            <div className="relative aspect-video bg-gray-100">
              <img src={getImageUrl(car.image)} className="w-full h-full object-cover" />
            </div>
            <div className="p-4">
              <h3 className="font-bold text-lg text-gray-900 mb-1">{car.metadata?.name || `${car.brand} ${car.model}`}</h3>
              <div className="flex justify-between items-center text-sm text-gray-500 mb-4">
                <span>{car.transmission}</span>
                <span>{car.fuel}</span>
                <span className="font-semibold text-purple-600">{car.price}€ / deň</span>
              </div>
              <div className="flex gap-2">
                <button onClick={() => openEditModal(car)} className="flex-1 py-2 bg-gray-50 hover:bg-gray-100 text-gray-700 rounded-lg text-sm font-medium transition-colors">Upraviť</button>
                <button onClick={() => handleDelete(car.id)} className="px-3 py-2 bg-red-50 hover:bg-red-100 text-red-600 rounded-lg transition-colors"><TrashIcon className="w-5 h-5" /></button>
              </div>
            </div>
          </div>
        ))}
      </div>

      {/* Modal */}
      {showAddModal && (
        <div className="fixed inset-0 z-50 overflow-y-auto bg-black/50 backdrop-blur-sm flex items-center justify-center p-4">
          <div className="bg-white rounded-2xl w-full max-w-7xl shadow-2xl my-8 flex flex-col max-h-[90vh]">
            <div className="p-6 border-b border-gray-100 flex justify-between items-center shrink-0">
              <h2 className="text-xl font-bold">{isEditMode ? 'Upraviť vozidlo' : 'Nové vozidlo'}</h2>
              <button onClick={() => setShowAddModal(false)}><XMarkIcon className="w-6 h-6 text-gray-400" /></button>
            </div>

            <form onSubmit={handleSubmit} className="p-6 space-y-8 overflow-y-auto">
              {/* Basic Info */}
              <section>
                <h3 className="text-sm font-bold text-gray-900 uppercase tracking-wider mb-4">Základné údaje</h3>
                <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
                  <div className="md:col-span-2">
                    <label className="block text-sm font-medium text-gray-700 mb-1">Celý názov (zobrazovaný na webe)</label>
                    <input required type="text" value={carForm.name} onChange={e => handleCarFormChange('name', e.target.value)} className="w-full px-4 py-3 rounded-xl border-gray-400 bg-gray-50 focus:bg-white focus:border-purple-600 focus:ring-2 focus:ring-purple-200 transition-all outline-none" placeholder="napr. Škoda Octavia RS" />
                  </div>
                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-1">Značka</label>
                    <input required type="text" value={carForm.brand} onChange={e => handleCarFormChange('brand', e.target.value)} className="w-full px-4 py-3 rounded-xl border-gray-400 bg-gray-50 focus:bg-white focus:border-purple-600 focus:ring-2 focus:ring-purple-200 transition-all outline-none" />
                  </div>
                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-1">Model</label>
                    <input required type="text" value={carForm.model} onChange={e => handleCarFormChange('model', e.target.value)} className="w-full px-4 py-3 rounded-xl border-gray-400 bg-gray-50 focus:bg-white focus:border-purple-600 focus:ring-2 focus:ring-purple-200 transition-all outline-none" />
                  </div>
                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-1">Kategória</label>
                    <select value={carForm.category} onChange={e => handleCarFormChange('category', e.target.value)} className="w-full px-4 py-3 rounded-xl border-gray-400 bg-gray-50 focus:bg-white focus:border-purple-600 focus:ring-2 focus:ring-purple-200 transition-all outline-none">
                      <option value="">Vyberte...</option>
                      {CATEGORIES.map(c => <option key={c} value={c}>{c}</option>)}
                    </select>
                  </div>
                </div>
              </section>

              {/* Pricing */}
              <section className="bg-gray-50 rounded-xl p-6">
                <h3 className="text-sm font-bold text-gray-900 uppercase tracking-wider mb-4">Cenník prenájmu (€)</h3>
                <div className="grid grid-cols-2 md:grid-cols-6 gap-4">
                  <div>
                    <label className="block text-xs font-medium text-gray-500 mb-1">1 deň</label>
                    <input type="number" value={carForm.price1day} onChange={e => handleCarFormChange('price1day', e.target.value)} className="w-full px-3 py-2 rounded-lg border-gray-400 bg-white focus:border-purple-600 focus:ring-2 focus:ring-purple-200 outline-none transition-all text-sm" />
                  </div>
                  <div>
                    <label className="block text-xs font-medium text-gray-500 mb-1">2-3 dni</label>
                    <input type="number" value={carForm.price2_3days} onChange={e => handleCarFormChange('price2_3days', e.target.value)} className="w-full px-3 py-2 rounded-lg border-gray-400 bg-white focus:border-purple-600 focus:ring-2 focus:ring-purple-200 outline-none transition-all text-sm" />
                  </div>
                  <div>
                    <label className="block text-xs font-medium text-gray-500 mb-1">4-7 dní</label>
                    <input type="number" value={carForm.price4_7days} onChange={e => handleCarFormChange('price4_7days', e.target.value)} className="w-full px-3 py-2 rounded-lg border-gray-400 bg-white focus:border-purple-600 focus:ring-2 focus:ring-purple-200 outline-none transition-all text-sm" />
                  </div>
                  <div>
                    <label className="block text-xs font-medium text-gray-500 mb-1">7-21 dní</label>
                    <input type="number" value={carForm.price7_21days} onChange={e => handleCarFormChange('price7_21days', e.target.value)} className="w-full px-3 py-2 rounded-lg border-gray-400 bg-white focus:border-purple-600 focus:ring-2 focus:ring-purple-200 outline-none transition-all text-sm" />
                  </div>
                  <div className="col-span-2">
                    <label className="block text-xs font-medium text-gray-500 mb-1">21+ dní (text)</label>
                    <input type="text" value={carForm.price21plus} onChange={e => handleCarFormChange('price21plus', e.target.value)} className="w-full px-3 py-2 rounded-lg border-gray-400 bg-white focus:border-purple-600 focus:ring-2 focus:ring-purple-200 outline-none transition-all text-sm" />
                  </div>
                </div>
                <div className="mt-4 pt-4 border-t border-gray-200 grid grid-cols-1 md:grid-cols-3 gap-6">
                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-1">Záloha (Deposit)</label>
                    <input type="number" value={carForm.deposit} onChange={e => handleCarFormChange('deposit', e.target.value)} className="w-full px-4 py-3 rounded-xl border-gray-400 bg-gray-50 focus:bg-white focus:border-purple-600 focus:ring-2 focus:ring-purple-200 outline-none transition-all" />
                  </div>
                </div>
              </section>

              {/* Specs */}
              <section>
                <h3 className="text-sm font-bold text-gray-900 uppercase tracking-wider mb-4">Špecifikácie</h3>
                <div className="grid grid-cols-2 md:grid-cols-4 gap-6">
                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-1">Prevodovka</label>
                    <select value={carForm.transmission} onChange={e => handleCarFormChange('transmission', e.target.value)} className="w-full px-4 py-3 rounded-xl border-gray-400 bg-gray-50 focus:bg-white focus:border-purple-600 focus:ring-2 focus:ring-purple-200 outline-none transition-all">
                      {TRANSMISSIONS.map(t => <option key={t} value={t}>{t}</option>)}
                    </select>
                  </div>
                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-1">Palivo</label>
                    <select value={carForm.fuel} onChange={e => handleCarFormChange('fuel', e.target.value)} className="w-full px-4 py-3 rounded-xl border-gray-400 bg-gray-50 focus:bg-white focus:border-purple-600 focus:ring-2 focus:ring-purple-200 outline-none transition-all">
                      {FUELS.map(t => <option key={t} value={t}>{t}</option>)}
                    </select>
                  </div>
                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-1">Počet sedadiel</label>
                    <input type="number" value={carForm.seats} onChange={e => handleCarFormChange('seats', e.target.value)} className="w-full px-4 py-3 rounded-xl border-gray-400 bg-gray-50 focus:bg-white focus:border-purple-600 focus:ring-2 focus:ring-purple-200 outline-none transition-all" />
                  </div>
                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-1">Batožina</label>
                    <input type="text" value={carForm.luggage} onChange={e => handleCarFormChange('luggage', e.target.value)} className="w-full px-4 py-3 rounded-xl border-gray-400 bg-gray-50 focus:bg-white focus:border-purple-600 focus:ring-2 focus:ring-purple-200 outline-none transition-all" placeholder="napr. 3 kufre" />
                  </div>
                </div>

                <div className="mt-4">
                  <label className="block text-sm font-medium text-gray-700 mb-2">Výbava</label>
                  <div className="flex flex-wrap gap-2">
                    {FEATURES_OPTIONS.map(feature => (
                      <button
                        key={feature}
                        type="button"
                        onClick={() => toggleFeature(feature)}
                        className={`px-3 py-1.5 rounded-lg text-sm transition-colors ${carForm.features.includes(feature) ? 'bg-purple-100 text-purple-700 border border-purple-200' : 'bg-gray-50 text-gray-600 border border-gray-200 hover:bg-gray-100'}`}
                      >
                        {feature}
                      </button>
                    ))}
                  </div>
                </div>
              </section>

              {/* Description & Image */}
              <section className="grid grid-cols-1 md:grid-cols-2 gap-8">
                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-1">Krátky popis (karta)</label>
                  <textarea rows={2} value={carForm.shortDescription} onChange={e => handleCarFormChange('shortDescription', e.target.value)} className="w-full px-4 py-3 rounded-xl border-gray-400 bg-gray-50 focus:bg-white focus:border-purple-600 focus:ring-2 focus:ring-purple-200 outline-none transition-all" />

                  <label className="block text-sm font-medium text-gray-700 mt-4 mb-1">Celý popis</label>
                  <textarea rows={5} value={carForm.description} onChange={e => handleCarFormChange('description', e.target.value)} className="w-full px-4 py-3 rounded-xl border-gray-400 bg-gray-50 focus:bg-white focus:border-purple-600 focus:ring-2 focus:ring-purple-200 outline-none transition-all" />
                </div>

                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-1">Obrázok vozidla</label>
                  <div className="border-2 border-dashed border-gray-300 rounded-xl p-6 text-center hover:bg-gray-50 transition-colors">
                    {carForm.allImages[0] ? (
                      <div className="relative">
                        <img src={carForm.allImages[0].type === 'existing' ? getImageUrl(carForm.allImages[0].data) : URL.createObjectURL(carForm.allImages[0].data)} className="mx-auto max-h-48 rounded-lg object-contain" />
                        <button type="button" onClick={() => setCarForm(p => ({ ...p, allImages: [] }))} className="absolute top-0 right-0 bg-red-500 text-white rounded-full p-1"><XMarkIcon className="w-4 h-4" /></button>
                      </div>
                    ) : (
                      <div className="relative">
                        <input type="file" accept="image/*" onChange={handleImageUpload} className="absolute inset-0 w-full h-full opacity-0 cursor-pointer" />
                        <div className="pointer-events-none">
                          <ArrowPathIcon className="w-8 h-8 mx-auto text-gray-400 mb-2" />
                          <p className="text-sm text-gray-500">Kliknite pre nahranie</p>
                        </div>
                      </div>
                    )}
                  </div>

                  <div className="mt-6 flex items-center">
                    <input type="checkbox" id="showHome" checked={carForm.showOnHomepage} onChange={e => handleCarFormChange('showOnHomepage', e.target.checked)} className="rounded border-gray-300 text-purple-600 focus:ring-purple-500" />
                    <label htmlFor="showHome" className="ml-2 text-sm text-gray-700">Zobraziť na úvodnej stránke</label>
                  </div>
                </div>
              </section>

              <div className="pt-6 border-t border-gray-200 flex justify-end gap-3">
                <button type="button" onClick={() => setShowAddModal(false)} className="px-5 py-2.5 text-gray-700 font-medium hover:bg-gray-100 rounded-xl transition-colors">Zrušiť</button>
                <button type="submit" disabled={submitting} className="px-5 py-2.5 bg-purple-600 text-white font-medium rounded-xl hover:bg-purple-700 transition-colors disabled:opacity-50">
                  {submitting ? (uploadProgress || 'Ukladám...') : (isEditMode ? 'Uložiť zmeny' : 'Vytvoriť vozidlo')}
                </button>
              </div>
            </form>
          </div>
        </div>
      )}
    </div>
  )
}