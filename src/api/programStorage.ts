import { supabase } from '../lib/supabaseClient'
import { STORAGE_BUCKET } from '../lib/constants'
import { getFileExtension, generateUUID } from '../lib/fileUtils'

export interface UploadProgramImageOptions {
    file: File
    siteSlug: string
    category: string
}

export async function uploadProgramImage(options: UploadProgramImageOptions): Promise<{ path: string }> {
    const { file, siteSlug, category } = options

    const ext = getFileExtension(file)
    const fileName = `${generateUUID()}.${ext}`
    const path = `${siteSlug}/program/${category}/${fileName}`

    const { error } = await supabase.storage
        .from(STORAGE_BUCKET)
        .upload(path, file, {
            upsert: false,
            cacheControl: '3600',
        })

    if (error) throw error
    return { path }
}

export async function deleteProgramImageFromStorage(path: string): Promise<void> {
    const { error } = await supabase.storage
        .from(STORAGE_BUCKET)
        .remove([path])

    if (error) throw error
}

export function getProgramImagePublicUrl(path: string): string {
    if (!path) return ''
    // If it's already a full URL (legacy), return it
    if (path.startsWith('http')) return path

    const { data } = supabase.storage
        .from(STORAGE_BUCKET)
        .getPublicUrl(path)

    return data.publicUrl
}
