import { useAuth } from '../contexts/AuthContext'
import { translations, type Lang, type TranslationKey } from './translations'

export function useTranslation() {
  const { profile } = useAuth()
  const lang: Lang = profile?.lang || 'sk'

  const t = (key: TranslationKey, overrideLang?: Lang): string => {
    const activeLang = overrideLang || lang
    return translations[key]?.[activeLang] || translations[key]?.['sk'] || key
  }

  // Helper to translate equipment category names
  const tCategory = (categoryName: string, overrideLang?: Lang): string => {
    const activeLang = overrideLang || lang
    const key = `cat_${categoryName}` as TranslationKey
    return translations[key]?.[activeLang] || translations[key]?.['sk'] || categoryName
  }

  // Helper to translate equipment option names
  const tEquipment = (optionName: string, overrideLang?: Lang): string => {
    const activeLang = overrideLang || lang
    const key = `eq_${optionName}` as TranslationKey
    return translations[key]?.[activeLang] || translations[key]?.['sk'] || optionName
  }

  return { t, tCategory, tEquipment, lang }
}
