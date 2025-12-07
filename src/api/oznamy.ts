import { supabase } from '../lib/supabaseClient'
import type { AnnouncementPopup } from '../types/announcement'

// Get or create the Oznamy page for a site
export async function getOrCreateOznamyPage(siteId: string) {
  // 1) Try to fetch existing page
  const { data: existing, error: fetchError } = await supabase
    .from('pages')
    .select('*')
    .eq('site_id', siteId)
    .eq('slug', 'oznamy')
    .single()

  if (!fetchError && existing) return existing

  // 2) Create if missing
  const { data, error: insertError } = await supabase
    .from('pages')
    .insert({
      site_id: siteId,
      slug: 'oznamy',
      title: 'Oznamy',
      status: 'published',
      is_public: true,
      show_in_nav: true,
      nav_label: 'Oznamy',
      nav_order: 2,
    })
    .select('*')
    .single()

  if (insertError) throw insertError
  return data
}

// Get or create the announcementPopup block for a page
export async function getOrCreateAnnouncementBlock(
  pageId: string
): Promise<AnnouncementPopup> {
  // 1) Try to fetch existing popup block
  const { data: existing, error: fetchError } = await supabase
    .from('blocks')
    .select('id, page_id, data')
    .eq('page_id', pageId)
    .eq('type', 'announcementPopup')
    .single()

  if (!fetchError && existing) {
    const d = (existing as any).data || {}
    return {
      id: existing.id,
      pageId: existing.page_id,
      title: d.title ?? '',
      description: d.description ?? '',
      enabled: d.enabled ?? false,
    }
  }

  // 2) Create default block if missing
  const defaultData = {
    title: 'Dolezity oznam',
    description: '',
    enabled: false,
  }

  const { data: created, error: insertError } = await supabase
    .from('blocks')
    .insert({
      page_id: pageId,
      type: 'announcementPopup',
      order: 0,
      data: defaultData,
    })
    .select('id, page_id, data')
    .single()

  if (insertError) throw insertError

  const d = (created as any).data || defaultData
  return {
    id: created.id,
    pageId: created.page_id,
    title: d.title,
    description: d.description,
    enabled: d.enabled,
  }
}

// Update the announcement block
export async function updateAnnouncementBlock(block: AnnouncementPopup) {
  const newData = {
    title: block.title,
    description: block.description,
    enabled: block.enabled,
  }

  const { error } = await supabase
    .from('blocks')
    .update({ data: newData })
    .eq('id', block.id)

  if (error) throw error
}

// Disable announcement (soft delete)
export async function disableAnnouncement(blockId: string) {
  const { data, error } = await supabase
    .from('blocks')
    .select('data')
    .eq('id', blockId)
    .single()

  if (error) throw error

  const currentData = (data as any).data || {}
  const newData = { ...currentData, enabled: false }

  const { error: updateError } = await supabase
    .from('blocks')
    .update({ data: newData })
    .eq('id', blockId)

  if (updateError) throw updateError
}
