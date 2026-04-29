import decode from 'heic-decode'
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
 * Now also handles HEIC/HEIF conversion to JPEG with multiple fallbacks.
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
    console.log(`HEIC/HEIF detected: ${file.name}, size: ${file.size}, type: ${file.type}`)
    
    // Strategy 1: heic-decode (modern decoder)
    try {
      console.log('Attempting heic-decode...')
      const arrayBuffer = await file.arrayBuffer()
      let decodeFn = decode
      if (typeof decodeFn !== 'function' && (decodeFn as any)?.default) {
        decodeFn = (decodeFn as any).default
      }
      
      const { width, height, data } = await decodeFn({ buffer: arrayBuffer })
      const canvas = document.createElement('canvas')
      canvas.width = width
      canvas.height = height
      const ctx = canvas.getContext('2d')
      if (!ctx) throw new Error('Canvas context failed')
      
      const imageData = new ImageData(new Uint8ClampedArray(data), width, height)
      ctx.putImageData(imageData, 0, 0)
      
      const blob = await new Promise<Blob>((resolve, reject) => {
        canvas.toBlob((b) => b ? resolve(b) : reject(new Error('toBlob failed')), 'image/jpeg', 0.9)
      })

      const newName = file.name.replace(/\.(heic|heif)$/i, '') + '.jpg'
      processingFile = new File([blob], newName, { type: 'image/jpeg', lastModified: Date.now() })
      console.log('heic-decode successful')
      
    } catch (err1) {
      console.warn('heic-decode failed, trying heic2any...', err1)
      
      // Strategy 2: heic2any (mature library)
      try {
        let convertFn = heic2any
        if (typeof convertFn !== 'function' && (convertFn as any)?.default) {
          convertFn = (convertFn as any).default
        }

        const convertedBlob = await (convertFn as any)({
          blob: file,
          toType: 'image/jpeg',
          multiple: true
        })

        const blob = Array.isArray(convertedBlob) ? convertedBlob[0] : convertedBlob
        const newName = file.name.replace(/\.(heic|heif)$/i, '') + '.jpg'
        
        processingFile = new File([blob], newName, { type: 'image/jpeg', lastModified: Date.now() })
        console.log('heic2any successful')
        
      } catch (err2) {
        console.warn('All client-side HEIC conversions failed. Falling back to raw upload.', err2)
        // Strategy 3: Raw upload (depends on server-side transformation for display)
        return file
      }
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
