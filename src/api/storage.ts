import { supabase } from '../lib/supabaseClient'
import { STORAGE_BUCKET } from '../lib/constants'
import { getFileExtension, generateUUID } from '../lib/fileUtils'

export interface UploadCarImageOptions {
  file: File
  siteSlug: string
  carId: string
  isMain?: boolean
}

export async function uploadCarImage(options: UploadCarImageOptions): Promise<{ path: string }> {
  const { file, siteSlug, carId, isMain } = options

  const ext = getFileExtension(file)
  const fileName = isMain
    ? `main.${ext}`
    : `gallery-${generateUUID()}.${ext}`

  const path = `${siteSlug}/cars/${carId}/${fileName}`

  const { error } = await supabase.storage
    .from(STORAGE_BUCKET)
    .upload(path, file, {
      upsert: true,
      cacheControl: '3600',
    })

  if (error) {
    throw error
  }

  return { path }
}

export async function deleteCarImageFromStorage(path: string): Promise<void> {
  const { error } = await supabase.storage
    .from(STORAGE_BUCKET)
    .remove([path])

  if (error) throw error
}

export function getPublicUrl(path: string): string {
  const { data } = supabase.storage
    .from(STORAGE_BUCKET)
    .getPublicUrl(path)

  return data.publicUrl
}

// Delete all images for a car (when deleting the car)
export async function deleteAllCarImages(siteSlug: string, carId: string): Promise<void> {
  const folderPath = `${siteSlug}/cars/${carId}`

  // List all files in the car's folder
  const { data: files, error: listError } = await supabase.storage
    .from(STORAGE_BUCKET)
    .list(folderPath)

  if (listError) throw listError

  if (files && files.length > 0) {
    const filePaths = files.map(f => `${folderPath}/${f.name}`)

    const { error: deleteError } = await supabase.storage
      .from(STORAGE_BUCKET)
      .remove(filePaths)

    if (deleteError) throw deleteError
  }
}
