import { supabase } from '../lib/supabaseClient'
import { uploadCarImage, deleteCarImageFromStorage, deleteAllCarImages } from './storage'
import { createMediaAsset, deleteMediaAssetByPath, deleteMediaAssetsByCarId } from './mediaAssets'

export interface SetCarMainImageOptions {
  file: File
  siteId: string
  siteSlug: string
  carId: string
  alt?: string
}

export async function setCarMainImage(options: SetCarMainImageOptions): Promise<{ path: string; mediaId: string }> {
  const { file, siteId, siteSlug, carId, alt } = options

  // 1) Upload file to storage
  const { path } = await uploadCarImage({
    file,
    siteSlug,
    carId,
    isMain: true,
  })

  // 2) Create media asset entry
  const { id: mediaId } = await createMediaAsset({
    siteId,
    path,
    alt,
  })

  // 3) Update car's main image path
  const { error } = await supabase
    .from('cars')
    .update({ image: path })
    .eq('id', carId)

  if (error) throw error

  return { path, mediaId }
}

export interface AddCarGalleryImageOptions {
  file: File
  siteId: string
  siteSlug: string
  carId: string
  alt?: string
}

// Upload image only (without modifying car record) - useful when setting order manually
export async function uploadCarImageOnly(options: AddCarGalleryImageOptions): Promise<{ path: string; mediaId: string }> {
  const { file, siteId, siteSlug, carId, alt } = options

  // 1) Upload
  const { path } = await uploadCarImage({
    file,
    siteSlug,
    carId,
    isMain: false,
  })

  // 2) Media asset row
  const { id: mediaId } = await createMediaAsset({
    siteId,
    path,
    alt,
  })

  return { path, mediaId }
}

export async function addCarGalleryImage(options: AddCarGalleryImageOptions): Promise<{ path: string; mediaId: string }> {
  const { file, siteId, siteSlug, carId, alt } = options

  // 1) Upload
  const { path } = await uploadCarImage({
    file,
    siteSlug,
    carId,
    isMain: false,
  })

  // 2) Media asset row
  const { id: mediaId } = await createMediaAsset({
    siteId,
    path,
    alt,
  })

  // 3) Push into cars.images array
  const { data: car, error: carError } = await supabase
    .from('cars')
    .select('images')
    .eq('id', carId)
    .single()

  if (carError) throw carError

  const currentImages: string[] = car.images ?? []
  const newImages = [...currentImages, path]

  const { error: updateError } = await supabase
    .from('cars')
    .update({ images: newImages })
    .eq('id', carId)

  if (updateError) throw updateError

  return { path, mediaId }
}

export async function deleteCarMainImage(carId: string): Promise<void> {
  // 1) Get current main image path
  const { data: car, error: carError } = await supabase
    .from('cars')
    .select('image')
    .eq('id', carId)
    .single()

  if (carError) throw carError

  const path = car.image as string | null
  if (!path) return

  // 2) Delete from storage
  await deleteCarImageFromStorage(path)

  // 3) Delete media_assets row
  await deleteMediaAssetByPath(path)

  // 4) Clear field on car
  const { error: updateError } = await supabase
    .from('cars')
    .update({ image: null })
    .eq('id', carId)

  if (updateError) throw updateError
}

export async function deleteCarGalleryImage(options: {
  carId: string
  imagePath: string
}): Promise<void> {
  const { carId, imagePath } = options

  // 1) Delete from storage
  await deleteCarImageFromStorage(imagePath)

  // 2) Delete media_assets row
  await deleteMediaAssetByPath(imagePath)

  // 3) Remove from cars.images array
  const { data: car, error: carError } = await supabase
    .from('cars')
    .select('images')
    .eq('id', carId)
    .single()

  if (carError) throw carError

  const currentImages: string[] = car.images ?? []
  const newImages = currentImages.filter((p) => p !== imagePath)

  const { error: updateError } = await supabase
    .from('cars')
    .update({ images: newImages })
    .eq('id', carId)

  if (updateError) throw updateError
}

// Delete all images when deleting a car
export async function deleteAllCarImagesAndAssets(options: {
  carId: string
  siteId: string
  siteSlug: string
}): Promise<void> {
  const { carId, siteId, siteSlug } = options

  // Delete all files from storage
  await deleteAllCarImages(siteSlug, carId)

  // Delete all media asset records
  await deleteMediaAssetsByCarId(siteId, carId, siteSlug)
}
