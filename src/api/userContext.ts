import { supabase } from '../lib/supabaseClient'

// Helper to add timeout to any promise
function withTimeout<T>(promise: Promise<T>, ms: number, operation: string): Promise<T> {
  return Promise.race([
    promise,
    new Promise<T>((_, reject) =>
      setTimeout(() => reject(new Error(`${operation} timed out after ${ms/1000}s`)), ms)
    )
  ])
}

export interface Profile {
  id: string
  full_name: string | null
  avatar_url: string | null
  role: string
  created_at: string
  updated_at: string
  lang: 'sk' | 'cs'
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
  console.log('getUserContext: starting...')

  // 1) current auth user - with 10s timeout (this call can hang on stale tokens)
  console.log('getUserContext: getting auth user...')
  const { data: { user }, error: userError } = await withTimeout(
    supabase.auth.getUser(),
    10000,
    'getUser'
  )
  if (userError || !user) throw userError || new Error('Not logged in')
  console.log('getUserContext: auth user found', user.id)

  // 2) profile - with 15s timeout
  console.log('getUserContext: fetching profile...')
  const { data: profile, error: profileError } = await withTimeout(
    supabase
      .from('profiles')
      .select('*')
      .eq('id', user.id)
      .single(),
    15000,
    'getProfile'
  )

  if (profileError) throw profileError
  console.log('getUserContext: profile found')

  // 3) site memberships + sites - with 15s timeout
  console.log('getUserContext: fetching memberships...')
  const { data: memberships, error: membershipsError } = await withTimeout(
    supabase
      .from('site_memberships')
      .select('role, sites(id, name, slug, domain)')
      .eq('user_id', user.id),
    15000,
    'getMemberships'
  )

  if (membershipsError) throw membershipsError
  console.log('getUserContext: memberships found', memberships?.length)

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
