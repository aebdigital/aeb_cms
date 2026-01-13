import { supabase } from '../lib/supabaseClient'

export type GalleryCategory = 'skola-ludus' | 'ludus-academy' | 'divadlo-ludus' | 'ludus-tabor'

export interface GalleryImage {
  id: string
  site_id: string
  category: GalleryCategory
  image_path: string
  alt_text: string | null
  display_order: number
  created_at: string
  updated_at: string
}

export const GALLERY_CATEGORIES: { value: GalleryCategory; label: string }[] = [
  { value: 'skola-ludus', label: 'Skola Ludus' },
  { value: 'ludus-academy', label: 'Ludus Academy' },
  { value: 'divadlo-ludus', label: 'Divadlo Ludus' },
  { value: 'ludus-tabor', label: 'Ludus Tabor' },
]

export async function getGalleryImages(siteId: string, category?: GalleryCategory): Promise<GalleryImage[]> {
  let query = supabase
    .from('gallery_images')
    .select('*')
    .eq('site_id', siteId)
    .order('display_order', { ascending: true })

  if (category) {
    query = query.eq('category', category)
  }

  const { data, error } = await query
  if (error) throw error
  return data as GalleryImage[]
}

export async function createGalleryImage(image: Omit<GalleryImage, 'id' | 'created_at' | 'updated_at'>): Promise<GalleryImage> {
  const { data, error } = await supabase
    .from('gallery_images')
    .insert(image)
    .select()
    .single()

  if (error) throw error
  return data as GalleryImage
}

export async function updateGalleryImage(id: string, updates: Partial<GalleryImage>): Promise<GalleryImage> {
  const { data, error } = await supabase
    .from('gallery_images')
    .update({ ...updates, updated_at: new Date().toISOString() })
    .eq('id', id)
    .select()
    .single()

  if (error) throw error
  return data as GalleryImage
}

export async function deleteGalleryImage(id: string): Promise<void> {
  const { error } = await supabase
    .from('gallery_images')
    .delete()
    .eq('id', id)

  if (error) throw error
}

export async function reorderGalleryImages(images: { id: string; display_order: number }[]): Promise<void> {
  for (const img of images) {
    const { error } = await supabase
      .from('gallery_images')
      .update({ display_order: img.display_order })
      .eq('id', img.id)

    if (error) throw error
  }
}
