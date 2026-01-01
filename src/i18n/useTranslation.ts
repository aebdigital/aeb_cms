import { useAuth } from '../contexts/AuthContext'
import { translations, type Lang, type TranslationKey } from './translations'

export function useTranslation() {
  const { profile } = useAuth()
  const lang: Lang = profile?.lang || 'sk'

  const t = (key: TranslationKey): string => {
    return translations[key]?.[lang] || translations[key]?.['sk'] || key
  }

  return { t, lang }
}
