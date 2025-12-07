import { supabase } from '../lib/supabaseClient'
import { Page } from './pages'

export interface BlockFilter {
  featuredOnly?: boolean
  minPrice?: number | null
  maxPrice?: number | null
  fuel?: string | null
  transmission?: string | null
}

export interface CarListBlockData {
  layout: 'grid' | 'list'
  limit: number
  filter: BlockFilter
}

export interface HeroBlockData {
  title?: string
  subtitle?: string
  backgroundImage?: string
  ctaText?: string
  ctaLink?: string
}

export interface Block {
  id: string
  page_id: string
  type: string
  order: number
  data: CarListBlockData | HeroBlockData | Record<string, any>
  created_at: string
  updated_at: string
}

export interface PageWithBlocks {
  page: Page
  blocks: Block[]
}

export async function getPageWithBlocks(pageId: string): Promise<PageWithBlocks> {
  const { data: page, error } = await supabase
    .from('pages')
    .select('id, slug, title, site_id, is_public, show_in_nav, nav_label, nav_order, created_at, updated_at')
    .eq('id', pageId)
    .single()

  if (error) throw error

  const { data: blocks, error: blocksError } = await supabase
    .from('blocks')
    .select('id, page_id, type, order, data, created_at, updated_at')
    .eq('page_id', pageId)
    .order('order', { ascending: true })

  if (blocksError) throw blocksError

  return { page: page as Page, blocks: blocks as Block[] }
}

export async function createBlock(block: Partial<Block>): Promise<Block> {
  const { data, error } = await supabase
    .from('blocks')
    .insert(block)
    .select()
    .single()

  if (error) throw error
  return data as Block
}

export async function updateBlock(blockId: string, updates: Partial<Block>): Promise<Block> {
  const { data, error } = await supabase
    .from('blocks')
    .update(updates)
    .eq('id', blockId)
    .select()
    .single()

  if (error) throw error
  return data as Block
}

export async function updateBlockData(blockId: string, data: Record<string, any>): Promise<Block> {
  return updateBlock(blockId, { data })
}

export async function deleteBlock(blockId: string): Promise<void> {
  const { error } = await supabase
    .from('blocks')
    .delete()
    .eq('id', blockId)

  if (error) throw error
}

export async function reorderBlocks(blocks: { id: string; order: number }[]): Promise<void> {
  for (const block of blocks) {
    const { error } = await supabase
      .from('blocks')
      .update({ order: block.order })
      .eq('id', block.id)

    if (error) throw error
  }
}

export async function getBlockTypes(): Promise<{ id: string; name: string; schema: any }[]> {
  const { data, error } = await supabase
    .from('block_types')
    .select('id, name, schema')

  if (error) throw error
  return data
}
