import { supabase } from '../lib/supabaseClient'
import { STORAGE_BUCKET } from '../lib/constants'
import { getFileExtension, generateUUID } from '../lib/fileUtils'
import { getStoragePublicUrl } from '../lib/storageUtils'

export const RAVING_OWNER_EMAIL = 'petras@raving.sk'
export const RAVING_SITE_SLUG = 'raving'

export type RavingProjectCategory =
  | 'priemyselne'
  | 'rodinne'
  | 'administrativne'
  | 'ostatne'

export interface RavingProject {
  id: string
  title: string
  description: string
  slug: string
  category: RavingProjectCategory
  cover_image_url: string
  gallery_images: string[]
  legacy_folder?: string | null
  legacy_first_image?: string | null
  sort_order: number
  is_published: boolean
  seo_title?: string | null
  seo_description?: string | null
  created_at: string
  updated_at: string
}

export const RAVING_PROJECT_CATEGORIES: { value: RavingProjectCategory; label: string }[] = [
  { value: 'priemyselne', label: 'Priemyselné a poľnohospodárske stavby' },
  { value: 'administrativne', label: 'Administratívne budovy' },
  { value: 'rodinne', label: 'Rodinné a bytové domy' },
  { value: 'ostatne', label: 'Ostatné stavby' },
]

export function slugifyRavingProjectTitle(value: string) {
  return value
    .normalize('NFD')
    .replace(/[\u0300-\u036f]/g, '')
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, '-')
    .replace(/^-+|-+$/g, '')
}

export async function getRavingProjects(): Promise<RavingProject[]> {
  const { data, error } = await supabase
    .from('raving_projects')
    .select('*')
    .order('sort_order', { ascending: true })
    .order('created_at', { ascending: false })

  if (error) throw error
  return (data || []) as RavingProject[]
}

export async function triggerRavingRevalidation(): Promise<void> {
  const secret = 'raving_reval_sec_d83e721a92e038c1'
  const isLocal = typeof window !== 'undefined' && 
    (window.location.hostname === 'localhost' || window.location.hostname === '127.0.0.1')

  const targets = Array.from(new Set([
    'https://raving.sk',
    'https://www.raving.sk',
    ...(isLocal ? ['http://localhost:3016', 'http://127.0.0.1:3016'] : []),
  ]))

  await Promise.allSettled(
    targets.map(async (baseUrl) => {
      try {
        const res = await fetch(`${baseUrl}/api/revalidate?secret=${secret}`, {
          method: 'POST',
          mode: 'no-cors',
        })

        if (res.type !== 'opaque' && !res.ok) {
          console.warn('Raving revalidation failed:', baseUrl, await res.text())
        }
      } catch (err) {
        console.warn('Raving revalidation error:', baseUrl, err)
      }
    })
  )
}

export async function createRavingProject(project: Partial<RavingProject>): Promise<RavingProject> {
  const { data, error } = await supabase
    .from('raving_projects')
    .insert(project)
    .select()
    .single()

  if (error) throw error
  triggerRavingRevalidation().catch(console.error)
  return data as RavingProject
}

export async function updateRavingProject(
  id: string,
  project: Partial<RavingProject>
): Promise<RavingProject> {
  const { data, error } = await supabase
    .from('raving_projects')
    .update(project)
    .eq('id', id)
    .select()
    .single()

  if (error) throw error
  triggerRavingRevalidation().catch(console.error)
  return data as RavingProject
}

export async function deleteRavingProject(id: string): Promise<void> {
  const { error } = await supabase
    .from('raving_projects')
    .delete()
    .eq('id', id)

  if (error) throw error
  triggerRavingRevalidation().catch(console.error)
}

export async function reorderRavingProjects(projects: { id: string; sort_order: number }[]) {
  for (const project of projects) {
    const { error } = await supabase
      .from('raving_projects')
      .update({ sort_order: project.sort_order })
      .eq('id', project.id)

    if (error) throw error
  }
  triggerRavingRevalidation().catch(console.error)
}

export async function uploadRavingProjectImage(file: File, projectId?: string) {
  const ext = getFileExtension(file)
  const fileName = `project-${generateUUID()}.${ext}`
  const path = projectId
    ? `${RAVING_SITE_SLUG}/projects/${projectId}/${fileName}`
    : `${RAVING_SITE_SLUG}/projects/temp/${fileName}`

  const { error } = await supabase.storage
    .from(STORAGE_BUCKET)
    .upload(path, file, {
      upsert: true,
      cacheControl: '3600',
    })

  if (error) throw error

  return getStoragePublicUrl(path)
}
