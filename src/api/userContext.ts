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
  console.log('getUserContext: starting...')
  
  // Create a timeout promise (60s to handle slow connections)
  const timeout = new Promise((_, reject) => {
    setTimeout(() => reject(new Error('getUserContext timed out after 60s')), 60000)
  })

  // Wrap the actual logic
  const fetchContext = async () => {
    // 1) current auth user
    console.log('getUserContext: getting auth user...')
    const { data: { user }, error: userError } = await supabase.auth.getUser()
    if (userError || !user) throw userError || new Error('Not logged in')
    console.log('getUserContext: auth user found', user.id)

    // 2) profile
    console.log('getUserContext: fetching profile...')
    const { data: profile, error: profileError } = await supabase
      .from('profiles')
      .select('*')
      .eq('id', user.id)
      .single()

    if (profileError) throw profileError
    console.log('getUserContext: profile found')

    // 3) site memberships + sites
    console.log('getUserContext: fetching memberships...')
    const { data: memberships, error: membershipsError } = await supabase
      .from('site_memberships')
      .select('role, sites(id, name, slug, domain)')
      .eq('user_id', user.id)

    if (membershipsError) throw membershipsError
    console.log('getUserContext: memberships found', memberships?.length)

    return {
      user,
      profile,
      memberships: memberships as unknown as SiteMembership[],
    }
  }

  // Race the fetch against the timeout
  return Promise.race([fetchContext(), timeout]) as Promise<UserContext>
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
