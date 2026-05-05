import { supabase } from '../lib/supabaseClient'
import { VAVROSTAV_OWNER_ID } from './ecommerce'

export type EcommerceCategory = {
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

export async function listEcommerceCategories(
  ownerId = VAVROSTAV_OWNER_ID
): Promise<EcommerceCategory[]> {
  const { data, error } = await supabase
    .from('ecommerce_categories')
    .select('*')
    .eq('owner_id', ownerId)
    .order('sort_order', { ascending: true })

  if (error) throw error
  return data || []
}

export async function createEcommerceCategory(
  category: Partial<EcommerceCategory>
): Promise<EcommerceCategory> {
  const { data, error } = await supabase
    .from('ecommerce_categories')
    .insert([{ ...category, owner_id: VAVROSTAV_OWNER_ID }])
    .select()
    .single()

  if (error) throw error
  return data
}

export async function updateEcommerceCategory(
  id: string,
  category: Partial<EcommerceCategory>
): Promise<EcommerceCategory> {
  const { data, error } = await supabase
    .from('ecommerce_categories')
    .update({ ...category, updated_at: new Date().toISOString() })
    .eq('id', id)
    .eq('owner_id', VAVROSTAV_OWNER_ID)
    .select()
    .single()

  if (error) throw error
  return data
}

export async function deleteEcommerceCategory(id: string): Promise<void> {
  const { error } = await supabase
    .from('ecommerce_categories')
    .delete()
    .eq('id', id)
    .eq('owner_id', VAVROSTAV_OWNER_ID)

  if (error) throw error
}
