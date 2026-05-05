import { useEffect, useState } from 'react'
import {
  ArchiveBoxIcon,
  CheckCircleIcon,
  PencilSquareIcon,
  PlusIcon,
  TrashIcon,
  XMarkIcon
} from '@heroicons/react/24/outline'
import { useAuth } from '../contexts/AuthContext'
import { useNotification } from '../contexts/NotificationContext'
import {
  VAVROSTAV_OWNER_ID,
  createEcommerceProduct,
  deleteEcommerceProduct,
  getPublicUrl,
  listEcommerceProducts,
  updateEcommerceProduct,
  uploadProductImage,
  listEcommerceCategories,
} from '../api'

const EMPTY_PRODUCT = {
  name: '',
  slug: '',
  sku: '',
  description: '',
  image_url: '',
  price: '',
  stock_quantity: 0,
  is_active: true,
  category_id: '',
  gallery_images: [],
  specifications: [],
}

function formatPrice(cents, currency = 'EUR') {
  return new Intl.NumberFormat('sk-SK', {
    style: 'currency',
    currency,
  }).format((Number(cents) || 0) / 100)
}

function slugify(value) {
  return value
    .toLowerCase()
    .normalize('NFD')
    .replace(/[\u0300-\u036f]/g, '')
    .replace(/[^a-z0-9]+/g, '-')
    .replace(/^-+|-+$/g, '')
}

function productToForm(product) {
  return {
    name: product.name || '',
    slug: product.slug || '',
    sku: product.sku || '',
    description: product.description || '',
    image_url: product.image_url || '',
    price: ((product.price_cents || 0) / 100).toFixed(2),
    stock_quantity: product.stock_quantity || 0,
    is_active: Boolean(product.is_active),
    category_id: product.category_id || '',
    gallery_images: product.gallery_images || [],
    specifications: product.specifications || [],
  }
}

function formToProductPayload(form) {
  return {
    name: form.name.trim(),
    slug: (form.slug || slugify(form.name)).trim(),
    sku: form.sku.trim() || null,
    description: form.description.trim() || null,
    image_url: form.image_url.trim() || null,
    price_cents: Math.round(Number(form.price || 0) * 100),
    currency: 'EUR',
    stock_quantity: Number(form.stock_quantity || 0),
    is_active: Boolean(form.is_active),
    category_id: form.category_id || null,
    gallery_images: form.gallery_images || [],
    specifications: form.specifications || [],
  }
}

