import { supabase } from '../lib/supabaseClient'
import { STORAGE_BUCKET } from '../lib/constants'

export interface BlogPost {
  id: string
  slug: string
  title: string
  excerpt: string
  category: string
  reading_time: string
  cover_image: string | null
  content_html: string
  is_published: boolean
  created_at: string
  updated_at: string
}

export type BlogPostUpsert = {
  slug: string
  title: string
  excerpt: string
  category: string
  reading_time: string
  cover_image: string | null
  content_html: string
  is_published?: boolean
}

export async function listBlogPosts(): Promise<BlogPost[]> {
  const { data, error } = await supabase
    .from('espron_blog_posts')
    .select('*')
    .order('updated_at', { ascending: false })
  if (error) throw error
  return (data ?? []) as BlogPost[]
}

export async function getBlogPost(id: string): Promise<BlogPost> {
  const { data, error } = await supabase
    .from('espron_blog_posts')
    .select('*')
    .eq('id', id)
    .single()
  if (error) throw error
  return data as BlogPost
}

export async function createBlogPost(post: BlogPostUpsert): Promise<BlogPost> {
  const { data, error } = await supabase
    .from('espron_blog_posts')
    .insert({
      slug: post.slug,
      title: post.title,
      excerpt: post.excerpt,
      category: post.category,
      reading_time: post.reading_time,
      cover_image: post.cover_image,
      content_html: post.content_html,
      is_published: post.is_published ?? false,
    })
    .select()
    .single()
  if (error) throw error
  return data as BlogPost
}

export async function updateBlogPost(id: string, updates: Partial<BlogPostUpsert>): Promise<BlogPost> {
  const { data, error } = await supabase
    .from('espron_blog_posts')
    .update(updates)
    .eq('id', id)
    .select()
    .single()
  if (error) throw error
  return data as BlogPost
}

export async function deleteBlogPost(id: string): Promise<void> {
  const { error } = await supabase
    .from('espron_blog_posts')
    .delete()
    .eq('id', id)
  if (error) throw error
}

export async function togglePublishBlogPost(id: string, published: boolean): Promise<BlogPost> {
  return updateBlogPost(id, { is_published: published })
}

export async function uploadBlogCoverImage(file: File, postId: string): Promise<string> {
  const ext = file.name.split('.').pop() || 'jpg'
  const path = `espron/blog-covers/${postId}/${Date.now()}.${ext}`
  const { error } = await supabase.storage
    .from(STORAGE_BUCKET)
    .upload(path, file, { upsert: true, cacheControl: '3600' })
  if (error) throw error
  const { data } = supabase.storage.from(STORAGE_BUCKET).getPublicUrl(path)
  return data.publicUrl
}
