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
  
  if (isHeic) {
    // Use Supabase Image Transformation for HEIC files
    // Format: [supabaseUrl]/storage/v1/render/image/public/[bucket]/[path]?format=auto
    // We add a large default width to ensure transformation triggers (some projects require it)
    return `${supabaseUrl}/storage/v1/render/image/public/${STORAGE_BUCKET}/${path}?width=2000&format=auto`
  }
  
  // Standard public URL
  // Format: [supabaseUrl]/storage/v1/object/public/[bucket]/[path]
  return `${supabaseUrl}/storage/v1/object/public/${STORAGE_BUCKET}/${path}`
}
