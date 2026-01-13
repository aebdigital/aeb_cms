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
  krajinaPovodu: { sk: 'Krajina pôvodu', cs: 'Země původu' },
  vyberteKrajinu: { sk: 'Vyberte krajinu', cs: 'Vyberte zemi' },
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

  // Layout / Navigation
  aktualnaStranka: { sk: 'Aktuálna stránka', cs: 'Aktuální stránka' },
  odhlasitSa: { sk: 'Odhlásiť sa', cs: 'Odhlásit se' },

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

  // Equipment category names
  'cat_Bezpečnosť': { sk: 'Bezpečnosť', cs: 'Bezpečnost' },
  'cat_Komfort': { sk: 'Komfort', cs: 'Komfort' },
  'cat_Ďalšia výbava': { sk: 'Ďalšia výbava', cs: 'Další výbava' },
  'cat_Doplňujúce údaje': { sk: 'Doplňujúce údaje', cs: 'Doplňující údaje' },

  // Bezpečnosť options
  'eq_ABS': { sk: 'ABS', cs: 'ABS' },
  'eq_Centrálne zamykanie': { sk: 'Centrálne zamykanie', cs: 'Centrální zamykání' },
  'eq_EBV': { sk: 'EBV', cs: 'EBV' },
  'eq_Mechanické zabezpečenie': { sk: 'Mechanické zabezpečenie', cs: 'Mechanické zabezpečení' },
  'eq_Asistent rozoznávania dopravných značiek (ISLW/ISLA)': { sk: 'Asistent rozoznávania dopravných značiek (ISLW/ISLA)', cs: 'Asistent rozpoznávání dopravních značek (ISLW/ISLA)' },
  'eq_Systém tiesňového volania (e-Call)': { sk: 'Systém tiesňového volania (e-Call)', cs: 'Systém tísňového volání (e-Call)' },
  'eq_Adaptívny tempomat': { sk: 'Adaptívny tempomat', cs: 'Adaptivní tempomat' },
  'eq_Alarm': { sk: 'Alarm', cs: 'Alarm' },
  'eq_Deaktivácia airbagov': { sk: 'Deaktivácia airbagov', cs: 'Deaktivace airbagů' },
  'eq_ESP': { sk: 'ESP', cs: 'ESP' },
  'eq_Natáčacie svetlomety': { sk: 'Natáčacie svetlomety', cs: 'Natáčecí světlomety' },
  'eq_Varovanie o vzdialenosti (BAS Plus)': { sk: 'Varovanie o vzdialenosti (BAS Plus)', cs: 'Varování o vzdálenosti (BAS Plus)' },
  'eq_Upozornenie premávky za vozidlom (RCTA)': { sk: 'Upozornenie premávky za vozidlom (RCTA)', cs: 'Upozornění provozu za vozidlem (RCTA)' },
  'eq_ADS': { sk: 'ADS', cs: 'ADS' },
  'eq_ASR': { sk: 'ASR', cs: 'ASR' },
  'eq_DSC': { sk: 'DSC', cs: 'DSC' },
  'eq_Imobilizér': { sk: 'Imobilizér', cs: 'Imobilizér' },
  'eq_Parkovacia kamera': { sk: 'Parkovacia kamera', cs: 'Parkovací kamera' },
  'eq_Systém rozoznania únavy vodiča (DAW)': { sk: 'Systém rozoznania únavy vodiča (DAW)', cs: 'Systém rozpoznání únavy řidiče (DAW)' },
  'eq_Asistent diaľkových svetiel (HBA)': { sk: 'Asistent diaľkových svetiel (HBA)', cs: 'Asistent dálkových světel (HBA)' },
  'eq_Airbagy': { sk: 'Airbagy', cs: 'Airbagy' },
  'eq_Brzdový asistent': { sk: 'Brzdový asistent', cs: 'Brzdový asistent' },
  'eq_EBD': { sk: 'EBD', cs: 'EBD' },
  'eq_Isofix': { sk: 'Isofix', cs: 'Isofix' },
  'eq_Systém kontroly tlaku v pneumatikách (TPMS)': { sk: 'Systém kontroly tlaku v pneumatikách (TPMS)', cs: 'Systém kontroly tlaku v pneumatikách (TPMS)' },
  'eq_360° kamera': { sk: '360° kamera', cs: '360° kamera' },

  // Komfort options
  'eq_Autorádio': { sk: 'Autorádio', cs: 'Autorádio' },
  'eq_Bezkľúčové štartovanie': { sk: 'Bezkľúčové štartovanie', cs: 'Bezklíčové startování' },
  'eq_Elektrické okná': { sk: 'Elektrické okná', cs: 'Elektrická okna' },
  'eq_Fólie': { sk: 'Fólie', cs: 'Fólie' },
  'eq_Kožený paket': { sk: 'Kožený paket', cs: 'Kožený paket' },
  'eq_Multifunkčný volant': { sk: 'Multifunkčný volant', cs: 'Multifunkční volant' },
  'eq_Palubný počítač': { sk: 'Palubný počítač', cs: 'Palubní počítač' },
  'eq_Sedadlá s masážnou funkciou': { sk: 'Sedadlá s masážnou funkciou', cs: 'Sedadla s masážní funkcí' },
  'eq_Vyhrievané zrkadlá': { sk: 'Vyhrievané zrkadlá', cs: 'Vyhřívaná zrcátka' },
  'eq_Elektrický šíber': { sk: 'Elektrický šíber', cs: 'Elektrický šíbr' },
  'eq_Welcome light': { sk: 'Welcome light', cs: 'Welcome light' },
  'eq_Matrix svetlá': { sk: 'Matrix svetlá', cs: 'Matrix světla' },
  'eq_Adaptívny podvozok': { sk: 'Adaptívny podvozok', cs: 'Adaptivní podvozek' },
  'eq_Bluetooth handsfree': { sk: 'Bluetooth handsfree', cs: 'Bluetooth handsfree' },
  'eq_Elektrické sedadlá': { sk: 'Elektrické sedadlá', cs: 'Elektrická sedadla' },
  'eq_Lakťová opierka': { sk: 'Lakťová opierka', cs: 'Loketní opěrka' },
  'eq_Navigačný systém': { sk: 'Navigačný systém', cs: 'Navigační systém' },
  'eq_Pamäťové sedáky': { sk: 'Pamäťové sedáky', cs: 'Paměťová sedadla' },
  'eq_Tempomat': { sk: 'Tempomat', cs: 'Tempomat' },
  'eq_Vyhrievaný volant': { sk: 'Vyhrievaný volant', cs: 'Vyhřívaný volant' },
  'eq_Xenónové svetlomety': { sk: 'Xenónové svetlomety', cs: 'Xenonové světlomety' },
  'eq_WLAN / WiFi Hotspot': { sk: 'WLAN / WiFi Hotspot', cs: 'WLAN / WiFi Hotspot' },
  'eq_Atermické čelné sklo': { sk: 'Atermické čelné sklo', cs: 'Atermické čelní sklo' },
  'eq_Bezdotykové otváranie kufra': { sk: 'Bezdotykové otváranie kufra', cs: 'Bezdotykové otevírání kufru' },
  'eq_Diaľkové ovládanie zamykania': { sk: 'Diaľkové ovládanie zamykania', cs: 'Dálkové ovládání zamykání' },
  'eq_Elektrické zrkadlá': { sk: 'Elektrické zrkadlá', cs: 'Elektrická zrcátka' },
  'eq_Klimatizovaná priehradka': { sk: 'Klimatizovaná priehradka', cs: 'Klimatizovaná přihrádka' },
  'eq_LED svetlomety': { sk: 'LED svetlomety', cs: 'LED světlomety' },
  'eq_Nezávislé kúrenie': { sk: 'Nezávislé kúrenie', cs: 'Nezávislé topení' },
  'eq_Parkovacie senzory': { sk: 'Parkovacie senzory', cs: 'Parkovací senzory' },
  'eq_Vyhrievané predné sklo': { sk: 'Vyhrievané predné sklo', cs: 'Vyhřívané přední sklo' },
  'eq_Vzduchové odpruženie podvozku': { sk: 'Vzduchové odpruženie podvozku', cs: 'Vzduchové odpružení podvozku' },
  'eq_Apple CarPlay': { sk: 'Apple CarPlay', cs: 'Apple CarPlay' },
  'eq_Virtuálny kokpit': { sk: 'Virtuálny kokpit', cs: 'Virtuální kokpit' },
  'eq_Bezdrotové nabíjanie pre smartphony': { sk: 'Bezdrotové nabíjanie pre smartphony', cs: 'Bezdrátové nabíjení pro smartphony' },
  'eq_Bezkľúčové otváranie dverí': { sk: 'Bezkľúčové otváranie dverí', cs: 'Bezklíčové otevírání dveří' },
  'eq_Dotykový displej': { sk: 'Dotykový displej', cs: 'Dotykový displej' },
  'eq_Elektrické ovládanie kufra': { sk: 'Elektrické ovládanie kufra', cs: 'Elektrické ovládání kufru' },
  'eq_Kožený interiér': { sk: 'Kožený interiér', cs: 'Kožený interiér' },
  'eq_LED osvetlenie': { sk: 'LED osvetlenie', cs: 'LED osvětlení' },
  'eq_Odvetrávané sedadlá': { sk: 'Odvetrávané sedadlá', cs: 'Odvětrávána sedadla' },
  'eq_Parkovací asistent': { sk: 'Parkovací asistent', cs: 'Parkovací asistent' },
  'eq_Vyhrievané sedadlá': { sk: 'Vyhrievané sedadlá', cs: 'Vyhřívaná sedadla' },
  'eq_Vonkajší teplomer': { sk: 'Vonkajší teplomer', cs: 'Venkovní teploměr' },
  'eq_Android Auto': { sk: 'Android Auto', cs: 'Android Auto' },
  'eq_Radenie pod volantom': { sk: 'Radenie pod volantom', cs: 'Řazení pod volantem' },
  'eq_Ambientné osvetlenie': { sk: 'Ambientné osvetlenie', cs: 'Ambientní osvětlení' },

  // Ďalšia výbava options
  'eq_Asistent jazdných pruhov': { sk: 'Asistent jazdných pruhov', cs: 'Asistent jízdních pruhů' },
  'eq_Doťahovanie dverí': { sk: 'Doťahovanie dverí', cs: 'Dotahování dveří' },
  'eq_Kontrola mŕtveho uhla': { sk: 'Kontrola mŕtveho uhla', cs: 'Kontrola mrtvého úhlu' },
  'eq_Sezónne prezutie': { sk: 'Sezónne prezutie', cs: 'Sezónní přezutí' },
  'eq_Svetelný senzor': { sk: 'Svetelný senzor', cs: 'Světelný senzor' },
  'eq_Asistent rozjazdu do kopca': { sk: 'Asistent rozjazdu do kopca', cs: 'Asistent rozjezdu do kopce' },
  'eq_Head-up display': { sk: 'Head-up display', cs: 'Head-up display' },
  'eq_Nočné videnie': { sk: 'Nočné videnie', cs: 'Noční vidění' },
  'eq_Stop&start systém': { sk: 'Stop&start systém', cs: 'Stop&start systém' },
  'eq_Tážne zariadenie': { sk: 'Tážne zariadenie', cs: 'Tažné zařízení' },
  'eq_Dažďový senzor': { sk: 'Dažďový senzor', cs: 'Dešťový senzor' },
  'eq_Hliníkové disky': { sk: 'Hliníkové disky', cs: 'Hliníkové disky' },
  'eq_Ostrekovače svetlometov': { sk: 'Ostrekovače svetlometov', cs: 'Ostřikovače světlometů' },
  'eq_Strešné okno': { sk: 'Strešné okno', cs: 'Střešní okno' },
  'eq_Deliaca mreža': { sk: 'Deliaca mreža', cs: 'Dělící mřížka' },
  'eq_Hmlovky': { sk: 'Hmlovky', cs: 'Mlhovky' },
  'eq_Panoramatická strecha': { sk: 'Panoramatická strecha', cs: 'Panoramatická střecha' },
  'eq_Strešný nosič': { sk: 'Strešný nosič', cs: 'Střešní nosič' },

  // Doplňujúce údaje options
  'eq_1. majiteľ': { sk: '1. majiteľ', cs: '1. majitel' },
  'eq_Garážované': { sk: 'Garážované', cs: 'Garážované' },
  'eq_Na dovoz': { sk: 'Na dovoz', cs: 'Na dovoz' },
  'eq_Servisná knižka': { sk: 'Servisná knižka', cs: 'Servisní knížka' },
  'eq_Úplná servisná história': { sk: 'Úplná servisná história', cs: 'Úplná servisní historie' },
  'eq_Možný leasing': { sk: 'Možný leasing', cs: 'Možný leasing' },
  'eq_Defektný motor alebo prevodovka': { sk: 'Defektný motor alebo prevodovka', cs: 'Vadný motor nebo převodovka' },
  'eq_Kontrola originality': { sk: 'Kontrola originality', cs: 'Kontrola originality' },
  'eq_Nehavarované': { sk: 'Nehavarované', cs: 'Nebourané' },
  'eq_STK': { sk: 'STK', cs: 'STK' },
  'eq_Úžitková verzia N1': { sk: 'Úžitková verzia N1', cs: 'Užitková verze N1' },
  'eq_Možný úver': { sk: 'Možný úver', cs: 'Možný úvěr' },
  'eq_Dovezené': { sk: 'Dovezené', cs: 'Dovezené' },
  'eq_Ako nové kúpené v SR': { sk: 'Ako nové kúpené v SR', cs: 'Jako nové koupené v SR' },
  'eq_ODO-Pass': { sk: 'ODO-Pass', cs: 'ODO-Pass' },
  'eq_Top stav!': { sk: 'Top stav!', cs: 'Top stav!' },
  'eq_Veterán': { sk: 'Veterán', cs: 'Veterán' },
  'eq_EK': { sk: 'EK', cs: 'EK' },
  'eq_Možná výmena': { sk: 'Možná výmena', cs: 'Možná výměna' },
  'eq_Pravostranné riadenie': { sk: 'Pravostranné riadenie', cs: 'Pravostranné řízení' },
  'eq_Tuning': { sk: 'Tuning', cs: 'Tuning' },
  'eq_Vozidlo je v záruke': { sk: 'Vozidlo je v záruke', cs: 'Vozidlo je v záruce' },
} as const

export type TranslationKey = keyof typeof translations

export function t(key: TranslationKey, lang: Lang = 'sk'): string {
  return translations[key]?.[lang] || translations[key]?.['sk'] || key
}

// Helper to translate equipment category names
export function tCategory(categoryName: string, lang: Lang = 'sk'): string {
  const key = `cat_${categoryName}` as TranslationKey
  return translations[key]?.[lang] || translations[key]?.['sk'] || categoryName
}

// Helper to translate equipment option names
export function tEquipment(optionName: string, lang: Lang = 'sk'): string {
  const key = `eq_${optionName}` as TranslationKey
  return translations[key]?.[lang] || translations[key]?.['sk'] || optionName
}
