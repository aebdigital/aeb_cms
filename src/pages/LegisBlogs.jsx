import { useState, useEffect, useRef } from 'react'
import { PlusIcon, PencilIcon, TrashIcon, XMarkIcon } from '@heroicons/react/24/outline'
import { useAuth } from '../contexts/AuthContext'
import { getLegisBlogs, createLegisBlog, updateLegisBlog, deleteLegisBlog, uploadLegisBlogImage } from '../api/legisBlogs'
import LegisBlogPreview from '../components/LegisBlogPreview'

const LANGS = [
    { code: 'sk', label: 'Slovenčina' },
    { code: 'en', label: 'English' },
    { code: 'de', label: 'Deutsch' },
    { code: 'fr', label: 'Français' }
]

const initialTranslation = {
    title: '',
    description: '',
    excerpt: '',
    category: '',
    reading_time: '',
    content: '',
    is_published: false, // Default to draft for new translations
    tags: []
}

const initialForm = {
    slug: '',
    image_url: '',
    is_published: true, // Master switch
    translations: {
        sk: { ...initialTranslation },
        en: { ...initialTranslation },
        de: { ...initialTranslation },
        fr: { ...initialTranslation }
    }
}

export default function LegisBlogs() {
    const { user, currentSite, loading: authLoading } = useAuth()
    const [blogs, setBlogs] = useState([])
    const [loading, setLoading] = useState(false)
    const [initialLoad, setInitialLoad] = useState(true)
    const [error, setError] = useState(null)
    const [showModal, setShowModal] = useState(false)
    const [isEditMode, setIsEditMode] = useState(false)
    const [editingId, setEditingId] = useState(null)
    const [formData, setFormData] = useState(initialForm)
    const [activeLangTab, setActiveLangTab] = useState('sk')
    const [submitting, setSubmitting] = useState(false)
    const fileInputRef = useRef(null)

    // Access Control
    const hasAccess = user?.email?.toLowerCase().includes('kubasky');

    useEffect(() => {
        if (authLoading || !currentSite?.id || !hasAccess) {
            if (!authLoading && !currentSite?.id) setInitialLoad(false)
            return
        }
        loadData()
    }, [currentSite?.id, authLoading, hasAccess])

    if (!authLoading && !hasAccess) return (
        <div className="p-12 text-center bg-white rounded-2xl shadow-lg border border-red-50 max-w-2xl mx-auto mt-20">
            <div className="w-16 h-16 bg-red-100 rounded-full flex items-center justify-center mx-auto mb-4">
                <XMarkIcon className="w-8 h-8 text-red-600" />
            </div>
            <h2 className="text-2xl font-bold text-gray-800 mb-2">Prístup zamietnutý</h2>
            <p className="text-gray-500 italic">Táto sekcia je vyhradená výhradne pre používateľa kubasky.</p>
        </div>
    )

    async function loadData() {
        setLoading(true)
        try {
            const data = await getLegisBlogs(currentSite.id)
            setBlogs(data)
        } catch (err) {
            console.error('Error loading blogs:', err)
            setError('Chyba pri načítavaní')
        } finally {
            setLoading(false)
            setInitialLoad(false)
        }
    }

    const openAddModal = () => {
        setFormData(initialForm)
        setIsEditMode(false)
        setEditingId(null)
        setActiveLangTab('sk')
        setShowModal(true)
    }

    const openEditModal = (blog) => {
        const translations = { ...initialForm.translations }
        blog.translations.forEach(t => {
            translations[t.lang] = {
                title: t.title || '',
                description: t.description || '',
                excerpt: t.excerpt || '',
                category: t.category || '',
                reading_time: t.reading_time || '',
                content: t.content || '',
                is_published: t.is_published ?? false,
                tags: t.tags || []
            }
        })

        setFormData({
            slug: blog.slug,
            image_url: blog.image_url || '',
            is_published: blog.is_published,
            translations
        })
        setIsEditMode(true)
        setEditingId(blog.id)
        setActiveLangTab('sk')
        setShowModal(true)
    }

    const handleSubmit = async () => {
        if (!formData.slug.trim()) return alert('Vyplňte slug')
        setSubmitting(true)
        try {
            const blogData = {
                site_id: currentSite.id,
                slug: formData.slug,
                image_url: formData.image_url,
                is_published: formData.is_published,
                updated_at: new Date().toISOString()
            }
            const translationsData = Object.entries(formData.translations).map(([lang, data]) => ({
                lang,
                ...data
            }))

            if (isEditMode && editingId) {
                await updateLegisBlog(editingId, blogData, translationsData)
            } else {
                const newBlog = await createLegisBlog(blogData, translationsData)
                setEditingId(newBlog.id)
                setIsEditMode(true)
            }
            await loadData()
        } catch (err) {
            console.error('Save error:', err)
            setError('Chyba pri ukladaní - skontrolujte či v DB existuje stĺpec is_published v tabuľke translation')
        } finally {
            setSubmitting(false)
        }
    }

    const handleTransChange = (lang, field, value) => {
        setFormData(prev => ({
            ...prev,
            translations: {
                ...prev.translations,
                [lang]: { ...prev.translations[lang], [field]: value }
            }
        }))
    }

    const handleImageUpload = async (e) => {
        const file = e.target.files[0]
        if (!file) return
        setSubmitting(true)
        try {
            const path = `legispro/blogs/${editingId || 'new'}/${Date.now()}-${file.name}`
            const url = await uploadLegisBlogImage(file, path)
            setFormData(prev => ({ ...prev, image_url: url }))
        } catch (err) {
            console.error(err)
            alert('Upload failed')
        } finally {
            setSubmitting(false)
        }
    }

    const handleDelete = async (id) => {
        if (!confirm('Naozaj vymazať?')) return
        try {
            await deleteLegisBlog(id)
            loadData()
        } catch (err) { console.error(err) }
    }

    if (initialLoad || authLoading) return <div className="p-6 text-center">Načítavam...</div>
    if (!currentSite) return <div className="p-6 text-center text-gray-500">Vyberte stránku</div>

    return (
        <div className="p-6">
            <div className="flex justify-between items-center mb-6">
                <h1 className="text-2xl font-bold text-gray-800">Blogy - {currentSite.name}</h1>
                <button
                    onClick={openAddModal}
                    className="flex items-center gap-2 bg-indigo-600 hover:bg-indigo-700 text-white px-4 py-2 rounded-lg transition-colors"
                >
                    <PlusIcon className="w-5 h-5" />
                    Nový článok
                </button>
            </div>

            <div className="bg-white rounded-xl shadow border border-gray-100 overflow-hidden">
                <table className="w-full text-left">
                    <thead className="bg-gray-50 border-b">
                        <tr>
                            <th className="px-6 py-3 text-xs font-bold text-gray-500 uppercase tracking-widest">URL Slug</th>
                            <th className="px-6 py-3 text-xs font-bold text-gray-500 uppercase tracking-widest">Názov článku</th>
                            <th className="px-6 py-3 text-xs font-bold text-gray-500 uppercase tracking-widest">Stav</th>
                            <th className="px-6 py-3 text-right text-xs font-bold text-gray-500 uppercase tracking-widest">Akcie</th>
                        </tr>
                    </thead>
                    <tbody className="divide-y divide-gray-50 text-sm">
                        {blogs.map(blog => {
                            const skTrans = blog.translations.find(t => t.lang === 'sk')
                            const anyPublished = blog.translations.some(t => t.is_published)
                            return (
                                <tr key={blog.id} className="hover:bg-gray-50 group">
                                    <td className="px-6 py-4 font-medium text-gray-900">{blog.slug}</td>
                                    <td className="px-6 py-4 text-gray-600">{skTrans?.title || 'Bez názvu'}</td>
                                    <td className="px-6 py-4">
                                        <span className={`px-2 py-0.5 rounded-full text-[10px] font-bold ${anyPublished ? 'bg-green-100 text-green-700' : 'bg-gray-100 text-gray-400'}`}>
                                            {anyPublished ? 'VIEWABLE' : 'ALL DRAFT'}
                                        </span>
                                    </td>
                                    <td className="px-6 py-4 text-right">
                                        <div className="flex justify-end gap-2 opacity-0 group-hover:opacity-100 transition-opacity">
                                            <button onClick={() => openEditModal(blog)} title="Upraviť"><PencilIcon className="w-5 h-5 text-indigo-600" /></button>
                                            <button onClick={() => handleDelete(blog.id)} title="Zmazať"><TrashIcon className="w-5 h-5 text-red-600" /></button>
                                        </div>
                                    </td>
                                </tr>
                            )
                        })}
                    </tbody>
                </table>
            </div>

            {showModal && (
                <div className="fixed inset-0 bg-slate-900/40 backdrop-blur-sm flex items-center justify-center z-50">
                    <div className="bg-white w-[98vw] h-[98vh] flex flex-col rounded-2xl shadow-2xl overflow-hidden">
                        {/* Header Bar */}
                        <div className="h-16 shrink-0 border-b flex items-center justify-between px-6 bg-white z-10">
                            <div className="flex items-center gap-6">
                                <button onClick={() => setShowModal(false)} className="p-2 hover:bg-gray-100 rounded-full transition-all">
                                    <XMarkIcon className="w-6 h-6 text-gray-400" />
                                </button>
                                <div className="h-6 w-px bg-gray-200" />
                                <div className="flex bg-gray-100 p-1 rounded-xl">
                                    {LANGS.map(l => {
                                        const isDraft = !formData.translations[l.code].is_published;
                                        return (
                                            <button
                                                key={l.code}
                                                onClick={() => setActiveLangTab(l.code)}
                                                className={`px-4 py-1.5 rounded-lg text-xs font-bold transition-all relative ${activeLangTab === l.code ? 'bg-white text-indigo-600 shadow-sm' : 'text-gray-500 hover:text-gray-800'}`}
                                            >
                                                {l.label.toUpperCase()}
                                                {isDraft && <span className="absolute top-0 right-0 w-1.5 h-1.5 bg-red-400 rounded-full border border-white translate-x-1/2 -translate-y-1/2" title="Draft" />}
                                            </button>
                                        );
                                    })}
                                </div>
                            </div>

                            <button
                                onClick={handleSubmit}
                                disabled={submitting}
                                className="px-10 py-2.5 bg-indigo-600 hover:bg-indigo-700 text-white rounded-xl font-bold text-sm shadow-xl shadow-indigo-200 disabled:opacity-50 transition-all active:scale-95"
                            >
                                {submitting ? 'UKLADÁM...' : 'ULOŽIŤ ZMENY'}
                            </button>
                        </div>

                        {/* Main Editor Surface */}
                        <div className="flex-1 flex overflow-hidden">
                            {/* Permanently Visible Left Sidebar */}
                            <div className="w-80 shrink-0 border-r bg-gray-50/50 p-6 overflow-y-auto space-y-8">
                                <div>
                                    <h3 className="text-[10px] font-black text-gray-400 uppercase tracking-[0.2em] mb-4">Blog Status ({activeLangTab.toUpperCase()})</h3>
                                    <div className="space-y-4">
                                        <div className="flex items-center justify-between p-4 bg-white border-2 border-dashed border-gray-200 rounded-xl">
                                            <div>
                                                <p className="text-[10px] font-black text-gray-400 uppercase mb-1">Zobraziť na webe</p>
                                                <p className="text-[11px] text-gray-500">Iba pre {LANGS.find(l => l.code === activeLangTab).label}</p>
                                            </div>
                                            <button
                                                onClick={() => handleTransChange(activeLangTab, 'is_published', !formData.translations[activeLangTab].is_published)}
                                                className={`px-4 py-1.5 rounded-full text-[10px] font-black transition-all ${formData.translations[activeLangTab].is_published ? 'bg-green-500 text-white shadow-lg shadow-green-100' : 'bg-gray-200 text-gray-500'}`}
                                            >
                                                {formData.translations[activeLangTab].is_published ? 'PUBLIKOVANÉ' : 'DRAFT'}
                                            </button>
                                        </div>
                                    </div>
                                </div>

                                <div>
                                    <h3 className="text-[10px] font-black text-gray-400 uppercase tracking-[0.2em] mb-4">Globálne info</h3>
                                    <div>
                                        <label className="block text-[10px] font-bold text-gray-500 mb-1">URL SLUG (IDENTIFIKÁTOR)</label>
                                        <input
                                            type="text"
                                            value={formData.slug}
                                            onChange={(e) => setFormData(prev => ({ ...prev, slug: e.target.value }))}
                                            className="w-full bg-white border border-gray-200 rounded-lg px-3 py-2 text-sm focus:ring-2 focus:ring-indigo-500 outline-none"
                                        />
                                    </div>
                                </div>

                                <div>
                                    <h3 className="text-[10px] font-black text-gray-400 uppercase tracking-[0.2em] mb-4">Metadata - {activeLangTab.toUpperCase()}</h3>
                                    <div className="space-y-4">
                                        <div>
                                            <label className="block text-[10px] font-bold text-gray-500 mb-1">KATEGÓRIA</label>
                                            <input
                                                type="text"
                                                value={formData.translations[activeLangTab].category}
                                                onChange={(e) => handleTransChange(activeLangTab, 'category', e.target.value)}
                                                className="w-full bg-white border border-gray-200 rounded-lg px-3 py-2 text-sm"
                                            />
                                        </div>
                                        <div>
                                            <label className="block text-[10px] font-bold text-gray-500 mb-1">ČAS ČÍTANIA</label>
                                            <input
                                                type="text"
                                                value={formData.translations[activeLangTab].reading_time}
                                                onChange={(e) => handleTransChange(activeLangTab, 'reading_time', e.target.value)}
                                                className="w-full bg-white border border-gray-200 rounded-lg px-3 py-2 text-sm"
                                                placeholder="napr. 5 min"
                                            />
                                        </div>
                                    </div>
                                </div>
                            </div>

                            {/* Main Content Pane */}
                            <div className="flex-1 overflow-y-auto bg-gray-100/30">
                                <div className="w-full min-h-full">
                                    <LegisBlogPreview
                                        key={`${activeLangTab}-${editingId}`}
                                        post={formData}
                                        lang={activeLangTab}
                                        onUpdate={(field, val) => handleTransChange(activeLangTab, field, val)}
                                        onImageEdit={() => fileInputRef.current?.click()}
                                    />
                                    <input type="file" ref={fileInputRef} onChange={handleImageUpload} className="hidden" accept="image/*" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            )}
        </div>
    )
}
