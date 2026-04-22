import heic2any from 'heic2any'

export function getFileExtension(file: File): string {
  const parts = file.name.split('.')
  return parts.length > 1 ? parts.pop()!.toLowerCase() : 'jpg'
}

export function generateUUID(): string {
  return crypto.randomUUID()
}

/**
 * Compress an image file to a target size (default 500KB)
 * Uses canvas to resize and compress the image.
 * Now also handles HEIC/HEIF conversion to JPEG.
 */
export async function compressImage(
  file: File,
  maxSizeKB: number = 500,
  maxWidth: number = 1920,
  maxHeight: number = 1080
): Promise<File> {
  let processingFile = file
  const extension = getFileExtension(file)
  const isHeic = extension === 'heic' || extension === 'heif' || file.type === 'image/heic' || file.type === 'image/heif'

  // Handle HEIC/HEIF conversion
  if (isHeic) {
    console.log(`HEIC/HEIF detected for ${file.name}, converting to JPEG...`)
    try {
      const convertedBlob = await heic2any({
        blob: file,
        toType: 'image/jpeg',
        quality: 0.8
      })

      // heic2any can return an array if multiple images are in one HEIC, we take the first one
      const blob = Array.isArray(convertedBlob) ? convertedBlob[0] : convertedBlob
      
      // Create a new filename with .jpg extension
      const newName = file.name.replace(/\.(heic|heif)$/i, '') + '.jpg'
      
      processingFile = new File([blob], newName, {
        type: 'image/jpeg',
        lastModified: Date.now()
      })
      
      console.log(`Conversion successful: ${processingFile.name}`)
    } catch (err) {
      console.error('HEIC conversion failed, attempting normal flow:', err)
      // If conversion fails, we still try the normal flow, though it might fail if browser doesn't support it
    }
  }

  // Skip if file is already small enough AND it's not a HEIC (since HEIC must be converted anyway)
  if (!isHeic && processingFile.size <= maxSizeKB * 1024) {
    console.log(`Image ${processingFile.name} already under ${maxSizeKB}KB, skipping compression`)
    return processingFile
  }

  // Skip non-image files (after possible conversion)
  if (!processingFile.type.startsWith('image/')) {
    return processingFile
  }

  console.log(`Compressing ${processingFile.name}: ${(processingFile.size / 1024).toFixed(1)}KB -> target ${maxSizeKB}KB`)

  return new Promise((resolve, reject) => {
    const img = new Image()
    const canvas = document.createElement('canvas')
    const ctx = canvas.getContext('2d')

    img.onload = () => {
      // Calculate new dimensions while maintaining aspect ratio
      let { width, height } = img

      if (width > maxWidth) {
        height = (height * maxWidth) / width
        width = maxWidth
      }
      if (height > maxHeight) {
        width = (width * maxHeight) / height
        height = maxHeight
      }

      canvas.width = width
      canvas.height = height

      // Draw image on canvas
      ctx?.drawImage(img, 0, 0, width, height)

      // Try different quality levels to get under target size
      const tryCompress = (quality: number): void => {
        canvas.toBlob(
          (blob) => {
            if (!blob) {
              reject(new Error('Failed to compress image'))
              return
            }

            const sizeKB = blob.size / 1024
            console.log(`  Quality ${(quality * 100).toFixed(0)}%: ${sizeKB.toFixed(1)}KB`)

            if (sizeKB <= maxSizeKB || quality <= 0.1) {
              // Success or minimum quality reached
              // Use the original (or converted) name but Ensure it has a .jpg extension if we compressed it
              const finalExtension = getFileExtension(processingFile)
              let finalName = processingFile.name
              if (finalExtension !== 'jpg' && finalExtension !== 'jpeg') {
                finalName = finalName.replace(new RegExp(`\\.${finalExtension}$`, 'i'), '') + '.jpg'
              }

              const compressedFile = new File([blob], finalName, {
                type: 'image/jpeg',
                lastModified: Date.now(),
              })
              console.log(`  Final: ${(compressedFile.size / 1024).toFixed(1)}KB`)
              resolve(compressedFile)
            } else {
              // Try lower quality
              tryCompress(quality - 0.1)
            }
          },
          'image/jpeg',
          quality
        )
      }

      // Start with 90% quality
      tryCompress(0.9)
    }

    img.onerror = () => {
      reject(new Error('Failed to load image for compression'))
    }

    // Load image from file
    img.src = URL.createObjectURL(processingFile)
  })
}

/**
 * Compress multiple images in parallel
 */
export async function compressImages(
  files: File[],
  maxSizeKB: number = 500
): Promise<File[]> {
  return Promise.all(files.map(file => compressImage(file, maxSizeKB)))
}
