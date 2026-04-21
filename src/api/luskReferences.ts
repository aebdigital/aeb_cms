import { supabase } from '../lib/supabaseClient'
import { STORAGE_BUCKET } from '../lib/constants'

export interface LuskReference {
  id: string
  site_id: string
  title: string
  image_url: string | null // Preview photo
  lightbox_url: string | null // Lightbox photo
  category: string
  display_order: number
  created_at: string
  updated_at: string
}

export type LuskReferenceUpsert = Omit<LuskReference, 'id' | 'created_at' | 'updated_at'>

export async function listLuskReferences(siteId: string, category?: string): Promise<LuskReference[]> {
  let query = supabase
    .from('lusk_references')
    .select('*')
    .eq('site_id', siteId)
    .order('display_order', { ascending: true })

  if (category && category !== 'all') {
    query = query.eq('category', category)
  }

  const { data, error } = await query
  if (error) throw error
  return (data ?? []) as LuskReference[]
}

export async function getLuskReference(id: string): Promise<LuskReference> {
  const { data, error } = await supabase
    .from('lusk_references')
    .select('*')
    .eq('id', id)
    .single()
  if (error) throw error
  return data as LuskReference
}

export async function createLuskReference(ref: LuskReferenceUpsert): Promise<LuskReference> {
  const { data, error } = await supabase
    .from('lusk_references')
    .insert(ref)
    .select()
    .single()
  if (error) throw error
  return data as LuskReference
}

export async function updateLuskReference(id: string, updates: Partial<LuskReferenceUpsert>): Promise<LuskReference> {
  const { data, error } = await supabase
    .from('lusk_references')
    .update({ ...updates, updated_at: new Date().toISOString() })
    .eq('id', id)
    .select()
    .single()
  if (error) throw error
  return data as LuskReference
}

export async function deleteLuskReference(id: string): Promise<void> {
  const { error } = await supabase
    .from('lusk_references')
    .delete()
    .eq('id', id)
  if (error) throw error
}

export async function reorderLuskReferences(reorders: { id: string; display_order: number }[]): Promise<void> {
  for (const item of reorders) {
    const { error } = await supabase
      .from('lusk_references')
      .update({ display_order: item.display_order })
      .eq('id', item.id)
    if (error) throw error
  }
}

export async function uploadLuskImage(file: File, siteSlug: string, type: 'preview' | 'lightbox'): Promise<string> {
  const ext = file.name.split('.').pop() || 'jpg'
  const path = `lusk/${siteSlug}/references/${type}-${Date.now()}.${ext}`
  
  const { error } = await supabase.storage
    .from(STORAGE_BUCKET)
    .upload(path, file, { upsert: true, cacheControl: '3600' })
  
  if (error) throw error
  
  const { data } = supabase.storage.from(STORAGE_BUCKET).getPublicUrl(path)
  return data.publicUrl
}
