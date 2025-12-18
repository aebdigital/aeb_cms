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

// Refresh session when tab becomes visible (after being in background)
if (typeof document !== 'undefined') {
  document.addEventListener('visibilitychange', async () => {
    if (document.visibilityState === 'visible') {
      console.log('Tab became visible, refreshing session...')
      try {
        const { error } = await supabase.auth.refreshSession()
        if (error) {
          console.warn('Background refresh failed:', error.message)
        } else {
          console.log('Session refreshed on tab focus')
        }
      } catch (err) {
        console.warn('Error refreshing session on visibility change:', err)
      }
    }
  })
}

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
 * Tries to ensure the Supabase session is valid before making API calls.
 * Attempts to refresh if needed, but always returns true to let the API call proceed.
 * The actual API call will handle auth errors if the session is truly invalid.
 */
export async function ensureValidSession(): Promise<boolean> {
  try {
    // Get session with 5s timeout
    const { data: { session } } = await withTimeout(
      supabase.auth.getSession(),
      5000
    )

    if (!session) {
      console.log('No session found')
      return true // Let the API call proceed - it will fail with proper auth error
    }

    // Check if token is close to expiry (within 5 minutes)
    try {
      const tokenPayload = JSON.parse(atob(session.access_token.split('.')[1]))
      const expiresAt = tokenPayload.exp * 1000
      const fiveMinutes = 5 * 60 * 1000

      if (Date.now() >= expiresAt - fiveMinutes) {
        console.log('Token expiring soon, refreshing...')

        // Try to refresh with 10s timeout - don't fail if this doesn't work
        try {
          await withTimeout(supabase.auth.refreshSession(), 10000)
          console.log('Session refreshed successfully')
        } catch (refreshErr) {
          console.warn('Session refresh failed, proceeding anyway:', refreshErr)
        }
      }
    } catch {
      // Token parsing failed, proceed anyway
    }

    return true
  } catch (err) {
    console.warn('Session check error, proceeding anyway:', err)
    return true // Always return true - let the actual API call handle auth errors
  }
}
