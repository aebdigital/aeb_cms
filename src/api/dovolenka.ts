import { supabase } from '../lib/supabaseClient'
import type { VacationPhone } from '../types/vacation'

// Get or create the Dovolenka page for a site
export async function getOrCreateDovolenkaPage(siteId: string) {
  // 1) Try fetch
  const { data: existing, error: fetchError } = await supabase
    .from('pages')
    .select('*')
    .eq('site_id', siteId)
    .eq('slug', 'dovolenka')
    .single()

  if (!fetchError && existing) return existing

  // 2) Create if missing
  const { data, error: insertError } = await supabase
    .from('pages')
    .insert({
      site_id: siteId,
      slug: 'dovolenka',
      title: 'Dovolenka',
      status: 'published',
      is_public: false,      // config page, not public
      show_in_nav: false,    // hide from navbar
      nav_label: 'Dovolenka',
      nav_order: 99,
    })
    .select('*')
    .single()

  if (insertError) throw insertError
  return data
}

// Get all vacation phone blocks for a page
export async function getVacationPhoneBlocks(pageId: string): Promise<VacationPhone[]> {
  const { data, error } = await supabase
    .from('blocks')
    .select('id, page_id, data')
    .eq('page_id', pageId)
    .eq('type', 'vacationPhone')
    .order('order', { ascending: true })

  if (error) throw error

  return (data || []).map((block: any) => {
    const d = block.data || {}
    return {
      id: block.id,
      pageId: block.page_id,
      phone: d.phone ?? '',
      enabled: d.enabled ?? false,
    }
  })
}

// Create a new vacation phone block
export async function createVacationPhoneBlock(
  pageId: string,
  phone: string,
  enabled: boolean = false
): Promise<VacationPhone> {
  const blockData = {
    phone,
    enabled,
  }

  // Get current max order
  const { data: existingBlocks } = await supabase
    .from('blocks')
    .select('order')
    .eq('page_id', pageId)
    .eq('type', 'vacationPhone')
    .order('order', { ascending: false })
    .limit(1)

  const maxOrder = existingBlocks?.[0]?.order ?? -1
  const newOrder = maxOrder + 1

  const { data: created, error: insertError } = await supabase
    .from('blocks')
    .insert({
      page_id: pageId,
      type: 'vacationPhone',
      order: newOrder,
      data: blockData,
    })
    .select('id, page_id, data')
    .single()

  if (insertError) throw insertError

  const d = (created as any).data || blockData
  return {
    id: created.id,
    pageId: created.page_id,
    phone: d.phone,
    enabled: d.enabled,
  }
}

// Update the vacationPhone block
export async function updateVacationPhoneBlock(block: VacationPhone) {
  const newData = {
    phone: block.phone,
    enabled: block.enabled,
  }

  const { error } = await supabase
    .from('blocks')
    .update({ data: newData })
    .eq('id', block.id)

  if (error) throw error
}

// Toggle vacation status for a phone
export async function toggleVacationPhone(blockId: string) {
  const { data, error } = await supabase
    .from('blocks')
    .select('data')
    .eq('id', blockId)
    .single()

  if (error) throw error

  const currentData = (data as any).data || {}
  const newData = { ...currentData, enabled: !currentData.enabled }

  const { error: updateError } = await supabase
    .from('blocks')
    .update({ data: newData })
    .eq('id', blockId)

  if (updateError) throw updateError

  return newData.enabled
}

// Delete a vacation phone block
export async function deleteVacationPhoneBlock(blockId: string) {
  const { error } = await supabase
    .from('blocks')
    .delete()
    .eq('id', blockId)

  if (error) throw error
}
