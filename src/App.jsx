import { BrowserRouter as Router, Routes, Route, Navigate } from 'react-router-dom'
import { AuthProvider } from './contexts/AuthContext'
import ProtectedRoute from './components/ProtectedRoute'
import Layout from './components/Layout'
import Projekty from './pages/Projekty'
import Galerie from './pages/Galerie'
import Blogy from './pages/Blogy'
import Kontakt from './pages/Kontakt'
import Nastavenia from './pages/Nastavenia'
import Vozidla from './pages/Vozidla'
import DariusVozidla from './pages/DariusVozidla'
import Oznamy from './pages/Oznamy'
import Dovolenka from './pages/Dovolenka'
import LudusGaleria from './pages/LudusGaleria'
import LudusAktuality from './pages/LudusAktuality'
import LudusProgram from './pages/LudusProgram'
import LudusRepertoar from './pages/LudusRepertoar'
import LegisBlogs from './pages/LegisBlogs'
import Login from './pages/Login'
import CMSDashboard from './pages/CMSDashboard'
import DynamicHomePage from './components/DynamicHomePage'
import NotFound from './pages/NotFound'

function App() {
  return (
    <AuthProvider>
      <Router>
        <Routes>
          {/* Public login route */}
          <Route path="/login" element={<Login />} />

          {/* CMS Dashboard (Supabase-powered page editor) */}
          <Route
            path="/cms"
            element={
              <ProtectedRoute>
                <CMSDashboard />
              </ProtectedRoute>
            }
          />

          {/* All main routes require authentication */}
          <Route
            path="/"
            element={
              <ProtectedRoute>
                <Layout />
              </ProtectedRoute>
            }
          >
            {/* Dynamic home page - redirects to first nav page */}
            <Route index element={<DynamicHomePage />} />
            <Route path="projekty" element={<Projekty />} />
            <Route path="galerie" element={<Galerie />} />
            <Route path="blogy" element={<Blogy />} />
            <Route path="kontakt" element={<Kontakt />} />
            <Route path="nastavenia" element={<Nastavenia />} />
            <Route path="vozidla" element={<Vozidla />} />
            {/* ponuka slug maps to Vozidla component */}
            <Route path="ponuka" element={<Vozidla />} />
            <Route path="oznamy" element={<Oznamy />} />
            <Route path="dovolenka" element={<Dovolenka />} />
            <Route path="darius-vozidla" element={<DariusVozidla />} />
            {/* Ludus Hub specific routes */}
            <Route path="ludus-galeria" element={<LudusGaleria />} />
            <Route path="ludus-aktuality" element={<LudusAktuality />} />
            <Route path="ludus-program" element={<LudusProgram />} />
            <Route path="ludus-repertoar" element={<LudusRepertoar />} />
            <Route path="legis-blogy" element={<LegisBlogs />} />
          </Route>

          {/* Catch all - show 404 if authenticated, otherwise redirect to login */}
          <Route
            path="*"
            element={
              <ProtectedRoute>
                <NotFound />
              </ProtectedRoute>
            }
          />
        </Routes>
      </Router>
    </AuthProvider>
  )
}

export default App
