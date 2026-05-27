import { useEffect, useState } from 'react'
import { CheckCircleIcon, PencilSquareIcon, PlusIcon, TagIcon, TrashIcon, XMarkIcon } from '@heroicons/react/24/outline'
import { useAuth } from '../contexts/AuthContext'
import { useNotification } from '../contexts/NotificationContext'
import {
  KOCHLIK_OWNER_ID,
  createKochlikCategory,
  deleteKochlikCategory,
  listKochlikCategories,
  updateKochlikCategory,
} from '../api'

const EMPTY_CATEGORY = {
  name: '',
  slug: '',
  description: '',
  sort_order: 0,
  is_active: true,
}

function slugify(value) {
  return value
    .toLowerCase()
    .normalize('NFD')
    .replace(/[\u0300-\u036f]/g, '')
    .replace(/[^a-z0-9]+/g, '-')
    .replace(/^-+|-+$/g, '')
}

export default function KochlikCategories() {
  const { user, loading: authLoading } = useAuth()
  const { showNotification } = useNotification()
  const [categories, setCategories] = useState([])
  const [loading, setLoading] = useState(true)
  const [savingCategory, setSavingCategory] = useState(false)
  const [editingCategory, setEditingCategory] = useState(null)
  const [categoryForm, setCategoryForm] = useState(EMPTY_CATEGORY)
  const [isModalOpen, setIsModalOpen] = useState(false)

  const hasAccess = user?.id === KOCHLIK_OWNER_ID || user?.email === 'alexander.hidveghy@gmail.com'

  useEffect(() => {
    if (authLoading || !hasAccess) return
    loadData()
  }, [authLoading, hasAccess])

  async function loadData() {
    setLoading(true)
    try {
      const nextCategories = await listKochlikCategories()
      setCategories(nextCategories)
    } catch (err) {
      console.error('Kochlik category load error:', err)
      showNotification('Nepodarilo sa načítať kategórie', 'error')
    } finally {
      setLoading(false)
    }
  }

  function openCreateModal() {
    setEditingCategory(null)
    setCategoryForm(EMPTY_CATEGORY)
    setIsModalOpen(true)
  }

  function openEditModal(cat) {
    setEditingCategory(cat)
    setCategoryForm({
      name: cat.name,
      slug: cat.slug,
      description: cat.description || '',
      sort_order: cat.sort_order,
      is_active: cat.is_active,
    })
    setIsModalOpen(true)
  }

  function closeModal() {
    setIsModalOpen(false)
    setEditingCategory(null)
    setCategoryForm(EMPTY_CATEGORY)
  }

  async function handleSubmitCategory(event) {
    event.preventDefault()
    const payload = {
      name: categoryForm.name.trim(),
      slug: (categoryForm.slug || slugify(categoryForm.name)).trim(),
      description: categoryForm.description.trim() || null,
      sort_order: Number(categoryForm.sort_order || 0),
      is_active: Boolean(categoryForm.is_active),
    }

    if (!payload.name || !payload.slug) {
      showNotification('Vyplňte názov kategórie', 'error')
      return
    }

    setSavingCategory(true)
    try {
      if (editingCategory) {
        const updated = await updateKochlikCategory(editingCategory.id, payload)
        setCategories(prev => prev.map(c => c.id === updated.id ? updated : c))
        showNotification('Kategória bola uložená', 'success')
      } else {
        const created = await createKochlikCategory(payload)
        setCategories(prev => [...prev, created])
        showNotification('Kategória bola pridaná', 'success')
      }
      closeModal()
    } catch (err) {
      console.error('Kochlik category save error:', err)
      showNotification(err.message || 'Kategóriu sa nepodarilo uložiť', 'error')
    } finally {
      setSavingCategory(false)
    }
  }

  async function handleDeleteCategory(cat) {
    if (!confirm(`Naozaj vymazať kategóriu "${cat.name}"?`)) return
    try {
      await deleteKochlikCategory(cat.id)
      setCategories(prev => prev.filter(c => c.id !== cat.id))
      showNotification('Kategória bola vymazaná', 'success')
    } catch (err) {
      console.error('Kochlik category delete error:', err)
      showNotification('Kategóriu sa nepodarilo vymazať', 'error')
    }
  }

  if (authLoading) return <div className="flex h-64 items-center justify-center"><div className="h-8 w-8 animate-spin rounded-full border-b-2 border-emerald-600"></div></div>
  if (!hasAccess) return <div className="flex h-64 items-center justify-center"><p className="text-gray-500">Nemáte prístup.</p></div>

  return (
    <div className="space-y-6">
      <div className="flex flex-col gap-4 lg:flex-row lg:items-end lg:justify-between">
        <div>
          <p className="text-sm font-semibold uppercase tracking-[0.18em] text-emerald-700">Kochlik</p>
          <h1 className="mt-1 text-3xl font-bold text-gray-950">Kategórie</h1>
        </div>
        <button
          onClick={openCreateModal}
          className="inline-flex items-center justify-center rounded-2xl bg-emerald-600 px-5 py-3 text-sm font-extrabold text-white transition hover:bg-emerald-700"
        >
          <PlusIcon className="mr-2 h-5 w-5" />
          Pridať kategóriu
        </button>
      </div>

      {loading ? (
        <div className="rounded-3xl bg-white p-12 text-center text-gray-500 shadow-sm ring-1 ring-gray-100">
          Načítavam kategórie...
        </div>
      ) : (
        <div className="overflow-x-auto rounded-3xl bg-white shadow-sm ring-1 ring-gray-100">
          <table className="min-w-full divide-y divide-gray-200">
            <thead className="bg-gray-50">
              <tr>
                <th className="px-6 py-4 text-left text-xs font-medium uppercase tracking-wider text-gray-500">Názov</th>
                <th className="px-6 py-4 text-left text-xs font-medium uppercase tracking-wider text-gray-500">URL slug</th>
                <th className="px-6 py-4 text-left text-xs font-medium uppercase tracking-wider text-gray-500">Popis</th>
                <th className="px-6 py-4 text-left text-xs font-medium uppercase tracking-wider text-gray-500">Poradie</th>
                <th className="px-6 py-4 text-left text-xs font-medium uppercase tracking-wider text-gray-500">Stav</th>
                <th className="px-6 py-4 text-right text-xs font-medium uppercase tracking-wider text-gray-500">Akcie</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-gray-200 bg-white">
              {categories.length === 0 ? (
                <tr>
                  <td colSpan="6" className="px-6 py-12 text-center text-sm text-gray-500">
                    Zatiaľ nemáte žiadne kategórie.
                  </td>
                </tr>
              ) : categories.sort((a, b) => a.sort_order - b.sort_order).map(cat => (
                <tr key={cat.id} className="transition hover:bg-gray-50">
                  <td className="whitespace-nowrap px-6 py-4">
                    <div className="flex items-center">
                      <TagIcon className="mr-3 h-5 w-5 text-gray-400" />
                      <div className="text-sm font-bold text-gray-900">{cat.name}</div>
                    </div>
                  </td>
                  <td className="whitespace-nowrap px-6 py-4">
                    <div className="text-sm text-gray-500">/{cat.slug}</div>
                  </td>
                  <td className="px-6 py-4">
                    <div className="max-w-[250px] truncate text-sm text-gray-500">{cat.description || '-'}</div>
                  </td>
                  <td className="whitespace-nowrap px-6 py-4">
                    <div className="text-sm text-gray-500">{cat.sort_order}</div>
                  </td>
                  <td className="whitespace-nowrap px-6 py-4">
                    <span className={`inline-flex rounded-full px-2 py-1 text-xs font-semibold leading-5 ${
                      cat.is_active ? 'bg-green-100 text-green-800' : 'bg-gray-100 text-gray-800'
                    }`}>
                      {cat.is_active ? 'Aktívna' : 'Skrytá'}
                    </span>
                  </td>
                  <td className="whitespace-nowrap px-6 py-4 text-right text-sm font-medium">
                    <button onClick={() => openEditModal(cat)} className="mr-3 inline-flex items-center text-indigo-600 hover:text-indigo-900">
                      <PencilSquareIcon className="mr-1 h-4 w-4" />
                      Upraviť
                    </button>
                    <button onClick={() => handleDeleteCategory(cat)} className="inline-flex items-center text-red-600 hover:text-red-900">
                      <TrashIcon className="mr-1 h-4 w-4" />
                      Vymazať
                    </button>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      )}

      {isModalOpen && (
        <div className="fixed inset-0 z-50 flex items-center justify-center bg-gray-900/50 px-4 backdrop-blur-sm">
          <div className="relative w-full max-w-lg rounded-3xl bg-white shadow-2xl">
            <div className="flex items-center justify-between border-b border-gray-100 px-6 py-4">
              <h2 className="text-xl font-bold text-gray-950">{editingCategory ? 'Upraviť kategóriu' : 'Nová kategória'}</h2>
              <button onClick={closeModal} className="rounded-full p-2 text-gray-400 transition hover:bg-gray-100 hover:text-gray-600">
                <XMarkIcon className="h-6 w-6" />
              </button>
            </div>

            <form onSubmit={handleSubmitCategory} className="p-6">
              <div className="space-y-4">
                <label className="block">
                  <span className="text-sm font-semibold text-gray-700">Názov</span>
                  <input
                    value={categoryForm.name}
                    onChange={(e) => setCategoryForm(prev => ({ ...prev, name: e.target.value, slug: editingCategory ? prev.slug : slugify(e.target.value) }))}
                    className="mt-1 w-full rounded-xl border border-gray-200 px-3 py-2"
                    required
                  />
                </label>
                <label className="block">
                  <span className="text-sm font-semibold text-gray-700">URL slug</span>
                  <input
                    value={categoryForm.slug}
                    onChange={(e) => setCategoryForm(prev => ({ ...prev, slug: slugify(e.target.value) }))}
                    className="mt-1 w-full rounded-xl border border-gray-200 px-3 py-2"
                    required
                  />
                </label>
                <label className="block">
                  <span className="text-sm font-semibold text-gray-700">Popis</span>
                  <textarea
                    rows={3}
                    value={categoryForm.description}
                    onChange={(e) => setCategoryForm(prev => ({ ...prev, description: e.target.value }))}
                    className="mt-1 w-full rounded-xl border border-gray-200 px-3 py-2"
                  />
                </label>
                <label className="block">
                  <span className="text-sm font-semibold text-gray-700">Poradie</span>
                  <input
                    type="number"
                    min="0"
                    value={categoryForm.sort_order}
                    onChange={(e) => setCategoryForm(prev => ({ ...prev, sort_order: e.target.value }))}
                    className="mt-1 w-full rounded-xl border border-gray-200 px-3 py-2"
                  />
                </label>
                <label className="flex items-center gap-2 text-sm font-semibold text-gray-700">
                  <input
                    type="checkbox"
                    checked={categoryForm.is_active}
                    onChange={(e) => setCategoryForm(prev => ({ ...prev, is_active: e.target.checked }))}
                    className="h-4 w-4 rounded border-gray-300 text-emerald-600"
                  />
                  Aktívna na webe
                </label>

                <div className="mt-6 flex justify-end gap-3 border-t border-gray-100 pt-4">
                  <button type="button" onClick={closeModal} className="rounded-xl bg-gray-100 px-5 py-3 text-sm font-bold text-gray-700 transition hover:bg-gray-200">
                    Zrušiť
                  </button>
                  <button type="submit" disabled={savingCategory} className="inline-flex items-center justify-center gap-2 rounded-xl bg-emerald-600 px-6 py-3 text-sm font-extrabold text-white transition hover:bg-emerald-700 disabled:opacity-60">
                    {editingCategory ? <CheckCircleIcon className="h-5 w-5" /> : <PlusIcon className="h-5 w-5" />}
                    {savingCategory ? 'Ukladám...' : editingCategory ? 'Uložiť kategóriu' : 'Pridať kategóriu'}
                  </button>
                </div>
              </div>
            </form>
          </div>
        </div>
      )}
    </div>
  )
}
