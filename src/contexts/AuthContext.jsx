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

  useEffect(() => {
    // Prevent double initialization in React strict mode
    if (initialized.current) return
    initialized.current = true

    // Check for existing session
    checkUser()

    // Safety timeout - ensure loading stops eventually
    const timeoutTimer = setTimeout(() => {
      if (loading) {
        console.warn('Auth check timed out, forcing loading false')
        setLoading(false)
      }
    }, 5000)

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

    return () => {
      clearTimeout(timeoutTimer)
      subscription?.unsubscribe()
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
      // Clear user state on error
      setUser(null)
      setProfile(null)
      setMemberships([])
      setCurrentSite(null)
    } finally {
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
