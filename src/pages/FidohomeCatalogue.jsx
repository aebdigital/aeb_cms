import { useEffect, useMemo, useState } from 'react'
import { createPortal } from 'react-dom'
import {
  ArchiveBoxIcon,
  CheckCircleIcon,
  FolderIcon,
  PencilSquareIcon,
  PhotoIcon,
  PlusIcon,
  SparklesIcon,
  TrashIcon,
  XMarkIcon,
} from '@heroicons/react/24/outline'
import { useAuth } from '../contexts/AuthContext'
import { useNotification } from '../contexts/NotificationContext'
import {
  FIDOHOME_ADMIN_EMAIL,
  FIDOHOME_OWNER_EMAIL,
  createFidohomeCategory,
  createFidohomeProduct,
  deleteFidohomeCategory,
  deleteFidohomeProduct,
  getPublicUrl,
  listFidohomeCategories,
  listFidohomeProducts,
  updateFidohomeCategory,
  updateFidohomeProduct,
  uploadProductImage,
} from '../api'

const EMPTY_CATEGORY = {
  slug: '',
  label: '',
  description: '',
  image_url: '',
  sort_order: 0,
  is_active: true,
}

const EMPTY_PRODUCT = {
  category_id: '',
  slug: '',
  name: '',
  subcategory: '',
  price: '',
  original_price: '',
  lead: '',
  description: '',
  specs_text: '',
  preview_url: '',
  detail_url: '',
  gallery_text: '',
  sort_order: 0,
  is_featured: false,
  is_active: true,
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

function formatPrice(cents, currency = 'EUR') {
  return new Intl.NumberFormat('sk-SK', {
    style: 'currency',
    currency,
  }).format((Number(cents) || 0) / 100)
}

function displayImageUrl(url) {
  if (!url) return ''
  if (url.startsWith('http')) return url
  if (url.startsWith('/')) return 'https://fidohome.sk' + url
  return url
}

function categoryToForm(category) {
  return {
    slug: category.slug || '',
    label: category.label || '',
    description: category.description || '',
    image_url: category.image_url || '',
    sort_order: category.sort_order || 0,
    is_active: Boolean(category.is_active),
  }
}

function productToForm(product) {
  return {
    category_id: product.category_id || '',
    slug: product.slug || '',
    name: product.name || '',
    subcategory: product.subcategory || '',
    price: ((product.price_cents || 0) / 100).toString(),
    original_price: product.original_price_cents ? (product.original_price_cents / 100).toString() : '',
    lead: product.lead || '',
    description: product.description || '',
    specs_text: (product.specs || []).join('\n'),
    preview_url: product.preview_url || '',
    detail_url: product.detail_url || '',
    gallery_text: (product.gallery_images || []).join('\n'),
    sort_order: product.sort_order || 0,
    is_featured: Boolean(product.is_featured),
    is_active: Boolean(product.is_active),
    seo_title: product.seo_title || '',
    seo_description: product.seo_description || '',
  }
}

function categoryPayload(form) {
  return {
    slug: (form.slug || slugify(form.label)).trim(),
    label: form.label.trim(),
    description: form.description.trim() || null,
    image_url: form.image_url.trim() || null,
    sort_order: Number(form.sort_order || 0),
    is_active: Boolean(form.is_active),
  }
}

function productPayload(form) {
  const gallery = form.gallery_text
    .split('\n')
    .map(item => item.trim())
    .filter(Boolean)

  return {
    category_id: form.category_id || null,
    slug: (form.slug || slugify(form.name)).trim(),
    name: form.name.trim(),
    subcategory: form.subcategory.trim() || null,
    price_cents: Math.round(Number(form.price || 0) * 100),
    original_price_cents: form.original_price ? Math.round(Number(form.original_price) * 100) : null,
    currency: 'EUR',
    lead: form.lead.trim() || null,
    description: form.description.trim() || null,
    specs: form.specs_text.split('\n').map(item => item.trim()).filter(Boolean),
    preview_url: form.preview_url.trim() || null,
    detail_url: form.detail_url.trim() || null,
    gallery_images: gallery,
    sort_order: Number(form.sort_order || 0),
    is_featured: Boolean(form.is_featured),
    is_active: Boolean(form.is_active),
    seo_title: form.seo_title.trim() || null,
    seo_description: form.seo_description.trim() || null,
  }
}

function fieldClass() {
  return 'mt-1 block w-full rounded-lg border border-gray-300 px-3 py-2 text-sm shadow-sm focus:border-purple-500 focus:outline-none focus:ring-2 focus:ring-purple-500/20'
}

function checkBoxClass() {
  return 'h-4 w-4 rounded border-gray-300 text-purple-600 focus:ring-purple-500'
}

export default function FidohomeCatalogue() {
  const { user, loading: authLoading } = useAuth()
  const { showNotification } = useNotification()
  const [activeTab, setActiveTab] = useState('products')
  const [products, setProducts] = useState([])
  const [categories, setCategories] = useState([])
  const [loading, setLoading] = useState(true)
  const [saving, setSaving] = useState(false)
  const [uploading, setUploading] = useState(false)
  const [search, setSearch] = useState('')
  const [categoryFilter, setCategoryFilter] = useState('all')
  const [productModal, setProductModal] = useState(false)
  const [categoryModal, setCategoryModal] = useState(false)
  const [editingProduct, setEditingProduct] = useState(null)
  const [editingCategory, setEditingCategory] = useState(null)
  const [productForm, setProductForm] = useState(EMPTY_PRODUCT)
  const [categoryForm, setCategoryForm] = useState(EMPTY_CATEGORY)

  const userEmail = user?.email?.toLowerCase()
  const hasAccess = userEmail === FIDOHOME_OWNER_EMAIL || userEmail === FIDOHOME_ADMIN_EMAIL

  const categoryById = useMemo(() => new Map(categories.map(category => [category.id, category])), [categories])

  const visibleProducts = useMemo(() => {
    const term = search.trim().toLowerCase()
    return products.filter(product => {
      const matchesSearch = !term || [product.name, product.slug, product.lead, product.description]
        .filter(Boolean)
        .some(value => value.toLowerCase().includes(term))
      const matchesCategory = categoryFilter === 'all' || product.category_id === categoryFilter
      return matchesSearch && matchesCategory
    })
  }, [categoryFilter, products, search])

  useEffect(() => {
    if (authLoading || !hasAccess) return
    loadData()
  }, [authLoading, hasAccess])

  useEffect(() => {
    if (productModal || categoryModal) {
      document.body.style.overflow = 'hidden'
    } else {
      document.body.style.overflow = ''
    }
    return () => {
      document.body.style.overflow = ''
    }
  }, [productModal, categoryModal])

  async function loadData() {
    setLoading(true)
    try {
      const [nextCategories, nextProducts] = await Promise.all([
        listFidohomeCategories(),
        listFidohomeProducts(),
      ])
      setCategories(nextCategories)
      setProducts(nextProducts)
    } catch (err) {
      console.error('Fidohome load error:', err)
      showNotification('Nepodarilo sa načítať Fidohome katalóg', 'error')
    } finally {
      setLoading(false)
    }
  }

  function openCreateProduct() {
    setEditingProduct(null)
    setProductForm({ ...EMPTY_PRODUCT, sort_order: (products.length + 1) * 10 })
    setProductModal(true)
  }

  function openEditProduct(product) {
    setEditingProduct(product)
    setProductForm(productToForm(product))
    setProductModal(true)
  }

  function closeProductModal() {
    setProductModal(false)
    setEditingProduct(null)
    setProductForm(EMPTY_PRODUCT)
  }

  function openCreateCategory() {
    setEditingCategory(null)
    setCategoryForm({ ...EMPTY_CATEGORY, sort_order: (categories.length + 1) * 10 })
    setCategoryModal(true)
  }

  function openEditCategory(category) {
    setEditingCategory(category)
    setCategoryForm(categoryToForm(category))
    setCategoryModal(true)
  }

  function closeCategoryModal() {
    setCategoryModal(false)
    setEditingCategory(null)
    setCategoryForm(EMPTY_CATEGORY)
  }

  async function handleProductSubmit(event) {
    event.preventDefault()
    const payload = productPayload(productForm)

    if (!payload.name || !payload.slug || payload.price_cents < 0) {
      showNotification('Vyplňte názov, slug a cenu produktu', 'error')
      return
    }

    setSaving(true)
    try {
      if (editingProduct) {
        const updated = await updateFidohomeProduct(editingProduct.id, payload)
        setProducts(prev => prev.map(product => product.id === updated.id ? updated : product))
        showNotification('Produkt bol uložený', 'success')
      } else {
        const created = await createFidohomeProduct(payload)
        setProducts(prev => [...prev, created].sort((a, b) => a.sort_order - b.sort_order))
        showNotification('Produkt bol pridaný', 'success')
      }
      closeProductModal()
    } catch (err) {
      console.error('Fidohome product save error:', err)
      showNotification(err.message || 'Produkt sa nepodarilo uložiť', 'error')
    } finally {
      setSaving(false)
    }
  }

  async function handleCategorySubmit(event) {
    event.preventDefault()
    const payload = categoryPayload(categoryForm)

    if (!payload.label || !payload.slug) {
      showNotification('Vyplňte názov a slug kategórie', 'error')
      return
    }

    setSaving(true)
    try {
      if (editingCategory) {
        const updated = await updateFidohomeCategory(editingCategory.id, payload)
        setCategories(prev => prev.map(category => category.id === updated.id ? updated : category))
        showNotification('Kategória bola uložená', 'success')
      } else {
        const created = await createFidohomeCategory(payload)
        setCategories(prev => [...prev, created].sort((a, b) => a.sort_order - b.sort_order))
        showNotification('Kategória bola pridaná', 'success')
      }
      closeCategoryModal()
    } catch (err) {
      console.error('Fidohome category save error:', err)
      showNotification(err.message || 'Kategóriu sa nepodarilo uložiť', 'error')
    } finally {
      setSaving(false)
    }
  }

  async function handleDeleteProduct(product) {
    if (!window.confirm('Naozaj chcete vymazať tento produkt?')) return
    try {
      await deleteFidohomeProduct(product.id)
      setProducts(prev => prev.filter(item => item.id !== product.id))
      showNotification('Produkt bol vymazaný', 'success')
    } catch (err) {
      console.error('Fidohome product delete error:', err)
      showNotification('Produkt sa nepodarilo vymazať', 'error')
    }
  }

  async function handleDeleteCategory(category) {
    if (!window.confirm('Naozaj chcete vymazať túto kategóriu? Produkty v nej ostanú bez kategórie.')) return
    try {
      await deleteFidohomeCategory(category.id)
      setCategories(prev => prev.filter(item => item.id !== category.id))
      setProducts(prev => prev.map(product => product.category_id === category.id ? { ...product, category_id: null, fidohome_categories: null } : product))
      showNotification('Kategória bola vymazaná', 'success')
    } catch (err) {
      console.error('Fidohome category delete error:', err)
      showNotification('Kategóriu sa nepodarilo vymazať', 'error')
    }
  }

  async function handleImageUpload(event, target) {
    const file = event.target.files?.[0]
    event.target.value = ''
    if (!file) return

    if (!file.type.startsWith('image/')) {
      showNotification('Vyberte obrázok', 'error')
      return
    }

    setUploading(true)
    try {
      const { path } = await uploadProductImage({
        file,
        ownerSlug: 'fidohome',
        productId: editingProduct?.id || 'new',
      })
      const url = getPublicUrl(path)
      setProductForm(prev => {
        if (target === 'gallery') {
          const gallery = prev.gallery_text ? prev.gallery_text + '\n' + url : url
          return { ...prev, gallery_text: gallery }
        }
        if (target === 'detail') return { ...prev, detail_url: url }
        return { ...prev, preview_url: url, detail_url: prev.detail_url || url }
      })
      showNotification('Obrázok bol nahraný', 'success')
    } catch (err) {
      console.error('Fidohome image upload error:', err)
      showNotification('Obrázok sa nepodarilo nahrať', 'error')
    } finally {
      setUploading(false)
    }
  }

  if (authLoading || loading) {
    return (
      <div className="flex min-h-[420px] items-center justify-center">
        <div className="text-center">
          <div className="mx-auto mb-4 h-12 w-12 animate-spin rounded-full border-4 border-purple-600 border-t-transparent" />
          <p className="text-gray-600">Načítavam Fidohome katalóg...</p>
        </div>
      </div>
    )
  }

  if (!hasAccess) {
    return (
      <div className="rounded-xl border border-red-200 bg-red-50 p-6 text-red-700">
        Nemáte prístup k Fidohome katalógu.
      </div>
    )
  }

  return (
    <div className="space-y-6">
      <div className="flex flex-col gap-4 sm:flex-row sm:items-center sm:justify-between">
        <div>
          <p className="text-sm font-semibold uppercase tracking-wide text-purple-600">Fidohome</p>
          <h1 className="text-3xl font-bold text-gray-900">Katalóg produktov</h1>
          <p className="mt-1 text-sm text-gray-500">Produkty a kategórie sú uložené v Supabase. Lokálny súbor vo Fidohome ostáva ako backup.</p>
        </div>
        <div className="flex flex-wrap gap-2">
          <button
            type="button"
            onClick={openCreateCategory}
            className="inline-flex items-center rounded-lg border border-gray-300 bg-white px-4 py-2 text-sm font-semibold text-gray-700 shadow-sm hover:bg-gray-50"
          >
            <FolderIcon className="mr-2 h-5 w-5" />
            Kategória
          </button>
          <button
            type="button"
            onClick={openCreateProduct}
            className="inline-flex items-center rounded-lg bg-purple-600 px-4 py-2 text-sm font-semibold text-white shadow-sm hover:bg-purple-700"
          >
            <PlusIcon className="mr-2 h-5 w-5" />
            Produkt
          </button>
        </div>
      </div>

      <div className="grid grid-cols-1 gap-4 sm:grid-cols-3">
        <div className="rounded-lg border border-gray-200 bg-white p-4 shadow-sm">
          <p className="text-sm text-gray-500">Produkty</p>
          <p className="mt-1 text-3xl font-bold text-gray-900">{products.length}</p>
        </div>
        <div className="rounded-lg border border-gray-200 bg-white p-4 shadow-sm">
          <p className="text-sm text-gray-500">Kategórie</p>
          <p className="mt-1 text-3xl font-bold text-gray-900">{categories.length}</p>
        </div>
        <div className="rounded-lg border border-gray-200 bg-white p-4 shadow-sm">
          <p className="text-sm text-gray-500">Aktívne produkty</p>
          <p className="mt-1 text-3xl font-bold text-gray-900">{products.filter(product => product.is_active).length}</p>
        </div>
      </div>

      <div className="flex flex-col gap-3 border-b border-gray-200 pb-4 lg:flex-row lg:items-center lg:justify-between">
        <div className="flex rounded-lg bg-gray-100 p-1">
          <button
            type="button"
            onClick={() => setActiveTab('products')}
            className={(activeTab === 'products' ? 'bg-white text-gray-900 shadow-sm' : 'text-gray-600 hover:text-gray-900') + ' rounded-md px-4 py-2 text-sm font-semibold'}
          >
            Produkty
          </button>
          <button
            type="button"
            onClick={() => setActiveTab('categories')}
            className={(activeTab === 'categories' ? 'bg-white text-gray-900 shadow-sm' : 'text-gray-600 hover:text-gray-900') + ' rounded-md px-4 py-2 text-sm font-semibold'}
          >
            Kategórie
          </button>
        </div>

        {activeTab === 'products' && (
          <div className="flex flex-col gap-2 sm:flex-row">
            <input
              type="search"
              value={search}
              onChange={event => setSearch(event.target.value)}
              placeholder="Hľadať produkt"
              className="rounded-lg border border-gray-300 px-3 py-2 text-sm shadow-sm focus:border-purple-500 focus:outline-none focus:ring-2 focus:ring-purple-500/20"
            />
            <select
              value={categoryFilter}
              onChange={event => setCategoryFilter(event.target.value)}
              className="rounded-lg border border-gray-300 px-3 py-2 text-sm shadow-sm focus:border-purple-500 focus:outline-none focus:ring-2 focus:ring-purple-500/20"
            >
              <option value="all">Všetky kategórie</option>
              {categories.map(category => (
                <option key={category.id} value={category.id}>{category.label}</option>
              ))}
            </select>
          </div>
        )}
      </div>

      {activeTab === 'products' ? (
        <div className="overflow-hidden rounded-lg border border-gray-200 bg-white shadow-sm">
          <div className="overflow-x-auto">
            <table className="min-w-full divide-y divide-gray-200">
              <thead className="bg-gray-50">
                <tr>
                  <th className="px-4 py-3 text-left text-xs font-semibold uppercase tracking-wide text-gray-500">Produkt</th>
                  <th className="px-4 py-3 text-left text-xs font-semibold uppercase tracking-wide text-gray-500">Kategória</th>
                  <th className="px-4 py-3 text-left text-xs font-semibold uppercase tracking-wide text-gray-500">Cena</th>
                  <th className="px-4 py-3 text-left text-xs font-semibold uppercase tracking-wide text-gray-500">Stav</th>
                  <th className="px-4 py-3 text-right text-xs font-semibold uppercase tracking-wide text-gray-500">Akcie</th>
                </tr>
              </thead>
              <tbody className="divide-y divide-gray-100 bg-white">
                {visibleProducts.map(product => {
                  const category = categoryById.get(product.category_id)
                  return (
                    <tr key={product.id} className="hover:bg-gray-50">
                      <td className="px-4 py-4">
                        <div className="flex items-center gap-3">
                          <div className="h-14 w-14 flex-shrink-0 overflow-hidden rounded-lg bg-gray-100">
                            {product.preview_url ? (
                              <img src={displayImageUrl(product.preview_url)} alt="" className="h-full w-full object-cover" />
                            ) : (
                              <PhotoIcon className="m-4 h-6 w-6 text-gray-400" />
                            )}
                          </div>
                          <div className="min-w-0">
                            <p className="font-semibold text-gray-900">{product.name}</p>
                            <p className="truncate text-sm text-gray-500">/{product.slug}</p>
                          </div>
                        </div>
                      </td>
                      <td className="px-4 py-4 text-sm text-gray-700">{category?.label || product.fidohome_categories?.label || '-'}</td>
                      <td className="px-4 py-4 text-sm font-semibold text-gray-900">{formatPrice(product.price_cents, product.currency)}</td>
                      <td className="px-4 py-4">
                        <span className={(product.is_active ? 'bg-green-100 text-green-700' : 'bg-gray-100 text-gray-600') + ' inline-flex items-center rounded-full px-2.5 py-1 text-xs font-semibold'}>
                          {product.is_active ? 'Aktívny' : 'Skrytý'}
                        </span>
                      </td>
                      <td className="px-4 py-4 text-right">
                        <div className="inline-flex gap-2">
                          <button type="button" onClick={() => openEditProduct(product)} className="rounded-lg p-2 text-gray-500 hover:bg-purple-50 hover:text-purple-700" title="Upraviť">
                            <PencilSquareIcon className="h-5 w-5" />
                          </button>
                          <button type="button" onClick={() => handleDeleteProduct(product)} className="rounded-lg p-2 text-gray-500 hover:bg-red-50 hover:text-red-700" title="Vymazať">
                            <TrashIcon className="h-5 w-5" />
                          </button>
                        </div>
                      </td>
                    </tr>
                  )
                })}
                {visibleProducts.length === 0 && (
                  <tr>
                    <td colSpan="5" className="px-4 py-10 text-center text-sm text-gray-500">Žiadne produkty.</td>
                  </tr>
                )}
              </tbody>
            </table>
          </div>
        </div>
      ) : (
        <div className="grid grid-cols-1 gap-4 md:grid-cols-2 xl:grid-cols-3">
          {categories.map(category => (
            <div key={category.id} className="rounded-lg border border-gray-200 bg-white p-4 shadow-sm">
              <div className="flex items-start justify-between gap-3">
                <div>
                  <p className="text-lg font-semibold text-gray-900">{category.label}</p>
                  <p className="text-sm text-gray-500">/{category.slug}</p>
                </div>
                <span className={(category.is_active ? 'bg-green-100 text-green-700' : 'bg-gray-100 text-gray-600') + ' rounded-full px-2.5 py-1 text-xs font-semibold'}>
                  {category.is_active ? 'Aktívna' : 'Skrytá'}
                </span>
              </div>
              {category.description && <p className="mt-3 text-sm text-gray-600">{category.description}</p>}
              <div className="mt-4 flex items-center justify-between text-sm text-gray-500">
                <span>{products.filter(product => product.category_id === category.id).length} produktov</span>
                <div className="flex gap-2">
                  <button type="button" onClick={() => openEditCategory(category)} className="rounded-lg p-2 text-gray-500 hover:bg-purple-50 hover:text-purple-700" title="Upraviť">
                    <PencilSquareIcon className="h-5 w-5" />
                  </button>
                  <button type="button" onClick={() => handleDeleteCategory(category)} className="rounded-lg p-2 text-gray-500 hover:bg-red-50 hover:text-red-700" title="Vymazať">
                    <TrashIcon className="h-5 w-5" />
                  </button>
                </div>
              </div>
            </div>
          ))}
        </div>
      )}

      {productModal && createPortal(
        <div className="fixed inset-0 z-[9999] flex items-center justify-center bg-black/40 p-4">
          <div className="max-h-[92vh] w-full max-w-5xl overflow-y-auto rounded-xl bg-white shadow-2xl">
            <div className="sticky top-0 z-10 flex items-center justify-between border-b border-gray-200 bg-white px-6 py-4">
              <div>
                <h2 className="text-xl font-bold text-gray-900">{editingProduct ? 'Upraviť produkt' : 'Nový produkt'}</h2>
                <p className="text-sm text-gray-500">Fidohome katalóg</p>
              </div>
              <button type="button" onClick={closeProductModal} className="rounded-lg p-2 text-gray-500 hover:bg-gray-100">
                <XMarkIcon className="h-6 w-6" />
              </button>
            </div>

            <form onSubmit={handleProductSubmit} className="space-y-6 p-6">
              <div className="grid grid-cols-1 gap-4 md:grid-cols-2">
                <label className="block text-sm font-medium text-gray-700">
                  Názov
                  <input
                    value={productForm.name}
                    onChange={event => setProductForm(prev => ({ ...prev, name: event.target.value, slug: prev.slug || slugify(event.target.value) }))}
                    className={fieldClass()}
                    required
                  />
                </label>
                <label className="block text-sm font-medium text-gray-700">
                  Slug
                  <input value={productForm.slug} onChange={event => setProductForm(prev => ({ ...prev, slug: event.target.value }))} className={fieldClass()} required />
                </label>
                <label className="block text-sm font-medium text-gray-700">
                  Kategória
                  <select value={productForm.category_id} onChange={event => setProductForm(prev => ({ ...prev, category_id: event.target.value }))} className={fieldClass()}>
                    <option value="">Bez kategórie</option>
                    {categories.map(category => <option key={category.id} value={category.id}>{category.label}</option>)}
                  </select>
                </label>
                <label className="block text-sm font-medium text-gray-700">
                  Podkategória
                  <input value={productForm.subcategory} onChange={event => setProductForm(prev => ({ ...prev, subcategory: event.target.value }))} className={fieldClass()} />
                </label>
                <label className="block text-sm font-medium text-gray-700">
                  Cena EUR
                  <input type="number" step="0.01" min="0" value={productForm.price} onChange={event => setProductForm(prev => ({ ...prev, price: event.target.value }))} className={fieldClass()} required />
                </label>
                <label className="block text-sm font-medium text-gray-700">
                  Pôvodná cena EUR
                  <input type="number" step="0.01" min="0" value={productForm.original_price} onChange={event => setProductForm(prev => ({ ...prev, original_price: event.target.value }))} className={fieldClass()} />
                </label>
              </div>

              <label className="block text-sm font-medium text-gray-700">
                Krátky popis
                <input value={productForm.lead} onChange={event => setProductForm(prev => ({ ...prev, lead: event.target.value }))} className={fieldClass()} />
              </label>

              <label className="block text-sm font-medium text-gray-700">
                Popis
                <textarea value={productForm.description} onChange={event => setProductForm(prev => ({ ...prev, description: event.target.value }))} className={fieldClass()} rows="4" />
              </label>

              <div className="grid grid-cols-1 gap-4 md:grid-cols-2">
                <label className="block text-sm font-medium text-gray-700">
                  Hlavný obrázok
                  <input value={productForm.preview_url} onChange={event => setProductForm(prev => ({ ...prev, preview_url: event.target.value }))} className={fieldClass()} />
                  <input type="file" accept="image/*" onChange={event => handleImageUpload(event, 'preview')} className="mt-2 text-sm text-gray-500" />
                </label>
                <label className="block text-sm font-medium text-gray-700">
                  Detail obrázok
                  <input value={productForm.detail_url} onChange={event => setProductForm(prev => ({ ...prev, detail_url: event.target.value }))} className={fieldClass()} />
                  <input type="file" accept="image/*" onChange={event => handleImageUpload(event, 'detail')} className="mt-2 text-sm text-gray-500" />
                </label>
              </div>

              <div className="grid grid-cols-1 gap-4 md:grid-cols-2">
                <label className="block text-sm font-medium text-gray-700">
                  Špecifikácie, každá na nový riadok
                  <textarea value={productForm.specs_text} onChange={event => setProductForm(prev => ({ ...prev, specs_text: event.target.value }))} className={fieldClass()} rows="6" />
                </label>
                <label className="block text-sm font-medium text-gray-700">
                  Galéria, každá URL na nový riadok
                  <textarea value={productForm.gallery_text} onChange={event => setProductForm(prev => ({ ...prev, gallery_text: event.target.value }))} className={fieldClass()} rows="6" />
                  <input type="file" accept="image/*" onChange={event => handleImageUpload(event, 'gallery')} className="mt-2 text-sm text-gray-500" />
                </label>
              </div>

              <div className="grid grid-cols-1 gap-4 md:grid-cols-3">
                <label className="block text-sm font-medium text-gray-700">
                  Poradie
                  <input type="number" value={productForm.sort_order} onChange={event => setProductForm(prev => ({ ...prev, sort_order: event.target.value }))} className={fieldClass()} />
                </label>
                <label className="flex items-center gap-2 pt-7 text-sm font-medium text-gray-700">
                  <input type="checkbox" checked={productForm.is_active} onChange={event => setProductForm(prev => ({ ...prev, is_active: event.target.checked }))} className={checkBoxClass()} />
                  Aktívny
                </label>
                <label className="flex items-center gap-2 pt-7 text-sm font-medium text-gray-700">
                  <input type="checkbox" checked={productForm.is_featured} onChange={event => setProductForm(prev => ({ ...prev, is_featured: event.target.checked }))} className={checkBoxClass()} />
                  Odporúčaný
                </label>
              </div>

              <div className="grid grid-cols-1 gap-4 md:grid-cols-2">
                <label className="block text-sm font-medium text-gray-700">
                  SEO titulok
                  <input value={productForm.seo_title} onChange={event => setProductForm(prev => ({ ...prev, seo_title: event.target.value }))} className={fieldClass()} />
                </label>
                <label className="block text-sm font-medium text-gray-700">
                  SEO popis
                  <input value={productForm.seo_description} onChange={event => setProductForm(prev => ({ ...prev, seo_description: event.target.value }))} className={fieldClass()} />
                </label>
              </div>

              <div className="flex justify-end gap-3 border-t border-gray-200 pt-4">
                <button type="button" onClick={closeProductModal} className="rounded-lg border border-gray-300 px-4 py-2 text-sm font-semibold text-gray-700 hover:bg-gray-50">Zrušiť</button>
                <button type="submit" disabled={saving || uploading} className="inline-flex items-center rounded-lg bg-purple-600 px-4 py-2 text-sm font-semibold text-white hover:bg-purple-700 disabled:opacity-60">
                  <CheckCircleIcon className="mr-2 h-5 w-5" />
                  {saving ? 'Ukladám...' : uploading ? 'Nahrávam...' : 'Uložiť'}
                </button>
              </div>
            </form>
          </div>
        </div>,
        document.body
      )}

      {categoryModal && createPortal(
        <div className="fixed inset-0 z-[9999] flex items-center justify-center bg-black/40 p-4">
          <div className="w-full max-w-2xl rounded-xl bg-white shadow-2xl">
            <div className="flex items-center justify-between border-b border-gray-200 px-6 py-4">
              <div>
                <h2 className="text-xl font-bold text-gray-900">{editingCategory ? 'Upraviť kategóriu' : 'Nová kategória'}</h2>
                <p className="text-sm text-gray-500">Fidohome katalóg</p>
              </div>
              <button type="button" onClick={closeCategoryModal} className="rounded-lg p-2 text-gray-500 hover:bg-gray-100">
                <XMarkIcon className="h-6 w-6" />
              </button>
            </div>
            <form onSubmit={handleCategorySubmit} className="space-y-4 p-6">
              <div className="grid grid-cols-1 gap-4 md:grid-cols-2">
                <label className="block text-sm font-medium text-gray-700">
                  Názov
                  <input
                    value={categoryForm.label}
                    onChange={event => setCategoryForm(prev => ({ ...prev, label: event.target.value, slug: prev.slug || slugify(event.target.value) }))}
                    className={fieldClass()}
                    required
                  />
                </label>
                <label className="block text-sm font-medium text-gray-700">
                  Slug
                  <input value={categoryForm.slug} onChange={event => setCategoryForm(prev => ({ ...prev, slug: event.target.value }))} className={fieldClass()} required />
                </label>
              </div>
              <label className="block text-sm font-medium text-gray-700">
                Popis
                <textarea value={categoryForm.description} onChange={event => setCategoryForm(prev => ({ ...prev, description: event.target.value }))} className={fieldClass()} rows="3" />
              </label>
              <div className="grid grid-cols-1 gap-4 md:grid-cols-2">
                <label className="block text-sm font-medium text-gray-700">
                  Obrázok URL
                  <input value={categoryForm.image_url} onChange={event => setCategoryForm(prev => ({ ...prev, image_url: event.target.value }))} className={fieldClass()} />
                </label>
                <label className="block text-sm font-medium text-gray-700">
                  Poradie
                  <input type="number" value={categoryForm.sort_order} onChange={event => setCategoryForm(prev => ({ ...prev, sort_order: event.target.value }))} className={fieldClass()} />
                </label>
              </div>
              <label className="flex items-center gap-2 text-sm font-medium text-gray-700">
                <input type="checkbox" checked={categoryForm.is_active} onChange={event => setCategoryForm(prev => ({ ...prev, is_active: event.target.checked }))} className={checkBoxClass()} />
                Aktívna kategória
              </label>
              <div className="flex justify-end gap-3 border-t border-gray-200 pt-4">
                <button type="button" onClick={closeCategoryModal} className="rounded-lg border border-gray-300 px-4 py-2 text-sm font-semibold text-gray-700 hover:bg-gray-50">Zrušiť</button>
                <button type="submit" disabled={saving} className="inline-flex items-center rounded-lg bg-purple-600 px-4 py-2 text-sm font-semibold text-white hover:bg-purple-700 disabled:opacity-60">
                  <CheckCircleIcon className="mr-2 h-5 w-5" />
                  {saving ? 'Ukladám...' : 'Uložiť'}
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
