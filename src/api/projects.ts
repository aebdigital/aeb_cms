import { supabase } from '../lib/supabaseClient'

export interface Project {
  id: string
  site_id: string
  title: string
  category?: string
  display_order?: number | null
  year?: number
  location?: string
  date?: string
  description?: string
  folder?: string
  hero_image?: string
  images: string[]
  seo: {
    metaDescription: string
    keywords: string
  }
}

export async function getProjects(siteId: string): Promise<Project[]> {
  const { data, error } = await supabase
    .from('projects')
    .select('*')
    .eq('site_id', siteId)
    .order('display_order', { ascending: true, nullsFirst: false })
    .order('created_at', { ascending: false })

  if (error) throw error
  
  return (data || []).map(p => ({
    ...p,
    heroImage: p.hero_image,
    seo: p.seo || { metaDescription: '', keywords: '' }
  }))
}

export async function createProject(project: Partial<Project>): Promise<Project> {
  const { data, error } = await supabase
    .from('projects')
    .insert([project])
    .select()
    .single()

  if (error) throw error
  return data
}

export async function updateProject(id: string, project: Partial<Project>): Promise<Project> {
  const { data, error } = await supabase
    .from('projects')
    .update(project)
    .eq('id', id)
    .select()
    .single()

  if (error) throw error
  return data
}

export async function deleteProject(id: string): Promise<void> {
  const { error } = await supabase
    .from('projects')
    .delete()
    .eq('id', id)

  if (error) throw error
}

export async function reorderProjects(projects: { id: string; display_order: number }[]): Promise<void> {
  for (const project of projects) {
    const { error } = await supabase
      .from('projects')
      .update({ display_order: project.display_order })
      .eq('id', project.id)

    if (error) throw error
  }
}
