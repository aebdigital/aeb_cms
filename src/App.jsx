import { BrowserRouter as Router, Routes, Route, Navigate } from 'react-router-dom'
import { useEffect } from 'react'
import { AuthProvider, useAuth } from './contexts/AuthContext'
import { NotificationProvider } from './contexts/NotificationContext'
import ProtectedRoute from './components/ProtectedRoute'
import Layout from './components/Layout'
import { KOCHLIK_OWNER_EMAIL, KOCHLIK_OWNER_ID, KOCHLIK_SITE_SLUG } from './api/kochlik'
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
import ViktorijaBookings from './pages/ViktorijaBookings'
import Login from './pages/Login'
import CMSDashboard from './pages/CMSDashboard'
import GalleryManager from './pages/GalleryManager'
import DynamicHomePage from './components/DynamicHomePage'
import VisualBuilder from './pages/VisualBuilder'
import VisualPagesList from './pages/VisualPagesList'
import BlogsList from './pages/BlogsList'
import BlogEditor from './pages/BlogEditor'
import LexanBlogsList from './pages/LexanBlogsList'
import LexanBlogEditor from './pages/LexanBlogEditor'
import EspronGaleria from './pages/EspronGaleria'
import LuskReferences from './pages/LuskReferences'
import VavrostavOrders from './pages/VavrostavOrders'
import VavrostavProducts from './pages/VavrostavProducts'
import VavrostavCategories from './pages/VavrostavCategories'
import KochlikProducts from './pages/KochlikProducts'
import KochlikCategories from './pages/KochlikCategories'
import KochlikContent from './pages/KochlikContent'
import KochlikBlogs from './pages/KochlikBlogs'
import KochlikColors from './pages/KochlikColors'
import NotFound from './pages/NotFound'

function AppShell() {
  const { user, currentSite } = useAuth()
  const isKochlikCms = user?.email === KOCHLIK_OWNER_EMAIL
    || user?.id === KOCHLIK_OWNER_ID
    || currentSite?.slug === KOCHLIK_SITE_SLUG

  useEffect(() => {
    document.body.classList.toggle('kochlik-cms-font', isKochlikCms)

    return () => {
      document.body.classList.remove('kochlik-cms-font')
    }
  }, [isKochlikCms])

  return (
    <div className={isKochlikCms ? 'kochlik-cms-font min-h-full' : 'min-h-full'}>
      <NotificationProvider>
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

            {/* Visual Builder full-screen editor (standalone) */}
            <Route
              path="/visual-builder/edit/:id?"
              element={
                <ProtectedRoute>
                  <VisualBuilder />
                </ProtectedRoute>
              }
            />

            {/* Espron blog editor (standalone full-screen) */}
            <Route
              path="/espron-blog/edit/:id?"
              element={
                <ProtectedRoute>
                  <BlogEditor />
                </ProtectedRoute>
              }
            />

            {/* Lexan blog editor (standalone full-screen) */}
            <Route
              path="/lexan-blog/edit/:id?"
              element={
                <ProtectedRoute>
                  <LexanBlogEditor />
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
              <Route path="galerie" element={<GalleryManager />} />
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
              <Route path="viktorija" element={<ViktorijaBookings />} />
              <Route path="visual-builder" element={<VisualPagesList />} />
              <Route path="espron-blog" element={<BlogsList />} />
              <Route path="lexan-blog" element={<LexanBlogsList />} />
              <Route path="espron-galeria" element={<EspronGaleria />} />
              <Route path="lusk-references" element={<LuskReferences mode="kolekcie" />} />
              <Route path="lusk-realizacie" element={<LuskReferences mode="realizacie" />} />
              <Route path="vavrostav-objednavky" element={<VavrostavOrders />} />
              <Route path="vavrostav-produkty" element={<VavrostavProducts />} />
              <Route path="vavrostav-kategorie" element={<VavrostavCategories />} />
              <Route path="vavrostav-obchod" element={<Navigate to="/vavrostav-objednavky" replace />} />
              <Route path="kochlik-produkty" element={<KochlikProducts />} />
              <Route path="kochlik-kategorie" element={<KochlikCategories />} />
              <Route path="kochlik-obsah" element={<KochlikContent />} />
              <Route path="kochlik-blog" element={<KochlikBlogs />} />
              <Route path="kochlik-farby" element={<KochlikColors />} />
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
      </NotificationProvider>
    </div>
  )
}

function App() {
  return (
    <AuthProvider>
      <AppShell />
    </AuthProvider>
  )
}

export default App
