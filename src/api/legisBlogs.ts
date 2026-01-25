import { supabase } from '../lib/supabaseClient'

export async function getLegisBlogs(siteId: string) {
    const { data, error } = await supabase
        .from('legis_blogs')
        .select(`
      *,
      translations:legis_blog_translations(*)
    `)
        .eq('site_id', siteId)
        .order('created_at', { ascending: false })

    if (error) throw error
    return data
}

export async function createLegisBlog(blog: any, translations: any[]) {
    // 1. Create blog entry
    const { data: newBlog, error: blogError } = await supabase
        .from('legis_blogs')
        .insert([blog])
        .select()
        .single()

    if (blogError) throw blogError

    // 2. Create translations
    const transWithId = translations.map(t => ({
        ...t,
        blog_id: newBlog.id
    }))

    const { error: transError } = await supabase
        .from('legis_blog_translations')
        .insert(transWithId)

    if (transError) throw transError

    return newBlog
}

export async function updateLegisBlog(blogId: string, blog: any, translations: any[]) {
    // 1. Update blog entry
    const { error: blogError } = await supabase
        .from('legis_blogs')
        .update(blog)
        .eq('id', blogId)

    if (blogError) throw blogError

    // 2. Update/Upsert translations
    for (const trans of translations) {
        const { error: transError } = await supabase
            .from('legis_blog_translations')
            .upsert({
                ...trans,
                blog_id: blogId
            }, {
                onConflict: 'blog_id, lang'
            })

        if (transError) throw transError
    }
}

export async function deleteLegisBlog(blogId: string) {
    const { error } = await supabase
        .from('legis_blogs')
        .delete()
        .eq('id', blogId)

    if (error) throw error
}

export async function uploadLegisBlogImage(file: File, path: string) {
    const { data, error } = await supabase.storage
        .from('site-assets')
        .upload(path, file, {
            upsert: true
        })

    if (error) throw error

    const { data: { publicUrl } } = supabase.storage
        .from('site-assets')
        .getPublicUrl(path)

    return publicUrl
}
