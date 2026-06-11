import { supabase } from '../lib/supabaseClient'

export const FIDOHOME_OWNER_EMAIL = 'info@fidohome.sk'
export const FIDOHOME_ADMIN_EMAIL = 'alexander.hidveghy@gmail.com'
export const FIDOHOME_SITE_SLUG = 'fidohome'

export type FidohomeCategory = {
  id: string
  slug: string
  label: string
  description: string | null
  image_url: string | null
  sort_order: number
  is_active: boolean
  created_at: string
  updated_at: string
}

export type FidohomeProduct = {
  id: string
  category_id: string | null
  slug: string
  name: string
  subcategory: string | null
  price_cents: number
  original_price_cents: number | null
  currency: string
  lead: string | null
  description: string | null
  specs: string[]
  preview_url: string | null
  detail_url: string | null
  gallery_images: string[]
  is_featured: boolean
  is_active: boolean
  sort_order: number
  seo_title: string | null
  seo_description: string | null
  created_at: string
  updated_at: string
  fidohome_categories?: Pick<FidohomeCategory, 'id' | 'label' | 'slug'>
}

const productSelect = '*, fidohome_categories(id, label, slug)'

export async function listFidohomeCategories(): Promise<FidohomeCategory[]> {
  const { data, error } = await supabase
    .from('fidohome_categories')
    .select('*')
    .order('sort_order', { ascending: true })
    .order('label', { ascending: true })

  if (error) throw error
  return data || []
}

export async function createFidohomeCategory(category: Partial<FidohomeCategory>): Promise<FidohomeCategory> {
  const { data, error } = await supabase
    .from('fidohome_categories')
    .insert([category])
    .select()
    .single()

  if (error) throw error
  return data
}

export async function updateFidohomeCategory(
  id: string,
  category: Partial<FidohomeCategory>
): Promise<FidohomeCategory> {
  const { data, error } = await supabase
    .from('fidohome_categories')
    .update({ ...category, updated_at: new Date().toISOString() })
    .eq('id', id)
    .select()
    .single()

  if (error) throw error
  return data
}

export async function deleteFidohomeCategory(id: string): Promise<void> {
  const { error } = await supabase
    .from('fidohome_categories')
    .delete()
    .eq('id', id)

  if (error) throw error
}

export async function listFidohomeProducts(): Promise<FidohomeProduct[]> {
  const { data, error } = await supabase
    .from('fidohome_products')
    .select(productSelect)
    .order('sort_order', { ascending: true })
    .order('name', { ascending: true })

  if (error) throw error
  return data || []
}

export async function createFidohomeProduct(product: Partial<FidohomeProduct>): Promise<FidohomeProduct> {
  const { data, error } = await supabase
    .from('fidohome_products')
    .insert([product])
    .select(productSelect)
    .single()

  if (error) throw error
  return data
}

export async function updateFidohomeProduct(
  id: string,
  product: Partial<FidohomeProduct>
): Promise<FidohomeProduct> {
  const { data, error } = await supabase
    .from('fidohome_products')
    .update({ ...product, updated_at: new Date().toISOString() })
    .eq('id', id)
    .select(productSelect)
    .single()

  if (error) throw error
  return data
}

export async function deleteFidohomeProduct(id: string): Promise<void> {
  const { error } = await supabase
    .from('fidohome_products')
    .delete()
    .eq('id', id)

  if (error) throw error
}

export async function updateFidohomeProductsOrder(
  products: { id: string; sort_order: number }[]
): Promise<void> {
  const results = await Promise.all(products.map(product =>
    supabase
      .from('fidohome_products')
      .update({ sort_order: product.sort_order, updated_at: new Date().toISOString() })
      .eq('id', product.id)
  ))

  const failed = results.find(result => result.error)
  if (failed?.error) throw failed.error
}
