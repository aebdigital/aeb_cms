import { createContext, useContext, useState, useCallback } from 'react'
import { motion, AnimatePresence } from 'framer-motion'
import { CheckCircleIcon, XCircleIcon } from '@heroicons/react/24/solid'

const NotificationContext = createContext(null)

export function NotificationProvider({ children }) {
  const [notification, setNotification] = useState(null)

  const showNotification = useCallback((message, type = 'success', duration = 3000) => {
    setNotification({ message, type })
    setTimeout(() => {
      setNotification(null)
    }, duration)
  }, [])

  const hideNotification = useCallback(() => {
    setNotification(null)
  }, [])

  return (
    <NotificationContext.Provider value={{ showNotification }}>
      {children}
      <AnimatePresence>
        {notification && (
          <div className="fixed inset-0 flex items-center justify-center z-[9999] pointer-events-none">
            <motion.div
              initial={{ opacity: 0, scale: 0.8, y: 20 }}
              animate={{ opacity: 1, scale: 1, y: 0 }}
              exit={{ opacity: 0, scale: 0.8, y: 20 }}
              className="bg-white rounded-2xl shadow-2xl p-8 flex flex-col items-center gap-4 pointer-events-auto border border-gray-100 min-w-[300px]"
            >
              {notification.type === 'success' ? (
                <div className="bg-green-100 p-4 rounded-full">
                  <CheckCircleIcon className="w-16 h-16 text-green-500" />
                </div>
              ) : (
                <div className="bg-red-100 p-4 rounded-full">
                  <XCircleIcon className="w-16 h-16 text-red-500" />
                </div>
              )}
              <p className="text-xl font-bold text-gray-800 text-center">
                {notification.message}
              </p>
            </motion.div>
          </div>
        )}
      </AnimatePresence>
    </NotificationContext.Provider>
  )
}

export function useNotification() {
  const context = useContext(NotificationContext)
  if (!context) {
    throw new Error('useNotification must be used within a NotificationProvider')
  }
  return context
}
