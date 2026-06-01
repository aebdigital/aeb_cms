import { useCallback, useEffect, useMemo, useState } from 'react'
import { createPortal } from 'react-dom'
import {
  ArchiveBoxIcon,
  CheckCircleIcon,
  MagnifyingGlassIcon,
  PencilSquareIcon,
  PhotoIcon,
  PlusIcon,
  Squares2X2Icon,
  StarIcon,
  SwatchIcon,
  TableCellsIcon,
  TrashIcon,
  XMarkIcon,
} from '@heroicons/react/24/outline'
import { useAuth } from '../contexts/AuthContext'
import { useNotification } from '../contexts/NotificationContext'
import {
  KOCHLIK_OWNER_ID,
  createKochlikProduct,
  deleteKochlikProduct,
  getPublicUrl,
  listKochlikCategories,
  listKochlikProducts,
  updateKochlikProduct,
  updateKochlikProductsOrder,
  uploadProductDownloadFile,
  uploadProductImage,
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

const DIMENSION_GROUPS = ['Do 50 cm', '51-100 cm', '101-150 cm', 'Nad 150 cm']

const EMPTY_PRODUCT = {
  name: '',
  slug: '',
  brand: '',
  category_id: '',
  price: '',
  short_description: '',
  description: '',
  main_image_url: '',
  gallery_images: [],
  color_options: [],
  dimensions_text: '',
  dimension_groups: [],
  variations: [],
  specifications: [],
  download_files: [],
  supplier_url: '',
  source_url: '',
  is_featured: false,
  is_active: true,
  sort_order: 0,
  seo_title: '',
  seo_description: '',
}

function slugify(value) {
  return value
    .toLowerCase()
    .normalize('NFD')
    .replace(/[\u0300-\u036f]/g, '')
    .replace(/[^a-z0-9]+/g, '-')
    .replace(/^-+|-+$/g, '')
}

function formatPrice(product) {
  if (product.price_cents == null) return 'Cena na vyžiadanie'
  return new Intl.NumberFormat('sk-SK', {
    style: 'currency',
    currency: product.currency || 'EUR',
  }).format((Number(product.price_cents) || 0) / 100)
}

function listFromText(value) {
  return String(value || '')
    .split(/\n|,/)
    .map(item => item.trim())
    .filter(Boolean)
}

function uniqueImages(...groups) {
  const seen = new Set()
  const images = []
  for (const group of groups) {
    for (const image of Array.isArray(group) ? group : [group]) {
      const url = String(image || '').trim()
      if (!url || seen.has(url)) continue
      seen.add(url)
      images.push(url)
    }
  }
  return images
}

function getProductImage(product) {
  return product.main_image_url || product.gallery_images?.[0] || ''
}

function productToForm(product) {
  return {
    name: product.name || '',
    slug: product.slug || '',
    brand: product.brand || '',
    category_id: product.category_id || '',
    price: product.price_cents == null ? '' : (Number(product.price_cents) / 100).toFixed(2),
    short_description: product.short_description || '',
    description: product.description || '',
    main_image_url: product.main_image_url || product.gallery_images?.[0] || '',
    gallery_images: uniqueImages(product.main_image_url, product.gallery_images || []),
    color_options: (product.color_options || []).map(color => ({
      name: color.name || '',
      family: color.family || '',
      hex: color.hex || '',
      image_url: color.image_url || '',
    })),
    dimensions_text: (product.dimensions || []).join('\n'),
    dimension_groups: product.dimension_groups || [],
    variations: (product.variations || []).map(variation => {
      const label = variation.label || ''
      const dimensions = variation.dimensions || ''
      return {
        label: label === dimensions ? '' : label,
        dimensions,
        price_cents: variation.price_cents == null ? '' : (Number(variation.price_cents) / 100).toFixed(2),
      }
    }),
    specifications: product.specifications || [],
    download_files: product.download_files || [],
    supplier_url: product.supplier_url || '',
    source_url: product.source_url || '',
    is_featured: Boolean(product.is_featured),
    is_active: Boolean(product.is_active),
    sort_order: product.sort_order || 0,
    seo_title: product.seo_title || '',
    seo_description: product.seo_description || '',
  }
}

function formToProductPayload(form) {
  const galleryImages = uniqueImages(form.main_image_url, form.gallery_images || [])
  const mainImage = galleryImages.includes(form.main_image_url)
    ? form.main_image_url
    : galleryImages[0] || ''

  const colorOptions = (form.color_options || [])
    .map(color => ({
      name: String(color.name || '').trim(),
      family: color.family || null,
      hex: color.hex || null,
      image_url: color.image_url || null,
    }))
    .filter(color => color.name)

  const variations = (form.variations || [])
    .map(variation => ({
      label: null,
      dimensions: String(variation.dimensions || '').trim() || null,
      price: null,
      price_cents: variation.price_cents === '' || variation.price_cents == null
        ? null
        : Math.round(Number(variation.price_cents || 0) * 100),
    }))
    .filter(variation => variation.dimensions || variation.price_cents != null)

  const specifications = (form.specifications || [])
    .map(spec => ({
      key: String(spec.key || '').trim(),
      value: String(spec.value || '').trim(),
    }))
    .filter(spec => spec.key || spec.value)

  const downloadFiles = (form.download_files || [])
    .map(file => ({
      label: String(file.label || '').trim() || 'Technický dokument',
      url: String(file.url || '').trim(),
    }))
    .filter(file => file.url)

  return {
    name: form.name.trim(),
    slug: (form.slug || slugify(form.name)).trim(),
    sku: null,
    brand: form.brand.trim() || null,
    category_id: form.category_id || null,
    price_text: null,
    price_cents: form.price === '' ? null : Math.round(Number(form.price || 0) * 100),
    currency: 'EUR',
    short_description: form.short_description.trim() || null,
    description: form.description.trim() || null,
    main_image_url: mainImage || null,
    gallery_images: mainImage
      ? [mainImage, ...galleryImages.filter(image => image !== mainImage)]
      : galleryImages,
    color_options: colorOptions,
    color_families: Array.from(new Set(colorOptions.map(color => color.family).filter(Boolean))),
    dimensions: Array.from(new Set(variations.map(v => v.dimensions).filter(Boolean))),
    dimension_groups: [],
    variations,
    specifications: [],
    download_files: downloadFiles,
    supplier_url: null,
    source_url: null,
    is_featured: Boolean(form.is_featured),
    is_active: Boolean(form.is_active),
    sort_order: Number(form.sort_order || 0),
    seo_title: form.seo_title.trim() || null,
    seo_description: form.seo_description.trim() || null,
  }
}

export default function KochlikProducts() {
  const { user, loading: authLoading } = useAuth()
  const { showNotification } = useNotification()
  const [products, setProducts] = useState([])
  const [categories, setCategories] = useState([])
  const [loading, setLoading] = useState(true)
  const [saving, setSaving] = useState(false)
  const [uploadingGallery, setUploadingGallery] = useState(false)
  const [uploadingColorIndex, setUploadingColorIndex] = useState(null)
  const [uploadingDownloadIndex, setUploadingDownloadIndex] = useState(null)
  const [isModalOpen, setIsModalOpen] = useState(false)
  const [editingProduct, setEditingProduct] = useState(null)
  const [productForm, setProductForm] = useState(EMPTY_PRODUCT)
  const [searchTerm, setSearchTerm] = useState('')
  const [categoryFilter, setCategoryFilter] = useState('all')
  const [brandFilter, setBrandFilter] = useState('all')
  const [viewMode, setViewMode] = useState('rows')
  const [draggedIndex, setDraggedIndex] = useState(null)

  const hasAccess = user?.id === KOCHLIK_OWNER_ID || user?.email === 'alexander.hidveghy@gmail.com'
  const categoryById = useMemo(() => new Map(categories.map(cat => [cat.id, cat])), [categories])

  const uniqueBrands = useMemo(() => {
    const brandsSet = new Set(products.map(p => p.brand?.trim()).filter(Boolean))
    return Array.from(brandsSet).sort((a, b) => a.localeCompare(b, 'sk'))
  }, [products])

  const visibleProducts = useMemo(() => {
    const query = searchTerm.trim().toLowerCase()

    return products.filter(product => {
      const categoryName = categoryById.get(product.category_id)?.name || product.kochlik_categories?.name || ''
      const matchesCategory = categoryFilter === 'all'
        || (categoryFilter === 'none' ? !product.category_id : product.category_id === categoryFilter)

      if (!matchesCategory) return false

      const matchesBrand = brandFilter === 'all'
        || (brandFilter === 'none' ? !product.brand?.trim() : product.brand?.trim() === brandFilter)

      if (!matchesBrand) return false
      if (!query) return true

      return [
        product.name,
        product.slug,
        product.brand,
        product.description,
        product.short_description,
        categoryName,
        formatPrice(product),
      ]
        .filter(Boolean)
        .join(' ')
        .toLowerCase()
        .includes(query)
    })
  }, [categoryById, categoryFilter, brandFilter, products, searchTerm])

  const isReorderEnabled = true

  const loadData = useCallback(async () => {
    setLoading(true)
    try {
      const [nextProducts, nextCategories] = await Promise.all([
        listKochlikProducts(),
        listKochlikCategories(),
      ])
      setProducts(nextProducts)
      setCategories(nextCategories)
    } catch (err) {
      console.error('Kochlik load error:', err)
      showNotification('Nepodarilo sa načítať produkty', 'error')
    } finally {
      setLoading(false)
    }
  }, [showNotification])

  useEffect(() => {
    if (authLoading || !hasAccess) return
    loadData()
  }, [authLoading, hasAccess, loadData])

  useEffect(() => {
    if (isModalOpen) {
      document.body.style.overflow = 'hidden'
    } else {
      document.body.style.overflow = ''
    }
    return () => {
      document.body.style.overflow = ''
    }
  }, [isModalOpen])

  function openCreateModal() {
    setEditingProduct(null)
    setProductForm(EMPTY_PRODUCT)
    setIsModalOpen(true)
  }

  function openEditModal(product) {
    setEditingProduct(product)
    setProductForm(productToForm(product))
    setIsModalOpen(true)
  }

  function closeModal() {
    setIsModalOpen(false)
    setEditingProduct(null)
    setProductForm(EMPTY_PRODUCT)
  }

  async function handleSubmitProduct(event) {
    event.preventDefault()
    const payload = formToProductPayload(productForm)

    if (!payload.name || !payload.slug) {
      showNotification('Vyplňte názov a URL slug produktu', 'error')
      return
    }

    setSaving(true)
    try {
      if (editingProduct) {
        const updated = await updateKochlikProduct(editingProduct.id, payload)
        setProducts(prev => prev.map(product => product.id === updated.id ? updated : product))
        showNotification('Produkt bol uložený', 'success')
      } else {
        const created = await createKochlikProduct(payload)
        setProducts(prev => [created, ...prev])
        showNotification('Produkt bol pridaný', 'success')
      }
      closeModal()
    } catch (err) {
      console.error('Kochlik product save error:', err)
      showNotification(err.message || 'Produkt sa nepodarilo uložiť', 'error')
    } finally {
      setSaving(false)
    }
  }

  async function uploadImage(file, target = {}) {
    const { path } = await uploadProductImage({
      file,
      ownerSlug: 'kochlik',
      productId: editingProduct?.id || 'new',
    })
    const url = getPublicUrl(path)
    if (target.kind === 'gallery') {
      setProductForm(prev => ({
        ...prev,
        main_image_url: prev.main_image_url || url,
        gallery_images: uniqueImages(prev.gallery_images || [], url),
      }))
    } else if (target.kind === 'color') {
      updateColorOption(target.index, 'image_url', url)
    }
  }

  async function handleGalleryImageUpload(event) {
    const files = Array.from(event.target.files || [])
    event.target.value = ''
    if (files.length === 0) return

    setUploadingGallery(true)
    try {
      for (const file of files) {
        if (file.type.startsWith('image/')) {
          await uploadImage(file, { kind: 'gallery' })
        }
      }
      showNotification('Galéria bola nahraná', 'success')
    } catch (err) {
      console.error('Kochlik gallery upload error:', err)
      showNotification('Galériu sa nepodarilo nahrať', 'error')
    } finally {
      setUploadingGallery(false)
    }
  }

  async function handleColorImageUpload(index, event) {
    const file = event.target.files?.[0]
    event.target.value = ''
    if (!file || !file.type.startsWith('image/')) return

    setUploadingColorIndex(index)
    try {
      await uploadImage(file, { kind: 'color', index })
      showNotification('Vzorka farby bola nahraná', 'success')
    } catch (err) {
      console.error('Kochlik color image upload error:', err)
      showNotification('Vzorku farby sa nepodarilo nahrať', 'error')
    } finally {
      setUploadingColorIndex(null)
    }
  }

  function addColorOption() {
    setProductForm(prev => ({
      ...prev,
      color_options: [...(prev.color_options || []), { name: '', family: '', hex: '', image_url: '' }],
    }))
  }

  function updateColorOption(index, field, value) {
    setProductForm(prev => {
      const next = [...(prev.color_options || [])]
      next[index] = { ...next[index], [field]: value }
      return { ...prev, color_options: next }
    })
  }

  function removeColorOption(index) {
    setProductForm(prev => ({
      ...prev,
      color_options: (prev.color_options || []).filter((_, i) => i !== index),
    }))
  }

  function addVariation() {
    setProductForm(prev => ({
      ...prev,
      variations: [...(prev.variations || []), { label: '', dimensions: '', price_cents: '' }],
    }))
  }

  function updateVariation(index, field, value) {
    setProductForm(prev => {
      const next = [...(prev.variations || [])]
      next[index] = { ...next[index], [field]: value }
      return { ...prev, variations: next }
    })
  }

  function removeVariation(index) {
    setProductForm(prev => ({
      ...prev,
      variations: (prev.variations || []).filter((_, i) => i !== index),
    }))
  }

  function addSpecification() {
    setProductForm(prev => ({
      ...prev,
      specifications: [...(prev.specifications || []), { key: '', value: '' }],
    }))
  }

  function updateSpecification(index, field, value) {
    setProductForm(prev => {
      const next = [...(prev.specifications || [])]
      next[index] = { ...next[index], [field]: value }
      return { ...prev, specifications: next }
    })
  }

  function removeSpecification(index) {
    setProductForm(prev => ({
      ...prev,
      specifications: (prev.specifications || []).filter((_, i) => i !== index),
    }))
  }

  function setMainGalleryImage(url) {
    setProductForm(prev => ({
      ...prev,
      main_image_url: url,
      gallery_images: uniqueImages(url, prev.gallery_images || []),
    }))
  }

  function removeGalleryImage(index) {
    setProductForm(prev => {
      const removedUrl = prev.gallery_images[index]
      const galleryImages = (prev.gallery_images || []).filter((_, i) => i !== index)
      const nextMainImage = prev.main_image_url === removedUrl
        ? galleryImages[0] || ''
        : prev.main_image_url

      return {
        ...prev,
        main_image_url: nextMainImage,
        gallery_images: galleryImages,
      }
    })
  }

  function addDownloadFile() {
    setProductForm(prev => ({
      ...prev,
      download_files: [...(prev.download_files || []), { label: 'Technický dokument', url: '' }],
    }))
  }

  function updateDownloadFile(index, field, value) {
    setProductForm(prev => {
      const next = [...(prev.download_files || [])]
      next[index] = { ...next[index], [field]: value }
      return { ...prev, download_files: next }
    })
  }

  function removeDownloadFile(index) {
    setProductForm(prev => ({
      ...prev,
      download_files: (prev.download_files || []).filter((_, i) => i !== index),
    }))
  }

  async function handleDownloadFileUpload(index, event) {
    const file = event.target.files?.[0]
    event.target.value = ''
    if (!file) return

    setUploadingDownloadIndex(index)
    try {
      const { path } = await uploadProductDownloadFile({
        file,
        ownerSlug: 'kochlik',
        productId: editingProduct?.id || 'new',
      })
      const url = getPublicUrl(path)
      setProductForm(prev => {
        const next = [...(prev.download_files || [])]
        next[index] = {
          ...next[index],
          label: next[index]?.label || file.name.replace(/\.[^.]+$/, '') || 'Technický dokument',
          url,
        }
        return { ...prev, download_files: next }
      })
      showNotification('Súbor bol nahraný', 'success')
    } catch (err) {
      console.error('Kochlik download upload error:', err)
      showNotification('Súbor sa nepodarilo nahrať', 'error')
    } finally {
      setUploadingDownloadIndex(null)
    }
  }

  async function handleDeleteProduct(product) {
    if (!confirm(`Naozaj vymazať produkt "${product.name}"?`)) return

    try {
      await deleteKochlikProduct(product.id)
      setProducts(prev => prev.filter(item => item.id !== product.id))
      showNotification('Produkt bol vymazaný', 'success')
    } catch (err) {
      console.error('Kochlik product delete error:', err)
      showNotification('Produkt sa nepodarilo vymazať', 'error')
    }
  }

  if (authLoading) return <div className="flex h-64 items-center justify-center"><div className="h-8 w-8 animate-spin rounded-full border-b-2 border-emerald-600"></div></div>
  if (!hasAccess) return <div className="flex h-64 items-center justify-center"><p className="text-gray-500">Nemáte prístup.</p></div>

  return (
    <div className="space-y-6">
      <div className="flex flex-col gap-4 lg:flex-row lg:items-end lg:justify-between">
        <div>
          <p className="text-sm font-semibold uppercase tracking-[0.18em] text-emerald-700">Kochlik</p>
          <h1 className="mt-1 text-3xl font-bold text-gray-950">Produkty</h1>
        </div>
        <button
          onClick={openCreateModal}
          className="inline-flex items-center justify-center rounded-2xl bg-emerald-600 px-5 py-3 text-sm font-extrabold text-white transition hover:bg-emerald-700"
        >
          <PlusIcon className="mr-2 h-5 w-5" />
          Pridať produkt
        </button>
      </div>

      <div className="grid gap-3 rounded-3xl bg-white p-4 shadow-sm ring-1 ring-gray-100 lg:grid-cols-[1fr_200px_200px_auto] lg:items-center">
        <label className="relative block">
          <MagnifyingGlassIcon className="pointer-events-none absolute left-4 top-1/2 h-5 w-5 -translate-y-1/2 text-gray-400" />
          <input
            value={searchTerm}
            onChange={(event) => setSearchTerm(event.target.value)}
            placeholder="Hľadať podľa názvu, slug, značky alebo textu"
            className="h-12 w-full rounded-2xl border border-gray-200 pl-11 pr-4 text-sm outline-none transition focus:border-emerald-500 focus:ring-2 focus:ring-emerald-100"
          />
        </label>
        <select
          value={categoryFilter}
          onChange={(event) => setCategoryFilter(event.target.value)}
          className="h-12 rounded-2xl border border-gray-200 px-4 text-sm text-gray-700 outline-none transition focus:border-emerald-500 focus:ring-2 focus:ring-emerald-100"
        >
          <option value="all">Všetky kategórie</option>
          <option value="none">Bez kategórie</option>
          {categories.map(cat => (
            <option key={cat.id} value={cat.id}>{cat.name}</option>
          ))}
        </select>
        <select
          value={brandFilter}
          onChange={(event) => setBrandFilter(event.target.value)}
          className="h-12 rounded-2xl border border-gray-200 px-4 text-sm text-gray-700 outline-none transition focus:border-emerald-500 focus:ring-2 focus:ring-emerald-100"
        >
          <option value="all">Všetky značky</option>
          <option value="none">Bez značky</option>
          {uniqueBrands.map(brand => (
            <option key={brand} value={brand}>{brand}</option>
          ))}
        </select>
        <div className="flex items-center justify-between gap-3 lg:justify-end">
          <span className="text-sm font-semibold text-gray-500">{visibleProducts.length} / {products.length}</span>
          <div className="flex rounded-2xl bg-gray-100 p-1">
            <button
              type="button"
              onClick={() => setViewMode('rows')}
              className={`inline-flex h-10 w-10 items-center justify-center rounded-xl transition ${
                viewMode === 'rows' ? 'bg-white text-emerald-700 shadow-sm' : 'text-gray-500 hover:text-gray-900'
              }`}
              title="Riadky"
            >
              <TableCellsIcon className="h-5 w-5" />
            </button>
            <button
              type="button"
              onClick={() => setViewMode('grid')}
              className={`inline-flex h-10 w-10 items-center justify-center rounded-xl transition ${
                viewMode === 'grid' ? 'bg-white text-emerald-700 shadow-sm' : 'text-gray-500 hover:text-gray-900'
              }`}
              title="Obrázky"
            >
              <Squares2X2Icon className="h-5 w-5" />
            </button>
          </div>
        </div>
      </div>

      {loading ? (
        <div className="rounded-3xl bg-white p-12 text-center text-gray-500 shadow-sm ring-1 ring-gray-100">
          Načítavam produkty...
        </div>
      ) : viewMode === 'rows' ? (
        <div className="overflow-x-auto rounded-3xl bg-white shadow-sm ring-1 ring-gray-100">
          <table className="min-w-full divide-y divide-gray-200">
            <thead className="bg-gray-50">
              <tr>
                {isReorderEnabled && <th className="w-10 px-4 py-4"></th>}
                <th className="px-6 py-4 text-left text-xs font-medium uppercase tracking-wider text-gray-500">Obrázok</th>
                <th className="px-6 py-4 text-left text-xs font-medium uppercase tracking-wider text-gray-500">Názov</th>
                <th className="px-6 py-4 text-left text-xs font-medium uppercase tracking-wider text-gray-500">Kategória</th>
                <th className="px-6 py-4 text-left text-xs font-medium uppercase tracking-wider text-gray-500">Cena</th>
                <th className="px-6 py-4 text-left text-xs font-medium uppercase tracking-wider text-gray-500">Farby</th>
                <th className="px-6 py-4 text-left text-xs font-medium uppercase tracking-wider text-gray-500">Rozmery</th>
                <th className="px-6 py-4 text-left text-xs font-medium uppercase tracking-wider text-gray-500">Stav</th>
                <th className="px-6 py-4 text-right text-xs font-medium uppercase tracking-wider text-gray-500">Akcie</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-gray-200 bg-white">
              {visibleProducts.length === 0 ? (
                <tr>
                  <td colSpan={isReorderEnabled ? 9 : 8} className="px-6 py-12 text-center text-sm text-gray-500">
                    Nenašli sa žiadne produkty.
                  </td>
                </tr>
              ) : visibleProducts.map((product, index) => (
                <tr
                  key={product.id}
                  onClick={() => openEditModal(product)}
                  className={`cursor-pointer transition ${product.is_featured ? 'bg-yellow-50 hover:bg-yellow-100' : 'hover:bg-gray-50'} ${draggedIndex === index ? 'opacity-50' : ''}`}
                  draggable={isReorderEnabled}
                  onDragStart={(e) => {
                    if (!isReorderEnabled) return;
                    setDraggedIndex(index);
                    e.dataTransfer.effectAllowed = 'move';
                  }}
                  onDragOver={(e) => {
                    if (!isReorderEnabled) return;
                    e.preventDefault();
                    if (draggedIndex === null || draggedIndex === index) return;
                    
                    const draggedItem = visibleProducts[draggedIndex];
                    const targetItem = visibleProducts[index];
                    if (!draggedItem || !targetItem) return;
                    
                    const newProducts = [...products];
                    const fullDraggedIdx = newProducts.findIndex(p => p.id === draggedItem.id);
                    const fullTargetIdx = newProducts.findIndex(p => p.id === targetItem.id);
                    
                    if (fullDraggedIdx !== -1 && fullTargetIdx !== -1) {
                      newProducts.splice(fullDraggedIdx, 1);
                      newProducts.splice(fullTargetIdx, 0, draggedItem);
                      setProducts(newProducts);
                      setDraggedIndex(index);
                    }
                  }}
                  onDragEnd={async () => {
                    setDraggedIndex(null);
                    if (!isReorderEnabled) return;
                    
                    const updates = [];
                    const updatedProducts = products.map((p, idx) => {
                      if (p.sort_order !== idx) {
                        updates.push({ id: p.id, sort_order: idx });
                        return { ...p, sort_order: idx };
                      }
                      return p;
                    });

                    if (updates.length === 0) return;
                    
                    try {
                      await updateKochlikProductsOrder(updates);
                      setProducts(updatedProducts);
                      showNotification('Poradie produktov bolo uložené', 'success');
                    } catch (err) {
                      console.error('Failed to save product order:', err);
                      showNotification('Nepodarilo sa uložiť poradie', 'error');
                    }
                  }}
                >
                  {isReorderEnabled && (
                    <td
                      onClick={(e) => e.stopPropagation()}
                      className="px-4 py-4 cursor-grab active:cursor-grabbing text-gray-400"
                    >
                      <svg className="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M4 8h16M4 16h16" />
                      </svg>
                    </td>
                  )}
                  <td className="whitespace-nowrap px-6 py-4">
                    <div className="h-12 w-12 flex-shrink-0 overflow-hidden rounded-lg bg-gray-100">
                      {getProductImage(product) ? (
                        <img src={getProductImage(product)} alt="" className="h-full w-full object-cover" />
                      ) : (
                        <div className="flex h-full items-center justify-center text-gray-300">
                          <ArchiveBoxIcon className="h-6 w-6" />
                        </div>
                      )}
                    </div>
                  </td>
                  <td className="whitespace-nowrap px-6 py-4">
                    <div className="text-sm font-medium text-gray-900">{product.name}</div>
                    <a
                      href={`https://kochlik.sk/produkt/${product.kochlik_categories?.slug || 'vsetky'}/${product.slug}`}
                      target="_blank"
                      rel="noopener noreferrer"
                      onClick={(e) => e.stopPropagation()}
                      className="relative z-10 text-xs font-semibold text-blue-600 hover:text-blue-800 hover:underline truncate block max-w-[240px]"
                      title={`https://kochlik.sk/produkt/${product.kochlik_categories?.slug || 'vsetky'}/${product.slug}`}
                    >
                      {`https://kochlik.sk/produkt/${product.kochlik_categories?.slug || 'vsetky'}/${product.slug}`}
                    </a>
                  </td>
                  <td className="whitespace-nowrap px-6 py-4">
                    <div className="text-sm text-gray-500">
                      {categoryById.get(product.category_id)?.name || product.kochlik_categories?.name || '-'}
                    </div>
                  </td>
                  <td className="whitespace-nowrap px-6 py-4">
                    <div className="text-sm font-bold text-gray-900">{formatPrice(product)}</div>
                  </td>
                  <td className="whitespace-nowrap px-6 py-4">
                    <div className="flex items-center gap-1 text-sm text-gray-500">
                      <SwatchIcon className="h-4 w-4" />
                      {(product.color_options || []).length}
                    </div>
                  </td>
                  <td className="whitespace-nowrap px-6 py-4">
                    <div className="text-sm text-gray-500">{(product.dimensions || []).length}</div>
                  </td>
                  <td className="whitespace-nowrap px-6 py-4">
                    <span className={`inline-flex rounded-full px-2 py-1 text-xs font-semibold leading-5 ${
                      product.is_active ? 'bg-green-100 text-green-800' : 'bg-gray-100 text-gray-800'
                    }`}>
                      {product.is_active ? 'Aktívny' : 'Skrytý'}
                    </span>
                  </td>
                  <td className="whitespace-nowrap px-6 py-4 text-right text-sm font-medium">
                    <button
                      onClick={(e) => {
                        e.stopPropagation()
                        handleDeleteProduct(product)
                      }}
                      className="relative z-10 inline-flex items-center text-red-600 hover:text-red-900"
                    >
                      <TrashIcon className="mr-1 h-4 w-4" />
                      Vymazať
                    </button>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      ) : (
        <div className="rounded-3xl bg-white p-4 shadow-sm ring-1 ring-gray-100">
          {visibleProducts.length === 0 ? (
            <div className="p-12 text-center text-sm text-gray-500">Nenašli sa žiadne produkty.</div>
          ) : (
            <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 2xl:grid-cols-5">
              {visibleProducts.map((product, index) => (
                <div
                  key={product.id}
                  draggable={isReorderEnabled}
                  onDragStart={(e) => {
                    if (!isReorderEnabled) return;
                    setDraggedIndex(index);
                    e.dataTransfer.effectAllowed = 'move';
                  }}
                  onDragOver={(e) => {
                    if (!isReorderEnabled) return;
                    e.preventDefault();
                    if (draggedIndex === null || draggedIndex === index) return;
                    
                    const draggedItem = visibleProducts[draggedIndex];
                    const targetItem = visibleProducts[index];
                    if (!draggedItem || !targetItem) return;
                    
                    const newProducts = [...products];
                    const fullDraggedIdx = newProducts.findIndex(p => p.id === draggedItem.id);
                    const fullTargetIdx = newProducts.findIndex(p => p.id === targetItem.id);
                    
                    if (fullDraggedIdx !== -1 && fullTargetIdx !== -1) {
                      newProducts.splice(fullDraggedIdx, 1);
                      newProducts.splice(fullTargetIdx, 0, draggedItem);
                      setProducts(newProducts);
                      setDraggedIndex(index);
                    }
                  }}
                  onDragEnd={async () => {
                    setDraggedIndex(null);
                    if (!isReorderEnabled) return;
                    
                    const updates = [];
                    const updatedProducts = products.map((p, idx) => {
                      if (p.sort_order !== idx) {
                        updates.push({ id: p.id, sort_order: idx });
                        return { ...p, sort_order: idx };
                      }
                      return p;
                    });

                    if (updates.length === 0) return;
                    
                    try {
                      await updateKochlikProductsOrder(updates);
                      setProducts(updatedProducts);
                      showNotification('Poradie produktov bolo uložené', 'success');
                    } catch (err) {
                      console.error('Failed to save product order:', err);
                      showNotification('Nepodarilo sa uložiť poradie', 'error');
                    }
                  }}
                  className={`group relative overflow-hidden rounded-2xl ${product.is_featured ? 'bg-yellow-50 hover:bg-yellow-100' : 'bg-gray-50 hover:bg-white'} text-left ring-1 ring-gray-100 transition duration-200 ${
                    isReorderEnabled ? 'cursor-grab active:cursor-grabbing' : ''
                  } ${draggedIndex === index ? 'opacity-50' : 'hover:-translate-y-0.5 hover:shadow-lg'}`}
                >
                  <button
                    type="button"
                    onClick={() => openEditModal(product)}
                    className="w-full h-full text-left outline-none"
                  >
                    <div className="relative aspect-square bg-gray-100">
                      {getProductImage(product) ? (
                        <img src={getProductImage(product)} alt="" className="h-full w-full object-cover transition duration-300 group-hover:scale-105" />
                      ) : (
                        <div className="flex h-full items-center justify-center text-gray-300">
                          <PhotoIcon className="h-12 w-12" />
                        </div>
                      )}
                      <div className="absolute inset-x-0 bottom-0 bg-gradient-to-t from-black/75 via-black/35 to-transparent p-4 text-white">
                        <h3 className="line-clamp-2 text-sm font-extrabold leading-tight">{product.name}</h3>
                        <p className="mt-1 text-sm font-semibold text-white/90">{formatPrice(product)}</p>
                      </div>
                      <span className={`absolute left-3 top-3 rounded-full px-2.5 py-1 text-xs font-bold ${
                        product.is_active ? 'bg-emerald-500 text-white' : 'bg-gray-900/70 text-white'
                      }`}>
                        {product.is_active ? 'Aktívny' : 'Skrytý'}
                      </span>
                    </div>
                  </button>
                </div>
              ))}
            </div>
          )}
        </div>
      )}

      {isModalOpen && createPortal(
        <div className="fixed inset-0 z-50 flex items-center justify-center overflow-y-auto bg-gray-900/50 px-4 py-6 backdrop-blur-sm sm:px-0">
          <div className="relative max-h-[92vh] w-full max-w-[1500px] overflow-y-auto rounded-3xl bg-white shadow-2xl">
            <div className="sticky top-0 z-10 flex items-center justify-between border-b border-gray-100 bg-white px-6 py-4">
              <h2 className="text-xl font-bold text-gray-950">{editingProduct ? 'Upraviť produkt' : 'Nový produkt'}</h2>
              <button onClick={closeModal} className="rounded-full p-2 text-gray-400 transition hover:bg-gray-100 hover:text-gray-600">
                <XMarkIcon className="h-6 w-6" />
              </button>
            </div>

            <form onSubmit={handleSubmitProduct} className="p-6">
              <div className="grid gap-6 lg:grid-cols-2 items-start">
                {/* Left Column */}
                <div className="space-y-6">
                  {/* Gallery Section */}
                  <section className="rounded-2xl border border-gray-200 bg-gray-50 p-4">
                    <div className="mb-4 flex flex-col gap-3 sm:flex-row sm:items-center sm:justify-between">
                      <div>
                        <span className="text-sm font-semibold text-gray-700">GALÉRIA</span>
                        <p className="text-xs text-gray-500">Hviezdička označuje hlavný obrázok produktu.</p>
                      </div>
                      <label className="inline-flex cursor-pointer items-center justify-center rounded-xl bg-gray-200 px-4 py-2 text-xs font-bold text-gray-900 transition hover:bg-gray-300">
                        {uploadingGallery ? 'Nahrávam...' : 'Pridať obrázky'}
                        <input type="file" multiple accept="image/*" className="hidden" disabled={uploadingGallery} onChange={handleGalleryImageUpload} />
                      </label>
                    </div>

                    <div className="w-full">
                      {(productForm.gallery_images || []).length === 0 ? (
                        <div className="flex min-h-[120px] items-center justify-center rounded-xl border border-dashed border-gray-300 bg-white text-sm font-semibold text-gray-400">
                          Zatiaľ bez obrázkov
                        </div>
                      ) : (
                        <div className="grid grid-cols-4 gap-3 sm:grid-cols-6 lg:grid-cols-8">
                          {(productForm.gallery_images || []).map((url, idx) => {
                            const isMainImage = productForm.main_image_url === url
                            return (
                              <div
                                key={url}
                                className={`group relative aspect-square overflow-hidden rounded-xl bg-white ring-2 transition ${
                                  isMainImage ? 'ring-amber-400' : 'ring-gray-100'
                                }`}
                              >
                                <img src={url} alt={`Galéria ${idx + 1}`} className="h-full w-full object-cover" />
                                <button
                                  type="button"
                                  onClick={() => setMainGalleryImage(url)}
                                  className={`absolute left-1 top-1 rounded-full p-1 shadow-sm backdrop-blur transition ${
                                    isMainImage ? 'bg-amber-400 text-white' : 'bg-white/90 text-gray-500 hover:bg-amber-50 hover:text-amber-600'
                                  }`}
                                  title={isMainImage ? 'Hlavný obrázok' : 'Nastaviť ako hlavný'}
                                >
                                  <StarIcon className={`h-3 w-3 ${isMainImage ? 'fill-current' : ''}`} />
                                </button>
                                <button
                                  type="button"
                                  onClick={() => removeGalleryImage(idx)}
                                  className="absolute right-1 top-1 rounded-full bg-white/90 p-1 text-red-600 opacity-0 shadow-sm backdrop-blur transition hover:bg-red-50 group-hover:opacity-100"
                                  title="Odstrániť obrázok"
                                >
                                  <TrashIcon className="h-3 w-3" />
                                </button>
                              </div>
                            )
                          })}
                        </div>
                      )}
                    </div>
                  </section>

                  {/* Basic Data Card */}
                  <section className="rounded-2xl border border-gray-200 bg-gray-50 p-4">
                    <div className="grid gap-4 sm:grid-cols-2">
                      <label className="block sm:col-span-2">
                        <span className="text-xs font-bold text-gray-600 uppercase tracking-wider">Názov</span>
                        <input
                          value={productForm.name}
                          onChange={(event) => setProductForm(prev => ({
                            ...prev,
                            name: event.target.value,
                            slug: editingProduct ? prev.slug : slugify(event.target.value),
                          }))}
                          className="mt-1 w-full rounded-xl border border-gray-200 px-3 py-2 text-sm focus:border-emerald-500 focus:ring-1 focus:ring-emerald-500 outline-none"
                          required
                        />
                      </label>
                      <label className="block sm:col-span-2">
                        <span className="text-xs font-bold text-gray-600 uppercase tracking-wider">URL slug</span>
                        <input
                          value={productForm.slug}
                          onChange={(event) => setProductForm(prev => ({ ...prev, slug: slugify(event.target.value) }))}
                          className="mt-1 w-full rounded-xl border border-gray-200 px-3 py-2 text-sm focus:border-emerald-500 focus:ring-1 focus:ring-emerald-500 outline-none"
                          required
                        />
                      </label>
                      <label className="block">
                        <span className="text-xs font-bold text-gray-600 uppercase tracking-wider">Kategória</span>
                        <select
                          value={productForm.category_id}
                          onChange={(event) => setProductForm(prev => ({ ...prev, category_id: event.target.value }))}
                          className="mt-1 w-full rounded-xl border border-gray-200 px-3 py-2 text-sm focus:border-emerald-500 focus:ring-1 focus:ring-emerald-500 outline-none"
                        >
                          <option value="">Bez kategórie</option>
                          {categories.map(cat => (
                            <option key={cat.id} value={cat.id}>{cat.name}</option>
                          ))}
                        </select>
                      </label>
                      <label className="block">
                        <span className="text-xs font-bold text-gray-600 uppercase tracking-wider">Značka</span>
                        <input
                          value={productForm.brand}
                          onChange={(event) => setProductForm(prev => ({ ...prev, brand: event.target.value }))}
                          className="mt-1 w-full rounded-xl border border-gray-200 px-3 py-2 text-sm focus:border-emerald-500 focus:ring-1 focus:ring-emerald-500 outline-none"
                        />
                      </label>
                      <label className="block sm:col-span-2">
                        <span className="text-xs font-bold text-gray-600 uppercase tracking-wider">Základná cena (€)</span>
                        <input
                          type="number"
                          step="0.01"
                          min="0"
                          value={productForm.price}
                          onChange={(event) => setProductForm(prev => ({ ...prev, price: event.target.value }))}
                          className="mt-1 w-full rounded-xl border border-gray-200 px-3 py-2 text-sm focus:border-emerald-500 focus:ring-1 focus:ring-emerald-500 outline-none"
                        />
                      </label>
                    </div>
                  </section>

                  {/* Colors and Variants */}
                  <section className="rounded-2xl border border-gray-200 bg-gray-50 p-4">
                    <div className="mb-3 flex items-center justify-between">
                      <div>
                        <span className="text-sm font-semibold text-gray-700">FARBY A VARIANTY</span>
                        <p className="text-xs text-gray-500">Hex farba alebo obrázková vzorka.</p>
                      </div>
                      <button type="button" onClick={addColorOption} className="rounded-xl bg-gray-200 px-3 py-1.5 text-xs font-bold text-gray-900 transition hover:bg-gray-300">
                        Pridať farbu
                      </button>
                    </div>
                    <div className="space-y-3">
                      {(productForm.color_options || []).map((color, index) => {
                        const hasImage = !!color.image_url
                        const hasHex = !!color.hex && color.hex !== ''
                        
                        const isImageActive = hasImage
                        const isHexActive = !hasImage && hasHex
                        const isTextActive = !hasImage && !hasHex

                        return (
                          <div
                            key={index}
                            className="grid gap-3 rounded-2xl bg-white p-3 border border-gray-150 transition-all lg:grid-cols-[1.2fr_1fr_auto_auto_auto] items-center"
                          >
                            <input
                              value={color.name || ''}
                              onChange={(event) => updateColorOption(index, 'name', event.target.value)}
                              placeholder="Napr. SALVIA"
                              className={`rounded-xl border px-3 py-2 text-sm focus:border-emerald-500 focus:ring-1 focus:ring-emerald-500 outline-none transition-all ${
                                isTextActive ? 'border-emerald-500 ring-2 ring-emerald-500/20 font-medium' : 'border-gray-200'
                              }`}
                            />
                            <select
                              value={color.family || ''}
                              onChange={(event) => updateColorOption(index, 'family', event.target.value)}
                              className="rounded-xl border border-gray-200 px-3 py-2 text-sm focus:border-emerald-500 focus:ring-1 focus:ring-emerald-500 outline-none"
                            >
                              <option value="">Bez rodiny</option>
                              {COLOR_FAMILIES.map(family => (
                                <option key={family} value={family}>{family}</option>
                              ))}
                            </select>
                            <label className={`flex items-center gap-2 rounded-xl border px-3 py-2 text-sm cursor-pointer transition-all ${
                              isHexActive ? 'border-emerald-500 ring-2 ring-emerald-500/20 font-medium' : 'border-gray-200'
                            }`}>
                              <input
                                type="color"
                                value={color.hex || '#ffffff'}
                                onChange={(event) => updateColorOption(index, 'hex', event.target.value)}
                                className="h-8 w-10 cursor-pointer"
                              />
                              <span className="text-gray-500">{color.hex || 'hex'}</span>
                            </label>
                            {color.image_url ? (
                              <div className="relative h-12 w-12 flex-shrink-0">
                                <label className={`relative block h-full w-full cursor-pointer overflow-hidden rounded-full border transition-all ${
                                  isImageActive ? 'border-emerald-500 ring-4 ring-emerald-500/30' : 'border-gray-200'
                                }`}>
                                  <img
                                    src={color.image_url}
                                    alt={color.name || 'Vzorka farby'}
                                    className="h-full w-full object-cover"
                                  />
                                  <div className="absolute inset-0 rounded-full bg-black/40 opacity-0 hover:opacity-100 transition-opacity flex items-center justify-center text-[9px] text-white font-bold text-center">
                                    Zmeniť
                                  </div>
                                  <input type="file" accept="image/*" className="hidden" onChange={(event) => handleColorImageUpload(index, event)} />
                                </label>
                                <button
                                  type="button"
                                  onClick={() => updateColorOption(index, 'image_url', '')}
                                  className="absolute -right-1 -top-1 rounded-full bg-red-500 p-0.5 text-white shadow-sm hover:bg-red-600 transition duration-150 z-10"
                                  title="Odstrániť obrázok"
                                >
                                  <svg className="h-2.5 w-2.5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={3} d="M6 18L18 6M6 6l12 12" />
                                  </svg>
                                </button>
                              </div>
                            ) : (
                              <label className="inline-flex cursor-pointer items-center justify-center rounded-xl bg-gray-100 px-3 py-2 text-xs font-bold text-gray-700 transition hover:bg-gray-200 h-10">
                                {uploadingColorIndex === index ? 'Nahrávam...' : 'Obrázok'}
                                <input type="file" accept="image/*" className="hidden" onChange={(event) => handleColorImageUpload(index, event)} />
                              </label>
                            )}
                            <button type="button" onClick={() => removeColorOption(index)} className="rounded-xl bg-red-50 px-3 py-2 text-red-600 hover:bg-red-100 self-center">
                              <TrashIcon className="h-4 w-4" />
                            </button>
                          </div>
                        )
                      })}
                    </div>
                  </section>

                  {/* Súbory na stiahnutie */}
                  <section className="rounded-2xl border border-gray-200 bg-gray-50 p-4">
                    <div className="mb-3 flex items-center justify-between">
                      <div>
                        <span className="text-sm font-semibold text-gray-700">SÚBORY NA STIAHNUTIE</span>
                        <p className="text-xs text-gray-500">Dokumenty na stiahnutie k produktu.</p>
                      </div>
                      <button type="button" onClick={addDownloadFile} className="rounded-xl bg-gray-200 px-3 py-1.5 text-xs font-bold text-gray-900 transition hover:bg-gray-300">
                        Pridať súbor
                      </button>
                    </div>
                    <div className="space-y-3">
                      {(productForm.download_files || []).map((file, index) => (
                        <div key={index} className="grid gap-2 rounded-2xl bg-white p-3 ring-1 ring-gray-100 lg:grid-cols-[150px_1fr_auto_auto]">
                          <input
                            value={file.label || ''}
                            onChange={(event) => updateDownloadFile(index, 'label', event.target.value)}
                            placeholder="Technický list"
                            className="rounded-xl border border-gray-200 px-3 py-2 text-sm"
                          />
                          <input
                            value={file.url || ''}
                            onChange={(event) => updateDownloadFile(index, 'url', event.target.value)}
                            placeholder="https://..."
                            className="rounded-xl border border-gray-200 px-3 py-2 text-sm"
                          />
                          <label className="inline-flex cursor-pointer items-center justify-center rounded-xl bg-gray-100 px-3 py-2 text-xs font-bold text-gray-700 transition hover:bg-gray-200">
                            {uploadingDownloadIndex === index ? 'Nahrávam...' : 'PDF'}
                            <input
                              type="file"
                              accept="application/pdf,.pdf"
                              className="hidden"
                              disabled={uploadingDownloadIndex === index}
                              onChange={(event) => handleDownloadFileUpload(index, event)}
                            />
                          </label>
                          <button type="button" onClick={() => removeDownloadFile(index)} className="rounded-xl bg-red-50 px-3 py-2 text-red-600 hover:bg-red-100">
                            <TrashIcon className="h-4 w-4" />
                          </button>
                        </div>
                      ))}
                    </div>
                  </section>
                </div>

                {/* Right Column */}
                <div className="space-y-6">
                  {/* Descriptions Card */}
                  <section className="rounded-2xl border border-gray-200 bg-gray-50 p-4">
                    <div className="space-y-4">
                      <label className="block">
                        <span className="text-xs font-bold text-gray-600 uppercase tracking-wider">Popis produktu</span>
                        <textarea
                          rows={4}
                          value={productForm.short_description}
                          onChange={(event) => setProductForm(prev => ({ ...prev, short_description: event.target.value }))}
                          className="mt-1 w-full rounded-xl border border-gray-200 px-3 py-2 text-sm focus:border-emerald-500 focus:ring-1 focus:ring-emerald-500 outline-none"
                        />
                      </label>
                      <label className="block">
                        <span className="text-xs font-bold text-gray-600 uppercase tracking-wider">Krátky popis</span>
                        <textarea
                          rows={4}
                          value={productForm.description}
                          onChange={(event) => setProductForm(prev => ({ ...prev, description: event.target.value }))}
                          className="mt-1 w-full rounded-xl border border-gray-200 px-3 py-2 text-sm focus:border-emerald-500 focus:ring-1 focus:ring-emerald-500 outline-none"
                        />
                      </label>
                    </div>
                  </section>

                  {/* Variations and Prices */}
                  <section className="rounded-2xl border border-gray-200 bg-gray-50 p-4">
                    <div className="mb-3 flex items-center justify-between">
                      <span className="text-sm font-semibold text-gray-700">VARIANTY A CENY</span>
                      <button type="button" onClick={addVariation} className="rounded-xl bg-gray-200 px-3 py-1.5 text-xs font-bold text-gray-900 transition hover:bg-gray-300">
                        Pridať variant
                      </button>
                    </div>
                    <div className="space-y-3">
                      {(productForm.variations || []).map((variation, index) => (
                        <div key={index} className="grid gap-2 rounded-2xl bg-white p-3 ring-1 ring-gray-100 lg:grid-cols-[2.5fr_1.5fr_auto]">
                          <input value={variation.dimensions || ''} onChange={(e) => updateVariation(index, 'dimensions', e.target.value)} placeholder="Rozmer (napr. 57x57x29 cm)" className="rounded-xl border border-gray-200 px-3 py-2 text-sm" />
                          <input type="number" step="0.01" min="0" value={variation.price_cents || ''} onChange={(e) => updateVariation(index, 'price_cents', e.target.value)} placeholder="Cena €" className="rounded-xl border border-gray-200 px-3 py-2 text-sm" />
                          <button type="button" onClick={() => removeVariation(index)} className="rounded-xl bg-red-50 px-3 py-2 text-red-600 hover:bg-red-100">
                            <TrashIcon className="h-4 w-4" />
                          </button>
                        </div>
                      ))}
                    </div>
                  </section>

                  {/* SEO Settings Card */}
                  <section className="rounded-2xl border border-gray-200 bg-gray-50 p-4">
                    <div className="space-y-4">
                      <label className="block">
                        <span className="text-xs font-bold text-gray-600 uppercase tracking-wider">SEO titulok</span>
                        <input
                          value={productForm.seo_title}
                          onChange={(event) => setProductForm(prev => ({ ...prev, seo_title: event.target.value }))}
                          className="mt-1 w-full rounded-xl border border-gray-200 px-3 py-2 text-sm focus:border-emerald-500 focus:ring-1 focus:ring-emerald-500 outline-none"
                        />
                      </label>
                      <label className="block">
                        <span className="text-xs font-bold text-gray-600 uppercase tracking-wider">SEO popis</span>
                        <textarea
                          rows={3}
                          value={productForm.seo_description}
                          onChange={(event) => setProductForm(prev => ({ ...prev, seo_description: event.target.value }))}
                          className="mt-1 w-full rounded-xl border border-gray-200 px-3 py-2 text-sm focus:border-emerald-500 focus:ring-1 focus:ring-emerald-500 outline-none"
                        />
                      </label>
                    </div>
                  </section>

                  {/* Checkbox Options */}
                  <div className="grid gap-3 sm:grid-cols-2">
                    <label className="flex items-center gap-2 rounded-2xl bg-gray-50 border border-gray-200 px-4 py-3 text-sm font-semibold text-gray-700 cursor-pointer select-none">
                      <input
                        type="checkbox"
                        checked={productForm.is_featured}
                        onChange={(event) => {
                          const isChecking = event.target.checked;
                          if (isChecking) {
                            const featuredCount = products.filter(p => p.is_featured && p.id !== editingProduct?.id).length;
                            if (featuredCount >= 12) {
                              showNotification('Môžete mať označených najviac 12 obľúbených produktov. Najprv zrušte výber iného produktu.', 'error');
                              return;
                            }
                          }
                          setProductForm(prev => ({ ...prev, is_featured: isChecking }));
                        }}
                        className="h-4 w-4 rounded border-gray-300 text-emerald-600 focus:ring-emerald-500"
                      />
                      Obľúbený produkt
                    </label>
                    <label className="flex items-center gap-2 rounded-2xl bg-gray-50 border border-gray-200 px-4 py-3 text-sm font-semibold text-gray-700 cursor-pointer select-none">
                      <input type="checkbox" checked={productForm.is_active} onChange={(event) => setProductForm(prev => ({ ...prev, is_active: event.target.checked }))} className="h-4 w-4 rounded border-gray-300 text-emerald-600 focus:ring-emerald-500" />
                      Aktívny na webe
                    </label>
                  </div>
                </div>
              </div>

              {/* Sticky Footer */}
              <div className="sticky bottom-0 mt-6 flex justify-end gap-3 border-t border-gray-100 bg-white pb-2 pt-4">
                <button type="button" onClick={closeModal} className="rounded-xl bg-gray-100 px-5 py-3 text-sm font-bold text-gray-700 transition hover:bg-gray-200">
                  Zrušiť
                </button>
                <button type="submit" disabled={saving} className="inline-flex items-center justify-center gap-2 rounded-xl bg-emerald-600 px-6 py-3 text-sm font-extrabold text-white transition hover:bg-emerald-700 disabled:opacity-60">
                  {editingProduct ? <CheckCircleIcon className="h-5 w-5" /> : <PlusIcon className="h-5 w-5" />}
                  {saving ? 'Ukladám...' : editingProduct ? 'Uložiť produkt' : 'Pridať produkt'}
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
