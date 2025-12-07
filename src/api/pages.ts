import { supabase } from '../lib/supabaseClient'

export interface Page {
  id: string
  site_id: string
  slug: string
  title: string
  is_public: boolean
  show_in_nav: boolean
  nav_label: string | null
  nav_order: number
  created_at: string
  updated_at: string
}

export async function getPagesForSite(siteId: string): Promise<Page[]> {
  const { data, error } = await supabase
    .from('pages')
    .select('id, site_id, slug, title, is_public, show_in_nav, nav_label, nav_order, created_at, updated_at')
    .eq('site_id', siteId)
    .order('nav_order', { ascending: true })

  if (error) throw error
  return data as Page[]
}

export async function getPage(pageId: string): Promise<Page> {
  const { data, error } = await supabase
    .from('pages')
    .select('*')
    .eq('id', pageId)
    .single()

  if (error) throw error
  return data as Page
}

export async function createPage(page: Partial<Page>): Promise<Page> {
  const { data, error } = await supabase
    .from('pages')
    .insert(page)
    .select()
    .single()

  if (error) throw error
  return data as Page
}

export async function updatePage(pageId: string, updates: Partial<Page>): Promise<Page> {
  const { data, error } = await supabase
    .from('pages')
    .update(updates)
    .eq('id', pageId)
    .select()
    .single()

  if (error) throw error
  return data as Page
}

export async function deletePage(pageId: string): Promise<void> {
  const { error } = await supabase
    .from('pages')
    .delete()
    .eq('id', pageId)

  if (error) throw error
}

export async function updatePageNavigation(pageId: string, updates: {
  show_in_nav?: boolean
  nav_label?: string | null
  nav_order?: number
}): Promise<Page> {
  return updatePage(pageId, updates)
}

export async function reorderPages(pages: { id: string; nav_order: number }[]): Promise<void> {
  for (const page of pages) {
    const { error } = await supabase
      .from('pages')
      .update({ nav_order: page.nav_order })
      .eq('id', page.id)

    if (error) throw error
  }
}
