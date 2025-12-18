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

// Helper to add timeout to promises
function withTimeout<T>(promise: Promise<T>, ms: number): Promise<T> {
  return Promise.race([
    promise,
    new Promise<T>((_, reject) =>
      setTimeout(() => reject(new Error(`Operation timed out after ${ms}ms`)), ms)
    )
  ])
}

/**
 * Ensures the Supabase session is valid before making API calls.
 * Call this before operations that might fail due to stale sessions (e.g., after tab switch).
 * Returns true if session is valid, false if user needs to re-login.
 */
export async function ensureValidSession(): Promise<boolean> {
  try {
    // Get session with 5s timeout
    const { data: { session }, error } = await withTimeout(
      supabase.auth.getSession(),
      5000
    )

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

      // Refresh with 5s timeout
      const { data: refreshData, error: refreshError } = await withTimeout(
        supabase.auth.refreshSession(),
        5000
      )

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
