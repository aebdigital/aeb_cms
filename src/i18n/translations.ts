export type Lang = 'sk' | 'cs'

export const translations = {
  // Page titles and headers
  vozidla: { sk: 'Vozidlá', cs: 'Vozidla' },
  spravujtePonuku: { sk: 'Spravujte ponuku vozidiel', cs: 'Spravujte nabídku vozidel' },
  pridatVozidlo: { sk: 'Pridať vozidlo', cs: 'Přidat vozidlo' },
  upravitVozidlo: { sk: 'Upraviť vozidlo', cs: 'Upravit vozidlo' },
  pridatNoveVozidlo: { sk: 'Pridať nové vozidlo', cs: 'Přidat nové vozidlo' },

  // Search and filters
  hladatVozidlo: { sk: 'Hľadať vozidlo...', cs: 'Hledat vozidlo...' },
  filtre: { sk: 'Filtre', cs: 'Filtry' },
  vymazatFiltre: { sk: 'Vymazať filtre', cs: 'Vymazat filtry' },
  vsetky: { sk: 'Všetky', cs: 'Všechny' },
  zobrazujem: { sk: 'Zobrazujem', cs: 'Zobrazuji' },
  z: { sk: 'z', cs: 'z' },
  vozidiel: { sk: 'vozidiel', cs: 'vozidel' },

  // Form labels
  znacka: { sk: 'Značka', cs: 'Značka' },
  model: { sk: 'Model', cs: 'Model' },
  rok: { sk: 'Rok', cs: 'Rok' },
  mesiacVyroby: { sk: 'Mesiac výroby', cs: 'Měsíc výroby' },
  cenaEur: { sk: 'Cena (EUR)', cs: 'Cena (EUR)' },
  odpocetDph: { sk: 'Odpočet DPH', cs: 'Odpočet DPH' },
  cenaBezDph: { sk: 'Cena bez DPH (EUR)', cs: 'Cena bez DPH (EUR)' },
  najazdenekm: { sk: 'Najazdené (km)', cs: 'Najeto (km)' },
  palivo: { sk: 'Palivo', cs: 'Palivo' },
  prevodovka: { sk: 'Prevodovka', cs: 'Převodovka' },
  motor: { sk: 'Motor', cs: 'Motor' },
  vykon: { sk: 'Výkon', cs: 'Výkon' },
  karoseria: { sk: 'Karoséria', cs: 'Karoserie' },
  pohon: { sk: 'Pohon', cs: 'Pohon' },
  vin: { sk: 'VIN', cs: 'VIN' },
  dvere: { sk: 'Dvere', cs: 'Dveře' },
  farba: { sk: 'Farba', cs: 'Barva' },
  typPrevodovky: { sk: 'Typ prevodovky', cs: 'Typ převodovky' },
  pocetStupnov: { sk: 'Počet stupňov', cs: 'Počet stupňů' },
  popis: { sk: 'Popis', cs: 'Popis' },
  vybava: { sk: 'Výbava', cs: 'Výbava' },
  fotografie: { sk: 'Fotografie', cs: 'Fotografie' },

  // Fuel types
  benzin: { sk: 'Benzín', cs: 'Benzín' },
  diesel: { sk: 'Diesel', cs: 'Diesel' },
  hybrid: { sk: 'Hybrid', cs: 'Hybrid' },
  elektro: { sk: 'Elektro', cs: 'Elektro' },
  lpg: { sk: 'LPG', cs: 'LPG' },
  cng: { sk: 'CNG', cs: 'CNG' },

  // Transmission
  manualna: { sk: 'Manuálna', cs: 'Manuální' },
  automaticka: { sk: 'Automatická', cs: 'Automatická' },

  // Months
  vyberteMessiac: { sk: 'Vyberte mesiac', cs: 'Vyberte měsíc' },
  januar: { sk: 'Január', cs: 'Leden' },
  februar: { sk: 'Február', cs: 'Únor' },
  marec: { sk: 'Marec', cs: 'Březen' },
  april: { sk: 'Apríl', cs: 'Duben' },
  maj: { sk: 'Máj', cs: 'Květen' },
  jun: { sk: 'Jún', cs: 'Červen' },
  jul: { sk: 'Júl', cs: 'Červenec' },
  august: { sk: 'August', cs: 'Srpen' },
  september: { sk: 'September', cs: 'Září' },
  oktober: { sk: 'Október', cs: 'Říjen' },
  november: { sk: 'November', cs: 'Listopad' },
  december: { sk: 'December', cs: 'Prosinec' },

  // Dropdowns
  vybertePalivo: { sk: 'Vyberte palivo', cs: 'Vyberte palivo' },
  vybertePrevodovku: { sk: 'Vyberte prevodovku', cs: 'Vyberte převodovku' },
  vyberteTyp: { sk: 'Vyberte typ', cs: 'Vyberte typ' },
  vyberte: { sk: 'Vyberte', cs: 'Vyberte' },

  // Placeholders
  naprHatchback: { sk: 'napr. Hatchback', cs: 'např. Hatchback' },
  naprPredny: { sk: 'napr. Predný', cs: 'např. Přední' },
  napr20TDI: { sk: 'napr. 2.0 TDI', cs: 'např. 2.0 TDI' },
  napr150kW: { sk: 'napr. 150 kW', cs: 'např. 150 kW' },
  napr5: { sk: 'napr. 5', cs: 'např. 5' },
  napr6: { sk: 'napr. 6', cs: 'např. 6' },
  naprCiernaMetaliza: { sk: 'napr. Čierna metalíza', cs: 'např. Černá metalíza' },
  detailnyPopisVozidla: { sk: 'Detailný popis vozidla...', cs: 'Detailní popis vozidla...' },

  // Equipment categories
  bezpecnost: { sk: 'Bezpečnosť', cs: 'Bezpečnost' },
  komfort: { sk: 'Komfort', cs: 'Komfort' },
  pocetAirbagov: { sk: 'Počet airbagov', cs: 'Počet airbagů' },
  klimatizacia: { sk: 'Klimatizácia', cs: 'Klimatizace' },
  pocetZon: { sk: 'Počet zón', cs: 'Počet zón' },
  parkovacieSenzory: { sk: 'Parkovacie senzory', cs: 'Parkovací senzory' },
  elektrickeOkna: { sk: 'Elektrické okná', cs: 'Elektrická okna' },
  vyhrievaneSedadla: { sk: 'Vyhrievané sedadlá', cs: 'Vyhřívaná sedadla' },
  audioAZabava: { sk: 'Audio a zábava', cs: 'Audio a zábava' },
  autoradioCd: { sk: 'Autorádio CD', cs: 'Autorádio CD' },
  autoradioCdMp3: { sk: 'Autorádio CD/MP3', cs: 'Autorádio CD/MP3' },
  androidAuto: { sk: 'Android Auto', cs: 'Android Auto' },

  // AC options
  ziadna: { sk: 'Žiadna', cs: 'Žádná' },
  ziadne: { sk: 'Žiadne', cs: 'Žádné' },
  manualnaKlima: { sk: 'Manuálna', cs: 'Manuální' },
  automatickaKlima: { sk: 'Automatická', cs: 'Automatická' },
  jednozonova: { sk: 'Jednozónová', cs: 'Jednozónová' },
  dvojzonova: { sk: 'Dvojzónová', cs: 'Dvouzónová' },
  trojzonova: { sk: 'Trojzónová', cs: 'Třízónová' },
  stvorzonova: { sk: 'Štvorzonová', cs: 'Čtyřzónová' },

  // Parking sensors
  predne: { sk: 'Predné', cs: 'Přední' },
  zadne: { sk: 'Zadné', cs: 'Zadní' },
  predneZadne: { sk: 'Predné + Zadné', cs: 'Přední + Zadní' },

  // Electric windows
  dvaXPredne: { sk: '2x (predné)', cs: '2x (přední)' },
  styriXVsetky: { sk: '4x (všetky)', cs: '4x (všechny)' },

  // Images
  vyberteObrazky: { sk: 'Vyberte jeden alebo viacero obrázkov (JPG, PNG, GIF). Obrázky sa nahrajú do Supabase Storage.', cs: 'Vyberte jeden nebo více obrázků (JPG, PNG, GIF). Obrázky se nahrají do Supabase Storage.' },
  vsetkyObrazky: { sk: 'Všetky obrázky (presuňte pre zmenu poradia):', cs: 'Všechny obrázky (přesuňte pro změnu pořadí):' },
  hlavna: { sk: 'Hlavná', cs: 'Hlavní' },
  nove: { sk: 'Nové', cs: 'Nové' },

  // Checkboxes
  zobrazitNaDomovskej: { sk: 'Zobraziť na domovskej stránke v sekcii "Najnovšie vozidlá"', cs: 'Zobrazit na domovské stránce v sekci "Nejnovější vozidla"' },
  rezervovane: { sk: 'Rezervované', cs: 'Rezervováno' },

  // Buttons
  zrusit: { sk: 'Zrušiť', cs: 'Zrušit' },
  ukladam: { sk: 'Ukladám...', cs: 'Ukládám...' },

  // Upload progress
  komprimujemObrazok: { sk: 'Komprimujem obrázok', cs: 'Komprimuji obrázek' },
  nahravamObrazok: { sk: 'Nahrávam obrázok', cs: 'Nahrávám obrázek' },
  vytvaramVozidlo: { sk: 'Vytváram vozidlo...', cs: 'Vytvářím vozidlo...' },
  vozidloAktualizovane: { sk: 'Vozidlo aktualizované...', cs: 'Vozidlo aktualizováno...' },
  ukladamPoradieObrazkov: { sk: 'Ukladám poradie obrázkov...', cs: 'Ukládám pořadí obrázků...' },

  // Alerts and messages
  prosimVyplnte: { sk: 'Prosím vyplňte všetky povinné polia (Značka, Model, Palivo, Prevodovka)', cs: 'Prosím vyplňte všechna povinná pole (Značka, Model, Palivo, Převodovka)' },
  chybaNieJeStranka: { sk: 'Chyba: Nie je vybratá žiadna stránka.', cs: 'Chyba: Není vybrána žádná stránka.' },
  vozidloUspesneUpravene: { sk: 'Vozidlo bolo úspešne upravené!', cs: 'Vozidlo bylo úspěšně upraveno!' },
  vozidloUspesnePridane: { sk: 'Vozidlo bolo úspešne pridané!', cs: 'Vozidlo bylo úspěšně přidáno!' },
  chybaPriUkladani: { sk: 'Chyba pri ukladaní vozidla: ', cs: 'Chyba při ukládání vozidla: ' },
  steIsti: { sk: 'Ste si istí, že chcete odstrániť toto vozidlo?', cs: 'Jste si jisti, že chcete odstranit toto vozidlo?' },
  chybaPriMazani: { sk: 'Chyba pri mazaní vozidla: ', cs: 'Chyba při mazání vozidla: ' },

  // Loading states
  nacitavamVozidla: { sk: 'Načítavam vozidlá...', cs: 'Načítám vozidla...' },
  vyberteStrankuPre: { sk: 'Vyberte stránku pre zobrazenie vozidiel', cs: 'Vyberte stránku pro zobrazení vozidel' },
  chybaPriNacitavani: { sk: 'Chyba pri načítavaní vozidiel: ', cs: 'Chyba při načítání vozidel: ' },
  skusitZnova: { sk: 'Skúsiť znova', cs: 'Zkusit znovu' },

  // Empty state
  ziadneVozidla: { sk: 'Žiadne vozidlá', cs: 'Žádná vozidla' },
  skusteZmenit: { sk: 'Skúste zmeniť filtre alebo vyhľadávanie', cs: 'Zkuste změnit filtry nebo vyhledávání' },

  // Detail modal
  galeria: { sk: 'Galéria', cs: 'Galerie' },
  kilometre: { sk: 'Kilometre', cs: 'Kilometry' },
  tlacitPdf: { sk: 'Tlačiť PDF', cs: 'Tisknout PDF' },
  upravit: { sk: 'Upraviť', cs: 'Upravit' },
  odstranit: { sk: 'Odstrániť', cs: 'Odstranit' },

  // Filter labels
  cenaOd: { sk: 'Cena od', cs: 'Cena od' },
  cenaDo: { sk: 'Cena do', cs: 'Cena do' },
  rokOd: { sk: 'Rok od', cs: 'Rok od' },
  rokDo: { sk: 'Rok do', cs: 'Rok do' },
  minEur: { sk: 'Min EUR', cs: 'Min EUR' },
  maxEur: { sk: 'Max EUR', cs: 'Max EUR' },
  minRok: { sk: 'Min rok', cs: 'Min rok' },
  maxRok: { sk: 'Max rok', cs: 'Max rok' },

  // Print
  rokVyroby: { sk: 'Rok výroby', cs: 'Rok výroby' },
  pocetKm: { sk: 'Počet km', cs: 'Počet km' },
  moznyLeasing: { sk: 'Možný leasing, Možný úver', cs: 'Možný leasing, Možný úvěr' },
} as const

export type TranslationKey = keyof typeof translations

export function t(key: TranslationKey, lang: Lang = 'sk'): string {
  return translations[key]?.[lang] || translations[key]?.['sk'] || key
}
