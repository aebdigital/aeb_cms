import { supabase } from '../lib/supabaseClient'
import { STORAGE_BUCKET } from '../lib/constants'

export interface MediaAsset {
  id: string
  site_id: string
  bucket: string
  path: string
  alt: string
  metadata: Record<string, any>
  created_at: string
  updated_at: string
}

export async function createMediaAsset(options: {
  siteId: string
  path: string
  alt?: string
}): Promise<{ id: string }> {
  const { siteId, path, alt } = options

  const { data, error } = await supabase
    .from('media_assets')
    .insert({
      site_id: siteId,
      bucket: STORAGE_BUCKET,
      path,
      alt: alt ?? '',
      metadata: {},
    })
    .select('id')
    .single()

  if (error) throw error
  return { id: data.id as string }
}

export async function deleteMediaAssetByPath(path: string): Promise<void> {
  const { error } = await supabase
    .from('media_assets')
    .delete()
    .eq('path', path)

  if (error) throw error
}

export async function deleteMediaAssetsByCarId(siteId: string, carId: string, siteSlug: string): Promise<void> {
  // Delete all media assets that match the car's folder path pattern
  const pathPattern = `${siteSlug}/cars/${carId}/%`

  const { error } = await supabase
    .from('media_assets')
    .delete()
    .eq('site_id', siteId)
    .like('path', pathPattern)

  if (error) throw error
}

export async function getMediaAssetByPath(path: string): Promise<MediaAsset | null> {
  const { data, error } = await supabase
    .from('media_assets')
    .select('*')
    .eq('path', path)
    .single()

  if (error) {
    if (error.code === 'PGRST116') return null // Not found
    throw error
  }

  return data as MediaAsset
}
