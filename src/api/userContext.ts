import { supabase } from '../lib/supabaseClient'

export interface Profile {
  id: string
  full_name: string | null
  avatar_url: string | null
  role: string
  created_at: string
  updated_at: string
}

export interface Site {
  id: string
  name: string
  slug: string
  domain: string | null
}

export interface SiteMembership {
  role: string
  sites: Site
}

export interface UserContext {
  user: any
  profile: Profile
  memberships: SiteMembership[]
}

export async function getUserContext(): Promise<UserContext> {
  // 1) current auth user
  const { data: { user }, error: userError } = await supabase.auth.getUser()
  if (userError || !user) throw userError || new Error('Not logged in')

  // 2) profile
  const { data: profile, error: profileError } = await supabase
    .from('profiles')
    .select('*')
    .eq('id', user.id)
    .single()

  if (profileError) throw profileError

  // 3) site memberships + sites
  const { data: memberships, error: membershipsError } = await supabase
    .from('site_memberships')
    .select('role, sites(id, name, slug, domain)')
    .eq('user_id', user.id)

  if (membershipsError) throw membershipsError

  return {
    user,
    profile,
    memberships: memberships as unknown as SiteMembership[],
  }
}

export async function updateProfile(userId: string, updates: Partial<Profile>) {
  const { data, error } = await supabase
    .from('profiles')
    .update(updates)
    .eq('id', userId)
    .select()
    .single()

  if (error) throw error
  return data
}
