export function getFileExtension(file: File): string {
  const parts = file.name.split('.')
  return parts.length > 1 ? parts.pop()!.toLowerCase() : 'jpg'
}

export function generateUUID(): string {
  return crypto.randomUUID()
}

/**
 * Compress an image file to a target size (default 500KB)
 * Uses canvas to resize and compress the image
 */
export async function compressImage(
  file: File,
  maxSizeKB: number = 500,
  maxWidth: number = 1920,
  maxHeight: number = 1080
): Promise<File> {
  // Skip if file is already small enough
  if (file.size <= maxSizeKB * 1024) {
    console.log(`Image ${file.name} already under ${maxSizeKB}KB, skipping compression`)
    return file
  }

  // Skip non-image files
  if (!file.type.startsWith('image/')) {
    return file
  }

  console.log(`Compressing ${file.name}: ${(file.size / 1024).toFixed(1)}KB -> target ${maxSizeKB}KB`)

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
              const compressedFile = new File([blob], file.name, {
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
    img.src = URL.createObjectURL(file)
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
