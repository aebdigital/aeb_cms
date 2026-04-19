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

// Upload a PDF/file for a car
export interface UploadCarPdfOptions {
  file: File
  siteSlug: string
  carId: string
  pdfType: 'service-book' | 'cebia-protocol' | 'additional'
}

export async function uploadCarPdf(options: UploadCarPdfOptions): Promise<{ path: string }> {
  const { file, siteSlug, carId, pdfType } = options

  let fileName = `${pdfType}.pdf`
  
  if (pdfType === 'additional') {
    const ext = getFileExtension(file)
    fileName = `file-${generateUUID()}.${ext}`
  }

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
// Upload a blog image
export interface UploadBlogImageOptions {
  file: File
  siteSlug: string
  blogId?: string // Optional if we don't have it yet
}

export async function uploadBlogImage(options: UploadBlogImageOptions): Promise<{ path: string }> {
  const { file, siteSlug, blogId } = options

  const ext = getFileExtension(file)
  const fileName = `blog-${generateUUID()}.${ext}`
  const path = blogId
    ? `${siteSlug}/blogs/${blogId}/${fileName}`
    : `${siteSlug}/blogs/temp/${fileName}`

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

// Upload a project image
export interface UploadProjectImageOptions {
  file: File
  siteSlug: string
  projectId?: string
}

export async function uploadProjectImage(options: UploadProjectImageOptions): Promise<{ path: string }> {
  const { file, siteSlug, projectId } = options

  const ext = getFileExtension(file)
  const fileName = `project-${generateUUID()}.${ext}`
  const path = projectId
    ? `${siteSlug}/projects/${projectId}/${fileName}`
    : `${siteSlug}/projects/temp/${fileName}`

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

// Upload an ecommerce product image
export interface UploadProductImageOptions {
  file: File
  ownerSlug: string
  productId?: string
}

export async function uploadProductImage(options: UploadProductImageOptions): Promise<{ path: string }> {
  const { file, ownerSlug, productId } = options

  const ext = getFileExtension(file)
  const fileName = `product-${generateUUID()}.${ext}`
  const path = productId
    ? `${ownerSlug}/products/${productId}/${fileName}`
    : `${ownerSlug}/products/temp/${fileName}`

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
