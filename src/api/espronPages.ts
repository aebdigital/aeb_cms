import { supabase } from '../lib/supabaseClient'

export type PageFamily =
  | 'about'
  | 'contact'
  | 'service'
  | 'tepovanie'
  | 'insulation-main'
  | 'insulation-city'
  | 'insulation-case-study'
  | 'insulation-guide'
  | 'faq'
  | 'staffing'

export type ContentBlock =
  | { type: 'paragraphs'; title: string; paragraphs: string[] }
  | { type: 'facts'; title: string; items: Array<{ label: string; value: string }> }
  | { type: 'pairs'; title: string; items: Array<{ title: string; body: string }> }
  | { type: 'steps'; title: string; items: Array<{ title: string; body?: string; details?: string[] }> }
  | { type: 'faq'; title: string; items: Array<{ question: string; answer: string }> }

export type RelatedPage = { href: string; label: string }

export interface EspronPage {
  id: string
  path: string
  label: string
  eyebrow: string
  family: PageFamily
  title: string
  meta_title: string
  description: string
  hero_image: string | null
  gallery_images: string[]
  highlights: string[]
  blocks: ContentBlock[]
  related: RelatedPage[]
  lastmod: string | null
  is_published: boolean
  created_at: string
  updated_at: string
}

export type EspronPageInsert = Omit<EspronPage, 'id' | 'created_at' | 'updated_at'>

/** Shape that espron-next's SitePage type expects (for JSON export) */
export interface EspronSitePage {
  path: string
  label: string
  eyebrow: string
  family: PageFamily
  title: string
  metaTitle: string
  description: string
  lastmod: string
  heroImage?: string
  galleryImages: string[]
  highlights: string[]
  blocks: ContentBlock[]
  related: RelatedPage[]
}

export async function listEspronPages(): Promise<EspronPage[]> {
  const { data, error } = await supabase
    .from('espron_pages')
    .select('*')
    .order('created_at', { ascending: false })
  if (error) throw error
  return data as EspronPage[]
}

export async function getEspronPage(id: string): Promise<EspronPage> {
  const { data, error } = await supabase
    .from('espron_pages')
    .select('*')
    .eq('id', id)
    .single()
  if (error) throw error
  return data as EspronPage
}

export async function createEspronPage(page: Partial<EspronPageInsert>): Promise<EspronPage> {
  const { data, error } = await supabase
    .from('espron_pages')
    .insert(page)
    .select()
    .single()
  if (error) throw error
  return data as EspronPage
}

export async function updateEspronPage(id: string, updates: Partial<EspronPageInsert>): Promise<EspronPage> {
  const { data, error } = await supabase
    .from('espron_pages')
    .update(updates)
    .eq('id', id)
    .select()
    .single()
  if (error) throw error
  return data as EspronPage
}

export async function deleteEspronPage(id: string): Promise<void> {
  const { error } = await supabase
    .from('espron_pages')
    .delete()
    .eq('id', id)
  if (error) throw error
}

/** Convert a stored EspronPage to the export format that espron-next expects */
export function toSitePage(page: EspronPage): EspronSitePage {
  return {
    path: page.path,
    label: page.label,
    eyebrow: page.eyebrow,
    family: page.family,
    title: page.title,
    metaTitle: page.meta_title,
    description: page.description,
    lastmod: page.lastmod ?? new Date().toISOString().split('T')[0],
    ...(page.hero_image ? { heroImage: page.hero_image } : {}),
    galleryImages: page.gallery_images ?? [],
    highlights: page.highlights ?? [],
    blocks: page.blocks ?? [],
    related: page.related ?? [],
  }
}
