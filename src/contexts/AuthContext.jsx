import { createContext, useContext, useState, useEffect, useRef } from 'react'
import { supabase } from '../lib/supabaseClient'
import { getUserContext } from '../api/userContext'

const AuthContext = createContext(null)

export function AuthProvider({ children }) {
  const [user, setUser] = useState(null)
  const [profile, setProfile] = useState(null)
  const [memberships, setMemberships] = useState([])
  const [currentSite, setCurrentSite] = useState(null)
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState(null)
  const initialized = useRef(false)
  const loadingContext = useRef(false) // Lock to prevent concurrent loadUserContext calls

  useEffect(() => {
    // Prevent double initialization in React strict mode
    if (initialized.current) return
    initialized.current = true

    // Check for existing session
    checkUser()

    // Listen for auth changes
    const { data: { subscription } } = supabase.auth.onAuthStateChange(async (event, session) => {
      console.log('Auth state change:', event, session?.user?.email)
      if (event === 'SIGNED_IN' && session) {
        await loadUserContext()
      } else if (event === 'SIGNED_OUT') {
        setUser(null)
        setProfile(null)
        setMemberships([])
        setCurrentSite(null)
        setLoading(false)
      }
    })

    // Listen for cross-tab session changes via localStorage
    const handleStorageChange = async (event) => {
      // Supabase stores auth in localStorage with keys starting with 'sb-'
      if (event.key?.startsWith('sb-') && event.key?.includes('auth-token')) {
        console.log('Cross-tab auth change detected')
        if (event.newValue === null) {
          // Session was cleared in another tab
          console.log('Session cleared in another tab, signing out')
          setUser(null)
          setProfile(null)
          setMemberships([])
          setCurrentSite(null)
          setLoading(false)
        } else if (event.newValue && !user) {
          // Session was set in another tab and we don't have a user
          console.log('Session set in another tab, reloading context')
          await loadUserContext()
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

  async function loadUserContext() {
    // Prevent concurrent calls - if already loading, skip
    if (loadingContext.current) {
      console.log('loadUserContext already in progress, skipping...')
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
      
      // CRITICAL FIX: If loading context fails (e.g. timeout or corrupted data),
      // we MUST sign out to clear the bad session from localStorage.
      // Otherwise, the app reloads, sees the session, tries to load context, fails, and loops.
      console.warn('Clearing potentially corrupted session...')
      await supabase.auth.signOut()
      
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
    const { data, error } = await supabase.auth.signInWithPassword({
      email,
      password,
    })

    if (error) {
      setError(error.message)
      throw error
    }

    await loadUserContext()
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
    refreshContext: loadUserContext,
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
