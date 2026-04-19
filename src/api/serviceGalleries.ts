import { supabase } from '../lib/supabaseClient'
import { STORAGE_BUCKET } from '../lib/constants'
import { getFileExtension, generateUUID } from '../lib/fileUtils'

export type EspronSite = 'sk' | 'cz'

export interface ServiceGalleryItem {
  id: string
  service_slug: string
  site: EspronSite
  image_url: string
  alt: string
  caption: string
  kind: 'image' | 'video'
  sort_order: number
  is_published: boolean
  created_at: string
  updated_at: string
}

export type ServiceDef = {
  slug: string
  label: string
  group: 'stavebne' | 'cistiace' | 'interier'
  sites: EspronSite[]
}

export const ESPRON_SERVICES: ServiceDef[] = [
  { slug: 'zateplenie-fasady', label: 'Zateplenie fasády', group: 'stavebne', sites: ['sk', 'cz'] },
  { slug: 'sadrokartonove-prace', label: 'Sadrokartónové práce', group: 'stavebne', sites: ['sk'] },
  { slug: 'rucne-omietky', label: 'Ručné omietky', group: 'stavebne', sites: ['sk'] },
  { slug: 'zakladove-dosky', label: 'Základové dosky', group: 'stavebne', sites: ['cz'] },
  { slug: 'cistenie-fasady', label: 'Čistenie fasády', group: 'cistiace', sites: ['sk', 'cz'] },
  { slug: 'cistenie-dlazby', label: 'Čistenie dlažby', group: 'cistiace', sites: ['sk'] },
  { slug: 'tepovanie', label: 'Tepovanie', group: 'cistiace', sites: ['sk'] },
  { slug: 'interierovy-dizajn', label: 'Interiérový dizajn', group: 'interier', sites: ['sk', 'cz'] },
]

export function getServicesForSite(site: EspronSite): ServiceDef[] {
  return ESPRON_SERVICES.filter((s) => s.sites.includes(site))
}

export async function listServiceGallery(
  site: EspronSite,
  serviceSlug: string,
): Promise<ServiceGalleryItem[]> {
  const { data, error } = await supabase
    .from('espron_service_galleries')
    .select('*')
    .eq('site', site)
    .eq('service_slug', serviceSlug)
    .order('sort_order', { ascending: true })
  if (error) throw error
  return (data ?? []) as ServiceGalleryItem[]
}

export async function createServiceGalleryItem(
  item: Omit<ServiceGalleryItem, 'id' | 'created_at' | 'updated_at'>,
): Promise<ServiceGalleryItem> {
  const { data, error } = await supabase
    .from('espron_service_galleries')
    .insert(item)
    .select()
    .single()
  if (error) throw error
  return data as ServiceGalleryItem
}

export async function updateServiceGalleryItem(
  id: string,
  updates: Partial<Omit<ServiceGalleryItem, 'id' | 'created_at' | 'updated_at'>>,
): Promise<ServiceGalleryItem> {
  const { data, error } = await supabase
    .from('espron_service_galleries')
    .update(updates)
    .eq('id', id)
    .select()
    .single()
  if (error) throw error
  return data as ServiceGalleryItem
}

export async function deleteServiceGalleryItem(id: string): Promise<void> {
  const { error } = await supabase
    .from('espron_service_galleries')
    .delete()
    .eq('id', id)
  if (error) throw error
}

export async function reorderServiceGallery(
  ordered: { id: string; sort_order: number }[],
): Promise<void> {
  for (const row of ordered) {
    const { error } = await supabase
      .from('espron_service_galleries')
      .update({ sort_order: row.sort_order })
      .eq('id', row.id)
    if (error) throw error
  }
}

export async function uploadServicePhoto(
  file: File,
  site: EspronSite,
  serviceSlug: string,
): Promise<string> {
  const ext = getFileExtension(file)
  const path = `espron-${site}/services/${serviceSlug}/${generateUUID()}.${ext}`
  const { error } = await supabase.storage
    .from(STORAGE_BUCKET)
    .upload(path, file, { upsert: false, cacheControl: '3600' })
  if (error) throw error
  const { data } = supabase.storage.from(STORAGE_BUCKET).getPublicUrl(path)
  return data.publicUrl
}
