import { supabaseUrl } from './supabaseClient'
import { STORAGE_BUCKET } from './constants'

/**
 * Generates a public URL for a file in Supabase storage.
 * Automatically handles HEIC/HEIF files by using Supabase Image Transformation
 * to serve them as JPEGs, ensuring they are viewable in all browsers.
 */
export function getStoragePublicUrl(path: string): string {
  if (!path) return ''
  
  const ext = path.split('.').pop()?.toLowerCase()
  const isHeic = ext === 'heic' || ext === 'heif'
  
  let url: string
  if (isHeic) {
    // Use Supabase Image Transformation for HEIC files
    // Force JPG format to ensure browser compatibility
    url = `${supabaseUrl}/storage/v1/render/image/public/${STORAGE_BUCKET}/${path}?width=2000&format=jpg`
  } else {
    // Standard public URL
    url = `${supabaseUrl}/storage/v1/object/public/${STORAGE_BUCKET}/${path}`
  }
  
  console.log(`Image URL [${isHeic ? 'TRANSFORMED' : 'STANDARD'}]:`, url)
  return url
}
