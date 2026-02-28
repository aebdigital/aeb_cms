import { supabase } from '../lib/supabaseClient'

export type ProgramCategory = 'skola-ludus' | 'ludus-academy' | 'divadlo-ludus'

export interface TeamMember {
  role: string
  name: string
}

export interface ProgramEvent {
  id: string
  site_id: string
  slug: string
  category: ProgramCategory
  event_date: string
  day_name: string
  time: string
  month: string
  title: string
  subtitle: string | null
  author: string | null
  age_badge: string | null
  venue: string
  status: 'vypredane' | 'available' | 'info'
  info_text: string | null
  price: string | null
  color: string
  image_path: string | null
  description: string | null
  duration: string | null
  age_info: string | null
  premiere: string | null
  cast_members: string[]
  team_members: TeamMember[]
  published: boolean
  display_order: number
  has_school_reservation: boolean
  has_ticket_reservation: boolean
  buy_ticket_link: string | null
  gallery_paths: string[]
  description_images: string[]
  created_at: string
  updated_at: string
}

export const PROGRAM_CATEGORIES: { value: ProgramCategory; label: string }[] = [
  { value: 'skola-ludus', label: 'Škola Ludus' },
  { value: 'ludus-academy', label: 'Ludus Academy' },
  { value: 'divadlo-ludus', label: 'Divadlo Ludus' },
]

export const PROGRAM_STATUSES: { value: ProgramEvent['status']; label: string }[] = [
  { value: 'available', label: 'Dostupné' },
  { value: 'vypredane', label: 'Vypredané' },
  { value: 'info', label: 'Info' },
]

// Slovak day names for auto-generation from date
const SLOVAK_DAYS = ['nedela', 'pondelok', 'utorok', 'streda', 'stvrtok', 'piatok', 'sobota']
const SLOVAK_MONTHS = ['január', 'február', 'marec', 'apríl', 'máj', 'jún', 'júl', 'august', 'september', 'október', 'november', 'december']

export function getDayNameFromDate(dateStr: string): string {
  const date = new Date(dateStr)
  return SLOVAK_DAYS[date.getDay()]
}

export function getMonthFromDate(dateStr: string): string {
  const date = new Date(dateStr)
  return SLOVAK_MONTHS[date.getMonth()]
}

export function formatDayFromDate(dateStr: string): string {
  const date = new Date(dateStr)
  const day = date.getDate()
  const month = date.getMonth() + 1
  return `${day}. ${month}.`
}

export function generateSlug(title: string): string {
  return title
    .toLowerCase()
    .normalize('NFD')
    .replace(/[\u0300-\u036f]/g, '') // Remove diacritics
    .replace(/[^a-z0-9]+/g, '-')
    .replace(/(^-|-$)/g, '')
}

export async function getProgramEvents(siteId: string, category?: ProgramCategory): Promise<ProgramEvent[]> {
  let query = supabase
    .from('program_events')
    .select('*')
    .eq('site_id', siteId)
    .order('event_date', { ascending: true })

  if (category) {
    query = query.eq('category', category)
  }

  const { data, error } = await query
  if (error) throw error
  return data as ProgramEvent[]
}

export async function getProgramEventsbyTitle(siteId: string, title: string): Promise<ProgramEvent[]> {
  const { data, error } = await supabase
    .from('program_events')
    .select('*')
    .eq('site_id', siteId)
    .eq('title', title)
    .order('event_date', { ascending: true })

  if (error) throw error
  return data as ProgramEvent[]
}

export async function getProgramEventBySlug(siteId: string, slug: string): Promise<ProgramEvent | null> {
  const { data, error } = await supabase
    .from('program_events')
    .select('*')
    .eq('site_id', siteId)
    .eq('slug', slug)
    .single()

  if (error) {
    if (error.code === 'PGRST116') return null // Not found
    throw error
  }
  return data as ProgramEvent
}

export async function createProgramEvent(event: Omit<ProgramEvent, 'id' | 'created_at' | 'updated_at'>): Promise<ProgramEvent> {
  const { data, error } = await supabase
    .from('program_events')
    .insert(event)
    .select()
    .single()

  if (error) throw error
  return data as ProgramEvent
}

export async function updateProgramEvent(id: string, updates: Partial<ProgramEvent>): Promise<ProgramEvent> {
  const { data, error } = await supabase
    .from('program_events')
    .update({ ...updates, updated_at: new Date().toISOString() })
    .eq('id', id)
    .select()
    .single()

  if (error) throw error
  return data as ProgramEvent
}

export async function deleteProgramEvent(id: string): Promise<void> {
  const { error } = await supabase
    .from('program_events')
    .delete()
    .eq('id', id)

  if (error) throw error
}

export async function checkSlugExists(siteId: string, slug: string, excludeId?: string): Promise<boolean> {
  let query = supabase
    .from('program_events')
    .select('id')
    .eq('site_id', siteId)
    .eq('slug', slug)

  if (excludeId) {
    query = query.neq('id', excludeId)
  }

  const { data, error } = await query
  if (error) throw error
  return (data?.length || 0) > 0
}
