import { supabase } from '../lib/supabaseClient'
import { STORAGE_BUCKET } from '../lib/constants'
import { generateUUID, getFileExtension } from '../lib/fileUtils'
import { getStoragePublicUrl } from '../lib/storageUtils'
import { KOCHLIK_OWNER_ID, KOCHLIK_SITE_SLUG } from './kochlik'

export type KochlikHomeBanner = {
  id: string
  owner_id: string
  title: string
  text: string | null
  image_url: string | null
  href: string
  button_label: string
  sort_order: number
  is_active: boolean
  created_at: string
  updated_at: string
}

export type KochlikBlogPost = {
  id: string
  owner_id: string
  slug: string
  title: string
  excerpt: string | null
  category: string
  reading_time: string
  cover_image: string | null
  content_html: string
  seo_title: string | null
  seo_description: string | null
  is_published: boolean
  published_at: string | null
  created_at: string
  updated_at: string
}

export type KochlikHomeBannerUpsert = {
  title: string
  text?: string | null
  image_url?: string | null
  href?: string
  button_label?: string
  sort_order?: number
  is_active?: boolean
}

export type KochlikBlogPostUpsert = {
  slug: string
  title: string
  excerpt?: string | null
  category?: string
  reading_time?: string
  cover_image?: string | null
  content_html?: string
  seo_title?: string | null
  seo_description?: string | null
  is_published?: boolean
  published_at?: string | null
}

export async function listKochlikHomeBanners(
  ownerId = KOCHLIK_OWNER_ID
): Promise<KochlikHomeBanner[]> {
  const { data, error } = await supabase
    .from('kochlik_home_banners')
    .select('*')
    .eq('owner_id', ownerId)
    .order('sort_order', { ascending: true })
    .order('updated_at', { ascending: false })

  if (error) throw error
  return (data ?? []) as KochlikHomeBanner[]
}

export async function createKochlikHomeBanner(
  banner: KochlikHomeBannerUpsert
): Promise<KochlikHomeBanner> {
  const { data, error } = await supabase
    .from('kochlik_home_banners')
    .insert([{ ...banner, owner_id: KOCHLIK_OWNER_ID }])
    .select()
    .single()

  if (error) throw error
  return data as KochlikHomeBanner
}

export async function updateKochlikHomeBanner(
  id: string,
  banner: Partial<KochlikHomeBannerUpsert>
): Promise<KochlikHomeBanner> {
  const { data, error } = await supabase
    .from('kochlik_home_banners')
    .update({ ...banner, updated_at: new Date().toISOString() })
    .eq('id', id)
    .eq('owner_id', KOCHLIK_OWNER_ID)
    .select()
    .single()

  if (error) throw error
  return data as KochlikHomeBanner
}

export async function deleteKochlikHomeBanner(id: string): Promise<void> {
  const { error } = await supabase
    .from('kochlik_home_banners')
    .delete()
    .eq('id', id)
    .eq('owner_id', KOCHLIK_OWNER_ID)

  if (error) throw error
}

export async function listKochlikBlogPosts(
  ownerId = KOCHLIK_OWNER_ID
): Promise<KochlikBlogPost[]> {
  const { data, error } = await supabase
    .from('kochlik_blog_posts')
    .select('*')
    .eq('owner_id', ownerId)
    .order('published_at', { ascending: false, nullsFirst: false })
    .order('updated_at', { ascending: false })

  if (error) throw error
  return (data ?? []) as KochlikBlogPost[]
}

export async function getKochlikBlogPost(id: string): Promise<KochlikBlogPost> {
  const { data, error } = await supabase
    .from('kochlik_blog_posts')
    .select('*')
    .eq('id', id)
    .eq('owner_id', KOCHLIK_OWNER_ID)
    .single()

  if (error) throw error
  return data as KochlikBlogPost
}

export async function createKochlikBlogPost(
  post: KochlikBlogPostUpsert
): Promise<KochlikBlogPost> {
  const { data, error } = await supabase
    .from('kochlik_blog_posts')
    .insert([{ ...post, owner_id: KOCHLIK_OWNER_ID }])
    .select()
    .single()

  if (error) throw error
  return data as KochlikBlogPost
}

export async function updateKochlikBlogPost(
  id: string,
  updates: Partial<KochlikBlogPostUpsert>
): Promise<KochlikBlogPost> {
  const { data, error } = await supabase
    .from('kochlik_blog_posts')
    .update({ ...updates, updated_at: new Date().toISOString() })
    .eq('id', id)
    .eq('owner_id', KOCHLIK_OWNER_ID)
    .select()
    .single()

  if (error) throw error
  return data as KochlikBlogPost
}

export async function deleteKochlikBlogPost(id: string): Promise<void> {
  const { error } = await supabase
    .from('kochlik_blog_posts')
    .delete()
    .eq('id', id)
    .eq('owner_id', KOCHLIK_OWNER_ID)

  if (error) throw error
}

export async function togglePublishKochlikBlogPost(
  post: KochlikBlogPost
): Promise<KochlikBlogPost> {
  const nextPublished = !post.is_published
  return updateKochlikBlogPost(post.id, {
    is_published: nextPublished,
    published_at: nextPublished && !post.published_at ? new Date().toISOString() : post.published_at,
  })
}

async function uploadKochlikImage(file: File, folder: string, entityId?: string): Promise<string> {
  const ext = getFileExtension(file)
  const fileName = `image-${generateUUID()}.${ext}`
  const path = `${KOCHLIK_SITE_SLUG}/${folder}/${entityId || 'temp'}/${fileName}`

  const { error } = await supabase.storage
    .from(STORAGE_BUCKET)
    .upload(path, file, {
      upsert: false,
      cacheControl: '3600',
      contentType: file.type || undefined,
    })

  if (error) throw error
  return getStoragePublicUrl(path)
}

export function uploadKochlikBannerImage(file: File, bannerId?: string): Promise<string> {
  return uploadKochlikImage(file, 'home-banners', bannerId)
}

export function uploadKochlikBlogImage(file: File, postId?: string): Promise<string> {
  return uploadKochlikImage(file, 'blogs', postId)
}
