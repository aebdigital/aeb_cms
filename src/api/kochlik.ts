import { supabase } from '../lib/supabaseClient'

export const KOCHLIK_OWNER_ID = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'
export const KOCHLIK_OWNER_EMAIL = 'info@kochlik.eu'
export const KOCHLIK_SITE_SLUG = 'kochlik'

export type KochlikCategory = {
  id: string
  owner_id: string
  name: string
  slug: string
  description: string | null
  sort_order: number
  is_active: boolean
  created_at: string
  updated_at: string
}

export type KochlikColorOption = {
  name: string
  family?: string
  hex?: string
  image_url?: string
}

export type KochlikVariation = {
  label?: string
  sku?: string
  dimensions?: string
  price?: string
  price_cents?: number | null
}

export type KochlikSpecification = {
  key: string
  value: string
}

export type KochlikDownloadFile = {
  label: string
  url: string
}

export type KochlikProduct = {
  id: string
  owner_id: string
  category_id: string | null
  name: string
  slug: string
  sku: string | null
  brand: string | null
  price_text: string | null
  price_cents: number | null
  currency: string
  short_description: string | null
  description: string | null
  main_image_url: string | null
  gallery_images: string[]
  color_options: KochlikColorOption[]
  color_families: string[]
  dimensions: string[]
  dimension_groups: string[]
  variations: KochlikVariation[]
  specifications: KochlikSpecification[]
  download_files: KochlikDownloadFile[]
  supplier_url: string | null
  source_url: string | null
  is_featured: boolean
  is_active: boolean
  sort_order: number
  seo_title: string | null
  seo_description: string | null
  created_at: string
  updated_at: string
  kochlik_categories?: Pick<KochlikCategory, 'id' | 'name' | 'slug'>
}

export async function listKochlikCategories(
  ownerId = KOCHLIK_OWNER_ID
): Promise<KochlikCategory[]> {
  const { data, error } = await supabase
    .from('kochlik_categories')
    .select('*')
    .eq('owner_id', ownerId)
    .order('sort_order', { ascending: true })
    .order('name', { ascending: true })

  if (error) throw error
  return data || []
}

export async function triggerRevalidation(): Promise<void> {
  const secret = 'kochlik_reval_sec_f982ea1d09e083c2'
  const isLocal = typeof window !== 'undefined' && 
    (window.location.hostname === 'localhost' || window.location.hostname === '127.0.0.1')
  
  const baseUrl = isLocal ? 'http://localhost:3006' : 'https://kochlik.sk'
  
  try {
    const res = await fetch(`${baseUrl}/api/revalidate?secret=${secret}`, {
      method: 'POST',
    })
    if (!res.ok) {
      console.warn('Revalidation failed:', await res.text())
    }
  } catch (err) {
    console.warn('Revalidation error:', err)
  }
}

export async function createKochlikCategory(
  category: Partial<KochlikCategory>
): Promise<KochlikCategory> {
  const { data, error } = await supabase
    .from('kochlik_categories')
    .insert([{ ...category, owner_id: KOCHLIK_OWNER_ID }])
    .select()
    .single()

  if (error) throw error
  triggerRevalidation().catch(console.error)
  return data
}

export async function updateKochlikCategory(
  id: string,
  category: Partial<KochlikCategory>
): Promise<KochlikCategory> {
  const { data, error } = await supabase
    .from('kochlik_categories')
    .update({ ...category, updated_at: new Date().toISOString() })
    .eq('id', id)
    .eq('owner_id', KOCHLIK_OWNER_ID)
    .select()
    .single()

  if (error) throw error
  triggerRevalidation().catch(console.error)
  return data
}

export async function deleteKochlikCategory(id: string): Promise<void> {
  const { error } = await supabase
    .from('kochlik_categories')
    .delete()
    .eq('id', id)
    .eq('owner_id', KOCHLIK_OWNER_ID)

  if (error) throw error
  triggerRevalidation().catch(console.error)
}

export async function listKochlikProducts(
  ownerId = KOCHLIK_OWNER_ID
): Promise<KochlikProduct[]> {
  const { data, error } = await supabase
    .from('kochlik_products')
    .select('*, kochlik_categories(id, name, slug)')
    .eq('owner_id', ownerId)
    .order('sort_order', { ascending: true })
    .order('name', { ascending: true })

  if (error) throw error
  return data || []
}

export async function createKochlikProduct(
  product: Partial<KochlikProduct>
): Promise<KochlikProduct> {
  const { data, error } = await supabase
    .from('kochlik_products')
    .insert([{ ...product, owner_id: KOCHLIK_OWNER_ID }])
    .select('*, kochlik_categories(id, name, slug)')
    .single()

  if (error) throw error
  triggerRevalidation().catch(console.error)
  return data
}

export async function updateKochlikProduct(
  id: string,
  product: Partial<KochlikProduct>
): Promise<KochlikProduct> {
  const { data, error } = await supabase
    .from('kochlik_products')
    .update({ ...product, updated_at: new Date().toISOString() })
    .eq('id', id)
    .eq('owner_id', KOCHLIK_OWNER_ID)
    .select('*, kochlik_categories(id, name, slug)')
    .single()

  if (error) throw error
  triggerRevalidation().catch(console.error)
  return data
}

export async function deleteKochlikProduct(id: string): Promise<void> {
  const { error } = await supabase
    .from('kochlik_products')
    .delete()
    .eq('id', id)
    .eq('owner_id', KOCHLIK_OWNER_ID)

  if (error) throw error
  triggerRevalidation().catch(console.error)
}

export async function updateKochlikProductsOrder(
  products: { id: string; sort_order: number }[]
): Promise<void> {
  const promises = products.map(p =>
    supabase
      .from('kochlik_products')
      .update({ sort_order: p.sort_order, updated_at: new Date().toISOString() })
      .eq('id', p.id)
      .eq('owner_id', KOCHLIK_OWNER_ID)
  )

  const results = await Promise.all(promises)
  const failed = results.find(r => r.error)
  if (failed && failed.error) {
    throw failed.error
  }
  triggerRevalidation().catch(console.error)
}
