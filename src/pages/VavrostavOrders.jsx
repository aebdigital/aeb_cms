import { useEffect, useMemo, useState } from 'react'
import { ShoppingBagIcon, CurrencyEuroIcon } from '@heroicons/react/24/outline'
import { useAuth } from '../contexts/AuthContext'
import { useNotification } from '../contexts/NotificationContext'
import { VAVROSTAV_OWNER_ID, listEcommerceOrders, updateEcommerceOrderStatus } from '../api'

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

export default function VavrostavOrders() {
  const { user, loading: authLoading } = useAuth()
  const { showNotification } = useNotification()
  const [orders, setOrders] = useState([])
  const [loading, setLoading] = useState(true)

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

    return { openOrders, revenue }
  }, [orders])

  async function loadData() {
    setLoading(true)
    try {
      const nextOrders = await listEcommerceOrders()
      setOrders(nextOrders)
    } catch (err) {
      console.error('Ecommerce load error:', err)
      showNotification('Nepodarilo sa načítať objednávky', 'error')
    } finally {
      setLoading(false)
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

  if (authLoading) return <div className="flex items-center justify-center h-64"><div className="animate-spin rounded-full h-8 w-8 border-b-2 border-purple-600"></div></div>
  if (!hasAccess) return <div className="flex items-center justify-center h-64"><p className="text-gray-500">Nemáte prístup.</p></div>

  return (
    <div className="space-y-6">
      <div className="flex flex-col gap-4 lg:flex-row lg:items-end lg:justify-between">
        <div>
          <p className="text-sm font-semibold uppercase tracking-[0.18em] text-yellow-600">Vavrostav</p>
          <h1 className="mt-1 text-3xl font-bold text-gray-950">Objednávky</h1>
        </div>
      </div>

      <div className="grid gap-4 md:grid-cols-2">
        <div className="rounded-3xl bg-white p-5 shadow-sm ring-1 ring-gray-100">
          <ShoppingBagIcon className="h-7 w-7 text-yellow-500" />
          <p className="mt-4 text-3xl font-bold text-gray-950">{stats.openOrders}</p>
          <p className="text-sm text-gray-500">Aktívne objednávky</p>
        </div>
        <div className="rounded-3xl bg-white p-5 shadow-sm ring-1 ring-gray-100">
          <CurrencyEuroIcon className="h-7 w-7 text-yellow-500" />
          <p className="mt-4 text-3xl font-bold text-gray-950">{formatPrice(stats.revenue)}</p>
          <p className="text-sm text-gray-500">Hodnota objednávok</p>
        </div>
      </div>

      {loading ? (
        <div className="rounded-3xl bg-white p-12 text-center text-gray-500 shadow-sm ring-1 ring-gray-100">
          Načítavam objednávky...
        </div>
      ) : (
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
                    <span className={`rounded-full px-3 py-1 text-xs font-bold uppercase ${order.payment_status === 'paid' ? 'bg-green-100 text-green-800' : 'bg-yellow-100 text-yellow-800'}`}>
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
      )}
    </div>
  )
}
