import { supabase } from '../lib/supabaseClient'

export type AktualityCategory = 'skola-ludus' | 'ludus-academy' | 'divadlo-ludus' | 'ludus-tabor'

export interface Aktualita {
  id: string
  site_id: string
  title: string
  description: string | null
  date: string
  category: AktualityCategory
  show_on_homepage: boolean
  published: boolean
  created_at: string
  updated_at: string
}

export const AKTUALITY_CATEGORIES: { value: AktualityCategory; label: string }[] = [
  { value: 'skola-ludus', label: 'Skola Ludus' },
  { value: 'ludus-academy', label: 'Ludus Academy' },
  { value: 'divadlo-ludus', label: 'Divadlo Ludus' },
  { value: 'ludus-tabor', label: 'Ludus Tabor' },
]

export async function getAktuality(siteId: string, category?: AktualityCategory): Promise<Aktualita[]> {
  let query = supabase
    .from('aktuality')
    .select('*')
    .eq('site_id', siteId)
    .order('date', { ascending: false })

  if (category) {
    query = query.eq('category', category)
  }

  const { data, error } = await query
  if (error) throw error
  return data as Aktualita[]
}

export async function getHomepageAktuality(siteId: string): Promise<Aktualita[]> {
  const { data, error } = await supabase
    .from('aktuality')
    .select('*')
    .eq('site_id', siteId)
    .eq('show_on_homepage', true)
    .eq('published', true)
    .order('date', { ascending: false })
    .limit(3)

  if (error) throw error
  return data as Aktualita[]
}

export async function countHomepageAktuality(siteId: string): Promise<number> {
  const { count, error } = await supabase
    .from('aktuality')
    .select('*', { count: 'exact', head: true })
    .eq('site_id', siteId)
    .eq('show_on_homepage', true)

  if (error) throw error
  return count || 0
}

export async function createAktualita(aktualita: Omit<Aktualita, 'id' | 'created_at' | 'updated_at'>): Promise<Aktualita> {
  // Enforce max 3 homepage items
  if (aktualita.show_on_homepage) {
    const count = await countHomepageAktuality(aktualita.site_id)
    if (count >= 3) {
      throw new Error('Maximum 3 aktuality mozu byt zobrazene na domovskej stranke')
    }
  }

  const { data, error } = await supabase
    .from('aktuality')
    .insert(aktualita)
    .select()
    .single()

  if (error) throw error
  return data as Aktualita
}

export async function updateAktualita(id: string, updates: Partial<Aktualita>, siteId: string): Promise<Aktualita> {
  // Enforce max 3 homepage items when enabling show_on_homepage
  if (updates.show_on_homepage === true) {
    const { data: current } = await supabase
      .from('aktuality')
      .select('show_on_homepage')
      .eq('id', id)
      .single()

    if (!current?.show_on_homepage) {
      const count = await countHomepageAktuality(siteId)
      if (count >= 3) {
        throw new Error('Maximum 3 aktuality mozu byt zobrazene na domovskej stranke')
      }
    }
  }

  const { data, error } = await supabase
    .from('aktuality')
    .update({ ...updates, updated_at: new Date().toISOString() })
    .eq('id', id)
    .select()
    .single()

  if (error) throw error
  return data as Aktualita
}

export async function deleteAktualita(id: string): Promise<void> {
  const { error } = await supabase
    .from('aktuality')
    .delete()
    .eq('id', id)

  if (error) throw error
}
