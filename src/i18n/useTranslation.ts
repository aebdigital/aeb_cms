import { useAuth } from '../contexts/AuthContext'
import { translations, type Lang, type TranslationKey } from './translations'

export function useTranslation() {
  const { profile } = useAuth()
  const lang: Lang = profile?.lang || 'sk'

  const t = (key: TranslationKey): string => {
    return translations[key]?.[lang] || translations[key]?.['sk'] || key
  }

  // Helper to translate equipment category names
  const tCategory = (categoryName: string): string => {
    const key = `cat_${categoryName}` as TranslationKey
    return translations[key]?.[lang] || translations[key]?.['sk'] || categoryName
  }

  // Helper to translate equipment option names
  const tEquipment = (optionName: string): string => {
    const key = `eq_${optionName}` as TranslationKey
    return translations[key]?.[lang] || translations[key]?.['sk'] || optionName
  }

  return { t, tCategory, tEquipment, lang }
}
