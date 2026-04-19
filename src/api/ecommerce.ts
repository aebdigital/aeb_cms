import { supabase } from '../lib/supabaseClient'

export const VAVROSTAV_OWNER_ID = '9083c583-0fcf-483d-b3f1-ba435287ec04'

export type EcommerceProduct = {
  id: string
  owner_id: string
  name: string
  slug: string
  sku: string | null
  description: string | null
  image_url: string | null
  price_cents: number
  currency: string
  stock_quantity: number
  is_active: boolean
  created_at: string
  updated_at: string
}

export type EcommerceOrderItem = {
  id: string
  order_id: string
  product_id: string | null
  product_name: string
  unit_price_cents: number
  quantity: number
  line_total_cents: number
}

export type EcommerceOrder = {
  id: string
  owner_id: string
  customer_name: string
  customer_email: string
  customer_phone: string | null
  customer_address: string | null
  notes: string | null
  status: string
  payment_status: string
  total_cents: number
  currency: string
  created_at: string
  updated_at: string
  ecommerce_order_items?: EcommerceOrderItem[]
}

export async function listEcommerceProducts(ownerId = VAVROSTAV_OWNER_ID): Promise<EcommerceProduct[]> {
  const { data, error } = await supabase
    .from('ecommerce_products')
    .select('*')
    .eq('owner_id', ownerId)
    .order('created_at', { ascending: false })

  if (error) throw error
  return data || []
}

export async function createEcommerceProduct(product: Partial<EcommerceProduct>): Promise<EcommerceProduct> {
  const { data, error } = await supabase
    .from('ecommerce_products')
    .insert([{ ...product, owner_id: VAVROSTAV_OWNER_ID }])
    .select()
    .single()

  if (error) throw error
  return data
}

export async function updateEcommerceProduct(id: string, product: Partial<EcommerceProduct>): Promise<EcommerceProduct> {
  const { data, error } = await supabase
    .from('ecommerce_products')
    .update({ ...product, updated_at: new Date().toISOString() })
    .eq('id', id)
    .eq('owner_id', VAVROSTAV_OWNER_ID)
    .select()
    .single()

  if (error) throw error
  return data
}

export async function deleteEcommerceProduct(id: string): Promise<void> {
  const { error } = await supabase
    .from('ecommerce_products')
    .delete()
    .eq('id', id)
    .eq('owner_id', VAVROSTAV_OWNER_ID)

  if (error) throw error
}

export async function listEcommerceOrders(ownerId = VAVROSTAV_OWNER_ID): Promise<EcommerceOrder[]> {
  const { data, error } = await supabase
    .from('ecommerce_orders')
    .select('*, ecommerce_order_items(*)')
    .eq('owner_id', ownerId)
    .order('created_at', { ascending: false })

  if (error) throw error
  return data || []
}

export async function updateEcommerceOrderStatus(id: string, status: string): Promise<EcommerceOrder> {
  const { data, error } = await supabase
    .from('ecommerce_orders')
    .update({ status, updated_at: new Date().toISOString() })
    .eq('id', id)
    .eq('owner_id', VAVROSTAV_OWNER_ID)
    .select('*, ecommerce_order_items(*)')
    .single()

  if (error) throw error
  return data
}
