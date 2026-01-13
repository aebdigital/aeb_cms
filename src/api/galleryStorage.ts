import { supabase } from '../lib/supabaseClient'
import { STORAGE_BUCKET } from '../lib/constants'
import { getFileExtension, generateUUID } from '../lib/fileUtils'

export interface UploadGalleryImageOptions {
  file: File
  siteSlug: string
  category: string
}

export async function uploadGalleryImage(options: UploadGalleryImageOptions): Promise<{ path: string }> {
  const { file, siteSlug, category } = options

  const ext = getFileExtension(file)
  const fileName = `${generateUUID()}.${ext}`
  const path = `${siteSlug}/gallery/${category}/${fileName}`

  const { error } = await supabase.storage
    .from(STORAGE_BUCKET)
    .upload(path, file, {
      upsert: false,
      cacheControl: '3600',
    })

  if (error) throw error
  return { path }
}

export async function deleteGalleryImageFromStorage(path: string): Promise<void> {
  const { error } = await supabase.storage
    .from(STORAGE_BUCKET)
    .remove([path])

  if (error) throw error
}

export function getGalleryImagePublicUrl(path: string): string {
  const { data } = supabase.storage
    .from(STORAGE_BUCKET)
    .getPublicUrl(path)

  return data.publicUrl
}
