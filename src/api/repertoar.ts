import { supabase } from '../lib/supabaseClient'

export interface RepertoarItem {
  id: string
  site_id: string
  program_title: string
  slug: string
  subtitle: string | null
  category: string | null
  year: string | null
  venue: string | null
  image_path: string | null
  gallery_paths: string[]
  display_order: number
  created_at: string
  updated_at: string
}

export async function getRepertoarItems(siteId: string): Promise<RepertoarItem[]> {
  const { data, error } = await supabase
    .from('repertoar')
    .select('*')
    .eq('site_id', siteId)
    .order('display_order', { ascending: true })

  if (error) throw error
  return data as RepertoarItem[]
}

export async function createRepertoarItem(
  item: Omit<RepertoarItem, 'id' | 'created_at' | 'updated_at'>
): Promise<RepertoarItem> {
  const { data, error } = await supabase
    .from('repertoar')
    .insert(item)
    .select()
    .single()

  if (error) throw error
  return data as RepertoarItem
}

export async function updateRepertoarItem(
  id: string,
  updates: Partial<RepertoarItem>
): Promise<RepertoarItem> {
  const { data, error } = await supabase
    .from('repertoar')
    .update({ ...updates, updated_at: new Date().toISOString() })
    .eq('id', id)
    .select()
    .single()

  if (error) throw error
  return data as RepertoarItem
}

export async function deleteRepertoarItem(id: string): Promise<void> {
  const { error } = await supabase
    .from('repertoar')
    .delete()
    .eq('id', id)

  if (error) throw error
}
