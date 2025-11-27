import { BrowserRouter as Router, Routes, Route } from 'react-router-dom'
import Layout from './components/Layout'
import Homepage from './pages/Homepage'
import Galerie from './pages/Galerie'
import Blogy from './pages/Blogy'
import Kontakt from './pages/Kontakt'
import Nastavenia from './pages/Nastavenia'

function App() {
  return (
    <Router>
      <Routes>
        <Route path="/" element={<Layout />}>
          <Route index element={<Homepage />} />
          <Route path="galerie" element={<Galerie />} />
          <Route path="blogy" element={<Blogy />} />
          <Route path="kontakt" element={<Kontakt />} />
          <Route path="nastavenia" element={<Nastavenia />} />
        </Route>
      </Routes>
    </Router>
  )
}

export default App
