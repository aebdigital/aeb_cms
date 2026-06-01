import { useEffect, useState } from 'react'
import { createPortal } from 'react-dom'
import {
  CheckCircleIcon,
  PencilSquareIcon,
  SwatchIcon,
  MagnifyingGlassIcon,
  XMarkIcon,
  ShoppingBagIcon,
  PhotoIcon,
} from '@heroicons/react/24/outline'
import { useAuth } from '../contexts/AuthContext'
import { useNotification } from '../contexts/NotificationContext'
import {
  KOCHLIK_OWNER_ID,
  listKochlikProducts,
  updateKochlikProduct,
  uploadProductImage,
  getPublicUrl,
} from '../api'

const COLOR_FAMILIES = [
  'Biela',
  'Čierna',
  'Hnedá',
  'Červená',
  'Zelená',
  'Modrá',
  'Žltá',
  'Oranžová',
  'Ružová',
  'Sivá',
  'Béžová',
]

export default function KochlikColors() {
  const { user, loading: authLoading } = useAuth()
  const { showNotification } = useNotification()
  const [products, setProducts] = useState([])
  const [colors, setColors] = useState([])
  const [loading, setLoading] = useState(true)
  const [selectedColor, setSelectedColor] = useState(null)
  const [searchTerm, setSearchTerm] = useState('')
  const [isModalOpen, setIsModalOpen] = useState(false)
  const [editingColor, setEditingColor] = useState(null)
  const [colorForm, setColorForm] = useState({ name: '', family: '', hex: '', image_url: '' })
  const [selectedFile, setSelectedFile] = useState(null)
  const [savingColor, setSavingColor] = useState(false)

  const [isCreateModalOpen, setIsCreateModalOpen] = useState(false)
  const [createForm, setCreateForm] = useState({ name: '', family: '', hex: '', image_url: '' })
  const [createFile, setCreateFile] = useState(null)
  const [createSelectedProducts, setCreateSelectedProducts] = useState([])
  const [productSearchTerm, setProductSearchTerm] = useState('')

  const hasAccess = user?.id === KOCHLIK_OWNER_ID || user?.email === 'alexander.hidveghy@gmail.com'

  useEffect(() => {
    if (authLoading || !hasAccess) return
    loadData()
  }, [authLoading, hasAccess])

  useEffect(() => {
    if (isModalOpen || isCreateModalOpen) {
      document.body.style.overflow = 'hidden'
    } else {
      document.body.style.overflow = ''
    }
    return () => {
      document.body.style.overflow = ''
    }
  }, [isModalOpen, isCreateModalOpen])

  async function loadData() {
    setLoading(true)
    try {
      const allProducts = await listKochlikProducts()
      setProducts(allProducts)
      aggregateColors(allProducts)
    } catch (err) {
      console.error('Kochlik colors load error:', err)
      showNotification('Nepodarilo sa načítať farby', 'error')
    } finally {
      setLoading(false)
    }
  }

  function aggregateColors(allProducts) {
    const colorMap = new Map()

    allProducts.forEach(prod => {
      const options = prod.color_options || []
      options.forEach(opt => {
        const name = opt.name ? opt.name.trim() : ''
        if (!name) return

        const key = name.toLowerCase()
        if (!colorMap.has(key)) {
          colorMap.set(key, {
            name: name, // Keep original case
            family: opt.family || '',
            hex: opt.hex || '',
            image_url: opt.image_url || '',
            active_type: opt.active_type || '',
            products: [],
          })
        }

        const colorEntry = colorMap.get(key)
        
        // Populate missing hex/image from other products if this one has it
        if (!colorEntry.family && opt.family) colorEntry.family = opt.family
        if (!colorEntry.hex && opt.hex) colorEntry.hex = opt.hex
        if (!colorEntry.image_url && opt.image_url) colorEntry.image_url = opt.image_url
        if (!colorEntry.active_type && opt.active_type) colorEntry.active_type = opt.active_type

        // Add product reference
        if (!colorEntry.products.some(p => p.id === prod.id)) {
          colorEntry.products.push({
            id: prod.id,
            name: prod.name,
            main_image_url: prod.main_image_url,
            slug: prod.slug,
            category_slug: prod.kochlik_categories?.slug || 'vsetky',
            category_name: prod.kochlik_categories?.name || 'Kvetináče',
          })
        }
      })
    })

    const aggregated = Array.from(colorMap.values()).sort((a, b) =>
      a.name.localeCompare(b.name, 'sk')
    )

    setColors(aggregated)

    // Preserve selection if possible
    if (selectedColor) {
      const updatedSelect = aggregated.find(c => c.name.toLowerCase() === selectedColor.name.toLowerCase())
      setSelectedColor(updatedSelect || null)
    }
  }

  function openEditModal(color) {
    setEditingColor(color)
    setColorForm({
      name: color.name,
      family: color.family || '',
      hex: color.hex || '',
      image_url: color.image_url || '',
    })
    setSelectedFile(null)
    setIsModalOpen(true)
  }

  function closeModal() {
    setIsModalOpen(false)
    setEditingColor(null)
    setColorForm({ name: '', family: '', hex: '', image_url: '' })
    setSelectedFile(null)
  }

  function openCreateModal() {
    setCreateForm({ name: '', family: '', hex: '', image_url: '' })
    setCreateFile(null)
    setCreateSelectedProducts([])
    setProductSearchTerm('')
    setIsCreateModalOpen(true)
  }

  function closeCreateModal() {
    setIsCreateModalOpen(false)
    setCreateForm({ name: '', family: '', hex: '', image_url: '' })
    setCreateFile(null)
    setCreateSelectedProducts([])
    setProductSearchTerm('')
  }

  async function handleCreateColor(event) {
    event.preventDefault()
    if (!createForm.name.trim()) {
      showNotification('Farba musí mať názov', 'error')
      return
    }
    if (createSelectedProducts.length === 0) {
      showNotification('Vyberte aspoň jeden produkt pre túto farbu', 'error')
      return
    }

    setSavingColor(true)
    try {
      let finalImageUrl = null

      if (createFile) {
        showNotification('Nahrávam obrázok farby...', 'info')
        const { path } = await uploadProductImage({
          file: createFile,
          ownerSlug: 'kochlik',
        })
        finalImageUrl = getPublicUrl(path)
      }

      const newColorOpt = {
        name: createForm.name.trim(),
        family: createForm.family || null,
        hex: createForm.hex || null,
        image_url: finalImageUrl || null,
        active_type: finalImageUrl ? 'image' : (createForm.hex ? 'hex' : 'text'),
      }

      const updatePromises = createSelectedProducts.map(async prodId => {
        const prod = products.find(p => p.id === prodId)
        if (!prod) return

        const exists = (prod.color_options || []).some(
          opt => opt.name?.trim().toLowerCase() === newColorOpt.name.toLowerCase()
        )
        if (exists) return

        const updatedOptions = [...(prod.color_options || []), newColorOpt]
        const updatedFamilies = Array.from(
          new Set(updatedOptions.map(o => o.family).filter(Boolean))
        )

        return updateKochlikProduct(prod.id, {
          color_options: updatedOptions,
          color_families: updatedFamilies,
        })
      })

      await Promise.all(updatePromises)
      showNotification(
        `Farba "${newColorOpt.name}" bola úspešne vytvorená a priradená k ${createSelectedProducts.length} produktom`,
        'success'
      )

      await loadData()
      
      const newColorEntry = {
        name: newColorOpt.name,
        family: newColorOpt.family || '',
        hex: newColorOpt.hex || '',
        image_url: newColorOpt.image_url || '',
        active_type: newColorOpt.active_type || '',
        products: [],
      }
      setSelectedColor(newColorEntry)

      closeCreateModal()
    } catch (err) {
      console.error('Error creating new color:', err)
      showNotification('Chyba pri vytváraní farby', 'error')
    } finally {
      setSavingColor(false)
    }
  }

  async function handleFileChange(e) {
    if (e.target.files && e.target.files[0]) {
      setSelectedFile(e.target.files[0])
    }
  }

  async function handleSubmitColor(event) {
    event.preventDefault()
    if (!colorForm.name.trim()) {
      showNotification('Farba musí mať názov', 'error')
      return
    }

    setSavingColor(true)
    try {
      let finalImageUrl = colorForm.image_url

      // 1. Upload new image if chosen
      if (selectedFile) {
        const { path } = await uploadProductImage({
          file: selectedFile,
          ownerSlug: 'kochlik',
        })
        finalImageUrl = getPublicUrl(path)
      }

      const updatedForm = {
        name: colorForm.name.trim(),
        family: colorForm.family || null,
        hex: colorForm.hex || null,
        image_url: finalImageUrl || null,
      }

      // 2. Find all products using this color
      const affectedProducts = products.filter(prod =>
        (prod.color_options || []).some(
          opt => opt.name?.trim().toLowerCase() === editingColor.name.trim().toLowerCase()
        )
      )

      if (affectedProducts.length > 0) {
        // Update each affected product
        const updatePromises = affectedProducts.map(async prod => {
          const updatedOptions = (prod.color_options || []).map(opt => {
            if (opt.name?.trim().toLowerCase() === editingColor.name.trim().toLowerCase()) {
              return {
                ...opt,
                name: updatedForm.name,
                family: updatedForm.family,
                hex: updatedForm.hex,
                image_url: updatedForm.image_url,
              }
            }
            return opt
          })

          const updatedFamilies = Array.from(
            new Set(updatedOptions.map(o => o.family).filter(Boolean))
          )

          return updateKochlikProduct(prod.id, {
            color_options: updatedOptions,
            color_families: updatedFamilies,
          })
        })

        await Promise.all(updatePromises)
        showNotification(
          `Farba bola úspešne aktualizovaná vo všetkých ${affectedProducts.length} produktoch`,
          'success'
        )
      } else {
        showNotification('Farba bola uložená', 'success')
      }

      await loadData()
      closeModal()
    } catch (err) {
      console.error('Kochlik color update error:', err)
      showNotification('Chyba pri aktualizácii farby', 'error')
    } finally {
      setSavingColor(false)
    }
  }

  // Helper to determine what type of swatch to show
  function renderSwatch(color, sizeClass = 'h-12 w-12') {
    const hasImage = !!color.image_url
    const hasHex = !!color.hex && color.hex !== ''

    if (hasImage) {
      return (
        <div className={`${sizeClass} rounded-full border border-gray-200 overflow-hidden shadow-xs flex-shrink-0`}>
          <img src={color.image_url} alt={color.name} className="h-full w-full object-cover" />
        </div>
      )
    }
    if (hasHex) {
      return (
        <div
          className={`${sizeClass} rounded-full border border-gray-200 shadow-xs flex-shrink-0`}
          style={{ backgroundColor: color.hex }}
        />
      )
    }
    return (
      <div className={`${sizeClass} rounded-full bg-gray-100 border border-gray-200 flex items-center justify-center text-xs font-bold text-gray-500 shadow-xs flex-shrink-0 uppercase`}>
        {color.name.slice(0, 2)}
      </div>
    )
  }

  async function handleActivateOption(type) {
    if (!selectedColor) return
    if (savingColor) return

    const activeType = selectedColor.active_type || (selectedColor.image_url ? 'image' : (selectedColor.hex ? 'hex' : 'text'))
    const isImageActive = activeType === 'image'
    const isHexActive = activeType === 'hex'
    const isTextActive = activeType === 'text'

    if (type === 'text') {
      if (isTextActive) return
      
      setSavingColor(true)
      try {
        const updatePromises = selectedColor.products.map(async prod => {
          const productRow = products.find(p => p.id === prod.id)
          if (!productRow) return

          const updatedOptions = (productRow.color_options || []).map(opt => {
            if (opt.name?.trim().toLowerCase() === selectedColor.name.trim().toLowerCase()) {
              return {
                ...opt,
                active_type: 'text',
              }
            }
            return opt
          })

          const updatedFamilies = Array.from(
            new Set(updatedOptions.map(o => o.family).filter(Boolean))
          )

          return updateKochlikProduct(prod.id, {
            color_options: updatedOptions,
            color_families: updatedFamilies,
          })
        })

        await Promise.all(updatePromises)
        showNotification('Aktivované zobrazenie podľa názvu', 'success')
        await loadData()
      } catch (err) {
        console.error('Error activating text option:', err)
        showNotification('Nepodarilo sa aktivovať možnosť', 'error')
      } finally {
        setSavingColor(false)
      }
    }

    if (type === 'hex') {
      if (isHexActive) return
      let targetHex = selectedColor.hex

      if (!targetHex) {
        const input = prompt('Táto farba nemá nastavený HEX kód. Zadajte HEX kód (napr. #8f9779):', '#8f9779')
        if (!input) return
        targetHex = input.trim()
      }

      setSavingColor(true)
      try {
        const updatePromises = selectedColor.products.map(async prod => {
          const productRow = products.find(p => p.id === prod.id)
          if (!productRow) return

          const updatedOptions = (productRow.color_options || []).map(opt => {
            if (opt.name?.trim().toLowerCase() === selectedColor.name.trim().toLowerCase()) {
              return {
                ...opt,
                hex: targetHex,
                active_type: 'hex',
              }
            }
            return opt
          })

          const updatedFamilies = Array.from(
            new Set(updatedOptions.map(o => o.family).filter(Boolean))
          )

          return updateKochlikProduct(prod.id, {
            color_options: updatedOptions,
            color_families: updatedFamilies,
          })
        })

        await Promise.all(updatePromises)
        showNotification('Aktivované zobrazenie podľa HEX kódu', 'success')
        await loadData()
      } catch (err) {
        console.error('Error activating hex option:', err)
        showNotification('Nepodarilo sa aktivovať možnosť', 'error')
      } finally {
        setSavingColor(false)
      }
    }

    if (type === 'image') {
      const hasImage = !!selectedColor.image_url
      if (hasImage && !isImageActive) {
        setSavingColor(true)
        try {
          const updatePromises = selectedColor.products.map(async prod => {
            const productRow = products.find(p => p.id === prod.id)
            if (!productRow) return

            const updatedOptions = (productRow.color_options || []).map(opt => {
              if (opt.name?.trim().toLowerCase() === selectedColor.name.trim().toLowerCase()) {
                return {
                  ...opt,
                  active_type: 'image',
                }
              }
              return opt
            })

            const updatedFamilies = Array.from(
              new Set(updatedOptions.map(o => o.family).filter(Boolean))
            )

            return updateKochlikProduct(prod.id, {
              color_options: updatedOptions,
              color_families: updatedFamilies,
            })
          })

          await Promise.all(updatePromises)
          showNotification('Aktivované zobrazenie podľa obrázka', 'success')
          await loadData()
        } catch (err) {
          console.error('Error activating image option:', err)
          showNotification('Nepodarilo sa aktivovať možnosť', 'error')
        } finally {
          setSavingColor(false)
        }
      } else {
        document.getElementById('selected-color-image-upload')?.click()
      }
    }
  }

  async function handleImageUploadDirect(e) {
    if (!selectedColor || !e.target.files || !e.target.files[0]) return

    const file = e.target.files[0]
    setSavingColor(true)
    try {
      showNotification('Nahrávam obrázok farby...', 'info')
      const { path } = await uploadProductImage({
        file,
        ownerSlug: 'kochlik',
      })
      const publicUrl = getPublicUrl(path)

      // Find all products using this color
      const affectedProducts = products.filter(prod =>
        (prod.color_options || []).some(
          opt => opt.name?.trim().toLowerCase() === selectedColor.name.trim().toLowerCase()
        )
      )

      if (affectedProducts.length > 0) {
        const updatePromises = affectedProducts.map(async prod => {
          const updatedOptions = (prod.color_options || []).map(opt => {
            if (opt.name?.trim().toLowerCase() === selectedColor.name.trim().toLowerCase()) {
              return {
                ...opt,
                image_url: publicUrl,
                active_type: 'image',
              }
            }
            return opt
          })

          const updatedFamilies = Array.from(
            new Set(updatedOptions.map(o => o.family).filter(Boolean))
          )

          return updateKochlikProduct(prod.id, {
            color_options: updatedOptions,
            color_families: updatedFamilies,
          })
        })

        await Promise.all(updatePromises)
        showNotification(
          `Obrázok bol úspešne nahraný a nastavený pre farbu "${selectedColor.name}" v ${affectedProducts.length} produktoch`,
          'success'
        )
      } else {
        showNotification('Obrázok bol úspešne nahraný', 'success')
      }

      await loadData()
    } catch (err) {
      console.error('Error uploading image directly:', err)
      showNotification('Nepodarilo sa nahrať obrázok farby', 'error')
    } finally {
      setSavingColor(false)
      // Reset input element value to allow selecting same file again
      if (e.target) e.target.value = ''
    }
  }

  async function handleRemoveImage() {
    if (!selectedColor) return
    if (!confirm(`Naozaj chcete odstrániť obrázkovú vzorku z farby "${selectedColor.name}" vo všetkých produktoch?`)) {
      return
    }

    setSavingColor(true)
    try {
      const affectedProducts = products.filter(prod =>
        (prod.color_options || []).some(
          opt => opt.name?.trim().toLowerCase() === selectedColor.name.trim().toLowerCase()
        )
      )

      if (affectedProducts.length > 0) {
        const updatePromises = affectedProducts.map(async prod => {
          const updatedOptions = (prod.color_options || []).map(opt => {
            if (opt.name?.trim().toLowerCase() === selectedColor.name.trim().toLowerCase()) {
              return {
                ...opt,
                image_url: null,
                active_type: null,
              }
            }
            return opt
          })

          const updatedFamilies = Array.from(
            new Set(updatedOptions.map(o => o.family).filter(Boolean))
          )

          return updateKochlikProduct(prod.id, {
            color_options: updatedOptions,
            color_families: updatedFamilies,
          })
        })

        await Promise.all(updatePromises)
        showNotification(`Obrázok bol úspešne odstránený z farby "${selectedColor.name}"`, 'success')
      } else {
        showNotification('Obrázok bol odstránený', 'success')
      }

      await loadData()
    } catch (err) {
      console.error('Error removing color image:', err)
      showNotification('Nepodarilo sa odstrániť obrázok farby', 'error')
    } finally {
      setSavingColor(false)
    }
  }


  const filteredColors = colors.filter(c =>
    c.name.toLowerCase().includes(searchTerm.toLowerCase())
  )

  if (authLoading) {
    return (
      <div className="flex h-64 items-center justify-center">
        <div className="h-8 w-8 animate-spin rounded-full border-b-2 border-emerald-600"></div>
      </div>
    )
  }
  if (!hasAccess) {
    return (
      <div className="flex h-64 items-center justify-center">
        <p className="text-gray-500">Nemáte prístup.</p>
      </div>
    )
  }

  return (
    <div className="space-y-6">
      <div>
        <p className="text-sm font-semibold uppercase tracking-[0.18em] text-emerald-700">Kochlik</p>
        <h1 className="mt-1 text-3xl font-bold text-gray-950">Správa farieb</h1>
      </div>

      <div className="grid grid-cols-1 gap-6 lg:grid-cols-[1.4fr_1fr]">
        {/* Left Pane - Grid of aggregated colors */}
        <div className="space-y-4">
          <div className="flex gap-3">
            <div className="relative flex-1">
              <MagnifyingGlassIcon className="absolute left-4 top-3.5 h-5 w-5 text-gray-400" />
              <input
                type="text"
                placeholder="Vyhľadať farbu podľa názvu..."
                value={searchTerm}
                onChange={e => setSearchTerm(e.target.value)}
                className="w-full rounded-2xl border border-gray-200 pl-12 pr-4 py-3 text-sm focus:border-emerald-500 focus:ring-1 focus:ring-emerald-500 outline-none transition-all"
              />
            </div>
            <button
              type="button"
              onClick={openCreateModal}
              className="rounded-2xl bg-emerald-600 px-5 py-3 text-sm font-extrabold text-white transition hover:bg-emerald-700 flex items-center gap-2 shadow-xs whitespace-nowrap"
            >
              <SwatchIcon className="h-5 w-5" />
              Pridať farbu
            </button>
          </div>

          {loading ? (
            <div className="rounded-3xl bg-white p-12 text-center text-gray-500 shadow-sm ring-1 ring-gray-100">
              Načítavam a analyzujem farby produktov...
            </div>
          ) : filteredColors.length === 0 ? (
            <div className="rounded-3xl border-2 border-dashed border-gray-200 bg-white p-12 text-center text-gray-500">
              Nenašli sa žiadne farby.
            </div>
          ) : (
            <div className="grid gap-3 sm:grid-cols-2">
              {filteredColors.map(color => {
                const isSelected = selectedColor?.name.toLowerCase() === color.name.toLowerCase()
                const hasImage = !!color.image_url
                const hasHex = !!color.hex && color.hex !== ''
                let activeBadge = 'Názov'
                if (hasImage) activeBadge = 'Obrázok'
                else if (hasHex) activeBadge = 'HEX farba'

                return (
                  <div
                    key={color.name}
                    onClick={() => setSelectedColor(color)}
                    className={`cursor-pointer rounded-2xl bg-white p-4 shadow-xs ring-1 transition hover:shadow-md flex items-center gap-4 ${
                      isSelected
                        ? 'ring-emerald-500 ring-2'
                        : 'ring-gray-100'
                    }`}
                  >
                    {renderSwatch(color)}

                    <div className="flex-1 min-w-0">
                      <div className="flex items-center gap-2">
                        <span className="font-bold text-gray-900 truncate text-sm">{color.name}</span>
                        {color.family && (
                          <span className="inline-block rounded-full bg-gray-100 px-2 py-0.5 text-[10px] text-gray-600 font-medium">
                            {color.family}
                          </span>
                        )}
                      </div>
                      <div className="text-[11px] text-gray-500 mt-0.5 flex gap-2">
                        <span>Aktívna vzorka: {activeBadge}</span>
                        {color.hex && <span className="font-mono text-gray-400">{color.hex}</span>}
                      </div>
                      <div className="text-xs text-emerald-700 font-semibold mt-1">
                        Použité v {color.products.length} produktoch
                      </div>
                    </div>

                    <button
                      type="button"
                      onClick={e => {
                        e.stopPropagation()
                        openEditModal(color)
                      }}
                      className="rounded-xl bg-gray-50 p-2 text-gray-600 hover:bg-emerald-50 hover:text-emerald-700 transition"
                      title="Upraviť farbu"
                    >
                      <PencilSquareIcon className="h-5 w-5" />
                    </button>
                  </div>
                )
              })}
            </div>
          )}
        </div>

        {/* Right Pane - Products using selected color */}
        <div>
          <div className="sticky top-24 rounded-3xl bg-white p-6 shadow-sm ring-1 ring-gray-100 min-h-[300px]">
            {selectedColor ? (() => {
              const activeType = selectedColor.active_type || (selectedColor.image_url ? 'image' : (selectedColor.hex ? 'hex' : 'text'))
              const isImageActive = activeType === 'image'
              const isHexActive = activeType === 'hex'
              const isTextActive = activeType === 'text'

              return (
                <div className="space-y-4">
                  <input
                    id="selected-color-image-upload"
                    type="file"
                    accept="image/*"
                    className="hidden"
                    onChange={handleImageUploadDirect}
                  />
                  <div>
                    <div className="flex items-center gap-3">
                      {renderSwatch(selectedColor, 'h-10 w-10')}
                      <div>
                        <h2 className="text-lg font-bold text-gray-950">{selectedColor.name}</h2>
                        <p className="text-xs text-gray-500">
                          Zoznam produktov používajúcich túto farbu
                        </p>
                      </div>
                    </div>
                  </div>

                  {/* Active representation preview (matching products page style) */}
                  <div className="rounded-2xl bg-gray-50 border border-gray-150 p-4 space-y-3">
                    <span className="text-[10px] font-bold uppercase tracking-wider text-gray-400 block">
                      Reprezentácia na webe (kliknutím aktivujete vybranú možnosť)
                    </span>
                    <div className="grid grid-cols-3 gap-2.5">
                      {/* Text Option */}
                      <div
                        onClick={() => handleActivateOption('text')}
                        className={`cursor-pointer rounded-xl bg-white border p-2 flex flex-col items-center justify-center text-center transition-all hover:border-emerald-400 hover:shadow-2xs ${
                          isTextActive
                            ? 'border-emerald-500 ring-2 ring-emerald-500/20 font-semibold'
                            : 'border-gray-200 opacity-60'
                        }`}
                      >
                        <span className="text-[9px] text-gray-400 uppercase font-bold tracking-wide">Názov</span>
                        <span className="text-xs text-gray-800 font-bold mt-1 truncate max-w-full">
                          {selectedColor.name}
                        </span>
                        {isTextActive && (
                          <span className="text-[9px] text-emerald-600 font-bold mt-1">Aktívny</span>
                        )}
                      </div>

                      {/* HEX Option */}
                      <div
                        onClick={() => handleActivateOption('hex')}
                        className={`cursor-pointer rounded-xl bg-white border p-2 flex flex-col items-center justify-center text-center transition-all hover:border-emerald-400 hover:shadow-2xs ${
                          isHexActive
                            ? 'border-emerald-500 ring-2 ring-emerald-500/20 font-semibold'
                            : 'border-gray-200 opacity-60'
                        }`}
                      >
                        <span className="text-[9px] text-gray-400 uppercase font-bold tracking-wide">HEX farba</span>
                        <div className="flex items-center justify-center gap-1 mt-1.5 w-full">
                          {selectedColor.hex ? (
                            <>
                              <div
                                className="h-3.5 w-3.5 rounded-full border border-gray-200 flex-shrink-0"
                                style={{ backgroundColor: selectedColor.hex }}
                              />
                              <span className="text-[11px] text-gray-800 font-bold font-mono truncate">
                                {selectedColor.hex}
                              </span>
                            </>
                          ) : (
                            <span className="text-[11px] text-gray-400 font-bold">Žiadna</span>
                          )}
                        </div>
                        {isHexActive && (
                          <span className="text-[9px] text-emerald-600 font-bold mt-1">Aktívna</span>
                        )}
                      </div>

                      {/* Image Option */}
                      <div
                        onClick={(e) => {
                          if (e.target.closest('.remove-image-btn')) return
                          handleActivateOption('image')
                        }}
                        className={`relative group/imgcard cursor-pointer rounded-xl bg-white border p-2 flex flex-col items-center justify-center text-center transition-all hover:border-emerald-400 hover:shadow-2xs ${
                          isImageActive
                            ? 'border-emerald-500 ring-2 ring-emerald-500/20 font-semibold'
                            : 'border-gray-200 opacity-60'
                        }`}
                      >
                        {selectedColor.image_url && (
                          <button
                            type="button"
                            onClick={(e) => {
                              e.stopPropagation()
                              handleRemoveImage()
                            }}
                            className="remove-image-btn absolute -top-1.5 -right-1.5 rounded-full bg-red-500 p-0.5 text-white shadow-md hover:bg-red-600 z-10 transition opacity-0 group-hover/imgcard:opacity-100 flex items-center justify-center h-5 w-5"
                            title="Odstrániť obrázok"
                          >
                            <XMarkIcon className="h-3 w-3 stroke-[3]" />
                          </button>
                        )}
                        <span className="text-[9px] text-gray-400 uppercase font-bold tracking-wide">Obrázok</span>
                        <div className="h-5 w-5 rounded-full overflow-hidden border border-gray-200 mt-1 flex items-center justify-center bg-gray-50 flex-shrink-0">
                          {selectedColor.image_url ? (
                            <img
                              src={selectedColor.image_url}
                              alt=""
                              className="h-full w-full object-cover"
                            />
                          ) : (
                            <PhotoIcon className="h-3 w-3 text-gray-300" />
                          )}
                        </div>
                        {isImageActive && (
                          <span className="text-[9px] text-emerald-600 font-bold mt-1">Aktívny</span>
                        )}
                      </div>
                    </div>
                  </div>

                  <div className="border-t border-gray-100 pt-4 max-h-[600px] overflow-y-auto pr-1">
                  <div className="grid grid-cols-3 gap-3">
                    {selectedColor.products.map(prod => (
                      <div
                        key={prod.id}
                        className="group relative aspect-square w-full overflow-hidden rounded-2xl bg-gray-100 border border-gray-150 shadow-xs hover:shadow-md transition duration-200"
                      >
                        {/* Product Image */}
                        {prod.main_image_url ? (
                          <img
                            src={prod.main_image_url}
                            alt=""
                            className="h-full w-full object-cover transition duration-300 group-hover:scale-105"
                          />
                        ) : (
                          <div className="flex h-full w-full items-center justify-center text-gray-300">
                            <PhotoIcon className="h-8 w-8" />
                          </div>
                        )}

                        {/* Dark Gradient Overlay */}
                        <div className="absolute inset-x-0 bottom-0 bg-gradient-to-t from-black/85 via-black/35 to-transparent p-3 text-white">
                          <h4 className="line-clamp-2 text-xs font-bold leading-tight text-white/95">
                            {prod.name}
                          </h4>
                        </div>

                        {/* Hover Quick Actions overlay in top corner */}
                        <div className="absolute right-2 top-2 flex gap-1.5 opacity-0 group-hover:opacity-100 transition-opacity duration-200">
                          {/* Live view button */}
                          <a
                            href={`http://localhost:3006/produkt/${prod.category_slug}/${prod.slug}`}
                            target="_blank"
                            rel="noreferrer"
                            className="rounded-full bg-white p-1.5 text-gray-700 shadow-xs hover:bg-emerald-50 hover:text-emerald-700 transition"
                            title="Zobraziť na webe"
                          >
                            <svg className="h-3.5 w-3.5" fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth={2.5}>
                              <path strokeLinecap="round" strokeLinejoin="round" d="M13.5 6H5.25A2.25 2.25 0 003 8.25v10.5A2.25 2.25 0 005.25 21h10.5A2.25 2.25 0 0018 18.75V10.5m-10.5 6L21 3m0 0h-5.25M21 3v5.25" />
                            </svg>
                          </a>
                          {/* CMS Edit button */}
                          <a
                            href={`/kochlik-produkty?search=${encodeURIComponent(prod.name)}`}
                            className="rounded-full bg-emerald-600 p-1.5 text-white shadow-xs hover:bg-emerald-700 transition"
                            title="Upraviť v CMS"
                          >
                            <svg className="h-3.5 w-3.5" fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth={2.5}>
                              <path strokeLinecap="round" strokeLinejoin="round" d="M16.862 4.487l1.687-1.688a1.875 1.875 0 112.652 2.652L6.832 19.82a4.5 4.5 0 01-1.897 1.13l-2.685.8.8-2.685a4.5 4.5 0 011.13-1.897L16.863 4.487zm0 0L19.5 7.125" />
                            </svg>
                          </a>
                        </div>
                      </div>
                    ))}
                  </div>
                </div>
              </div>
            );
          })() : (
              <div className="flex flex-col items-center justify-center h-[260px] text-center text-gray-400">
                <SwatchIcon className="h-12 w-12 text-gray-300 mb-3" />
                <p className="text-sm font-medium">Vyberte farbu v zozname na zobrazenie prislúchajúcich produktov.</p>
              </div>
            )}
          </div>
        </div>
      </div>

      {/* Global Edit Color Modal */}
      {isModalOpen &&
        createPortal(
          <div className="fixed inset-0 z-50 flex items-center justify-center bg-gray-900/50 px-4 backdrop-blur-sm">
            <div className="relative w-full max-w-lg rounded-3xl bg-white shadow-2xl overflow-hidden">
              <div className="flex items-center justify-between border-b border-gray-100 px-6 py-4">
                <h2 className="text-xl font-bold text-gray-950">Upraviť farbu globálne</h2>
                <button
                  onClick={closeModal}
                  className="rounded-full p-2 text-gray-400 transition hover:bg-gray-100 hover:text-gray-600"
                >
                  <XMarkIcon className="h-6 w-6" />
                </button>
              </div>

              <form onSubmit={handleSubmitColor} className="p-6">
                <div className="space-y-4">
                  {/* Warning Box */}
                  <div className="rounded-2xl bg-amber-50 p-4 border border-amber-200 text-xs text-amber-800 space-y-1">
                    <span className="font-bold uppercase tracking-wide block">Pozor</span>
                    Zmeny vykonané tu sa automaticky prejavia vo všetkých <strong>{editingColor?.products.length}</strong> produktoch, ktoré túto farbu momentálne používajú.
                  </div>

                  <label className="block">
                    <span className="text-sm font-semibold text-gray-700">Názov farby (identifikátor)</span>
                    <input
                      value={colorForm.name}
                      onChange={e => setColorForm(prev => ({ ...prev, name: e.target.value }))}
                      className="mt-1 w-full rounded-xl border border-gray-200 px-3 py-2 text-sm outline-none focus:border-emerald-500 focus:ring-1 focus:ring-emerald-500"
                      required
                    />
                  </label>

                  <label className="block">
                    <span className="text-sm font-semibold text-gray-700">Skupina farieb (rodina)</span>
                    <select
                      value={colorForm.family}
                      onChange={e => setColorForm(prev => ({ ...prev, family: e.target.value }))}
                      className="mt-1 w-full rounded-xl border border-gray-200 px-3 py-2 text-sm outline-none focus:border-emerald-500 focus:ring-1 focus:ring-emerald-500"
                    >
                      <option value="">Bez rodiny</option>
                      {COLOR_FAMILIES.map(family => (
                        <option key={family} value={family}>
                          {family}
                        </option>
                      ))}
                    </select>
                  </label>

                  <div>
                    <span className="text-sm font-semibold text-gray-700 block mb-1">HEX Farba</span>
                    <div className="flex items-center gap-3">
                      <label className="flex items-center gap-2 rounded-xl border border-gray-200 px-3 py-2 text-sm cursor-pointer hover:bg-gray-50 flex-1">
                        <input
                          type="color"
                          value={colorForm.hex || '#ffffff'}
                          onChange={e => setColorForm(prev => ({ ...prev, hex: e.target.value }))}
                          className="h-8 w-10 cursor-pointer"
                        />
                        <span className="text-gray-500 font-mono">{colorForm.hex || 'bez hex'}</span>
                      </label>
                      {colorForm.hex && (
                        <button
                          type="button"
                          onClick={() => setColorForm(prev => ({ ...prev, hex: '' }))}
                          className="rounded-xl bg-red-50 px-3 py-3 text-xs font-bold text-red-600 hover:bg-red-100"
                        >
                          Zrušiť HEX
                        </button>
                      )}
                    </div>
                  </div>

                  <div>
                    <span className="text-sm font-semibold text-gray-700 block mb-1">Obrázková vzorka</span>
                    {colorForm.image_url ? (
                      <div className="flex items-center gap-4">
                        <div className="relative h-16 w-16">
                          <img
                            src={colorForm.image_url}
                            alt=""
                            className="h-full w-full rounded-full object-cover border border-gray-200 shadow-2xs"
                          />
                        </div>
                        <div className="space-y-1">
                          <button
                            type="button"
                            onClick={() => setColorForm(prev => ({ ...prev, image_url: '' }))}
                            className="rounded-xl bg-red-50 px-3 py-2 text-xs font-bold text-red-600 hover:bg-red-100 block"
                          >
                            Odstrániť obrázok
                          </button>
                          <p className="text-[10px] text-gray-500">Môžete tiež vybrať nový súbor nižšie.</p>
                        </div>
                      </div>
                    ) : null}

                    <div className="mt-2">
                      <label className="inline-flex cursor-pointer items-center justify-center rounded-xl bg-gray-100 px-4 py-3 text-xs font-bold text-gray-700 transition hover:bg-gray-200 border border-dashed border-gray-300 w-full text-center">
                        <span>
                          {selectedFile
                            ? `Vybrané: ${selectedFile.name}`
                            : 'Vybrať alebo nahrať novú obrázkovú vzorku'}
                        </span>
                        <input
                          type="file"
                          accept="image/*"
                          className="hidden"
                          onChange={handleFileChange}
                        />
                      </label>
                    </div>
                  </div>

                  <div className="mt-6 flex justify-end gap-3 border-t border-gray-100 pt-4">
                    <button
                      type="button"
                      onClick={closeModal}
                      className="rounded-xl bg-gray-100 px-5 py-3 text-sm font-bold text-gray-700 transition hover:bg-gray-200"
                    >
                      Zrušiť
                    </button>
                    <button
                      type="submit"
                      disabled={savingColor}
                      className="inline-flex items-center justify-center gap-2 rounded-xl bg-emerald-600 px-6 py-3 text-sm font-extrabold text-white transition hover:bg-emerald-700 disabled:opacity-60"
                    >
                      <CheckCircleIcon className="h-5 w-5" />
                      {savingColor ? 'Ukladám...' : 'Uložiť a aktualizovať webe'}
                    </button>
                  </div>
                </div>
              </form>
            </div>
          </div>,
          document.body
        )}

      {/* Create Color Modal */}
      {isCreateModalOpen &&
        createPortal(
          <div className="fixed inset-0 z-50 flex items-center justify-center bg-gray-900/50 px-4 backdrop-blur-sm">
            <div className="relative w-full max-w-lg rounded-3xl bg-white shadow-2xl overflow-hidden max-h-[90vh] flex flex-col">
              <div className="flex items-center justify-between border-b border-gray-100 px-6 py-4 flex-shrink-0">
                <h2 className="text-xl font-bold text-gray-950">Pridať novú farbu</h2>
                <button
                  onClick={closeCreateModal}
                  className="rounded-full p-2 text-gray-400 transition hover:bg-gray-100 hover:text-gray-600"
                >
                  <XMarkIcon className="h-6 w-6" />
                </button>
              </div>

              <form onSubmit={handleCreateColor} className="flex-1 overflow-y-auto p-6 space-y-4">
                <label className="block">
                  <span className="text-sm font-semibold text-gray-700">Názov farby (napr. Antracit)</span>
                  <input
                    value={createForm.name}
                    onChange={e => setCreateForm(prev => ({ ...prev, name: e.target.value }))}
                    className="mt-1 w-full rounded-xl border border-gray-200 px-3 py-2 text-sm outline-none focus:border-emerald-500 focus:ring-1 focus:ring-emerald-500"
                    placeholder="Zadajte názov novej farby"
                    required
                  />
                </label>

                <label className="block">
                  <span className="text-sm font-semibold text-gray-700">Skupina farieb (rodina)</span>
                  <select
                    value={createForm.family}
                    onChange={e => setCreateForm(prev => ({ ...prev, family: e.target.value }))}
                    className="mt-1 w-full rounded-xl border border-gray-200 px-3 py-2 text-sm outline-none focus:border-emerald-500 focus:ring-1 focus:ring-emerald-500"
                  >
                    <option value="">Bez rodiny</option>
                    {COLOR_FAMILIES.map(family => (
                      <option key={family} value={family}>
                        {family}
                      </option>
                    ))}
                  </select>
                </label>

                <div>
                  <span className="text-sm font-semibold text-gray-700 block mb-1">HEX Farba (voliteľné)</span>
                  <div className="flex items-center gap-3">
                    <label className="flex items-center gap-2 rounded-xl border border-gray-200 px-3 py-2 text-sm cursor-pointer hover:bg-gray-50 flex-1">
                      <input
                        type="color"
                        value={createForm.hex || '#ffffff'}
                        onChange={e => setCreateForm(prev => ({ ...prev, hex: e.target.value }))}
                        className="h-8 w-10 cursor-pointer"
                      />
                      <span className="text-gray-500 font-mono">{createForm.hex || 'bez hex'}</span>
                    </label>
                    {createForm.hex && (
                      <button
                        type="button"
                        onClick={() => setCreateForm(prev => ({ ...prev, hex: '' }))}
                        className="rounded-xl bg-red-50 px-3 py-3 text-xs font-bold text-red-600 hover:bg-red-100"
                      >
                        Zrušiť HEX
                      </button>
                    )}
                  </div>
                </div>

                <div>
                  <span className="text-sm font-semibold text-gray-700 block mb-1">Obrázková vzorka (voliteľné)</span>
                  <div className="mt-1">
                    <label className="inline-flex cursor-pointer items-center justify-center rounded-xl bg-gray-100 px-4 py-3 text-xs font-bold text-gray-700 transition hover:bg-gray-200 border border-dashed border-gray-300 w-full text-center">
                      <span>
                        {createFile
                          ? `Vybrané: ${createFile.name}`
                          : 'Vybrať alebo nahrať obrázkovú vzorku'}
                      </span>
                      <input
                        type="file"
                        accept="image/*"
                        className="hidden"
                        onChange={e => {
                          if (e.target.files && e.target.files[0]) {
                            setCreateFile(e.target.files[0])
                          }
                        }}
                      />
                    </label>
                  </div>
                </div>

                <div className="border-t border-gray-100 pt-4 space-y-2">
                  <span className="text-sm font-semibold text-gray-700 block">
                    Priradiť k produktom ({createSelectedProducts.length} vybraných) *
                  </span>
                  
                  <div className="flex gap-2">
                    <input
                      type="text"
                      placeholder="Vyhľadať produkt..."
                      value={productSearchTerm}
                      onChange={e => setProductSearchTerm(e.target.value)}
                      className="w-full rounded-xl border border-gray-200 px-3 py-1.5 text-xs outline-none focus:border-emerald-500 focus:ring-1 focus:ring-emerald-500"
                    />
                    <button
                      type="button"
                      onClick={() => {
                        const visibleIds = products
                          .filter(p => p.name.toLowerCase().includes(productSearchTerm.toLowerCase()))
                          .map(p => p.id)
                        setCreateSelectedProducts(prev => Array.from(new Set([...prev, ...visibleIds])))
                      }}
                      className="rounded-xl bg-gray-100 px-3 py-1.5 text-[10px] font-bold text-gray-600 hover:bg-gray-200 whitespace-nowrap"
                    >
                      Vybrať všetko
                    </button>
                    <button
                      type="button"
                      onClick={() => setCreateSelectedProducts([])}
                      className="rounded-xl bg-gray-100 px-3 py-1.5 text-[10px] font-bold text-gray-600 hover:bg-gray-200 whitespace-nowrap"
                    >
                      Vyčistiť
                    </button>
                  </div>

                  <div className="max-h-40 overflow-y-auto border border-gray-150 rounded-2xl p-2 space-y-1.5 bg-gray-50">
                    {products
                      .filter(p => p.name.toLowerCase().includes(productSearchTerm.toLowerCase()))
                      .map(prod => {
                        const isChecked = createSelectedProducts.includes(prod.id)
                        return (
                          <label
                            key={prod.id}
                            className="flex items-center gap-3 p-1.5 hover:bg-white rounded-xl cursor-pointer transition text-xs border border-transparent hover:border-gray-200"
                          >
                            <input
                              type="checkbox"
                              checked={isChecked}
                              onChange={() => {
                                setCreateSelectedProducts(prev =>
                                  isChecked
                                    ? prev.filter(id => id !== prod.id)
                                    : [...prev, prod.id]
                                )
                              }}
                              className="rounded border-gray-300 text-emerald-600 focus:ring-emerald-500"
                            />
                            {prod.main_image_url ? (
                              <img
                                src={prod.main_image_url}
                                alt=""
                                className="h-6 w-6 rounded-md object-cover flex-shrink-0"
                              />
                            ) : (
                              <div className="h-6 w-6 rounded-md bg-gray-200 flex items-center justify-center flex-shrink-0">
                                <PhotoIcon className="h-3 w-3 text-gray-400" />
                              </div>
                            )}
                            <span className="font-semibold text-gray-800 truncate flex-1">{prod.name}</span>
                            <span className="text-[10px] text-gray-400">
                              ({(prod.color_options || []).length} farieb)
                            </span>
                          </label>
                        )
                      })}
                  </div>
                </div>

                <div className="pt-4 border-t border-gray-100 flex justify-end gap-3">
                  <button
                    type="button"
                    onClick={closeCreateModal}
                    className="rounded-xl bg-gray-100 px-5 py-2.5 text-sm font-bold text-gray-700 transition hover:bg-gray-200"
                  >
                    Zrušiť
                  </button>
                  <button
                    type="submit"
                    disabled={savingColor}
                    className="inline-flex items-center justify-center gap-2 rounded-xl bg-emerald-600 px-6 py-2.5 text-sm font-extrabold text-white transition hover:bg-emerald-700 disabled:opacity-60"
                  >
                    <CheckCircleIcon className="h-5 w-5" />
                    {savingColor ? 'Vytváram...' : 'Vytvoriť farbu'}
                  </button>
                </div>
              </form>
            </div>
          </div>,
          document.body
        )}
    </div>
  )
}
