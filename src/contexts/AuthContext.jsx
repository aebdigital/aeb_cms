import { createContext, useContext, useState, useEffect, useRef } from 'react'
import { supabase } from '../lib/supabaseClient'
import { getUserContext } from '../api/userContext'

const AuthContext = createContext(null)

// Helper to clear all Supabase auth data from localStorage
function clearSupabaseAuth() {
  const keysToRemove = []
  for (let i = 0; i < localStorage.length; i++) {
    const key = localStorage.key(i)
    if (key && key.startsWith('sb-')) {
      keysToRemove.push(key)
    }
  }
  keysToRemove.forEach(key => localStorage.removeItem(key))
  console.log('Cleared Supabase auth keys:', keysToRemove.length)
}

// Check if a JWT token is expired (with 60s buffer)
function isTokenExpired(token) {
  if (!token) return true
  try {
    const payload = JSON.parse(atob(token.split('.')[1]))
    const expiresAt = payload.exp * 1000 // Convert to milliseconds
    const now = Date.now()
    const buffer = 60 * 1000 // 60 second buffer
    return now >= (expiresAt - buffer)
  } catch {
    return true // If we can't parse, assume expired
  }
}

export function AuthProvider({ children }) {
  const [user, setUser] = useState(null)
  const [profile, setProfile] = useState(null)
  const [memberships, setMemberships] = useState([])
  const [currentSite, setCurrentSite] = useState(null)
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState(null)
  const initialized = useRef(false)
  const loadingContext = useRef(false) // Lock to prevent concurrent loadUserContext calls
  const authFailed = useRef(false) // Track if auth has already failed to prevent loop

  useEffect(() => {
    // Prevent double initialization in React strict mode
    if (initialized.current) return
    initialized.current = true

    // Check for existing session
    checkUser()

    // Listen for auth changes - but IGNORE the initial SIGNED_IN event
    // because checkUser() handles the initial session validation with token expiry checks
    let isInitialEvent = true
    const { data: { subscription } } = supabase.auth.onAuthStateChange(async (event, session) => {
      console.log('Auth state change:', event, session?.user?.email, isInitialEvent ? '(initial)' : '')

      if (event === 'SIGNED_IN' && session) {
        // Skip the initial SIGNED_IN event - checkUser() handles it with proper validation
        if (isInitialEvent) {
          isInitialEvent = false
          return
        }
        // For subsequent SIGNED_IN events (e.g., after login), load context
        await loadUserContext()
      } else if (event === 'SIGNED_OUT') {
        isInitialEvent = false
        authFailed.current = false // Reset so user can login again
        setUser(null)
        setProfile(null)
        setMemberships([])
        setCurrentSite(null)
        setLoading(false)
      } else if (event === 'TOKEN_REFRESHED' && session) {
        // Token was refreshed successfully - this is good, no action needed
        isInitialEvent = false
        console.log('Token refreshed successfully')
      } else {
        isInitialEvent = false
      }
    })

    // Listen for cross-tab session changes via localStorage
    const handleStorageChange = async (event) => {
      // Supabase stores auth in localStorage with keys starting with 'sb-'
      if (event.key?.startsWith('sb-') && event.key?.includes('auth-token')) {
        console.log('Cross-tab auth change detected:', event.key)
        if (event.newValue === null) {
          // Session was cleared in another tab
          console.log('Session cleared in another tab, signing out')
          authFailed.current = false // Reset so user can login again
          setUser(null)
          setProfile(null)
          setMemberships([])
          setCurrentSite(null)
          setLoading(false)
        } else if (event.newValue) {
          // Session was updated in another tab - re-check our auth state
          console.log('Session updated in another tab, checking auth state')
          const { data: { session } } = await supabase.auth.getSession()
          if (session && !user) {
            authFailed.current = false // Reset to allow loading
            await loadUserContext()
          }
        }
      }
    }
    window.addEventListener('storage', handleStorageChange)

    return () => {
      subscription?.unsubscribe()
      window.removeEventListener('storage', handleStorageChange)
    }
  }, [])

  async function checkUser() {
    try {
      console.log('Checking for existing session...')
      const { data: { session }, error: sessionError } = await supabase.auth.getSession()

      if (sessionError) {
        console.error('Session error:', sessionError)
        setLoading(false)
        return
      }

      console.log('Session check result:', session ? 'Has session' : 'No session')

      if (session?.user) {
        // Check if access token is expired before trying to use it
        if (isTokenExpired(session.access_token)) {
          console.log('Access token expired, checking refresh token...')

          // Also check if refresh token is expired
          if (isTokenExpired(session.refresh_token)) {
            console.log('Refresh token also expired, clearing session')
            clearSupabaseAuth()
            await supabase.auth.signOut({ scope: 'local' })
            setLoading(false)
            return
          }

          // Try to refresh the session
          console.log('Attempting to refresh session...')
          const { data: refreshData, error: refreshError } = await supabase.auth.refreshSession()

          if (refreshError || !refreshData.session) {
            console.error('Failed to refresh session:', refreshError)
            clearSupabaseAuth()
            await supabase.auth.signOut({ scope: 'local' })
            setLoading(false)
            return
          }

          console.log('Session refreshed successfully')
        }

        await loadUserContext()
      } else {
        // No session - user needs to login
        setLoading(false)
      }
    } catch (err) {
      console.error('Error checking user:', err)
      setError(err.message)
      setLoading(false)
    }
  }

  async function loadUserContext(forceReload = false) {
    // Prevent concurrent calls - if already loading, skip
    if (loadingContext.current) {
      console.log('loadUserContext already in progress, skipping...')
      return
    }

    // Prevent infinite loop - if auth already failed, don't retry
    if (authFailed.current) {
      console.log('Auth previously failed, not retrying to prevent loop')
      setLoading(false)
      return
    }

    // If user is already loaded and not forcing reload, skip
    // This prevents unnecessary reloads on tab switches
    if (user && !forceReload) {
      console.log('User already loaded, skipping reload')
      setLoading(false)
      return
    }

    loadingContext.current = true

    try {
      console.log('Loading user context...')
      const context = await getUserContext()
      console.log('User context loaded:', context.user?.email)
      setUser(context.user)
      setProfile(context.profile)
      setMemberships(context.memberships)
      authFailed.current = false // Reset on success

      // Set first site as default if none selected
      if (context.memberships.length > 0) {
        const defaultSite = context.memberships[0].sites
        setCurrentSite(prev => {
          if (prev?.id === defaultSite.id) return prev
          return defaultSite
        })
      }
    } catch (err) {
      console.error('Error loading user context:', err)
      setError(err.message)

      // Mark auth as failed to prevent infinite retry loop
      authFailed.current = true

      // Clear ALL Supabase auth data from localStorage (not just signOut)
      // This ensures corrupted sessions are fully removed
      console.warn('Clearing corrupted session from localStorage...')
      clearSupabaseAuth()

      // Also call signOut to clean up Supabase client state
      try {
        await supabase.auth.signOut({ scope: 'local' })
      } catch (signOutErr) {
        console.warn('SignOut error (ignoring):', signOutErr)
      }

      // Clear user state
      setUser(null)
      setProfile(null)
      setMemberships([])
      setCurrentSite(null)
    } finally {
      loadingContext.current = false
      setLoading(false)
    }
  }

  async function login(email, password) {
    setError(null)
    authFailed.current = false // Reset on new login attempt

    const { data, error } = await supabase.auth.signInWithPassword({
      email,
      password,
    })

    if (error) {
      setError(error.message)
      throw error
    }

    await loadUserContext(true) // Force reload after login
    return data
  }

  async function logout() {
    const { error } = await supabase.auth.signOut()
    if (error) {
      setError(error.message)
      throw error
    }

    setUser(null)
    setProfile(null)
    setMemberships([])
    setCurrentSite(null)
  }

  function selectSite(site) {
    setCurrentSite(site)
  }

  const value = {
    user,
    profile,
    memberships,
    currentSite,
    loading,
    error,
    login,
    logout,
    selectSite,
    refreshContext: () => loadUserContext(true), // Always force reload when manually refreshing
  }

  return (
    <AuthContext.Provider value={value}>
      {children}
    </AuthContext.Provider>
  )
}

export function useAuth() {
  const context = useContext(AuthContext)
  if (!context) {
    throw new Error('useAuth must be used within an AuthProvider')
  }
  return context
}
