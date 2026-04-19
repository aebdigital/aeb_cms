import { supabase } from '../lib/supabaseClient'
import { STORAGE_BUCKET } from '../lib/constants'
import { compressImage, generateUUID, getFileExtension } from '../lib/fileUtils'

export type EspronVisualSite = 'sk' | 'cz'

export async function uploadBuilderImage(file: File): Promise<string> {
  const compressed = await compressImage(file, 800, 2400, 1600)
  const ext = getFileExtension(compressed)
  const path = `espron/visual-builder/${generateUUID()}.${ext}`
  const { error } = await supabase.storage
    .from(STORAGE_BUCKET)
    .upload(path, compressed, { upsert: false, cacheControl: '3600' })
  if (error) throw error
  const { data } = supabase.storage.from(STORAGE_BUCKET).getPublicUrl(path)
  return data.publicUrl
}

export interface VisualElement {
  id: string
  type: string
  content?: string
  src?: string
  alt?: string
  level?: string
  children?: VisualElement[]
  style?: Record<string, string>
}

export interface VisualPage {
  id: string
  site: EspronVisualSite
  slug: string
  title: string
  elements: VisualElement[]
  is_published: boolean
  created_at: string
  updated_at: string
}

export type VisualPageUpsert = {
  id?: string
  site?: EspronVisualSite
  slug: string
  title: string
  elements: VisualElement[]
  is_published?: boolean
}

function normalizeVisualPage(page: Record<string, unknown>): VisualPage {
  return {
    ...page,
    site: (page.site ?? 'sk') as EspronVisualSite,
  } as VisualPage
}

export async function listVisualPages(): Promise<VisualPage[]> {
  const { data, error } = await supabase
    .from('espron_visual_pages')
    .select('*')
    .order('updated_at', { ascending: false })
  if (error) throw error
  return (data ?? []).map(normalizeVisualPage)
}

export async function getVisualPage(id: string): Promise<VisualPage> {
  const { data, error } = await supabase
    .from('espron_visual_pages')
    .select('*')
    .eq('id', id)
    .single()
  if (error) throw error
  return normalizeVisualPage(data)
}

export async function getVisualPageBySlug(
  slug: string,
  site: EspronVisualSite = 'sk',
): Promise<VisualPage | null> {
  const { data, error } = await supabase
    .from('espron_visual_pages')
    .select('*')
    .eq('site', site)
    .eq('slug', slug)
    .maybeSingle()
  if (error) throw error
  return data ? normalizeVisualPage(data) : null
}

export async function createVisualPage(page: VisualPageUpsert): Promise<VisualPage> {
  const { data, error } = await supabase
    .from('espron_visual_pages')
    .insert({
      site: page.site ?? 'sk',
      slug: page.slug,
      title: page.title,
      elements: page.elements,
      is_published: page.is_published ?? false,
    })
    .select()
    .single()
  if (error) throw error
  return normalizeVisualPage(data)
}

export async function updateVisualPage(id: string, updates: Partial<VisualPageUpsert>): Promise<VisualPage> {
  const { data, error } = await supabase
    .from('espron_visual_pages')
    .update(updates)
    .eq('id', id)
    .select()
    .single()
  if (error) throw error
  return normalizeVisualPage(data)
}

export async function deleteVisualPage(id: string): Promise<void> {
  const { error } = await supabase
    .from('espron_visual_pages')
    .delete()
    .eq('id', id)
  if (error) throw error
}

export async function togglePublishVisualPage(id: string, published: boolean): Promise<VisualPage> {
  return updateVisualPage(id, { is_published: published })
}
