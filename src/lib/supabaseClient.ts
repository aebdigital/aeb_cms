import { createClient } from '@supabase/supabase-js'

const supabaseUrl = import.meta.env.VITE_SUPABASE_URL
const supabaseAnonKey = import.meta.env.VITE_SUPABASE_ANON_KEY

if (!supabaseUrl || !supabaseAnonKey) {
  throw new Error('Missing Supabase environment variables')
}

export const supabase = createClient(supabaseUrl, supabaseAnonKey, {
  auth: {
    autoRefreshToken: true,
    persistSession: true,
    detectSessionInUrl: true,
  }
})

/**
 * Ensures the Supabase session is valid before making API calls.
 * Call this before operations that might fail due to stale sessions (e.g., after tab switch).
 * Returns true if session is valid, false if user needs to re-login.
 */
export async function ensureValidSession(): Promise<boolean> {
  try {
    const { data: { session }, error } = await supabase.auth.getSession()

    if (error || !session) {
      console.log('No valid session found')
      return false
    }

    // Check if token is close to expiry (within 2 minutes)
    const tokenPayload = JSON.parse(atob(session.access_token.split('.')[1]))
    const expiresAt = tokenPayload.exp * 1000
    const twoMinutes = 2 * 60 * 1000

    if (Date.now() >= expiresAt - twoMinutes) {
      console.log('Token expiring soon, refreshing...')
      const { data: refreshData, error: refreshError } = await supabase.auth.refreshSession()

      if (refreshError || !refreshData.session) {
        console.error('Failed to refresh session:', refreshError)
        return false
      }
      console.log('Session refreshed successfully')
    }

    return true
  } catch (err) {
    console.error('Error checking session:', err)
    return false
  }
}
