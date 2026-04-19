import { useEffect, useMemo, useState } from 'react'
import {
  ArchiveBoxIcon,
  CheckCircleIcon,
  CurrencyEuroIcon,
  PencilSquareIcon,
  PlusIcon,
  ShoppingBagIcon,
  TrashIcon,
} from '@heroicons/react/24/outline'
import { useAuth } from '../contexts/AuthContext'
import { useNotification } from '../contexts/NotificationContext'
import {
  VAVROSTAV_OWNER_ID,
  createEcommerceProduct,
  deleteEcommerceProduct,
  getPublicUrl,
  listEcommerceOrders,
  listEcommerceProducts,
  updateEcommerceOrderStatus,
  updateEcommerceProduct,
  uploadProductImage,
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
}

const ORDER_STATUSES = [
  { value: 'new', label: 'Nová' },
  { value: 'confirmed', label: 'Potvrdená' },
  { value: 'in_progress', label: 'V riešení' },
  { value: 'completed', label: 'Dokončená' },
  { value: 'cancelled', label: 'Zrušená' },
]

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
  }
}

export default function VavrostavEcommerce() {
  const { user, loading: authLoading } = useAuth()
  const { showNotification } = useNotification()
  const [activeTab, setActiveTab] = useState('orders')
  const [products, setProducts] = useState([])
  const [orders, setOrders] = useState([])
  const [loading, setLoading] = useState(true)
  const [saving, setSaving] = useState(false)
  const [uploadingImage, setUploadingImage] = useState(false)
  const [editingProduct, setEditingProduct] = useState(null)
  const [productForm, setProductForm] = useState(EMPTY_PRODUCT)

  const hasAccess = user?.id === VAVROSTAV_OWNER_ID

  useEffect(() => {
    if (authLoading || !hasAccess) return
    loadData()
  }, [authLoading, hasAccess])

  const stats = useMemo(() => {
    const openOrders = orders.filter(order => !['completed', 'cancelled'].includes(order.status)).length
    const revenue = orders
      .filter(order => order.status !== 'cancelled')
      .reduce((sum, order) => sum + Number(order.total_cents || 0), 0)

    return {
      activeProducts: products.filter(product => product.is_active).length,
      openOrders,
      revenue,
    }
  }, [orders, products])

  async function loadData() {
    setLoading(true)
    try {
      const [nextProducts, nextOrders] = await Promise.all([
        listEcommerceProducts(),
        listEcommerceOrders(),
      ])
      setProducts(nextProducts)
      setOrders(nextOrders)
    } catch (err) {
      console.error('Ecommerce load error:', err)
      showNotification('Nepodarilo sa načítať obchod', 'error')
    } finally {
      setLoading(false)
    }
  }

  function resetForm() {
    setEditingProduct(null)
    setProductForm(EMPTY_PRODUCT)
  }

  function startEditing(product) {
    setEditingProduct(product)
    setProductForm(productToForm(product))
    setActiveTab('products')
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
      resetForm()
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
        productId: editingProduct?.id,
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

  async function handleStatusChange(order, status) {
    try {
      const updated = await updateEcommerceOrderStatus(order.id, status)
      setOrders(prev => prev.map(item => item.id === updated.id ? updated : item))
      showNotification('Stav objednávky bol aktualizovaný', 'success')
    } catch (err) {
      console.error('Order status error:', err)
      showNotification('Stav objednávky sa nepodarilo uložiť', 'error')
    }
  }

  if (authLoading) {
    return (
      <div className="flex items-center justify-center h-64">
        <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-purple-600"></div>
      </div>
    )
  }

  if (!hasAccess) {
    return (
      <div className="flex items-center justify-center h-64">
        <p className="text-gray-500">Nemáte prístup k Vavrostav obchodu.</p>
      </div>
    )
  }

  return (
    <div className="space-y-6">
      <div className="flex flex-col gap-4 lg:flex-row lg:items-end lg:justify-between">
        <div>
          <p className="text-sm font-semibold uppercase tracking-[0.18em] text-yellow-600">Vavrostav</p>
          <h1 className="mt-1 text-3xl font-bold text-gray-950">Obchod a objednávky</h1>
          <p className="mt-2 text-sm text-gray-500">
            Správa produktov a objednávok z webu vavrostav.sk. Platby sú pripravené ako neuhradené pre budúci Stripe krok.
          </p>
        </div>
        <a
          href="https://www.vavrostav.sk/shop"
          target="_blank"
          rel="noreferrer"
          className="inline-flex items-center justify-center rounded-2xl bg-gray-950 px-5 py-3 text-sm font-bold text-white hover:bg-yellow-500 hover:text-black"
        >
          Otvoriť obchod
        </a>
      </div>

      <div className="grid gap-4 md:grid-cols-3">
        <div className="rounded-3xl bg-white p-5 shadow-sm ring-1 ring-gray-100">
          <ShoppingBagIcon className="h-7 w-7 text-yellow-500" />
          <p className="mt-4 text-3xl font-bold text-gray-950">{stats.openOrders}</p>
          <p className="text-sm text-gray-500">Aktívne objednávky</p>
        </div>
        <div className="rounded-3xl bg-white p-5 shadow-sm ring-1 ring-gray-100">
          <ArchiveBoxIcon className="h-7 w-7 text-yellow-500" />
          <p className="mt-4 text-3xl font-bold text-gray-950">{stats.activeProducts}</p>
          <p className="text-sm text-gray-500">Aktívne produkty</p>
        </div>
        <div className="rounded-3xl bg-white p-5 shadow-sm ring-1 ring-gray-100">
          <CurrencyEuroIcon className="h-7 w-7 text-yellow-500" />
          <p className="mt-4 text-3xl font-bold text-gray-950">{formatPrice(stats.revenue)}</p>
          <p className="text-sm text-gray-500">Objednávky mimo zrušených</p>
        </div>
      </div>

      <div className="flex gap-2 rounded-2xl bg-white p-2 shadow-sm ring-1 ring-gray-100">
        {[
          { id: 'orders', label: 'Objednávky' },
          { id: 'products', label: 'Produkty' },
        ].map(tab => (
          <button
            key={tab.id}
            onClick={() => setActiveTab(tab.id)}
            className={`flex-1 rounded-xl px-4 py-3 text-sm font-bold transition ${
              activeTab === tab.id ? 'bg-gray-950 text-white' : 'text-gray-500 hover:bg-gray-50 hover:text-gray-900'
            }`}
          >
            {tab.label}
          </button>
        ))}
      </div>

      {loading ? (
        <div className="rounded-3xl bg-white p-12 text-center text-gray-500 shadow-sm ring-1 ring-gray-100">
          Načítavam obchod...
        </div>
      ) : activeTab === 'orders' ? (
        <section className="space-y-4">
          {orders.length === 0 ? (
            <div className="rounded-3xl border-2 border-dashed border-gray-200 bg-white p-12 text-center text-gray-500">
              Zatiaľ žiadne objednávky.
            </div>
          ) : orders.map(order => (
            <article key={order.id} className="rounded-3xl bg-white p-6 shadow-sm ring-1 ring-gray-100">
              <div className="flex flex-col gap-4 lg:flex-row lg:items-start lg:justify-between">
                <div>
                  <div className="flex flex-wrap items-center gap-2">
                    <h2 className="text-lg font-bold text-gray-950">Objednávka #{order.id.slice(0, 8)}</h2>
                    <span className="rounded-full bg-yellow-100 px-3 py-1 text-xs font-bold uppercase text-yellow-800">
                      {order.payment_status === 'paid' ? 'Zaplatená' : 'Nezaplatená'}
                    </span>
                  </div>
                  <p className="mt-1 text-sm text-gray-500">
                    {new Date(order.created_at).toLocaleString('sk-SK')} · {order.customer_name} · {order.customer_email}
                  </p>
                  {order.customer_phone && <p className="text-sm text-gray-500">{order.customer_phone}</p>}
                  {order.customer_address && <p className="mt-2 text-sm text-gray-700">{order.customer_address}</p>}
                  {order.notes && <p className="mt-2 rounded-2xl bg-gray-50 p-3 text-sm text-gray-600">{order.notes}</p>}
                </div>
                <div className="flex flex-col gap-2 lg:items-end">
                  <p className="text-2xl font-bold text-gray-950">{formatPrice(order.total_cents, order.currency)}</p>
                  <select
                    value={order.status}
                    onChange={(event) => handleStatusChange(order, event.target.value)}
                    className="rounded-xl border border-gray-200 bg-white px-3 py-2 text-sm font-semibold text-gray-700"
                  >
                    {ORDER_STATUSES.map(status => (
                      <option key={status.value} value={status.value}>{status.label}</option>
                    ))}
                  </select>
                </div>
              </div>
              <div className="mt-5 overflow-hidden rounded-2xl border border-gray-100">
                {(order.ecommerce_order_items || []).map(item => (
                  <div key={item.id} className="flex items-center justify-between gap-4 border-b border-gray-100 px-4 py-3 last:border-b-0">
                    <div>
                      <p className="font-semibold text-gray-900">{item.product_name}</p>
                      <p className="text-xs text-gray-500">{item.quantity} × {formatPrice(item.unit_price_cents, order.currency)}</p>
                    </div>
                    <p className="font-bold text-gray-950">{formatPrice(item.line_total_cents, order.currency)}</p>
                  </div>
                ))}
              </div>
            </article>
          ))}
        </section>
      ) : (
        <section className="grid gap-6 lg:grid-cols-[380px_1fr]">
          <form onSubmit={handleSubmitProduct} className="rounded-3xl bg-white p-6 shadow-sm ring-1 ring-gray-100">
            <div className="mb-5 flex items-center justify-between gap-3">
              <h2 className="text-lg font-bold text-gray-950">{editingProduct ? 'Upraviť produkt' : 'Nový produkt'}</h2>
              {editingProduct && (
                <button type="button" onClick={resetForm} className="text-sm font-semibold text-gray-500 hover:text-gray-900">
                  Zrušiť úpravu
                </button>
              )}
            </div>

            <div className="space-y-4">
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
                <span className="text-sm font-semibold text-gray-700">SKU</span>
                <input
                  value={productForm.sku}
                  onChange={(event) => setProductForm(prev => ({ ...prev, sku: event.target.value }))}
                  className="mt-1 w-full rounded-xl border border-gray-200 px-3 py-2"
                />
              </label>
              <label className="block">
                <span className="text-sm font-semibold text-gray-700">Obrázok URL</span>
                <input
                  value={productForm.image_url}
                  onChange={(event) => setProductForm(prev => ({ ...prev, image_url: event.target.value }))}
                  className="mt-1 w-full rounded-xl border border-gray-200 px-3 py-2"
                />
              </label>
              <div className="rounded-2xl border border-dashed border-gray-200 bg-gray-50 p-4">
                {productForm.image_url && (
                  <div className="mb-3 aspect-[4/3] overflow-hidden rounded-xl bg-white">
                    <img src={productForm.image_url} alt="Náhľad produktu" className="h-full w-full object-cover" />
                  </div>
                )}
                <label className="flex cursor-pointer items-center justify-center rounded-xl bg-gray-950 px-4 py-3 text-sm font-bold text-white transition hover:bg-yellow-400 hover:text-black">
                  {uploadingImage ? 'Nahrávam obrázok...' : 'Nahrať obrázok z počítača'}
                  <input
                    type="file"
                    accept="image/*"
                    className="hidden"
                    disabled={uploadingImage}
                    onChange={handleProductImageUpload}
                  />
                </label>
                <p className="mt-2 text-xs text-gray-500">
                  Po nahratí sa URL obrázka automaticky vloží do poľa vyššie.
                </p>
              </div>
              <label className="block">
                <span className="text-sm font-semibold text-gray-700">Popis</span>
                <textarea
                  rows={4}
                  value={productForm.description}
                  onChange={(event) => setProductForm(prev => ({ ...prev, description: event.target.value }))}
                  className="mt-1 w-full rounded-xl border border-gray-200 px-3 py-2"
                />
              </label>
              <label className="flex items-center gap-2 text-sm font-semibold text-gray-700">
                <input
                  type="checkbox"
                  checked={productForm.is_active}
                  onChange={(event) => setProductForm(prev => ({ ...prev, is_active: event.target.checked }))}
                  className="h-4 w-4 rounded border-gray-300 text-yellow-500"
                />
                Aktívny na webe
              </label>
              <button
                disabled={saving}
                className="inline-flex w-full items-center justify-center gap-2 rounded-2xl bg-yellow-400 px-5 py-3 text-sm font-extrabold text-black transition hover:bg-yellow-300 disabled:opacity-60"
              >
                {editingProduct ? <CheckCircleIcon className="h-5 w-5" /> : <PlusIcon className="h-5 w-5" />}
                {saving ? 'Ukladám...' : editingProduct ? 'Uložiť produkt' : 'Pridať produkt'}
              </button>
            </div>
          </form>

          <div className="grid gap-4 md:grid-cols-2">
            {products.map(product => (
              <article key={product.id} className="overflow-hidden rounded-3xl bg-white shadow-sm ring-1 ring-gray-100">
                <div className="aspect-[4/3] bg-gray-100">
                  {product.image_url ? (
                    <img src={product.image_url} alt={product.name} className="h-full w-full object-cover" />
                  ) : (
                    <div className="flex h-full items-center justify-center text-gray-300">
                      <ArchiveBoxIcon className="h-12 w-12" />
                    </div>
                  )}
                </div>
                <div className="p-5">
                  <div className="flex items-start justify-between gap-3">
                    <div>
                      <h3 className="font-bold text-gray-950">{product.name}</h3>
                      <p className="text-sm text-gray-500">/{product.slug}</p>
                    </div>
                    <span className={`rounded-full px-2 py-1 text-xs font-bold ${
                      product.is_active ? 'bg-green-100 text-green-700' : 'bg-gray-100 text-gray-500'
                    }`}>
                      {product.is_active ? 'Aktívny' : 'Skrytý'}
                    </span>
                  </div>
                  <p className="mt-3 text-xl font-bold text-gray-950">{formatPrice(product.price_cents, product.currency)}</p>
                  <p className="text-sm text-gray-500">Sklad: {product.stock_quantity} ks</p>
                  <div className="mt-4 flex gap-2">
                    <button
                      type="button"
                      onClick={() => startEditing(product)}
                      className="inline-flex flex-1 items-center justify-center gap-2 rounded-xl bg-gray-950 px-3 py-2 text-sm font-bold text-white"
                    >
                      <PencilSquareIcon className="h-4 w-4" />
                      Upraviť
                    </button>
                    <button
                      type="button"
                      onClick={() => handleDeleteProduct(product)}
                      className="inline-flex items-center justify-center rounded-xl bg-red-50 px-3 py-2 text-red-600 hover:bg-red-100"
                    >
                      <TrashIcon className="h-4 w-4" />
                    </button>
                  </div>
                </div>
              </article>
            ))}
          </div>
        </section>
      )}
    </div>
  )
}