export default function VavrostavProducts() {
  const { user, loading: authLoading } = useAuth()
  const { showNotification } = useNotification()
  const [products, setProducts] = useState([])
  const [categories, setCategories] = useState([])
  const [loading, setLoading] = useState(true)
  const [saving, setSaving] = useState(false)
  const [uploadingImage, setUploadingImage] = useState(false)
  const [uploadingGallery, setUploadingGallery] = useState(false)
  const [isModalOpen, setIsModalOpen] = useState(false)
  const [editingProduct, setEditingProduct] = useState(null)
  const [productForm, setProductForm] = useState(EMPTY_PRODUCT)

  const hasAccess = user?.id === VAVROSTAV_OWNER_ID

  useEffect(() => {
    if (authLoading || !hasAccess) return
    loadData()
  }, [authLoading, hasAccess])

  async function loadData() {
    setLoading(true)
    try {
      const [nextProducts, nextCategories] = await Promise.all([
        listEcommerceProducts(),
        listEcommerceCategories(),
      ])
      setProducts(nextProducts)
      setCategories(nextCategories)
    } catch (err) {
      console.error('Ecommerce load error:', err)
      showNotification('Nepodarilo sa načítať produkty', 'error')
    } finally {
      setLoading(false)
    }
  }

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

    if (!payload.name || !payload.slug || payload.price_cents < 0) {
      showNotification('Vyplňte názov, URL slug a cenu produktu', 'error')
      return
    }

    setSaving(true)
    try {
      if (editingProduct) {
        const updated = await updateEcommerceProduct(editingProduct.id, payload)
        setProducts(prev => prev.map(product => product.id === updated.id ? updated : product))
        showNotification('Produkt bol uložený', 'success')
      } else {
        const created = await createEcommerceProduct(payload)
        setProducts(prev => [created, ...prev])
        showNotification('Produkt bol pridaný', 'success')
      }
      closeModal()
    } catch (err) {
      console.error('Product save error:', err)
      showNotification(err.message || 'Produkt sa nepodarilo uložiť', 'error')
    } finally {
      setSaving(false)
    }
  }

  async function handleProductImageUpload(event) {
    const file = event.target.files?.[0]
    event.target.value = ''
    if (!file) return

    if (!file.type.startsWith('image/')) {
      showNotification('Vyberte obrázok produktu', 'error')
      return
    }

    setUploadingImage(true)
    try {
      const { path } = await uploadProductImage({
        file,
        ownerSlug: 'vavrostav',
        productId: editingProduct?.id || 'new',
      })
      const url = getPublicUrl(path)
      setProductForm(prev => ({ ...prev, image_url: url }))
      showNotification('Obrázok bol nahraný', 'success')
    } catch (err) {
      console.error('Product image upload error:', err)
      showNotification('Obrázok sa nepodarilo nahrať', 'error')
    } finally {
      setUploadingImage(false)
    }
  }

  async function handleGalleryImageUpload(event) {
    const files = Array.from(event.target.files || [])
    event.target.value = ''
    if (files.length === 0) return

    setUploadingGallery(true)
    try {
      const newUrls = []
      for (const file of files) {
        if (!file.type.startsWith('image/')) continue
        const { path } = await uploadProductImage({
          file,
          ownerSlug: 'vavrostav',
          productId: editingProduct?.id || 'new',
        })
        newUrls.push(getPublicUrl(path))
      }
      setProductForm(prev => ({ ...prev, gallery_images: [...(prev.gallery_images || []), ...newUrls] }))
      showNotification('Obrázky do galérie boli nahrané', 'success')
    } catch (err) {
      console.error('Gallery upload error:', err)
      showNotification('Obrázky sa nepodarilo nahrať', 'error')
    } finally {
      setUploadingGallery(false)
    }
  }

  async function handleDescriptionImageUpload(event) {
    const file = event.target.files?.[0]
    event.target.value = ''
    if (!file || !file.type.startsWith('image/')) return

    try {
      showNotification('Nahrávam obrázok do popisu...', 'info')
      const { path } = await uploadProductImage({
        file,
        ownerSlug: 'vavrostav',
        productId: editingProduct?.id || 'new',
      })
      const url = getPublicUrl(path)
      const imageTag = `\n<img src="${url}" alt="Obrázok v popise" className="my-4 max-w-full rounded-2xl" />\n`
      setProductForm(prev => ({ ...prev, description: (prev.description || '') + imageTag }))
      showNotification('Obrázok vložený do popisu', 'success')
    } catch (err) {
      console.error('Description image upload error:', err)
      showNotification('Nepodarilo sa vložiť obrázok', 'error')
    }
  }

  function addSpecification() {
    setProductForm(prev => ({
      ...prev,
      specifications: [...(prev.specifications || []), { key: '', value: '' }]
    }))
  }

  function removeSpecification(index) {
    setProductForm(prev => ({
      ...prev,
      specifications: prev.specifications.filter((_, i) => i !== index)
    }))
  }

  function updateSpecification(index, field, value) {
    setProductForm(prev => {
      const newSpecs = [...(prev.specifications || [])]
      newSpecs[index] = { ...newSpecs[index], [field]: value }
      return { ...prev, specifications: newSpecs }
    })
  }

  async function handleDeleteProduct(product) {
    if (!confirm(`Naozaj vymazať produkt "${product.name}"?`)) return

    try {
      await deleteEcommerceProduct(product.id)
      setProducts(prev => prev.filter(item => item.id !== product.id))
      showNotification('Produkt bol vymazaný', 'success')
    } catch (err) {
      console.error('Product delete error:', err)
      showNotification('Produkt sa nepodarilo vymazať', 'error')
    }
  }

  if (authLoading) return <div className="flex items-center justify-center h-64"><div className="animate-spin rounded-full h-8 w-8 border-b-2 border-purple-600"></div></div>
  if (!hasAccess) return <div className="flex items-center justify-center h-64"><p className="text-gray-500">Nemáte prístup.</p></div>

  return (
    <div className="space-y-6">
      <div className="flex flex-col gap-4 lg:flex-row lg:items-end lg:justify-between">
        <div>
          <p className="text-sm font-semibold uppercase tracking-[0.18em] text-yellow-600">Vavrostav</p>
          <h1 className="mt-1 text-3xl font-bold text-gray-950">Produkty</h1>
        </div>
        <button
          onClick={openCreateModal}
          className="inline-flex items-center justify-center rounded-2xl bg-yellow-400 px-5 py-3 text-sm font-extrabold text-black transition hover:bg-yellow-300"
        >
          <PlusIcon className="mr-2 h-5 w-5" />
          Pridať produkt
        </button>
      </div>

      {loading ? (
        <div className="rounded-3xl bg-white p-12 text-center text-gray-500 shadow-sm ring-1 ring-gray-100">
          Načítavam produkty...
        </div>
      ) : (
        <div className="overflow-x-auto rounded-3xl bg-white shadow-sm ring-1 ring-gray-100">
          <table className="min-w-full divide-y divide-gray-200">
            <thead className="bg-gray-50">
              <tr>
                <th className="px-6 py-4 text-left text-xs font-medium uppercase tracking-wider text-gray-500">Obrázok</th>
                <th className="px-6 py-4 text-left text-xs font-medium uppercase tracking-wider text-gray-500">Názov</th>
                <th className="px-6 py-4 text-left text-xs font-medium uppercase tracking-wider text-gray-500">Kategória</th>
                <th className="px-6 py-4 text-left text-xs font-medium uppercase tracking-wider text-gray-500">Cena</th>
                <th className="px-6 py-4 text-left text-xs font-medium uppercase tracking-wider text-gray-500">Sklad</th>
                <th className="px-6 py-4 text-left text-xs font-medium uppercase tracking-wider text-gray-500">Stav</th>
                <th className="px-6 py-4 text-right text-xs font-medium uppercase tracking-wider text-gray-500">Akcie</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-gray-200 bg-white">
              {products.length === 0 ? (
                <tr>
                  <td colSpan="7" className="px-6 py-12 text-center text-sm text-gray-500">
                    Zatiaľ nemáte žiadne produkty.
                  </td>
                </tr>
              ) : products.map(product => (
                <tr key={product.id} className="transition hover:bg-gray-50">
                  <td className="whitespace-nowrap px-6 py-4">
                    <div className="h-12 w-12 flex-shrink-0 overflow-hidden rounded-lg bg-gray-100">
                      {product.image_url ? (
                        <img src={product.image_url} alt="" className="h-full w-full object-cover" />
                      ) : (
                        <div className="flex h-full items-center justify-center text-gray-300">
                          <ArchiveBoxIcon className="h-6 w-6" />
                        </div>
                      )}
                    </div>
                  </td>
                  <td className="whitespace-nowrap px-6 py-4">
                    <div className="text-sm font-medium text-gray-900">{product.name}</div>
                    <div className="text-xs text-gray-500">/{product.slug}</div>
                  </td>
                  <td className="whitespace-nowrap px-6 py-4">
                    <div className="text-sm text-gray-500">
                      {categories.find(c => c.id === product.category_id)?.name || '-'}
                    </div>
                  </td>
                  <td className="whitespace-nowrap px-6 py-4">
                    <div className="text-sm font-bold text-gray-900">{formatPrice(product.price_cents, product.currency)}</div>
                  </td>
                  <td className="whitespace-nowrap px-6 py-4">
                    <div className="text-sm text-gray-500">{product.stock_quantity} ks</div>
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
                      onClick={() => openEditModal(product)}
                      className="mr-3 text-indigo-600 hover:text-indigo-900"
                    >
                      Upraviť
                    </button>
                    <button
                      onClick={() => handleDeleteProduct(product)}
                      className="text-red-600 hover:text-red-900"
                    >
                      Vymazať
                    </button>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      )}

      {isModalOpen && (
        <div className="fixed inset-0 z-50 flex items-center justify-center overflow-y-auto bg-gray-900/50 px-4 py-6 backdrop-blur-sm sm:px-0">
          <div className="relative w-full max-w-2xl rounded-3xl bg-white shadow-2xl max-h-[90vh] overflow-y-auto">
            <div className="sticky top-0 z-10 flex items-center justify-between border-b border-gray-100 bg-white px-6 py-4">
              <h2 className="text-xl font-bold text-gray-950">{editingProduct ? 'Upraviť produkt' : 'Nový produkt'}</h2>
              <button onClick={closeModal} className="rounded-full p-2 text-gray-400 hover:bg-gray-100 hover:text-gray-600 transition">
                <XMarkIcon className="h-6 w-6" />
              </button>
            </div>
            
            <form onSubmit={handleSubmitProduct} className="p-6">
              <div className="space-y-5">
                <label className="block">
                  <span className="text-sm font-semibold text-gray-700">Názov</span>
                  <input
                    value={productForm.name}
                    onChange={(event) => setProductForm(prev => ({
                      ...prev,
                      name: event.target.value,
                      slug: editingProduct ? prev.slug : slugify(event.target.value),
                    }))}
                    className="mt-1 w-full rounded-xl border border-gray-200 px-3 py-2"
                    required
                  />
                </label>
                <label className="block">
                  <span className="text-sm font-semibold text-gray-700">URL slug</span>
                  <input
                    value={productForm.slug}
                    onChange={(event) => setProductForm(prev => ({ ...prev, slug: slugify(event.target.value) }))}
                    className="mt-1 w-full rounded-xl border border-gray-200 px-3 py-2"
                    required
                  />
                </label>
                <div className="grid grid-cols-2 gap-3">
                  <label className="block">
                    <span className="text-sm font-semibold text-gray-700">Cena (€)</span>
                    <input
                      type="number"
                      step="0.01"
                      min="0"
                      value={productForm.price}
                      onChange={(event) => setProductForm(prev => ({ ...prev, price: event.target.value }))}
                      className="mt-1 w-full rounded-xl border border-gray-200 px-3 py-2"
                      required
                    />
                  </label>
                  <label className="block">
                    <span className="text-sm font-semibold text-gray-700">Sklad</span>
                    <input
                      type="number"
                      min="0"
                      value={productForm.stock_quantity}
                      onChange={(event) => setProductForm(prev => ({ ...prev, stock_quantity: event.target.value }))}
                      className="mt-1 w-full rounded-xl border border-gray-200 px-3 py-2"
                    />
                  </label>
                </div>
                <label className="block">
                  <span className="text-sm font-semibold text-gray-700">Kategória</span>
                  <select
                    value={productForm.category_id}
                    onChange={(event) => setProductForm(prev => ({ ...prev, category_id: event.target.value }))}
                    className="mt-1 w-full rounded-xl border border-gray-200 px-3 py-2"
                  >
                    <option value="">— Bez kategórie —</option>
                    {categories.map(cat => (
                      <option key={cat.id} value={cat.id}>{cat.name}</option>
                    ))}
                  </select>
                </label>
                <label className="block">
                  <span className="text-sm font-semibold text-gray-700">SKU</span>
                  <input
                    value={productForm.sku}
                    onChange={(event) => setProductForm(prev => ({ ...prev, sku: event.target.value }))}
                    className="mt-1 w-full rounded-xl border border-gray-200 px-3 py-2"
                  />
                </label>
                
                <div className="rounded-2xl border border-dashed border-gray-200 bg-gray-50 p-4">
                  {productForm.image_url && (
                    <div className="mb-3 aspect-[4/3] overflow-hidden rounded-xl bg-white mx-auto max-w-xs">
                      <img src={productForm.image_url} alt="Náhľad produktu" className="h-full w-full object-cover" />
                    </div>
                  )}
                  <label className="flex cursor-pointer items-center justify-center rounded-xl bg-gray-950 px-4 py-3 text-sm font-bold text-white transition hover:bg-yellow-400 hover:text-black">
                    {uploadingImage ? 'Nahrávam obrázok...' : 'Hlavný obrázok'}
                    <input
                      type="file"
                      accept="image/*"
                      className="hidden"
                      disabled={uploadingImage}
                      onChange={handleProductImageUpload}
                    />
                  </label>
                </div>

                <div className="rounded-2xl border border-gray-200 bg-gray-50 p-4">
                  <div className="mb-3 flex items-center justify-between">
                    <span className="text-sm font-semibold text-gray-700">Galéria obrázkov</span>
                    <label className="cursor-pointer rounded-xl bg-gray-200 px-3 py-1.5 text-xs font-bold text-gray-900 transition hover:bg-gray-300">
                      {uploadingGallery ? 'Nahrávam...' : 'Pridať obrázky'}
                      <input type="file" multiple accept="image/*" className="hidden" disabled={uploadingGallery} onChange={handleGalleryImageUpload} />
                    </label>
                  </div>
                  <div className="grid grid-cols-3 gap-3">
                    {(productForm.gallery_images || []).map((url, idx) => (
                      <div key={idx} className="group relative aspect-square overflow-hidden rounded-xl bg-white border border-gray-200">
                        <img src={url} alt={`Galéria ${idx + 1}`} className="h-full w-full object-cover" />
                        <button
                          type="button"
                          onClick={() => setProductForm(prev => ({ ...prev, gallery_images: prev.gallery_images.filter((_, i) => i !== idx) }))}
                          className="absolute right-2 top-2 rounded-lg bg-white/90 p-1 text-red-600 opacity-0 shadow-sm backdrop-blur transition hover:bg-red-50 group-hover:opacity-100"
                        >
                          <TrashIcon className="h-4 w-4" />
                        </button>
                      </div>
                    ))}
                  </div>
                </div>

                <div className="rounded-2xl border border-gray-200 bg-gray-50 p-4">
                  <div className="mb-3 flex items-center justify-between">
                    <span className="text-sm font-semibold text-gray-700">Technické parametre</span>
                    <button type="button" onClick={addSpecification} className="rounded-xl bg-gray-200 px-3 py-1.5 text-xs font-bold text-gray-900 transition hover:bg-gray-300">
                      Pridať parameter
                    </button>
                  </div>
                  <div className="space-y-3">
                    {(productForm.specifications || []).map((spec, idx) => (
                      <div key={idx} className="flex gap-2">
                        <input
                          value={spec.key}
                          onChange={(e) => updateSpecification(idx, 'key', e.target.value)}
                          placeholder="Napr. Hmotnosť"
                          className="w-1/3 rounded-xl border border-gray-200 px-3 py-2 text-sm"
                        />
                        <input
                          value={spec.value}
                          onChange={(e) => updateSpecification(idx, 'value', e.target.value)}
                          placeholder="Napr. 25 kg"
                          className="flex-1 rounded-xl border border-gray-200 px-3 py-2 text-sm"
                        />
                        <button
                          type="button"
                          onClick={() => removeSpecification(idx)}
                          className="rounded-xl bg-red-50 px-3 text-red-600 hover:bg-red-100"
                        >
                          <TrashIcon className="h-4 w-4" />
                        </button>
                      </div>
                    ))}
                  </div>
                </div>

                <div className="space-y-2">
                  <label className="block">
                    <span className="text-sm font-semibold text-gray-700">Popis (HTML)</span>
                    <textarea
                      rows={6}
                      value={productForm.description}
                      onChange={(event) => setProductForm(prev => ({ ...prev, description: event.target.value }))}
                      className="mt-1 w-full rounded-xl border border-gray-200 px-3 py-2 font-mono text-sm"
                    />
                  </label>
                  <label className="inline-flex cursor-pointer items-center gap-2 rounded-xl bg-gray-100 px-3 py-2 text-xs font-bold text-gray-700 transition hover:bg-gray-200">
                    <PlusIcon className="h-4 w-4" /> Vložiť obrázok do popisu
                    <input type="file" accept="image/*" className="hidden" onChange={handleDescriptionImageUpload} />
                  </label>
                </div>

                <label className="flex items-center gap-2 text-sm font-semibold text-gray-700">
                  <input
                    type="checkbox"
                    checked={productForm.is_active}
                    onChange={(event) => setProductForm(prev => ({ ...prev, is_active: event.target.checked }))}
                    className="h-4 w-4 rounded border-gray-300 text-yellow-500"
                  />
                  Aktívny na webe
                </label>
                
                <div className="sticky bottom-0 bg-white pt-4 pb-2 border-t border-gray-100 flex gap-3 justify-end mt-6">
                  <button
                    type="button"
                    onClick={closeModal}
                    className="rounded-xl bg-gray-100 px-5 py-3 text-sm font-bold text-gray-700 hover:bg-gray-200 transition"
                  >
                    Zrušiť
                  </button>
                  <button
                    type="submit"
                    disabled={saving}
                    className="inline-flex items-center justify-center gap-2 rounded-xl bg-yellow-400 px-6 py-3 text-sm font-extrabold text-black transition hover:bg-yellow-300 disabled:opacity-60"
                  >
                    {editingProduct ? <CheckCircleIcon className="h-5 w-5" /> : <PlusIcon className="h-5 w-5" />}
                    {saving ? 'Ukladám...' : editingProduct ? 'Uložiť produkt' : 'Pridať produkt'}
                  </button>
                </div>
              </div>
            </form>
          </div>
        </div>
      )}
    </div>
  )
}
