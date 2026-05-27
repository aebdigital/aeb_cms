-- Seed Kochlik products from kochlik-nextjs/data/master_catalog.json
-- Generated 2026-05-27T14:43:49.723Z — 256 products
-- Run in Supabase SQL Editor for project ngifengeshwvyzhqvprn AFTER create_kochlik_products.sql.
-- Re-runnable: ON CONFLICT (owner_id, slug) DO UPDATE.

BEGIN;

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'moderne-kvetinace' LIMIT 1),
  'ETRIA UNO',
  'etria-uno',
  'Euro3plast',
  2800,
  NULL,
  'Etria Uno je jednodielny (jednostenný) kvetináč – vnútorný objem je väčší a pojme viac substrátu, takže rastlinám a kvetom poskytne viac priestoru na rast a kvitnutie. Minimalistický dizajn so čistými líniami vynikne v každom prostredí. Vďaka širokej škále veľkostí a farieb môžete ladiť odtiene a používať Etria Uno ako samostatný kvetináč alebo ako obal – skutočný univerzál, s ktorým ľahko meníte kombinácie podľa nálady.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.euro3plast.com/gb/-/356-etria-uno.html)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/etria-uno/etria-uno_1.webp',
  ARRAY['https://kochlik.netlify.app/images/etria-uno/etria-uno_1.webp', 'https://kochlik.netlify.app/images/etria-uno/etria-uno_2.webp', 'https://kochlik.netlify.app/images/etria-uno/etria-uno_3.webp']::text[],
  '[{"name":"WHITE C2","hex":"#ffffff","image_url":null,"family":"Biela"},{"name":"RUST","hex":"#543920","image_url":null,"family":"Hnedá"},{"name":"TAUPE","hex":"#706961","image_url":null,"family":"Hnedá"},{"name":"SANDY","hex":"#b8a999","image_url":null,"family":"Béžová"},{"name":"PEARL BLACK","hex":"#4a4a49","image_url":null,"family":"Čierna"}]'::jsonb,
  ARRAY['Béžová', 'Biela', 'Čierna', 'Hnedá']::text[],
  ARRAY['24x20 cm', '34x28 cm', '44x36 cm', '54x44 cm', '74x61 cm']::text[],
  ARRAY['Do 50 cm', '51-100 cm']::text[],
  '[{"label":"24x20 cm","dimensions":"24x20 cm","price_cents":2800,"attributes":{"rozmer":"24x20 cm"}},{"label":"34x28 cm","dimensions":"34x28 cm","price_cents":4400,"attributes":{"rozmer":"34x28 cm"}},{"label":"44x36 cm","dimensions":"44x36 cm","price_cents":7300,"attributes":{"rozmer":"44x36 cm"}},{"label":"54x44 cm","dimensions":"54x44 cm","price_cents":18800,"attributes":{"rozmer":"54x44 cm"}},{"label":"74x61 cm","dimensions":"74x61 cm","price_cents":26700,"attributes":{"rozmer":"74x61 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"24×20 cm, 34×28 cm, 44×36 cm, 54×44 cm, 74×61 cm"}]'::jsonb,
  '[{"label":"Technický dokument","url":"https://www.euro3plast.com/sheets/etria_uno_vaso.pdf"},{"label":"Informačný dokument","url":"https://www.euro3plast.com/sheets/etria_uno_pot_info_en.pdf"}]'::jsonb,
  'https://www.euro3plast.com/gb/-/356-etria-uno.html',
  'https://www.euro3plast.com/gb/-/356-etria-uno.html',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'nabytok' LIMIT 1),
  'Barová stolička Frozen okrúhla',
  'barova-stolicka-frozen-okruhla',
  'Plust',
  18500,
  NULL,
  'Barová stolička vhodná na použitie v interiéri aj exteriéri. Možno ju kombinovať s vysokými stolmi a barovými pultmi. Pevná a funkčná konštrukcia zaručuje pohodlie, univerzálnosť a jednoduchú manipuláciu.
Rozmer
39 x 38 x 74 cm
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.plust.it/en/products/frozen-stool/)',
  'https://kochlik.netlify.app/images/barova-stolicka-frozen-okruhla/barova-stolicka-frozen-okruhla_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/barova-stolicka-frozen-okruhla/barova-stolicka-frozen-okruhla_1.jpg', 'https://kochlik.netlify.app/images/barova-stolicka-frozen-okruhla/barova-stolicka-frozen-okruhla_2.jpg', 'https://kochlik.netlify.app/images/barova-stolicka-frozen-okruhla/barova-stolicka-frozen-okruhla_3.jpg']::text[],
  '[{"name":"Night blue","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_16_nightblue.jpg","family":"Modrá"},{"name":"Sage green","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_34_sagegreen.jpg","family":"Zelená"},{"name":"Pearl black","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_87_pearlblack.jpg","family":"Čierna"},{"name":"White C2","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_c2_whitec2.jpg","family":"Biela"},{"name":"Sandy","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_m9_sandy.jpg","family":"Béžová"},{"name":"Golden rust","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_n4_goldenrust.jpg","family":"Hnedá"},{"name":"White light","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_u1_whitelight.jpg","family":"Biela"}]'::jsonb,
  ARRAY['Béžová', 'Biela', 'Čierna', 'Hnedá', 'Modrá', 'Zelená']::text[],
  ARRAY['38 x 74 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb,
  'https://www.plust.it/en/products/frozen-stool/',
  'https://www.plust.it/en/products/frozen-stool/',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'nabytok' LIMIT 1),
  'Odkladací stolík Dado',
  'odkladaci-stolik-dado',
  'Serralunga',
  26000,
  NULL,
  'Stolík Dado navrhli pre Serralunga Fabio Bortolani a Ermanno Righi. „Jednoduchá hracia kocka, ktorá sa odráža v podlahe,“ takto Fabio Bortolani opisuje tento nový kúsok súčasného nábytku.
Tento luxusný kus nábytku je navrhnutý s dôrazom na všestrannosť a vďaka povrchovej úprave sa prirodzene začlení do rôznych prostredí. Základná verzia má prirodzenú povrchovú úpravu.
Obsahuje otvor špeciálne určený na knihy a časopisy, vybavený malým odtokom na dne, ktorý umožňuje odvod vody, vďaka čomu je tento stojan na časopisy vhodný na vonkajšie použitie po celý rok.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/products/dado-table?_pos=1&_psq=Dado&_ss=e&_v=1.0)',
  'https://kochlik.netlify.app/images/odkladaci-stolik-dado/odkladaci-stolik-dado_1.webp',
  ARRAY['https://kochlik.netlify.app/images/odkladaci-stolik-dado/odkladaci-stolik-dado_1.webp', 'https://kochlik.netlify.app/images/odkladaci-stolik-dado/odkladaci-stolik-dado_2.webp', 'https://kochlik.netlify.app/images/odkladaci-stolik-dado/odkladaci-stolik-dado_3.webp', 'https://kochlik.netlify.app/images/odkladaci-stolik-dado/odkladaci-stolik-dado_4.webp']::text[],
  '[{"name":"ANTRACITE","hex":null,"image_url":null,"family":"Sivá"},{"name":"ROSSO","hex":null,"image_url":null,"family":"Červená"},{"name":"ACQUA DELLA MADDALENA","hex":null,"image_url":null,"family":"Modrá"},{"name":"BIANCO","hex":null,"image_url":null,"family":"Biela"},{"name":"SALVIA DI SARDEGNA","hex":null,"image_url":null,"family":"Zelená"},{"name":"TORTORA DI TORINO","hex":null,"image_url":null,"family":"Hnedá"},{"name":"GIALLO SAHARA","hex":null,"image_url":null,"family":"Žltá"},{"name":"VERDE BRITISH","hex":null,"image_url":null,"family":"Zelená"},{"name":"ROSSO POMPEIANO","hex":null,"image_url":null,"family":"Červená"},{"name":"CORTEN","hex":null,"image_url":null,"family":"Hnedá"}]'::jsonb,
  ARRAY['Biela', 'Červená', 'Hnedá', 'Modrá', 'Sivá', 'Zelená', 'Žltá']::text[],
  ARRAY[]::text[],
  ARRAY[]::text[],
  '[]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/products/dado-table?_pos=1&_psq=Dado&_ss=e&_v=1.0',
  'https://serralunga.com/products/dado-table?_pos=1&_psq=Dado&_ss=e&_v=1.0',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'svietiace-kvetinace' LIMIT 1),
  'Kvetináč VASO RETTANGOLARE s osvetlením',
  'kvetinac-rettangolare-s-osvetlenim',
  'Serralunga',
  37500,
  NULL,
  'Materiál: Vyrobené z LLDPE (lineárny nízkohustotný polyetylén) Výrobný proces: Rotačné tvarovanie Vhodné na vonkajšie použitie a odolné voči všetkým poveternostným podmienkam. Poskytuje UV ochranu, je 100 % recyklovateľné a farbené v hmote (solution dyed). Má vysokú mechanickú pevnosť a odolnosť voči nárazom. Odoláva teplotám od -35 °C do +80 °C.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/en/products/vaso-rettangolare-o-e-planter-with-light?_pos=3&_psq=VASO+RETTANGOLARE&_ss=e&_v=1.0)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/kvetinac-rettangolare-s-osvetlenim/kvetinac-rettangolare-s-osvetlenim_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/kvetinac-rettangolare-s-osvetlenim/kvetinac-rettangolare-s-osvetlenim_1.jpg']::text[],
  '[{"name":"RGB light with cable","hex":null,"image_url":null,"family":null},{"name":"White light with cable","hex":null,"image_url":null,"family":"Biela"},{"name":"LED with cable","hex":null,"image_url":null,"family":null}]'::jsonb,
  ARRAY['Biela']::text[],
  ARRAY['93.5x26.5x70 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[{"label":"93.5x26.5x70 cm","dimensions":"93.5x26.5x70 cm","price_cents":40300,"attributes":{"rozmer":"93.5x26.5x70 cm","typ-ziarovky":"LED"}},{"label":"93.5x26.5x70 cm","dimensions":"93.5x26.5x70 cm","price_cents":37500,"attributes":{"rozmer":"93.5x26.5x70 cm","typ-ziarovky":"RGB"}}]'::jsonb,
  '[{"key":"Rozmer","value":"93.5×26.5×70 cm"},{"key":"Typ žiarovky","value":"LED, RGB"}]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/en/products/vaso-rettangolare-o-e-planter-with-light?_pos=3&_psq=VASO+RETTANGOLARE&_ss=e&_v=1.0',
  'https://serralunga.com/en/products/vaso-rettangolare-o-e-planter-with-light?_pos=3&_psq=VASO+RETTANGOLARE&_ss=e&_v=1.0',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'nabytok' LIMIT 1),
  'Kreslo Airball',
  'kreslo-airball',
  'Plust',
  76000,
  NULL,
  'Kreslo z kolekcie Gumball pôsobí výrazne a je ideálne do priestorov, ktoré si vyžadujú nábytok s charakterom. Otvory na povrchu mu dodávajú výnimočnú ľahkosť v porovnaní s podobnými typmi nábytku. Možno ho vybaviť RGB svetelnou sadou, ktorá vytvára pôsobivý efekt meniacich sa farieb. Otvory v nepriehľadnom textilnom sedadle umožňujú prenikanie svetla zo zdroja vo vnútri, čím vzniká jedinečná svetelná hra.
Rozmer
92 x 86 x 65 cm
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.plust.it/en/products/airball-armchair/)',
  'https://kochlik.netlify.app/images/kreslo-airball/kreslo-airball_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/kreslo-airball/kreslo-airball_1.jpg', 'https://kochlik.netlify.app/images/kreslo-airball/kreslo-airball_2.jpg']::text[],
  '[{"name":"White C2","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_c2_whitec2.jpg","family":"Biela"}]'::jsonb,
  ARRAY['Biela']::text[],
  ARRAY['86 x 65 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb,
  'https://www.plust.it/en/products/airball-armchair/',
  'https://www.plust.it/en/products/airball-armchair/',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'svietiace-kvetinace' LIMIT 1),
  'Kvetináč Marcantonio svietiaci',
  'kvetinac-marcantonio-svietiaci',
  'Serralunga',
  33500,
  NULL,
  'Materiál: Vyrobené z LLDPE (lineárny nízkohustotný polyetylén) Farba: Neutrálna priesvitná Výrobný proces: Rotačné tvarovanie Vhodné na vonkajšie použitie – odolné voči všetkým poveternostným podmienkam. Poskytuje UV ochranu, je 100 % recyklovateľné a farbené v hmote. Má vysokú mechanickú pevnosť a odolnosť proti nárazom. Odoláva teplotám od -35 °C do +80 °C.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/en/products/marcantonio-planter-with-light?_pos=4&_psq=Marcantonio&_ss=e&_v=1.0)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/kvetinac-marcantonio-svietiaci/kvetinac-marcantonio-svietiaci_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/kvetinac-marcantonio-svietiaci/kvetinac-marcantonio-svietiaci_1.jpg', 'https://kochlik.netlify.app/images/kvetinac-marcantonio-svietiaci/kvetinac-marcantonio-svietiaci_2.webp']::text[],
  '[]'::jsonb,
  ARRAY[]::text[],
  ARRAY['39x39x90 cm', '50x50x120 cm', '63x63x150 cm']::text[],
  ARRAY['51-100 cm', '101-150 cm']::text[],
  '[{"label":"39x39x90 cm","dimensions":"39x39x90 cm","price_cents":39000,"attributes":{"rozmer":"39x39x90 cm","typ-ziarovky":"LED"}},{"label":"39x39x90 cm","dimensions":"39x39x90 cm","price_cents":33500,"attributes":{"rozmer":"39x39x90 cm","typ-ziarovky":"RGB"}},{"label":"50x50x120 cm","dimensions":"50x50x120 cm","price_cents":40700,"attributes":{"rozmer":"50x50x120 cm","typ-ziarovky":"LED"}},{"label":"50x50x120 cm","dimensions":"50x50x120 cm","price_cents":37700,"attributes":{"rozmer":"50x50x120 cm","typ-ziarovky":"RGB"}},{"label":"63x63x150 cm","dimensions":"63x63x150 cm","price_cents":58600,"attributes":{"rozmer":"63x63x150 cm","typ-ziarovky":"LED"}},{"label":"63x63x150 cm","dimensions":"63x63x150 cm","price_cents":47800,"attributes":{"rozmer":"63x63x150 cm","typ-ziarovky":"RGB"}}]'::jsonb,
  '[{"key":"Rozmer","value":"39x39x90 cm, 50x50x120 cm, 63x63x150 cm"},{"key":"Typ žiarovky","value":"LED, RGB"}]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/en/products/marcantonio-planter-with-light?_pos=4&_psq=Marcantonio&_ss=e&_v=1.0',
  'https://serralunga.com/en/products/marcantonio-planter-with-light?_pos=4&_psq=Marcantonio&_ss=e&_v=1.0',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'nabytok' LIMIT 1),
  'Lehátko Lazy Sdraio',
  'lehatko-lazy-sdraio',
  'Serralunga',
  125000,
  NULL,
  'Lehátko Lazy Sdraio je súčasťou kolekcie Lazy, ktorú navrhol belgický dizajnér Michel Boucquillon pre Serralunga. Jeho konštrukcia z eloxovaného hliníka je určená pre vonkajšie použitie a zabezpečuje vysokú odolnosť voči poveternostným vplyvom. Sedacia časť z materiálu Batyline® je vodoodolná, priedušná a poskytuje pocit komfortu a elegancie bez hraníc. Vďaka svojmu striktne minimalistickému tvaru sa Lazy Sdraio dokonale hodí do moderných exteriérových priestorov, či už ide o terasy, bazény alebo pláže. Táto kolekcia predstavuje súčasný dizajn nábytku, vytvorený s ohľadom na náročné podmienky námorného prostredia, kde sa spája funkčnosť, estetika a pohodlie.
Rozmer
52 x 95 x 112 cm
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/en/products/lazy-sdraio-deckchair?_pos=1&_psq=Lazy+Sdraio&_ss=e&_v=1.0&variant=46612758856018)',
  'https://kochlik.netlify.app/images/lehatko-lazy-sdraio/lehatko-lazy-sdraio_1.webp',
  ARRAY['https://kochlik.netlify.app/images/lehatko-lazy-sdraio/lehatko-lazy-sdraio_1.webp']::text[],
  '[{"name":"LAZY DECKCHAIR","hex":null,"image_url":null,"family":null},{"name":"LAZY DOUBLE DECKCHAIR","hex":null,"image_url":null,"family":null}]'::jsonb,
  ARRAY[]::text[],
  ARRAY['95 x 112 cm']::text[],
  ARRAY['101-150 cm']::text[],
  '[]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/en/products/lazy-sdraio-deckchair?_pos=1&_psq=Lazy+Sdraio&_ss=e&_v=1.0&variant=46612758856018',
  'https://serralunga.com/en/products/lazy-sdraio-deckchair?_pos=1&_psq=Lazy+Sdraio&_ss=e&_v=1.0&variant=46612758856018',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'moderne-kvetinace' LIMIT 1),
  'Kvetináč June',
  'kvetinac-june',
  'Serralunga',
  42400,
  NULL,
  'Kvetináč June, navrhnutý Christophom Pilletom pre značku Serralunga, sa vyznačuje čistými líniami a minimalistickou estetikou, vďaka čomu ľahko zapadne do akéhokoľvek exteriéru, no zároveň vynikne ako dizajnový solitér. Je vyrobený z odolných materiálov, ktoré zaručujú dlhú životnosť a odolnosť voči poveternostným podmienkam počas celého roka. Vďaka univerzálnej veľkosti je ideálny na výsadbu kvetov, bohatej zelene alebo menších stromov. Či už je umiestnený na terase alebo medzi záhradnými záhonmi, kvetináč June prináša eleganciu a sofistikovanosť, čím okamžite pozdvihne atmosféru priestoru a pritiahne obdiv každého návštevníka.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/en/products/june-planter?_pos=1&_psq=June&_ss=e&_v=1.0)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/kvetinac-june/kvetinac-june_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/kvetinac-june/kvetinac-june_1.jpg', 'https://kochlik.netlify.app/images/kvetinac-june/kvetinac-june_2.jpg', 'https://kochlik.netlify.app/images/kvetinac-june/kvetinac-june_3.webp', 'https://kochlik.netlify.app/images/kvetinac-june/kvetinac-june_4.webp', 'https://kochlik.netlify.app/images/kvetinac-june/kvetinac-june_5.webp']::text[],
  '[{"name":"BIANCO","hex":null,"image_url":null,"family":"Biela"},{"name":"ANTRACITE","hex":null,"image_url":null,"family":"Sivá"},{"name":"TORTORA DI TORINO","hex":null,"image_url":null,"family":"Hnedá"},{"name":"SALVIA DI SARDEGNA","hex":null,"image_url":null,"family":"Zelená"},{"name":"AZZURRO DI PROVENZA","hex":null,"image_url":null,"family":"Modrá"},{"name":"PIETRA DELLA DOLOMITI","hex":null,"image_url":null,"family":"Sivá"},{"name":"LACQUEROSSO BIANCO","hex":null,"image_url":null,"family":"Biela"},{"name":"ROSSO","hex":null,"image_url":null,"family":"Červená"},{"name":"TERRACOTTA TOSCANA","hex":null,"image_url":null,"family":"Červená"},{"name":"VERDE PAVONE","hex":null,"image_url":null,"family":"Zelená"},{"name":"GIALLO SAHARA","hex":null,"image_url":null,"family":"Žltá"},{"name":"VERDE BRITISH","hex":null,"image_url":null,"family":"Zelená"},{"name":"ROSSO POMPEIANO","hex":null,"image_url":null,"family":"Červená"}]'::jsonb,
  ARRAY['Biela', 'Červená', 'Hnedá', 'Modrá', 'Sivá', 'Zelená', 'Žltá']::text[],
  ARRAY['60x60x120 cm']::text[],
  ARRAY['101-150 cm']::text[],
  '[{"label":"60x60x120 cm","dimensions":"60x60x120 cm","price_cents":42400,"attributes":{"rozmer":"60x60x120 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"60x60x120 cm"}]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/en/products/june-planter?_pos=1&_psq=June&_ss=e&_v=1.0',
  'https://serralunga.com/en/products/june-planter?_pos=1&_psq=June&_ss=e&_v=1.0',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  NULL,
  'Eggy',
  'eggy',
  'Vecagarden',
  NULL,
  NULL,
  'Tento kvetináč, inšpirovaný severským dizajnom, zaujme neobvyklým a pútavým zaobleným tvarom, vďaka ktorému sa hodí do akéhokoľvek interiéru či exteriéru. Nové extra veľké rozmery nielenže pôsobia impozantne, ale dokážu premeniť aj tie najväčšie a najprestížnejšie priestory na vizuálne výrazné miesta. Všestranný a elegantný, dokonale zapadne do moderných obývacích izieb, priestranných vstupných hál či sofistikovaných terás, kde dodá nádych rafinovaného, súčasného dizajnu.',
  'https://kochlik.netlify.app/images/eggy/eggy_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/eggy/eggy_1.jpg']::text[],
  '[]'::jsonb,
  ARRAY[]::text[],
  ARRAY[]::text[],
  ARRAY[]::text[],
  '[]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb,
  'https://kochlik.sk/produkt/eggy/',
  'https://kochlik.sk/produkt/eggy/',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'nabytok' LIMIT 1),
  'Barový stôl Fade',
  'barovy-stol-fade',
  'Plust',
  36000,
  NULL,
  'Tento vysoký stôl sa vyznačuje výbornou stabilitou. Jeho rebrovaný povrch vytvára jedinečnú hru svetla a tieňov, zatiaľ čo špeciálne povrchové úpravy pripomínajú prírodné materiály. V bielej svietiacej verzii je možné stôl vybaviť špeciálnou svetelnou sadou, ktorá dodá priestoru elegantnú atmosféru.
Rozmer
61 x 61 x 130 cm
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.plust.it/en/products/fade-table/)',
  'https://kochlik.netlify.app/images/barovy-stol-fade/barovy-stol-fade_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/barovy-stol-fade/barovy-stol-fade_1.jpg', 'https://kochlik.netlify.app/images/barovy-stol-fade/barovy-stol-fade_2.jpg', 'https://kochlik.netlify.app/images/barovy-stol-fade/barovy-stol-fade_3.jpg', 'https://kochlik.netlify.app/images/barovy-stol-fade/barovy-stol-fade_4.jpg']::text[],
  '[{"name":"Granite","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_s4_granite.jpg","family":"Sivá"},{"name":"Lava","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_u0_lava.jpg","family":"Sivá"},{"name":"Stone","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_u4_stone.jpg","family":"Sivá"},{"name":"Creta","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_v7_creta.jpg","family":"Béžová"},{"name":"White light","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_u1_whitelight.jpg","family":"Biela"}]'::jsonb,
  ARRAY['Béžová', 'Biela', 'Sivá']::text[],
  ARRAY['61 x 130 cm']::text[],
  ARRAY['101-150 cm']::text[],
  '[]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb,
  'https://www.plust.it/en/products/fade-table/',
  'https://www.plust.it/en/products/fade-table/',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'moderne-kvetinace' LIMIT 1),
  'IKON Pot',
  'ikon-pot',
  'Euro3plast',
  20400,
  NULL,
  'Štýl je synonymom minimalistického dizajnu – čisté, jednoduché línie kvetináčov a doplnkov dopĺňa farebná škála pre každý vkus. Vytvára harmonické a elegantné kompozície vo vašich obľúbených priestoroch.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.euro3plast.com/gb/-/326-3136-ikon.html#/332-colour-white_c2/620-significant_measure-80)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/ikon-pot/ikon-pot_1.webp',
  ARRAY['https://kochlik.netlify.app/images/ikon-pot/ikon-pot_1.webp']::text[],
  '[{"name":"WHITE C2","hex":"#ffffff","image_url":null,"family":"Biela"},{"name":"RUST","hex":"#543920","image_url":null,"family":"Hnedá"},{"name":"TAUPE","hex":"#706961","image_url":null,"family":"Hnedá"},{"name":"SANDY","hex":"#b8a999","image_url":null,"family":"Béžová"},{"name":"CEMENT","hex":"#999390","image_url":null,"family":"Sivá"},{"name":"GRANITE","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/e3p_ikon-pot_granite.jpg","family":"Sivá"},{"name":"PEARL BLACK","hex":"#4a4a49","image_url":null,"family":"Čierna"}]'::jsonb,
  ARRAY['Béžová', 'Biela', 'Čierna', 'Hnedá', 'Sivá']::text[],
  ARRAY['70x62 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[{"label":"70x62 cm","dimensions":"70x62 cm","price_cents":20400,"attributes":{"rozmer":"70x62 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"70×62 cm"}]'::jsonb,
  '[{"label":"Technický dokument","url":"https://www.euro3plast.com/sheets/ikon_vaso.pdf"},{"label":"Informačný dokument","url":"https://www.euro3plast.com/sheets/ikon_pot_info_en.pdf"}]'::jsonb,
  'https://www.euro3plast.com/gb/-/326-3136-ikon.html#/332-colour-white_c2/620-significant_measure-80',
  'https://www.euro3plast.com/gb/-/326-3136-ikon.html#/332-colour-white_c2/620-significant_measure-80',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'moderne-kvetinace' LIMIT 1),
  'Hrantík SIEPI hladký',
  'hrantik-siepi-hladky',
  'Euro3plast',
  16300,
  NULL,
  'Kolekcia Style je elegantná a nadčasová: tieto kvetináče a dekorácie s klasickým šarmom dodajú záhradám a terasám sofistikovaný vzhľad a po prvom použití sa stanú nepostrádateľné. Dokonale dopĺňajú priestory, ktoré sa rady nechávajú obdivovať.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.euro3plast.com/gb/products/314-siepi.html)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/hrantik-siepi-hladky/hrantik-siepi-hladky_1.webp',
  ARRAY['https://kochlik.netlify.app/images/hrantik-siepi-hladky/hrantik-siepi-hladky_1.webp', 'https://kochlik.netlify.app/images/hrantik-siepi-hladky/hrantik-siepi-hladky_2.webp', 'https://kochlik.netlify.app/images/hrantik-siepi-hladky/hrantik-siepi-hladky_3.webp']::text[],
  '[{"name":"WHITE C2","hex":"#ffffff","image_url":null,"family":"Biela"},{"name":"TAUPE","hex":"#706961","image_url":null,"family":"Hnedá"},{"name":"TERRA DI SIENA","hex":"#e3945b","image_url":null,"family":"Červená"},{"name":"PEARL BLACK","hex":"#4a4a49","image_url":null,"family":"Čierna"}]'::jsonb,
  ARRAY['Biela', 'Červená', 'Čierna', 'Hnedá']::text[],
  ARRAY['80x39x35 cm', '99x47x41 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[{"label":"80x39x35 cm","dimensions":"80x39x35 cm","price_cents":16300,"attributes":{"rozmer":"80x39x35 cm"}},{"label":"99x47x41 cm","dimensions":"99x47x41 cm","price_cents":20900,"attributes":{"rozmer":"99x47x41 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"80x39x35 cm, 99x47x41 cm"}]'::jsonb,
  '[{"label":"Technický dokument","url":"https://www.euro3plast.com/sheets/siepi_cassetta.pdf"},{"label":"Informačný dokument","url":"https://www.euro3plast.com/sheets/siepi_plant_box_info_en.pdf"}]'::jsonb,
  'https://www.euro3plast.com/gb/products/314-siepi.html',
  'https://www.euro3plast.com/gb/products/314-siepi.html',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'moderne-kvetinace' LIMIT 1),
  'Hrantík SIEPI s dvojitou stenou',
  'hrantik-siepi-s-dvojitou-stenou',
  'Euro3plast',
  37700,
  NULL,
  'Kolekcia Style je elegantná a nadčasová: tieto kvetináče a dekorácie s klasickým šarmom dodajú záhradám a terasám sofistikovaný vzhľad a po prvom použití sa stanú nepostrádateľné. Dokonale dopĺňajú priestory, ktoré sa rady nechávajú obdivovať.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.euro3plast.com/gb/products/318-3067-siepi.html#/377-colour-taupe/729-significant_measure-120)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/hrantik-siepi-s-dvojitou-stenou/hrantik-siepi-s-dvojitou-stenou_1.webp',
  ARRAY['https://kochlik.netlify.app/images/hrantik-siepi-s-dvojitou-stenou/hrantik-siepi-s-dvojitou-stenou_1.webp']::text[],
  '[{"name":"TAUPE","hex":"#706961","image_url":null,"family":"Hnedá"},{"name":"TERRA DI SIENA","hex":"#e3945b","image_url":null,"family":"Červená"},{"name":"PEARL BLACK","hex":"#4a4a49","image_url":null,"family":"Čierna"}]'::jsonb,
  ARRAY['Červená', 'Čierna', 'Hnedá']::text[],
  ARRAY['120x55x48 cm']::text[],
  ARRAY['101-150 cm']::text[],
  '[{"label":"120x55x48 cm","dimensions":"120x55x48 cm","price_cents":37700,"attributes":{"rozmer":"120x55x48 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"120x55x48 cm"}]'::jsonb,
  '[{"label":"Technický dokument","url":"https://www.euro3plast.com/sheets/siepi_cassetta_con_doppia_parete.pdf"},{"label":"Informačný dokument","url":"https://www.euro3plast.com/sheets/siepi_plant_box_with_double_wall_info_en.pdf"}]'::jsonb,
  'https://www.euro3plast.com/gb/products/318-3067-siepi.html#/377-colour-taupe/729-significant_measure-120',
  'https://www.euro3plast.com/gb/products/318-3067-siepi.html#/377-colour-taupe/729-significant_measure-120',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'klasicke-kvetinace' LIMIT 1),
  'Kvetináč Rettangolare Millerighe',
  'kvetinac-rettangolare-millerighe',
  'Serralunga',
  8000,
  NULL,
  'Kvetináč Millerighe Rettangolare od Serralunga je večná klasika, ktorá spája tradičný tvar s moderným farebným prevedením. Práve farba robí túto kolekciu výnimočnou – jemné tón v tóne odtiene a chromatické akcenty vytvárajú zaujímavé vizuálne kombinácie a dodávajú priestoru elegantný charakter. Vďaka svojim väčším rozmerom je Millerighe Rettangolare ideálny ako dominantný dizajnový prvok v záhrade, na terase či vo vstupných priestoroch. Kvetináče Millerighe patria do kolekcie Serralunga garden décor a predstavujú nadčasové riešenie pre exteriéry s vkusom.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/en/products/millerighe-rettangolare-planter?_pos=1&_psq=Rettangolare+Millerighe&_ss=e&_v=1.0)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/kvetinac-rettangolare-millerighe/kvetinac-rettangolare-millerighe_1.webp',
  ARRAY['https://kochlik.netlify.app/images/kvetinac-rettangolare-millerighe/kvetinac-rettangolare-millerighe_1.webp', 'https://kochlik.netlify.app/images/kvetinac-rettangolare-millerighe/kvetinac-rettangolare-millerighe_2.webp']::text[],
  '[{"name":"TORTORA DI TORINO","hex":null,"image_url":null,"family":"Hnedá"},{"name":"TERRACOTTA TOSCANA","hex":null,"image_url":null,"family":"Červená"},{"name":"ANTRACITE","hex":null,"image_url":null,"family":"Sivá"},{"name":"AZZURRO DI PROVENZA","hex":null,"image_url":null,"family":"Modrá"},{"name":"ROSSO","hex":null,"image_url":null,"family":"Červená"},{"name":"SALVIA DI SARDEGNA","hex":null,"image_url":null,"family":"Zelená"},{"name":"TERRACOTTA SCURA","hex":null,"image_url":null,"family":"Červená"},{"name":"bianco","hex":null,"image_url":null,"family":"Biela"},{"name":"VERDE PAVONE","hex":null,"image_url":null,"family":"Zelená"},{"name":"PIETRA DELLE DOLOMITI","hex":null,"image_url":null,"family":"Sivá"},{"name":"GIALLO SAHARA","hex":null,"image_url":null,"family":"Žltá"},{"name":"VERDE BRITISH","hex":null,"image_url":null,"family":"Zelená"},{"name":"ROSSO POMPEIANO","hex":null,"image_url":null,"family":"Červená"}]'::jsonb,
  ARRAY['Biela', 'Červená', 'Hnedá', 'Modrá', 'Sivá', 'Zelená', 'Žltá']::text[],
  ARRAY['100x43x40 cm', '50x22x23 cm', '60x28x27 cm', '83x35x35 cm']::text[],
  ARRAY['Do 50 cm', '51-100 cm']::text[],
  '[{"label":"100x43x40 cm","dimensions":"100x43x40 cm","price_cents":20200,"attributes":{"rozmer":"100x43x40 cm"}},{"label":"50x22x23 cm","dimensions":"50x22x23 cm","price_cents":8000,"attributes":{"rozmer":"50x22x23 cm"}},{"label":"60x28x27 cm","dimensions":"60x28x27 cm","price_cents":9300,"attributes":{"rozmer":"60x28x27 cm"}},{"label":"83x35x35 cm","dimensions":"83x35x35 cm","price_cents":15300,"attributes":{"rozmer":"83x35x35 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"100x43x40 cm, 110x50x50 cm, 50x22x23 cm, 60x28x27 cm, 83x35x35 cm"}]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/en/products/millerighe-rettangolare-planter?_pos=1&_psq=Rettangolare+Millerighe&_ss=e&_v=1.0',
  'https://serralunga.com/en/products/millerighe-rettangolare-planter?_pos=1&_psq=Rettangolare+Millerighe&_ss=e&_v=1.0',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'nabytok' LIMIT 1),
  'Stôl Balzac',
  'stol-balzac',
  'Serralunga',
  50000,
  NULL,
  'Balzac predstavuje prvú spoluprácu medzi značkou Serralunga a dizajnérom Patrickom Norguetom, ktorá prináša výraznú kolekciu spájajúcu pevnosť, eleganciu a komfort. Dizajn sa vyznačuje štedrými krivkami a protikladnými líniami, ktoré pripomínajú štýl vonkajšieho nábytku z počiatku 20. storočia. Stôl Balzac so svojím rozpoznateľným a jednotným dizajnom je vhodný na terasy, verandy či záhradné priestory, ale aj do interiérov, ako sú hotelové lobby alebo spoločenské priestory. Balzac sa dokonale začleňuje do interiérov aj exteriérov, pričom si zachováva harmonický a nadčasový vzhľad. Tento elegantný stôl je dostupný s rôznymi typmi dosiek – od sofistikovanej Lavagna, cez elegantnú Carrara, až po výraznú Red Magma.
 
Rozmer
40 x 72 cm
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/en/products/balzac-table?_pos=1&_psq=balzac&_ss=e&_v=1.0)',
  'https://kochlik.netlify.app/images/stol-balzac/stol-balzac_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/stol-balzac/stol-balzac_1.jpg', 'https://kochlik.netlify.app/images/stol-balzac/stol-balzac_2.webp', 'https://kochlik.netlify.app/images/stol-balzac/stol-balzac_3.jpg', 'https://kochlik.netlify.app/images/stol-balzac/stol-balzac_4.jpg', 'https://kochlik.netlify.app/images/stol-balzac/stol-balzac_5.jpg', 'https://kochlik.netlify.app/images/stol-balzac/stol-balzac_6.jpg']::text[],
  '[{"name":"SALVIA DI SARDEGNA BASE","hex":null,"image_url":null,"family":"Zelená"},{"name":"RED CLAY BASE","hex":null,"image_url":null,"family":"Červená"},{"name":"MORE DI ROVO BASE","hex":null,"image_url":null,"family":"Ružová"},{"name":"PIETRA DI MATERA BASE","hex":null,"image_url":null,"family":"Sivá"},{"name":"TORTORA DI TORINO BASE","hex":null,"image_url":null,"family":"Hnedá"}]'::jsonb,
  ARRAY['Červená', 'Hnedá', 'Ružová', 'Sivá', 'Zelená']::text[],
  ARRAY['40 x 72 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/en/products/balzac-table?_pos=1&_psq=balzac&_ss=e&_v=1.0',
  'https://serralunga.com/en/products/balzac-table?_pos=1&_psq=balzac&_ss=e&_v=1.0',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'dizajnove' LIMIT 1),
  'Kvetináč Missed Tree II',
  'kvetinac-missed-tree-ii',
  'Serralunga',
  195000,
  NULL,
  'Kvetináč Missed Tree, ktorý navrhol Jean-Marie Massaud pre Serralunga, vdychuje život fantazijnej prízračnej lesnej scenérii a vytvára pôsobivé exteriérové prostredia, v ktorých sa spájajú technické a etnické tvary. Tento jedinečný dizajn povyšuje interiérové aj exteriérové rastliny na úroveň sochárskych objektov, ktoré pripomínajú stromy v modernom kontexte. Missed Tree je kvetináč výrazných rozmerov, ideálny ako dominantný prvok v záhradnej či architektonickej kompozícii.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/en/products/missed-tree-planter-ii?_pos=1&_psq=Missed+Tree+II&_ss=e&_v=1.0)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/kvetinac-missed-tree-ii/kvetinac-missed-tree-ii_1.webp',
  ARRAY['https://kochlik.netlify.app/images/kvetinac-missed-tree-ii/kvetinac-missed-tree-ii_1.webp']::text[],
  '[{"name":"LACQUEROSSO BIANCO","hex":null,"image_url":null,"family":"Biela"},{"name":"ROSSO","hex":null,"image_url":null,"family":"Červená"},{"name":"SALVIA DI SARDEGNA","hex":null,"image_url":null,"family":"Zelená"},{"name":"TORTORA DI TORINO","hex":null,"image_url":null,"family":"Hnedá"},{"name":"BIANCO","hex":null,"image_url":null,"family":"Biela"},{"name":"VERDE PAVONE","hex":null,"image_url":null,"family":"Zelená"},{"name":"ANTRACITE","hex":null,"image_url":null,"family":"Sivá"},{"name":"GIALLO SAHARA","hex":null,"image_url":null,"family":"Žltá"},{"name":"VERDE BRITISH","hex":null,"image_url":null,"family":"Zelená"},{"name":"ROSSO POMPEIANO","hex":null,"image_url":null,"family":"Červená"}]'::jsonb,
  ARRAY['Biela', 'Červená', 'Hnedá', 'Sivá', 'Zelená', 'Žltá']::text[],
  ARRAY['75x75x200 cm']::text[],
  ARRAY['Nad 150 cm']::text[],
  '[{"label":"75x75x200 cm","dimensions":"75x75x200 cm","price_cents":195000,"attributes":{"rozmer":"75x75x200 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"75x75x200 cm"}]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/en/products/missed-tree-planter-ii?_pos=1&_psq=Missed+Tree+II&_ss=e&_v=1.0',
  'https://serralunga.com/en/products/missed-tree-planter-ii?_pos=1&_psq=Missed+Tree+II&_ss=e&_v=1.0',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'svietiace-kvetinace' LIMIT 1),
  'Kvetináč Torre svietiaci',
  'kvetinac-torre-svietiaci',
  'Serralunga',
  25600,
  NULL,
  'Materiál: Vyrobené z LLDPE (lineárny nízkohustotný polyetylén) Výrobný proces: Rotačné tvarovanie Vhodnosť použitia: Určené na vonkajšie použitie, odolné voči poveternostným vplyvom Ochrana: UV ochrana, 100 % recyklovateľný materiál, farba prefarbená v hmote Vlastnosti: • Vysoká mechanická pevnosť a odolnosť voči nárazom • Odolné voči teplotám od –35 °C do +80 °C
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/en/products/torre-planter-with-light?_pos=2&_psq=Torre&_ss=e&_v=1.0)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/kvetinac-torre-svietiaci/kvetinac-torre-svietiaci_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/kvetinac-torre-svietiaci/kvetinac-torre-svietiaci_1.jpg']::text[],
  '[{"name":"RGB light with cable","hex":null,"image_url":null,"family":null},{"name":"White light with cable","hex":null,"image_url":null,"family":"Biela"},{"name":"LED with cable","hex":null,"image_url":null,"family":null}]'::jsonb,
  ARRAY['Biela']::text[],
  ARRAY['38x38x70 cm', '42x42x90 cm', '45x45x50 cm', '55x55x100 cm']::text[],
  ARRAY['Do 50 cm', '51-100 cm']::text[],
  '[{"label":"38x38x70 cm","dimensions":"38x38x70 cm","price_cents":29900,"attributes":{"rozmer":"38x38x70 cm","typ-ziarovky":"LED"}},{"label":"38x38x70 cm","dimensions":"38x38x70 cm","price_cents":27000,"attributes":{"rozmer":"38x38x70 cm","typ-ziarovky":"RGB"}},{"label":"42x42x90 cm","dimensions":"42x42x90 cm","price_cents":34600,"attributes":{"rozmer":"42x42x90 cm","typ-ziarovky":"LED"}},{"label":"42x42x90 cm","dimensions":"42x42x90 cm","price_cents":31700,"attributes":{"rozmer":"42x42x90 cm","typ-ziarovky":"RGB"}},{"label":"45x45x50 cm","dimensions":"45x45x50 cm","price_cents":28500,"attributes":{"rozmer":"45x45x50 cm","typ-ziarovky":"LED"}},{"label":"45x45x50 cm","dimensions":"45x45x50 cm","price_cents":25600,"attributes":{"rozmer":"45x45x50 cm","typ-ziarovky":"RGB"}},{"label":"55x55x100 cm","dimensions":"55x55x100 cm","price_cents":42700,"attributes":{"rozmer":"55x55x100 cm","typ-ziarovky":"LED"}},{"label":"55x55x100 cm","dimensions":"55x55x100 cm","price_cents":39800,"attributes":{"rozmer":"55x55x100 cm","typ-ziarovky":"RGB"}}]'::jsonb,
  '[{"key":"Rozmer","value":"38x38x70 cm, 42x42x90 cm, 45x45x50 cm, 55x55x100 cm"},{"key":"Typ žiarovky","value":"LED, RGB"}]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/en/products/torre-planter-with-light?_pos=2&_psq=Torre&_ss=e&_v=1.0',
  'https://serralunga.com/en/products/torre-planter-with-light?_pos=2&_psq=Torre&_ss=e&_v=1.0',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'nabytok' LIMIT 1),
  'Kreslo Bay',
  'kreslo-bay',
  'Serralunga',
  37000,
  NULL,
  'Kompaktné kreslo Bay bolo navrhnuté s dôrazom na dokonale vyvážené proporcie – jeho sedacia časť je vytvarovaná tak, aby pohodlne objala sediaceho. Ľahké, harmonické a minimalistické, s malými rozmermi, no s výraznou osobnosťou. Charakteristickým prvkom je jemné prešitie na kontúrach a zadnej časti operadla, pripomínajúce krajčírske línie čalúneného kresla z látky, ktoré dodávajú dizajnu jedinečný remeselný nádych. Táto verzia je dostupná aj v Moleskin povrchovej úprave, registrovaný dizajn, ktorá produktu dodáva teplo, hĺbku a sofistikovaný charakter.
Rozmer
65 x 65 x 70cm
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/en/products/bay-armchair?_pos=1&_psq=Bay&_ss=e&_v=1.0)',
  'https://kochlik.netlify.app/images/kreslo-bay/kreslo-bay_1.webp',
  ARRAY['https://kochlik.netlify.app/images/kreslo-bay/kreslo-bay_1.webp', 'https://kochlik.netlify.app/images/kreslo-bay/kreslo-bay_2.webp', 'https://kochlik.netlify.app/images/kreslo-bay/kreslo-bay_3.webp', 'https://kochlik.netlify.app/images/kreslo-bay/kreslo-bay_4.webp']::text[],
  '[{"name":"BIANCO","hex":null,"image_url":null,"family":"Biela"},{"name":"VERDE PAVONE","hex":null,"image_url":null,"family":"Zelená"},{"name":"VERDE OLIVE DI CERIGNOLA","hex":null,"image_url":null,"family":"Zelená"},{"name":"TORTORA DI TORINO","hex":null,"image_url":null,"family":"Hnedá"},{"name":"AZZURRO DI PROVENZA","hex":null,"image_url":null,"family":"Modrá"},{"name":"ANTRACITE","hex":null,"image_url":null,"family":"Sivá"},{"name":"ACQUA DELLA MADDALENA","hex":null,"image_url":null,"family":"Modrá"},{"name":"PIETRA DELLA DOLOMITI","hex":null,"image_url":null,"family":"Sivá"},{"name":"LACQUERED WHITE","hex":null,"image_url":null,"family":"Biela"},{"name":"ROSSO","hex":null,"image_url":null,"family":"Červená"},{"name":"SALVIA DI SARDEGNA","hex":null,"image_url":null,"family":"Zelená"},{"name":"GIALLO SAHARA","hex":null,"image_url":null,"family":"Žltá"},{"name":"VERDE BRITISH","hex":null,"image_url":null,"family":"Zelená"},{"name":"ROSSO POMPEIANO","hex":null,"image_url":null,"family":"Červená"}]'::jsonb,
  ARRAY['Biela', 'Červená', 'Hnedá', 'Modrá', 'Sivá', 'Zelená', 'Žltá']::text[],
  ARRAY['65 x 70cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/en/products/bay-armchair?_pos=1&_psq=Bay&_ss=e&_v=1.0',
  'https://serralunga.com/en/products/bay-armchair?_pos=1&_psq=Bay&_ss=e&_v=1.0',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'nabytok' LIMIT 1),
  'Kreslo Gumball junior',
  'kreslo-gumball-junior',
  'Plust',
  23000,
  NULL,
  'Navrhnutá dizajnérom Albertom Brogliatom, kolekcia Gumball Junior Family je venovaná detskému svetu a zahŕňa kreslo, pohovku a nízky stolík. Všetky prvky sú plne ergonomické, bez ostrých hrán, a poskytujú deťom pohodlné miesto na oddych po veľkých dobrodružstvách či ako základňu pre nové hry a fantáziu.
Rozmer
60 x 64 x 49 cm
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.plust.it/en/products/gumball-armchair-junior/)',
  'https://kochlik.netlify.app/images/kreslo-gumball-junior/kreslo-gumball-junior_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/kreslo-gumball-junior/kreslo-gumball-junior_1.jpg', 'https://kochlik.netlify.app/images/kreslo-gumball-junior/kreslo-gumball-junior_2.jpg']::text[],
  '[{"name":"Blue","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_11_blue.jpg","family":"Modrá"},{"name":"Emerald green","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_43_emeraldgreen.jpg","family":"Zelená"},{"name":"Fuchsia","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_74_fuchsia.jpg","family":"Ružová"},{"name":"Green A2","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_a2_greena2.jpg","family":"Zelená"},{"name":"Yellow","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_b3_yellow.jpg","family":"Žltá"},{"name":"Orange C1","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_c1_orangec1.jpg","family":"Oranžová"},{"name":"White C2","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_c2_whitec2.jpg","family":"Biela"}]'::jsonb,
  ARRAY['Biela', 'Modrá', 'Oranžová', 'Ružová', 'Zelená', 'Žltá']::text[],
  ARRAY['64 x 49 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb,
  'https://www.plust.it/en/products/gumball-armchair-junior/',
  'https://www.plust.it/en/products/gumball-armchair-junior/',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'moderne-kvetinace' LIMIT 1),
  'Kvetináč IKON mini',
  'kvetinac-ikon-mini',
  'Euro3plast',
  2600,
  NULL,
  'Ikon od euro3plast je elegantný a nadčasový kvetináč navrhnutý tak, aby zvýraznil vaše obľúbené aromatické rastliny v akomkoľvek priestore, v interiéri aj exteriéri. Jeho ikonická silueta je ladená do rafinovaných odtieňov – bielej, perleťovo čiernej, hrdzavej a taupe – aby s jemnosťou a charakterom ozdobila každý kút vášho domova či záhrady. Patrí do novej kolekcie Aromatika, vytvorenej s cieľom spojiť štýl a funkčnosť a premeniť každodenné priestory na voňavé zelené zákutia plné života.
Vďaka technológii rotačného odlievania je Ikon odolný, ľahký a ručne dokončovaný: je to kvalitná voľba, ktorá zaručuje dlhú životnosť a dôraz na detail. Matná textúra a čisté línie z neho robia moderný a všestranný dekoratívny prvok, ideálny na elegantné pestovanie aromatických rastlín.
Vyberte si Ikon a vytvorte si vlastný zelený kútik v kuchyni, na balkóne alebo na verande a vychutnávajte si každý deň autentickú vôňu svojich obľúbených byliniek.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.euro3plast.com/gb/indoor-pots/591-5654-mini-ikon.html#/332-colour-white_c2/607-significant_measure-20)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/kvetinac-ikon-mini/kvetinac-ikon-mini_1.webp',
  ARRAY['https://kochlik.netlify.app/images/kvetinac-ikon-mini/kvetinac-ikon-mini_1.webp', 'https://kochlik.netlify.app/images/kvetinac-ikon-mini/kvetinac-ikon-mini_2.webp', 'https://kochlik.netlify.app/images/kvetinac-ikon-mini/kvetinac-ikon-mini_3.webp', 'https://kochlik.netlify.app/images/kvetinac-ikon-mini/kvetinac-ikon-mini_4.webp', 'https://kochlik.netlify.app/images/kvetinac-ikon-mini/kvetinac-ikon-mini_5.webp']::text[],
  '[{"name":"WHITE C2","hex":"#ffffff","image_url":null,"family":"Biela"},{"name":"RUST","hex":"#543920","image_url":null,"family":"Hnedá"},{"name":"TAUPE","hex":"#706961","image_url":null,"family":"Hnedá"},{"name":"PEARL BLACK","hex":"#4a4a49","image_url":null,"family":"Čierna"}]'::jsonb,
  ARRAY['Biela', 'Čierna', 'Hnedá']::text[],
  ARRAY['20x18 cm']::text[],
  ARRAY['Do 50 cm']::text[],
  '[{"label":"20x18 cm","dimensions":"20x18 cm","price_cents":2600,"attributes":{"rozmer":"20x18 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"20×18 cm"}]'::jsonb,
  '[{"label":"Technický dokument","url":"https://www.euro3plast.com/sheets/ikon_aromatika_vaso.pdf"}]'::jsonb,
  'https://www.euro3plast.com/gb/indoor-pots/591-5654-mini-ikon.html#/332-colour-white_c2/607-significant_measure-20',
  'https://www.euro3plast.com/gb/indoor-pots/591-5654-mini-ikon.html#/332-colour-white_c2/607-significant_measure-20',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'svietiace-kvetinace' LIMIT 1),
  'Kvetináč Cubotti Alto svietiaci',
  'kvetinac-cubotti-alto-svietiaci',
  'Serralunga',
  36000,
  NULL,
  'Materiál: Vyrobené z LLDPE (lineárny nízkohustotný polyetylén) Farba: Neutrálna – priesvitná Spôsob výroby: Rotačné tvarovanie Vhodné na vonkajšie použitie, odolné voči všetkým poveternostným podmienkam. Poskytuje UV ochranu, je 100 % recyklovateľné a farbené v hmote. Vyznačuje sa vysokou mechanickou pevnosťou a odolnosťou voči nárazom. Materiál je tepelne odolný, znáša teploty od –35 °C do +80 °C.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/en/products/cubotti-alto-planter-with-light?_pos=2&_psq=Cubotti+Alto&_ss=e&_v=1.0)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/kvetinac-cubotti-alto-svietiaci/kvetinac-cubotti-alto-svietiaci_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/kvetinac-cubotti-alto-svietiaci/kvetinac-cubotti-alto-svietiaci_1.jpg']::text[],
  '[{"name":"RGB light with cable","hex":null,"image_url":null,"family":null},{"name":"White light with cable","hex":null,"image_url":null,"family":"Biela"}]'::jsonb,
  ARRAY['Biela']::text[],
  ARRAY['37x37x90 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[{"label":"37x37x90 cm","dimensions":"37x37x90 cm","price_cents":38400,"attributes":{"rozmer":"37x37x90 cm","typ-ziarovky":"LED"}},{"label":"37x37x90 cm","dimensions":"37x37x90 cm","price_cents":36000,"attributes":{"rozmer":"37x37x90 cm","typ-ziarovky":"RGB"}}]'::jsonb,
  '[{"key":"Rozmer","value":"37x37x90 cm"},{"key":"Typ žiarovky","value":"LED, RGB"}]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/en/products/cubotti-alto-planter-with-light?_pos=2&_psq=Cubotti+Alto&_ss=e&_v=1.0',
  'https://serralunga.com/en/products/cubotti-alto-planter-with-light?_pos=2&_psq=Cubotti+Alto&_ss=e&_v=1.0',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'nabytok' LIMIT 1),
  'Barový stôl Fura obdĺžnik',
  'barovy-stol-fura-obdlznik',
  'Plust',
  73000,
  NULL,
  'Jedálenský stôl Fura je elegantný, minimalistický a univerzálny – ideálny na spoločné chvíle a príjemné posedenia.
Rozmer
33 x 33 x 75 cm
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.plust.it/en/products/fura-dining-table-structure/)',
  'https://kochlik.netlify.app/images/barovy-stol-fura-obdlznik/barovy-stol-fura-obdlznik_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/barovy-stol-fura-obdlznik/barovy-stol-fura-obdlznik_1.jpg', 'https://kochlik.netlify.app/images/barovy-stol-fura-obdlznik/barovy-stol-fura-obdlznik_2.jpg']::text[],
  '[{"name":"Pearl black","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_87_pearlblack.jpg","family":"Čierna"},{"name":"White C2","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_c2_whitec2.jpg","family":"Biela"},{"name":"Rosemary","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_l4_rosemary.jpg","family":"Zelená"},{"name":"Sandy","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_m9_sandy.jpg","family":"Béžová"},{"name":"Black","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_black_black.jpg","family":"Čierna"},{"name":"White","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_white_white.jpg","family":"Biela"}]'::jsonb,
  ARRAY['Béžová', 'Biela', 'Čierna', 'Zelená']::text[],
  ARRAY['33 x 75 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb,
  'https://www.plust.it/en/products/fura-dining-table-structure/',
  'https://www.plust.it/en/products/fura-dining-table-structure/',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'moderne-kvetinace' LIMIT 1),
  'Kvetináč Bordato Liscio',
  'kvetinac-bordato-liscio',
  'Serralunga',
  7300,
  NULL,
  'Spoločnosť Serralunga 1825 ponúka široký výber kvetináčov a záhradných nádob, vrátane kolekcie Bordato Liscio. Tieto kúsky sa vyznačujú jednoduchými, príjemnými tvarmi a jemne textúrovaným povrchom, ktorý im dodáva tradičný vzhľad so štipkou rustikálneho šarmu, no zároveň si zachovávajú eleganciu. Séria Bordato Liscio prináša moderný nádych klasického tvaru vázy, vďaka čomu je ideálnou voľbou pre akékoľvek prostredie – do interiéru, exteriéru, na terasy či do záhrad. Vďaka jedinečnému „škrabanému“ povrchu a ponuke tradičných farieb tieto kvetináče vyniknú v každom priestore. Dostupné sú v rôznych veľkostiach a štandardných farbách, ako aj v svietiacej verzii.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/en/products/bordato-liscio-planter?pr_prod_strat=e5_desc&pr_rec_id=ca1d8dce0&pr_rec_pid=7006949441673&pr_ref_pid=7003990982793&pr_seq=uniform)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/kvetinac-bordato-liscio/kvetinac-bordato-liscio_1.webp',
  ARRAY['https://kochlik.netlify.app/images/kvetinac-bordato-liscio/kvetinac-bordato-liscio_1.webp', 'https://kochlik.netlify.app/images/kvetinac-bordato-liscio/kvetinac-bordato-liscio_2.webp', 'https://kochlik.netlify.app/images/kvetinac-bordato-liscio/kvetinac-bordato-liscio_3.webp', 'https://kochlik.netlify.app/images/kvetinac-bordato-liscio/kvetinac-bordato-liscio_4.webp', 'https://kochlik.netlify.app/images/kvetinac-bordato-liscio/kvetinac-bordato-liscio_5.webp', 'https://kochlik.netlify.app/images/kvetinac-bordato-liscio/kvetinac-bordato-liscio_6.webp']::text[],
  '[{"name":"BIANCO","hex":null,"image_url":null,"family":"Biela"},{"name":"PIETRA DELLA DOLOMITI","hex":null,"image_url":null,"family":"Sivá"},{"name":"TORTORA DI TORINO","hex":null,"image_url":null,"family":"Hnedá"},{"name":"TERRACOTTA","hex":null,"image_url":null,"family":"Červená"},{"name":"ANTRACITE","hex":null,"image_url":null,"family":"Sivá"},{"name":"AZZURRO DI PROVENZA","hex":null,"image_url":null,"family":"Modrá"},{"name":"SALVIA DI SARDEGNA","hex":null,"image_url":null,"family":"Zelená"},{"name":"ROSSO","hex":null,"image_url":null,"family":"Červená"},{"name":"TERRACOTTA SCURA","hex":null,"image_url":null,"family":"Červená"},{"name":"VERDE PAVONE","hex":null,"image_url":null,"family":"Zelená"},{"name":"ACQUA DELLA MADDALENA","hex":null,"image_url":null,"family":"Modrá"},{"name":"CASTORO","hex":null,"image_url":null,"family":"Hnedá"},{"name":"PIETRA DI MATERA","hex":null,"image_url":null,"family":"Sivá"},{"name":"GIALLO SAHARA","hex":null,"image_url":null,"family":"Žltá"},{"name":"VERDE BRITISH","hex":null,"image_url":null,"family":"Zelená"},{"name":"ROSSO POMPEIANO","hex":null,"image_url":null,"family":"Červená"},{"name":"ORIGANO DI SARDEGNA","hex":null,"image_url":null,"family":"Zelená"},{"name":"OLIVE DI CERIGNOLA","hex":null,"image_url":null,"family":"Zelená"},{"name":"CORTEN","hex":null,"image_url":null,"family":"Hnedá"}]'::jsonb,
  ARRAY['Biela', 'Červená', 'Hnedá', 'Modrá', 'Sivá', 'Zelená', 'Žltá']::text[],
  ARRAY['35,5x35,5x31 cm', '46x46x40 cm', '58x58x50 cm', '68x68x60 cm', '78x78x70 cm', '110x110x100 cm']::text[],
  ARRAY['Do 50 cm', '51-100 cm', '101-150 cm']::text[],
  '[{"label":"35,5x35,5x31 cm","dimensions":"35,5x35,5x31 cm","price_cents":7300,"attributes":{"rozmer":"35,5x35,5x31 cm"}},{"label":"46x46x40 cm","dimensions":"46x46x40 cm","price_cents":9300,"attributes":{"rozmer":"46x46x40 cm"}},{"label":"58x58x50 cm","dimensions":"58x58x50 cm","price_cents":14600,"attributes":{"rozmer":"58x58x50 cm"}},{"label":"68x68x60 cm","dimensions":"68x68x60 cm","price_cents":15600,"attributes":{"rozmer":"68x68x60 cm"}},{"label":"78x78x70 cm","dimensions":"78x78x70 cm","price_cents":22600,"attributes":{"rozmer":"78x78x70 cm"}},{"label":"110x110x100 cm","dimensions":"110x110x100 cm","price_cents":63500,"attributes":{"rozmer":"110x110x100 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"110x110x100 cm, 35,5×35,5×31 cm, 46x46x40 cm, 58x58x50 cm, 68x68x60 cm, 78x78x70 cm"}]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/en/products/bordato-liscio-planter?pr_prod_strat=e5_desc&pr_rec_id=ca1d8dce0&pr_rec_pid=7006949441673&pr_ref_pid=7003990982793&pr_seq=uniform',
  'https://serralunga.com/en/products/bordato-liscio-planter?pr_prod_strat=e5_desc&pr_rec_id=ca1d8dce0&pr_rec_pid=7006949441673&pr_ref_pid=7003990982793&pr_seq=uniform',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'klasicke-kvetinace' LIMIT 1),
  'Balustráda',
  'balustrada',
  'Euro3plast',
  52500,
  NULL,
  'Kolekcia Style je elegantná a nadčasová: tieto nadčasové kvetináče a doplnky dodajú šik nádych záhradám, ktoré túžia po obdive. Úplne talianska svojou tradíciou ponúka širokú škálu veľkostí a vkusne klasických dekorácií, ktoré sa po prvom vzhliadnutí stanú nepostrádateľnými.
Rozmer:
116 x 35 x 87 cm
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.euro3plast.com/gb/products/370-3512-balaustra.html#/534-colour-white/654-significant_measure-116)',
  'https://kochlik.netlify.app/images/balustrada/balustrada_1.webp',
  ARRAY['https://kochlik.netlify.app/images/balustrada/balustrada_1.webp']::text[],
  '[{"name":"WHITE","hex":"#ffffff","image_url":null,"family":"Biela"}]'::jsonb,
  ARRAY['Biela']::text[],
  ARRAY['35 x 87 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[]'::jsonb,
  '[]'::jsonb,
  '[{"label":"Technický dokument","url":"https://www.euro3plast.com/sheets/balaustra_balaustra.pdf"},{"label":"Informačný dokument","url":"https://www.euro3plast.com/sheets/balaustra_balustrade_info_en.pdf"}]'::jsonb,
  'https://www.euro3plast.com/gb/products/370-3512-balaustra.html#/534-colour-white/654-significant_measure-116',
  'https://www.euro3plast.com/gb/products/370-3512-balaustra.html#/534-colour-white/654-significant_measure-116',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'nabytok' LIMIT 1),
  'Stolička Solea',
  'stolicka-solea-2-2',
  'Serralunga',
  37000,
  NULL,
  'Kreslo Solea, navrhnuté Giovannim Giacobonem a Massimom Rojom pre Serralunga, spája tradíciu s moderným dizajnom. Kovová rúrková konštrukcia spolu s jednoliatou škrupinou z polypropylénu odkazuje na harmonické viedenské línie a elegantné krivky konca 19. storočia. Jeho jemný a objímajúci tvar je znovu interpretovaný v modernom duchu, vďaka čomu je ideálne na zariadenie vonkajších priestorov aj neformálnych interiérov, s dôrazom na jednoduchosť a nadčasovú eleganciu. Svedectvom jeho všestrannosti je možnosť dodania s opierkami alebo bez nich, s rôznymi typmi podnoží, ako aj kombinovanie s ďalšími prvkami z rovnakej kolekcie.
Rozmer
62 x 55 x 73 cm
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/en/products/solea-chair-set-of-4?_pos=1&_psq=Solea&_ss=e&_v=1.0)',
  'https://kochlik.netlify.app/images/stolicka-solea-2-2/stolicka-solea-2-2_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/stolicka-solea-2-2/stolicka-solea-2-2_1.jpg']::text[],
  '[]'::jsonb,
  ARRAY[]::text[],
  ARRAY['55 x 73 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/en/products/solea-chair-set-of-4?_pos=1&_psq=Solea&_ss=e&_v=1.0',
  'https://serralunga.com/en/products/solea-chair-set-of-4?_pos=1&_psq=Solea&_ss=e&_v=1.0',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'klasicke-kvetinace' LIMIT 1),
  'Kvetináč FESTONATO',
  'kvetinac-festonato',
  'Serralunga',
  6900,
  NULL,
  'Kvetináč Decorati Festonato od značky Serralunga vyniká tradičnými detailmi a klasickými zemistými tónmi, ktoré vytvárajú pastorálnu atmosféru pripomínajúcu anglické záhrady a taliansky vidiek. Jeho povrch prináša pôvab nečakaného a odhaľuje kryštalickú krásu starobylých kvetináčov, čo pôsobí ako nová, prekvapivá povrchová úprava. Vďaka svojmu elegantnému a nadčasovému dizajnu sa Festonato Medium hodí do každého prostredia – od klasických záhrad až po moderné exteriéry. Dostupný je vo veľkostiach od 35 cm do 55 cm.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/en/products/festonato-planter?_pos=2&_psq=FESTONATO&_ss=e&_v=1.0)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/kvetinac-festonato/kvetinac-festonato_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/kvetinac-festonato/kvetinac-festonato_1.jpg', 'https://kochlik.netlify.app/images/kvetinac-festonato/kvetinac-festonato_2.jpg']::text[],
  '[{"name":"TORTORA DI TORINO","hex":null,"image_url":null,"family":"Hnedá"},{"name":"TERRACOTTA TOSCANA","hex":null,"image_url":null,"family":"Červená"},{"name":"ANTHRACITE","hex":null,"image_url":null,"family":"Sivá"},{"name":"BIANCO","hex":null,"image_url":null,"family":"Biela"},{"name":"AZZURRO DI PROVENZA","hex":null,"image_url":null,"family":"Modrá"},{"name":"PIETRA DELLA DOLOMITI","hex":null,"image_url":null,"family":"Sivá"},{"name":"ROSSO","hex":null,"image_url":null,"family":"Červená"},{"name":"SALVIA DI SARDEGNA","hex":null,"image_url":null,"family":"Zelená"},{"name":"TERRACOTTA SCURA","hex":null,"image_url":null,"family":"Červená"},{"name":"VERDE PAVONE","hex":null,"image_url":null,"family":"Zelená"},{"name":"PIETRA DI MATERA","hex":null,"image_url":null,"family":"Sivá"},{"name":"GIALLO SAHARA","hex":null,"image_url":null,"family":"Žltá"},{"name":"VERDE BRITISH","hex":null,"image_url":null,"family":"Zelená"},{"name":"ROSSO POMPEIANO","hex":null,"image_url":null,"family":"Červená"},{"name":"IMPRUNETA","hex":null,"image_url":null,"family":"Hnedá"}]'::jsonb,
  ARRAY['Biela', 'Červená', 'Hnedá', 'Modrá', 'Sivá', 'Zelená', 'Žltá']::text[],
  ARRAY['35x35x30cm', '40x40x35cm', '45x45x40cm', '50x50x45cm', '55x55x46cm', '65x65x55cm', '75x75x60cm']::text[],
  ARRAY['Do 50 cm', '51-100 cm']::text[],
  '[{"label":"35x35x30cm","dimensions":"35x35x30cm","price_cents":6900,"attributes":{"rozmer":"35x35x30cm"}},{"label":"40x40x35cm","dimensions":"40x40x35cm","price_cents":7600,"attributes":{"rozmer":"40x40x35cm"}},{"label":"45x45x40cm","dimensions":"45x45x40cm","price_cents":8200,"attributes":{"rozmer":"45x45x40cm"}},{"label":"50x50x45cm","dimensions":"50x50x45cm","price_cents":9000,"attributes":{"rozmer":"50x50x45cm"}},{"label":"55x55x46cm","dimensions":"55x55x46cm","price_cents":11000,"attributes":{"rozmer":"55x55x46cm"}},{"label":"65x65x55cm","dimensions":"65x65x55cm","price_cents":13300,"attributes":{"rozmer":"65x65x55cm"}},{"label":"75x75x60cm","dimensions":"75x75x60cm","price_cents":20800,"attributes":{"rozmer":"75x75x60cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"35x35x30cm, 40x40x35cm, 45x45x40cm, 50x50x45cm, 55x55x46cm, 65x65x55cm, 75x75x60cm"}]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/en/products/festonato-planter?_pos=2&_psq=FESTONATO&_ss=e&_v=1.0',
  'https://serralunga.com/en/products/festonato-planter?_pos=2&_psq=FESTONATO&_ss=e&_v=1.0',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'dizajnove' LIMIT 1),
  'Kvetináč Lluna',
  'kvetinac-lluna-plena',
  'Serralunga',
  66000,
  NULL,
  'Kvetináče LLUNA, ktoré pre značku Serralunga navrhol Joan Gaspar, sú ideálne na oddelenie vonkajších priestorov pri zachovaní vizuálneho prepojenia medzi nimi. Sú vhodné na terasy, exteriérové priestory, verejné priestranstvá či okolie bazénov. Model LLUNA Plena je menšia a nižšia verzia v rámci kolekcie, no zachováva si rovnaký elegantný a moderný dizajn. Dostupný je aj v svietiacej verzii, ktorá spája funkciu kvetináča a osvetlenia v jednom štýlovom objekte, ideálnom na vytváranie atmosféry a jemného osvetlenia vo vonkajších priestoroch.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/en/products/lluna-plena-planter?_pos=2&_psq=Lluna&_ss=e&_v=1.0)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/kvetinac-lluna-plena/kvetinac-lluna-plena_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/kvetinac-lluna-plena/kvetinac-lluna-plena_1.jpg']::text[],
  '[{"name":"LACQUEROSSO BIANCO","hex":null,"image_url":null,"family":"Biela"},{"name":"ANTRACITE","hex":null,"image_url":null,"family":"Sivá"},{"name":"AZZURRO DI PROVENZA","hex":null,"image_url":null,"family":"Modrá"},{"name":"ROSSO","hex":null,"image_url":null,"family":"Červená"},{"name":"TERRACOTTA SCURA","hex":null,"image_url":null,"family":"Červená"},{"name":"TORTORA DI TORINO","hex":null,"image_url":null,"family":"Hnedá"},{"name":"BIANCO","hex":null,"image_url":null,"family":"Biela"},{"name":"VERDE PAVONE","hex":null,"image_url":null,"family":"Zelená"},{"name":"GIALLO SAHARA","hex":null,"image_url":null,"family":"Žltá"},{"name":"VERDE BRITISH","hex":null,"image_url":null,"family":"Zelená"},{"name":"ROSSO POMPEIANO","hex":null,"image_url":null,"family":"Červená"}]'::jsonb,
  ARRAY['Biela', 'Červená', 'Hnedá', 'Modrá', 'Sivá', 'Zelená', 'Žltá']::text[],
  ARRAY['40x40x66 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[{"label":"40x40x66 cm","dimensions":"40x40x66 cm","price_cents":66000,"attributes":{"rozmer":"40x40x66 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"40x40x66 cm"}]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/en/products/lluna-plena-planter?_pos=2&_psq=Lluna&_ss=e&_v=1.0',
  'https://serralunga.com/en/products/lluna-plena-planter?_pos=2&_psq=Lluna&_ss=e&_v=1.0',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'nabytok' LIMIT 1),
  'Konferenčný stolík Palenquera',
  'konferencny-stolik-palenquera',
  'Serralunga',
  31500,
  NULL,
  'Stôl Palenquera, navrhnutý Linou Obregon pre Serralunga. Pyramídové tvary sa spájajú a vytvárajú obdĺžnikové záhradné stoly so zaoblenými hranami – objekt súčasného umenia a talianskeho dizajnového nábytku.
Rozmer
70 x 30 x 40 cm
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/products/palenquera-table?_pos=1&_psq=Palenquera&_ss=e&_v=1.0)',
  'https://kochlik.netlify.app/images/konferencny-stolik-palenquera/konferencny-stolik-palenquera_1.webp',
  ARRAY['https://kochlik.netlify.app/images/konferencny-stolik-palenquera/konferencny-stolik-palenquera_1.webp', 'https://kochlik.netlify.app/images/konferencny-stolik-palenquera/konferencny-stolik-palenquera_2.webp']::text[],
  '[{"name":"ANTRACITE","hex":null,"image_url":null,"family":"Sivá"},{"name":"BIANCO","hex":null,"image_url":null,"family":"Biela"},{"name":"AZZURRO DI PROVENZA","hex":null,"image_url":null,"family":"Modrá"},{"name":"ROSSO","hex":null,"image_url":null,"family":"Červená"},{"name":"SALVIA DI SARDEGNA","hex":null,"image_url":null,"family":"Zelená"},{"name":"TORTORA DI TORINO","hex":null,"image_url":null,"family":"Hnedá"},{"name":"CORTEN","hex":null,"image_url":null,"family":"Hnedá"}]'::jsonb,
  ARRAY['Biela', 'Červená', 'Hnedá', 'Modrá', 'Sivá', 'Zelená']::text[],
  ARRAY['30 x 40 cm']::text[],
  ARRAY['Do 50 cm']::text[],
  '[]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/products/palenquera-table?_pos=1&_psq=Palenquera&_ss=e&_v=1.0',
  'https://serralunga.com/products/palenquera-table?_pos=1&_psq=Palenquera&_ss=e&_v=1.0',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'nabytok' LIMIT 1),
  'Stolík JUJU',
  'stolik-juju',
  'Serralunga',
  26300,
  NULL,
  'Juju je pôvabný príručný stolík, ktorý navrhol Garth Roberts pre Serralunga. Stolík Juju zaujme svojím jednoduchým, no hravým dizajnom, ktorý spája minimalizmus s jemným nádychom elegancie. Je kompaktný, ľahký a ľahko prenosný, čo z neho robí praktický a štýlový doplnok pre akýkoľvek priestor – či už ide o raňajkovú kávu na terase, alebo večerné posedenie s priateľmi. Dostupný je aj vo verzii Corten, ako aj v osvetlenom variante, ktorý pridáva atmosféru a moderný charakter. Táto verzia je vytvorená s Moleskin povrchovou úpravou – registrovaný dizajn, ktorý dodáva stolíku textúru, teplo a jedinečný vizuálny dojem.
Rozmer
52 x 52 x 50 cm
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/en/products/juju-table?_pos=1&_psq=JUJU&_ss=e&_v=1.0)',
  'https://kochlik.netlify.app/images/stolik-juju/stolik-juju_1.webp',
  ARRAY['https://kochlik.netlify.app/images/stolik-juju/stolik-juju_1.webp', 'https://kochlik.netlify.app/images/stolik-juju/stolik-juju_2.webp', 'https://kochlik.netlify.app/images/stolik-juju/stolik-juju_3.webp', 'https://kochlik.netlify.app/images/stolik-juju/stolik-juju_4.webp', 'https://kochlik.netlify.app/images/stolik-juju/stolik-juju_5.webp']::text[],
  '[{"name":"BIANCO","hex":null,"image_url":null,"family":"Biela"},{"name":"VERDE PAVONE","hex":null,"image_url":null,"family":"Zelená"},{"name":"ANTRACITE","hex":null,"image_url":null,"family":"Sivá"},{"name":"AZZURRO DI PROVENZA","hex":null,"image_url":null,"family":"Modrá"},{"name":"SALVIA DI SARDEGNA","hex":null,"image_url":null,"family":"Zelená"},{"name":"TORTORA DI TORINO","hex":null,"image_url":null,"family":"Hnedá"},{"name":"VERDE OLIVE DI CERIGNOLA","hex":null,"image_url":null,"family":"Zelená"},{"name":"ACQUA DELLA MADDALENA","hex":null,"image_url":null,"family":"Modrá"},{"name":"PIETRA DELLA DOLOMITI","hex":null,"image_url":null,"family":"Sivá"},{"name":"LACCATO BIANCO","hex":null,"image_url":null,"family":"Biela"},{"name":"ROSSO","hex":null,"image_url":null,"family":"Červená"},{"name":"TERRACOTTA SCURA","hex":null,"image_url":null,"family":"Červená"},{"name":"GIALLO SAHARA","hex":null,"image_url":null,"family":"Žltá"},{"name":"VERDE BRITISH","hex":null,"image_url":null,"family":"Zelená"},{"name":"ROSSO POMPEIANO","hex":null,"image_url":null,"family":"Červená"},{"name":"MORE DI ROVO - NERO","hex":null,"image_url":null,"family":"Čierna"},{"name":"GESSO DI BOLOGNA","hex":null,"image_url":null,"family":"Biela"}]'::jsonb,
  ARRAY['Biela', 'Červená', 'Čierna', 'Hnedá', 'Modrá', 'Sivá', 'Zelená', 'Žltá']::text[],
  ARRAY['52 x 50 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/en/products/juju-table?_pos=1&_psq=JUJU&_ss=e&_v=1.0',
  'https://serralunga.com/en/products/juju-table?_pos=1&_psq=JUJU&_ss=e&_v=1.0',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'moderne-kvetinace' LIMIT 1),
  'Hrantik KUBE s kolieskami',
  'hrantik-kube-s-kolieskami',
  'Euro3plast',
  23100,
  NULL,
  'Štýl je synonymom minimalizmu – dokonale zhrnutý v čistých a jednoduchých líniách našich kvetináčov a doplnkov. Skombinovali sme čisté profily s farebnou paletou pre každý vkus – od výraznej kyslej zelene a červenej po klasické odtiene – aby ste obohatili svoje obľúbené priestory harmóniou a eleganciou.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.euro3plast.com/gb/-/332-3191-kube.html#/332-colour-white_c2/621-significant_measure-100)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/hrantik-kube-s-kolieskami/hrantik-kube-s-kolieskami_1.webp',
  ARRAY['https://kochlik.netlify.app/images/hrantik-kube-s-kolieskami/hrantik-kube-s-kolieskami_1.webp', 'https://kochlik.netlify.app/images/hrantik-kube-s-kolieskami/hrantik-kube-s-kolieskami_2.webp']::text[],
  '[{"name":"WHITE C2","hex":"#ffffff","image_url":null,"family":"Biela"},{"name":"RUST","hex":"#543920","image_url":null,"family":"Hnedá"},{"name":"TAUPE","hex":"#706961","image_url":null,"family":"Hnedá"},{"name":"CEMENT","hex":"#999390","image_url":null,"family":"Sivá"},{"name":"GRANITE","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/e3p_hrantik-kube-s-kolieskami_granite.jpg","family":"Sivá"},{"name":"LAVA","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/e3p_hrantik-kube-s-kolieskami_lava.jpg","family":"Sivá"},{"name":"STONE","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/e3p_hrantik-kube-s-kolieskami_stone.jpg","family":"Sivá"},{"name":"CRETA","hex":"#786e69","image_url":null,"family":"Béžová"},{"name":"PEARL BLACK","hex":"#4a4a49","image_url":null,"family":"Čierna"}]'::jsonb,
  ARRAY['Béžová', 'Biela', 'Čierna', 'Hnedá', 'Sivá']::text[],
  ARRAY['100x40x41 cm', '80x30x31 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[{"label":"100x40x41 cm","dimensions":"100x40x41 cm","price_cents":29500,"attributes":{"rozmer":"100x40x41 cm"}},{"label":"80x30x31 cm","dimensions":"80x30x31 cm","price_cents":23100,"attributes":{"rozmer":"80x30x31 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"100x40x41 cm, 80x30x31 cm"}]'::jsonb,
  '[{"label":"Technický dokument","url":"https://www.euro3plast.com/sheets/kube_cassetta_con_doppia_parete_+_ruote.pdf"},{"label":"Informačný dokument","url":"https://www.euro3plast.com/sheets/kube_plant_box_with_double_wall_+_castors_info_en.pdf"}]'::jsonb,
  'https://www.euro3plast.com/gb/-/332-3191-kube.html#/332-colour-white_c2/621-significant_measure-100',
  'https://www.euro3plast.com/gb/-/332-3191-kube.html#/332-colour-white_c2/621-significant_measure-100',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'svietiace-kvetinace' LIMIT 1),
  'Kvetináč Kabin HIGH svietiaci',
  'kvetinac-kabin-high-svietiaci',
  'Serralunga',
  46800,
  NULL,
  'Materiál: Vyrobené z LLDPE (lineárny nízkohustotný polyetylén) Spôsob výroby: Rotačné tvarovanie Vhodnosť: Určené na vonkajšie použitie, odolné voči všetkým poveternostným podmienkam. Poskytuje UV ochranu, je 100 % recyklovateľné a farbené v hmote. Vyznačuje sa vysokou mechanickou pevnosťou a odolnosťou voči nárazom. Materiál je tepelne odolný, znáša teploty od –35 °C do +80 °C.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/en/products/kabin-high-planter-with-light?_pos=2&_psq=Kabin+HIGH&_ss=e&_v=1.0)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/kvetinac-kabin-high-svietiaci/kvetinac-kabin-high-svietiaci_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/kvetinac-kabin-high-svietiaci/kvetinac-kabin-high-svietiaci_1.jpg']::text[],
  '[{"name":"RGB light with cable","hex":null,"image_url":null,"family":null},{"name":"White light with cable","hex":null,"image_url":null,"family":"Biela"}]'::jsonb,
  ARRAY['Biela']::text[],
  ARRAY['35x35x70cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[{"label":"35x35x70cm","dimensions":"35x35x70cm","price_cents":50400,"attributes":{"rozmer":"35x35x70cm","typ-ziarovky":"LED"}},{"label":"35x35x70cm","dimensions":"35x35x70cm","price_cents":46800,"attributes":{"rozmer":"35x35x70cm","typ-ziarovky":"RGB"}}]'::jsonb,
  '[{"key":"Rozmer","value":"35x35x70cm"},{"key":"Typ žiarovky","value":"LED, RGB"}]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/en/products/kabin-high-planter-with-light?_pos=2&_psq=Kabin+HIGH&_ss=e&_v=1.0',
  'https://serralunga.com/en/products/kabin-high-planter-with-light?_pos=2&_psq=Kabin+HIGH&_ss=e&_v=1.0',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'dizajnove' LIMIT 1),
  'Vaso Flow Medium',
  'vaso-flow-medium',
  'Serralunga',
  451,
  NULL,
  'Model Flow Medium si aj napriek svojej výške 1 meter zachováva impozantný vzhľad – vyniká pôsobivými krivkami a elegantnými tvarmi, ktoré sa neustále menia podľa uhla pohľadu. V kombinácii s väčším modelom Flow Large vytvára úchvatnú dvojicu, ktorá pôsobí ako sochárske umelecké dielo. Za dizajnom stojí Zaha Hadid, ktorá je právom označovaná za „matku“ kolekcie Serralunga Flow.',
  'https://kochlik.netlify.app/images/vaso-flow-medium/vaso-flow-medium_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/vaso-flow-medium/vaso-flow-medium_1.jpg']::text[],
  '[]'::jsonb,
  ARRAY[]::text[],
  ARRAY[]::text[],
  ARRAY[]::text[],
  '[]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb,
  'https://kochlik.sk/produkt/vaso-flow-medium/',
  'https://kochlik.sk/produkt/vaso-flow-medium/',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'dizajnove' LIMIT 1),
  'Kvetináč Cone',
  'kvetinac-cone',
  'Serralunga',
  86900,
  NULL,
  'Cone je kvetináč inšpirovaný ikonickým tvarom tradičnej vázy, ktorý svojou zväčšenou veľkosťou pôsobí výrazne a jedinečne. Vďaka svojmu dizajnu dokáže oživiť každý záhradný priestor a štýlovo doplniť exteriérový nábytok. Tento veľkoformátový kvetináč je vyrobený technológiou rotačného tvarovania a je dostupný v rôznych farebných prevedeniach, vrátane svietiacej verzie. Dizajn od Naota Fukasawu robí z modelu Cone elegantný prvok kolekcie kvetináčov Serralunga, ktorý spája minimalizmus, štýl a funkcionalitu.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/en/products/cone-planter?pr_prod_strat=e5_desc&pr_rec_id=c4d788b79&pr_rec_pid=7003989475465&pr_ref_pid=7003989508233&pr_seq=uniform)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/kvetinac-cone/kvetinac-cone_1.webp',
  ARRAY['https://kochlik.netlify.app/images/kvetinac-cone/kvetinac-cone_1.webp', 'https://kochlik.netlify.app/images/kvetinac-cone/kvetinac-cone_2.webp', 'https://kochlik.netlify.app/images/kvetinac-cone/kvetinac-cone_3.jpg']::text[],
  '[{"name":"BIANCO","hex":null,"image_url":null,"family":"Biela"},{"name":"TORTORA DI TORINO","hex":null,"image_url":null,"family":"Hnedá"},{"name":"LACQUERED WHITE","hex":null,"image_url":null,"family":"Biela"},{"name":"ANTRACITE","hex":null,"image_url":null,"family":"Sivá"},{"name":"AZZURRO DI PROVENZA","hex":null,"image_url":null,"family":"Modrá"},{"name":"ROSSO","hex":null,"image_url":null,"family":"Červená"},{"name":"SALVIA DI SARDEGNA","hex":null,"image_url":null,"family":"Zelená"},{"name":"VERDE PAVONE","hex":null,"image_url":null,"family":"Zelená"},{"name":"GIALLO SAHARA","hex":null,"image_url":null,"family":"Žltá"},{"name":"VERDE BRITISH","hex":null,"image_url":null,"family":"Zelená"},{"name":"ROSSO POMPEIANO","hex":null,"image_url":null,"family":"Červená"}]'::jsonb,
  ARRAY['Biela', 'Červená', 'Hnedá', 'Modrá', 'Sivá', 'Zelená', 'Žltá']::text[],
  ARRAY['130x130x90 cm']::text[],
  ARRAY['101-150 cm']::text[],
  '[{"label":"130x130x90 cm","dimensions":"130x130x90 cm","price_cents":86900,"attributes":{"rozmer":"130x130x90 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"130x130x90 cm"}]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/en/products/cone-planter?pr_prod_strat=e5_desc&pr_rec_id=c4d788b79&pr_rec_pid=7003989475465&pr_ref_pid=7003989508233&pr_seq=uniform',
  'https://serralunga.com/en/products/cone-planter?pr_prod_strat=e5_desc&pr_rec_id=c4d788b79&pr_rec_pid=7003989475465&pr_ref_pid=7003989508233&pr_seq=uniform',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'nabytok' LIMIT 1),
  'Kreslo Bold',
  'kreslo-bold',
  'Plust',
  101000,
  NULL,
  'Kreslo so širokým a hlbokým sedadlom je doplnené systémom vankúšov, ktoré zabezpečujú maximálne pohodlie a útulnosť. Vankúše sú dostupné v troch farebných prevedeniach a vďaka výplni DryFeel a poťahu z látky Sunbrella sú vhodné na použitie v interiéri aj exteriéri. Svietiaca verzia kresla a pohovky vytvára sústavu sedacích prvkov s jemne zaoblenými líniami, ktoré v kombinácii so svetelným efektom navodzujú príjemnú, uvoľnenú atmosféru – ideálnu pre interiérové salóniky a oddychové zóny.
Rozmer
85 x 78 x 77 cm
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.plust.it/en/products/bold-armchair/)',
  'https://kochlik.netlify.app/images/kreslo-bold/kreslo-bold_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/kreslo-bold/kreslo-bold_1.jpg', 'https://kochlik.netlify.app/images/kreslo-bold/kreslo-bold_2.jpg', 'https://kochlik.netlify.app/images/kreslo-bold/kreslo-bold_3.jpg', 'https://kochlik.netlify.app/images/kreslo-bold/kreslo-bold_4.jpg', 'https://kochlik.netlify.app/images/kreslo-bold/kreslo-bold_5.jpg']::text[],
  '[{"name":"Sage green","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_34_sagegreen.jpg","family":"Zelená"},{"name":"White C2","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_c2_whitec2.jpg","family":"Biela"},{"name":"Taupe","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_g9_taupe.jpg","family":"Hnedá"},{"name":"Golden rust","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_n4_goldenrust.jpg","family":"Hnedá"},{"name":"Brown","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_brown_brown.jpg","family":"Hnedá"},{"name":"Grey","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_grey_grey.jpg","family":"Sivá"},{"name":"White","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_white_white.jpg","family":"Biela"},{"name":"White light","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_u1_whitelight.jpg","family":"Biela"}]'::jsonb,
  ARRAY['Biela', 'Hnedá', 'Sivá', 'Zelená']::text[],
  ARRAY['78 x 77 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb,
  'https://www.plust.it/en/products/bold-armchair/',
  'https://www.plust.it/en/products/bold-armchair/',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  NULL,
  'Kvetináč IKON xxl',
  'kvetinac-ikon-xxl',
  'Euro3plast',
  156700,
  NULL,
  'Štýl je synonymom minimalistického dizajnu – čisté, jednoduché línie kvetináčov a doplnkov dopĺňa farebná škála pre každý vkus. Vytvára harmonické a elegantné kompozície vo vašich obľúbených priestoroch.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.euro3plast.com/gb/indoor-pots/510-ikon.html)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/kvetinac-ikon-xxl/kvetinac-ikon-xxl_1.webp',
  ARRAY['https://kochlik.netlify.app/images/kvetinac-ikon-xxl/kvetinac-ikon-xxl_1.webp', 'https://kochlik.netlify.app/images/kvetinac-ikon-xxl/kvetinac-ikon-xxl_2.webp']::text[],
  '[{"name":"WHITE C2","hex":"#ffffff","image_url":null,"family":"Biela"},{"name":"RUST","hex":"#543920","image_url":null,"family":"Hnedá"},{"name":"TAUPE","hex":"#706961","image_url":null,"family":"Hnedá"},{"name":"PEARL BLACK","hex":"#4a4a49","image_url":null,"family":"Čierna"}]'::jsonb,
  ARRAY['Biela', 'Čierna', 'Hnedá']::text[],
  ARRAY['200x178 cm', '160x143 cm', '140x125 cm']::text[],
  ARRAY['101-150 cm', 'Nad 150 cm']::text[],
  '[{"label":"200x178 cm","dimensions":"200x178 cm","price_cents":245600,"attributes":{"rozmer":"200x178 cm"}},{"label":"160x143 cm","dimensions":"160x143 cm","price_cents":182100,"attributes":{"rozmer":"160x143 cm"}},{"label":"140x125 cm","dimensions":"140x125 cm","price_cents":156700,"attributes":{"rozmer":"140x125 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"140×125 cm, 160×143 cm, 200×178 cm"}]'::jsonb,
  '[{"label":"Technický dokument","url":"https://www.euro3plast.com/sheets/ikon_vaso_xxl.pdf"},{"label":"Informačný dokument","url":"https://www.euro3plast.com/sheets/ikon_pot_xxl_info_en.pdf"}]'::jsonb,
  'https://www.euro3plast.com/gb/indoor-pots/510-ikon.html',
  'https://www.euro3plast.com/gb/indoor-pots/510-ikon.html',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'nabytok' LIMIT 1),
  'Stolík Big Cut',
  'stolik-big-cut',
  'Plust',
  24000,
  NULL,
  'Tento konferenčný stolík možno použiť samostatne alebo ako súčasť modulárneho systému Big Cut, vďaka praktickému upevňovaciemu systému umiestnenému v spodnej časti.
Rozmer
60 x 60 x 31 cm
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.plust.it/en/products/big-cut-table/)',
  'https://kochlik.netlify.app/images/stolik-big-cut/stolik-big-cut_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/stolik-big-cut/stolik-big-cut_1.jpg', 'https://kochlik.netlify.app/images/stolik-big-cut/stolik-big-cut_2.jpg', 'https://kochlik.netlify.app/images/stolik-big-cut/stolik-big-cut_3.jpg']::text[],
  '[{"name":"White C2","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_c2_whitec2.jpg","family":"Biela"},{"name":"Taupe","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_g9_taupe.jpg","family":"Hnedá"},{"name":"White light","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_u1_whitelight.jpg","family":"Biela"}]'::jsonb,
  ARRAY['Biela', 'Hnedá']::text[],
  ARRAY['60 x 31 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb,
  'https://www.plust.it/en/products/big-cut-table/',
  'https://www.plust.it/en/products/big-cut-table/',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'nabytok' LIMIT 1),
  'Sedátko Cero',
  'sedatko-cero',
  'Serralunga',
  23000,
  NULL,
  'Taburet Cero je neformálne sedenie z polyetylénu, ktoré vyniká ľahkosťou a otvoreným tvarom. Pôsobivá kombinácia tvaru a funkčnosti z neho robí sochársky prvok moderného nábytku, ideálny na zútulnenie mestského prostredia s dávkou štýlu a energie. Vďaka svojej praktickosti a mobilite je vhodný pre interiéry aj exteriéry – možno ho použiť ako podnožku, doplnkové sedenie alebo dekoračný prvok. Táto verzia je dostupná aj v Moleskin povrchovej úprave, registrovaný dizajn, ktorá dodáva taburetu elegantný, teplý a sofistikovaný charakter.
Rozmer
58 x 40 x 45 cm
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/en/products/cero-stool?_pos=2&_psq=Cero&_ss=e&_v=1.0)',
  'https://kochlik.netlify.app/images/sedatko-cero/sedatko-cero_1.webp',
  ARRAY['https://kochlik.netlify.app/images/sedatko-cero/sedatko-cero_1.webp', 'https://kochlik.netlify.app/images/sedatko-cero/sedatko-cero_2.webp']::text[],
  '[{"name":"BIANCO","hex":null,"image_url":null,"family":"Biela"},{"name":"VERDE PAVONE","hex":null,"image_url":null,"family":"Zelená"},{"name":"ANTRACITE","hex":null,"image_url":null,"family":"Sivá"},{"name":"AZZURRO DI PROVENZA","hex":null,"image_url":null,"family":"Modrá"},{"name":"SALVIA DI SARDEGNA","hex":null,"image_url":null,"family":"Zelená"},{"name":"TORTORA DI TORINO","hex":null,"image_url":null,"family":"Hnedá"},{"name":"VERDE OLIVE DI CERIGNOLA","hex":null,"image_url":null,"family":"Zelená"},{"name":"ACQUA DELLA MADDALENA","hex":null,"image_url":null,"family":"Modrá"},{"name":"ROSSO","hex":null,"image_url":null,"family":"Červená"},{"name":"TERRACOTTA TOSCANA","hex":null,"image_url":null,"family":"Červená"},{"name":"GIALLO SAHARA","hex":null,"image_url":null,"family":"Žltá"},{"name":"VERDE BRITISH","hex":null,"image_url":null,"family":"Zelená"},{"name":"ROSSO POMPEIANO","hex":null,"image_url":null,"family":"Červená"}]'::jsonb,
  ARRAY['Biela', 'Červená', 'Hnedá', 'Modrá', 'Sivá', 'Zelená', 'Žltá']::text[],
  ARRAY['40 x 45 cm']::text[],
  ARRAY['Do 50 cm']::text[],
  '[]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/en/products/cero-stool?_pos=2&_psq=Cero&_ss=e&_v=1.0',
  'https://serralunga.com/en/products/cero-stool?_pos=2&_psq=Cero&_ss=e&_v=1.0',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'dizajnove' LIMIT 1),
  'Madame',
  'madame',
  'Plust',
  18200,
  NULL,
  'Trojica váz s plynulými tvarmi, ktoré odrážajú ladnú harmóniu ženského tela. Ideálne na menšie rastliny alebo dekorácie so zvislým tvarom. Jednotlivé časti môžu byť umiestnené spolu alebo samostatne.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.plust.it/en/products/madame/)',
  'https://kochlik.netlify.app/images/madame/madame_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/madame/madame_1.jpg']::text[],
  '[{"name":"White C2","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_c2_whitec2.jpg","family":"Biela"},{"name":"Granite","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_s4_granite.jpg","family":"Sivá"},{"name":"White light","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_u1_whitelight.jpg","family":"Biela"},{"name":"Stone","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_u4_stone.jpg","family":"Sivá"}]'::jsonb,
  ARRAY['Biela', 'Sivá']::text[],
  ARRAY['35x35x60 cm', '36x36x95 cm', '42x42x145 cm']::text[],
  ARRAY['51-100 cm', '101-150 cm']::text[],
  '[{"label":"35x35x60 cm","dimensions":"35x35x60 cm","price_cents":18200,"attributes":{"rozmer":"35x35x60 cm"}},{"label":"36x36x95 cm","dimensions":"36x36x95 cm","price_cents":26000,"attributes":{"rozmer":"36x36x95 cm"}},{"label":"42x42x145 cm","dimensions":"42x42x145 cm","price_cents":38000,"attributes":{"rozmer":"42x42x145 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"35x35x60 cm, 36x36x95 cm, 42x42x145 cm"}]'::jsonb,
  '[]'::jsonb,
  'https://www.plust.it/en/products/madame/',
  'https://www.plust.it/en/products/madame/',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'nabytok' LIMIT 1),
  'Kreslo Fade',
  'kreslo-fade',
  'Plust',
  47000,
  NULL,
  'Toto kreslo sa vyznačuje elegantnými líniami a jedinečným pruhovaným povrchom so špeciálnymi úpravami pripomínajúcimi prírodné materiály. V bielej svietiacej verzii je možné kreslo vybaviť špeciálnou svetelnou sadou, ktorá vytvára pôsobivý svetelný efekt.
Rozmer
95 x 75 x 74 cm
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.plust.it/en/products/fade-relax-armchair/)',
  'https://kochlik.netlify.app/images/kreslo-fade/kreslo-fade_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/kreslo-fade/kreslo-fade_1.jpg', 'https://kochlik.netlify.app/images/kreslo-fade/kreslo-fade_2.jpg', 'https://kochlik.netlify.app/images/kreslo-fade/kreslo-fade_3.gif', 'https://kochlik.netlify.app/images/kreslo-fade/kreslo-fade_4.gif']::text[],
  '[{"name":"Granite","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_s4_granite.jpg","family":"Sivá"},{"name":"Lava","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_u0_lava.jpg","family":"Sivá"},{"name":"Stone","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_u4_stone.jpg","family":"Sivá"},{"name":"Creta","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_v7_creta.jpg","family":"Béžová"},{"name":"Beige","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_beige_beige.jpg","family":"Béžová"},{"name":"Light Blue","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_lightblue_lightblue.jpg","family":"Modrá"},{"name":"Pink Sand","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_pinksand_pinksand.jpg","family":"Ružová"},{"name":"White","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_white_white.jpg","family":"Biela"},{"name":"White light","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_u1_whitelight.jpg","family":"Biela"}]'::jsonb,
  ARRAY['Béžová', 'Biela', 'Modrá', 'Ružová', 'Sivá']::text[],
  ARRAY['75 x 74 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb,
  'https://www.plust.it/en/products/fade-relax-armchair/',
  'https://www.plust.it/en/products/fade-relax-armchair/',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'moderne-kvetinace' LIMIT 1),
  'Kvetináč DOPPIO BORDO',
  'kvetinac-doppio-bordo',
  'Serralunga',
  7300,
  NULL,
  'Kvetináč Doppio Bordo od Serralunga predstavuje klasický taliansky dizajn v modernom prevedení. Tradičný tvar dopĺňajú jemné tón v tóne zemitých odtieňov, ktoré vytvárajú idylku na pomedzí anglickej záhrady a talianskeho vidieka. Tento kvetináč prináša pocit elegancie a nadčasovosti, pričom jeho povrchová úprava odhaľuje čaro nečakaného a pripomína krištáľovú krásu historických kvetináčov.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/en/products/neoclassic-doppio-bordo-planter?_pos=1&_psq=DOPPIO+BORDO&_ss=e&_v=1.0)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/kvetinac-doppio-bordo/kvetinac-doppio-bordo_1.webp',
  ARRAY['https://kochlik.netlify.app/images/kvetinac-doppio-bordo/kvetinac-doppio-bordo_1.webp', 'https://kochlik.netlify.app/images/kvetinac-doppio-bordo/kvetinac-doppio-bordo_2.webp']::text[],
  '[{"name":"TORTORA DI TORINO","hex":null,"image_url":null,"family":"Hnedá"},{"name":"TERRACOTTA TOSCANA","hex":null,"image_url":null,"family":"Červená"},{"name":"IMPRUNETA","hex":null,"image_url":null,"family":"Hnedá"},{"name":"GESSO DI BOLOGNA","hex":null,"image_url":null,"family":"Biela"},{"name":"ANTRACITE","hex":null,"image_url":null,"family":"Sivá"},{"name":"AZZURRO DI PROVENZA","hex":null,"image_url":null,"family":"Modrá"},{"name":"SALVIA DI SARDEGNA","hex":null,"image_url":null,"family":"Zelená"},{"name":"TERRACOTTA SCURA","hex":null,"image_url":null,"family":"Červená"},{"name":"BIANCO","hex":null,"image_url":null,"family":"Biela"},{"name":"VERDE PAVONE","hex":null,"image_url":null,"family":"Zelená"},{"name":"PIETRA DELLA DOLOMITI","hex":null,"image_url":null,"family":"Sivá"},{"name":"GIALLO SAHARA","hex":null,"image_url":null,"family":"Žltá"},{"name":"VERDE BRITISH","hex":null,"image_url":null,"family":"Zelená"},{"name":"ROSSO POMPEIANO","hex":null,"image_url":null,"family":"Červená"}]'::jsonb,
  ARRAY['Biela', 'Červená', 'Hnedá', 'Modrá', 'Sivá', 'Zelená', 'Žltá']::text[],
  ARRAY['100x100x80cm', '45x45x40 cm', '50x50x45 cm', '57x57x50 cm', '67x67x55 cm', '85x85x71']::text[],
  ARRAY['Do 50 cm', '51-100 cm']::text[],
  '[{"label":"100x100x80cm","dimensions":"100x100x80cm","price_cents":46300,"attributes":{"rozmer":"100x100x80cm"}},{"label":"45x45x40 cm","dimensions":"45x45x40 cm","price_cents":7300,"attributes":{"rozmer":"45x45x40 cm"}},{"label":"50x50x45 cm","dimensions":"50x50x45 cm","price_cents":9200,"attributes":{"rozmer":"50x50x45 cm"}},{"label":"57x57x50 cm","dimensions":"57x57x50 cm","price_cents":11400,"attributes":{"rozmer":"57x57x50 cm"}},{"label":"67x67x55 cm","dimensions":"67x67x55 cm","price_cents":12900,"attributes":{"rozmer":"67x67x55 cm"}},{"label":"85x85x71","dimensions":"85x85x71","price_cents":21900,"attributes":{"rozmer":"85x85x71"}}]'::jsonb,
  '[{"key":"Rozmer","value":"100x100x80cm, 45x45x40 cm, 50x50x45 cm, 57x57x50 cm, 67x67x55 cm, 85x85x71"}]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/en/products/neoclassic-doppio-bordo-planter?_pos=1&_psq=DOPPIO+BORDO&_ss=e&_v=1.0',
  'https://serralunga.com/en/products/neoclassic-doppio-bordo-planter?_pos=1&_psq=DOPPIO+BORDO&_ss=e&_v=1.0',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'svietiace-kvetinace' LIMIT 1),
  'Stolova lampa Fade 22 cm',
  'stolova-lampa-fade-22-cm',
  'Plust',
  13000,
  NULL,
  'Stolová lampa Fade je malý vodopád svetla, ktorý možno umiestniť kamkoľvek podľa potreby. Rebrovaný povrch základne vytvára jedinečnú hru svetla a tieňov, zatiaľ čo špeciálne povrchové úpravy pripomínajú prírodné materiály. Lampa je vybavená LED svetelným zdrojom a ľahko nabíjateľnou batériou vďaka magnetickému nabíjaciemu káblu.
Rozmer
13 x 13 x 22 cm
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.plust.it/en/products/fade-table-lamp/)',
  'https://kochlik.netlify.app/images/stolova-lampa-fade-22-cm/stolova-lampa-fade-22-cm_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/stolova-lampa-fade-22-cm/stolova-lampa-fade-22-cm_1.jpg', 'https://kochlik.netlify.app/images/stolova-lampa-fade-22-cm/stolova-lampa-fade-22-cm_2.jpg', 'https://kochlik.netlify.app/images/stolova-lampa-fade-22-cm/stolova-lampa-fade-22-cm_3.jpg']::text[],
  '[{"name":"Old stone","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_04_oldstone.jpg","family":"Sivá"},{"name":"Golden rust","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_n4_goldenrust.jpg","family":"Hnedá"},{"name":"Granite","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_s4_granite.jpg","family":"Sivá"},{"name":"Aquamarina","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_s8_aquamarina.jpg","family":"Modrá"},{"name":"Lava","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_u0_lava.jpg","family":"Sivá"},{"name":"White light","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_u1_whitelight.jpg","family":"Biela"},{"name":"Coral sand","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_u2_coralsand.jpg","family":"Ružová"},{"name":"Ochre","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_u3_ochre.jpg","family":"Žltá"},{"name":"Stone","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_u4_stone.jpg","family":"Sivá"},{"name":"Creta","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_v7_creta.jpg","family":"Béžová"}]'::jsonb,
  ARRAY['Béžová', 'Biela', 'Hnedá', 'Modrá', 'Ružová', 'Sivá', 'Žltá']::text[],
  ARRAY['13 x 22 cm']::text[],
  ARRAY['Do 50 cm']::text[],
  '[]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb,
  'https://www.plust.it/en/products/fade-table-lamp/',
  'https://www.plust.it/en/products/fade-table-lamp/',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'doplnky' LIMIT 1),
  'Vešiak Lapsus',
  'vesiak-lapsus',
  'Plust',
  54000,
  NULL,
  'Voľne stojaci vešiak, inšpirovaný typickými sukulentmi púští. Je vybavený šiestimi háčikmi a slúži ako dekoratívny, no zároveň praktický doplnok do domácnosti či kancelárie. Kovová základňa zaručuje výbornú stabilitu.
Rozmer
40 x 40 x 197 cm
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.plust.it/en/products/lapsus/)',
  'https://kochlik.netlify.app/images/vesiak-lapsus/vesiak-lapsus_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/vesiak-lapsus/vesiak-lapsus_1.jpg', 'https://kochlik.netlify.app/images/vesiak-lapsus/vesiak-lapsus_2.jpg']::text[],
  '[{"name":"Acid green","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_86_acidgreen.jpg","family":"Zelená"},{"name":"Red A9","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_a9_reda9.jpg","family":"Červená"},{"name":"White C2","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_c2_whitec2.jpg","family":"Biela"}]'::jsonb,
  ARRAY['Biela', 'Červená', 'Zelená']::text[],
  ARRAY['40 x 197 cm']::text[],
  ARRAY['Nad 150 cm']::text[],
  '[]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb,
  'https://www.plust.it/en/products/lapsus/',
  'https://www.plust.it/en/products/lapsus/',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'moderne-kvetinace' LIMIT 1),
  'Kvetináč Cassero Long',
  'kvetinac-cassero-long',
  'Serralunga',
  35000,
  NULL,
  'Kolekcia Cassero, ktorú pre značku Serralunga navrhla Patricia Urquiola, je inšpirovaná formami používanými v stavebníctve pri odlievaní betónu. Táto séria jednodielnych kvetináčov z polyetylénu zámerne vytvára efekt betónu, akoby boli odliate a následne vybraté z formy. S kolekciou Cassero sa architektka Urquiola rozhodla navrhnúť kvetináče, ktoré sú ideálne nielen do exteriéru, ale umožňujú aj vnášať rastliny do interiéru, čím ich povýšila na dekoratívne dizajnové prvky. Model Cassero 60 predstavuje oválnu verziu tejto kolekcie, ktorá spolu s okrúhlym variantom vytvára dokonale zladenú dvojicu.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/en/products/cassero-long?pr_prod_strat=e5_desc&pr_rec_id=c012644ce&pr_rec_pid=7003991736457&pr_ref_pid=8647605092690&pr_seq=uniform)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/kvetinac-cassero-long/kvetinac-cassero-long_1.webp',
  ARRAY['https://kochlik.netlify.app/images/kvetinac-cassero-long/kvetinac-cassero-long_1.webp', 'https://kochlik.netlify.app/images/kvetinac-cassero-long/kvetinac-cassero-long_2.webp']::text[],
  '[{"name":"GESSO DI BOLOGNA","hex":null,"image_url":null,"family":"Biela"},{"name":"SALVIA DI SARDEGNA","hex":null,"image_url":null,"family":"Zelená"},{"name":"TORTORA DI TORINO","hex":null,"image_url":null,"family":"Hnedá"},{"name":"TERRACOTTA SCURA","hex":null,"image_url":null,"family":"Červená"},{"name":"ORIGANO DI SARDEGNA","hex":null,"image_url":null,"family":"Zelená"},{"name":"TERRACOTTA TOSCANA","hex":null,"image_url":null,"family":"Červená"},{"name":"ANTRACITE","hex":null,"image_url":null,"family":"Sivá"},{"name":"AZZURRO DI PROVENZA","hex":null,"image_url":null,"family":"Modrá"},{"name":"IMPRUNETA","hex":null,"image_url":null,"family":"Hnedá"},{"name":"MORE DI ROVO","hex":null,"image_url":null,"family":"Ružová"},{"name":"PIETRA DI MATERA","hex":null,"image_url":null,"family":"Sivá"}]'::jsonb,
  ARRAY['Biela', 'Červená', 'Hnedá', 'Modrá', 'Ružová', 'Sivá', 'Zelená']::text[],
  ARRAY['100x48x55 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[{"label":"100x48x55 cm","dimensions":"100x48x55 cm","price_cents":35000,"attributes":{"rozmer":"100x48x55 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"100x48x55 cm"}]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/en/products/cassero-long?pr_prod_strat=e5_desc&pr_rec_id=c012644ce&pr_rec_pid=7003991736457&pr_ref_pid=8647605092690&pr_seq=uniform',
  'https://serralunga.com/en/products/cassero-long?pr_prod_strat=e5_desc&pr_rec_id=c012644ce&pr_rec_pid=7003991736457&pr_ref_pid=8647605092690&pr_seq=uniform',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'moderne-kvetinace' LIMIT 1),
  'Kvetináč KABIN MAXI',
  'kvetinac-kabin-maxi',
  'Serralunga',
  49300,
  NULL,
  'Kvetináč Kabin Maxi, ktorý pre značku Serralunga navrhla Luisa Bocchietto, je archetypálnym dizajnovým dielom, ktoré spája klasické geometrické tvary s jemne brúseným povrchom v sofistikovanom a harmonickom prevedení. Presnosť rohov a línií sa tu prelína s mäkkosťou zamatového vzhľadu a čistotou zenového minimalizmu. Model Kabin Maxi predstavuje veľkoformátový kvetináč, ktorý sa stáva dominantným prvkom každého moderného interiéru či exteriéru – symbolom elegancie, rovnováhy a nadčasového štýlu.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/en/products/kabin-maxi-planter?_pos=1&_psq=KABIN+MAXI&_ss=e&_v=1.0)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/kvetinac-kabin-maxi/kvetinac-kabin-maxi_1.webp',
  ARRAY['https://kochlik.netlify.app/images/kvetinac-kabin-maxi/kvetinac-kabin-maxi_1.webp', 'https://kochlik.netlify.app/images/kvetinac-kabin-maxi/kvetinac-kabin-maxi_2.webp', 'https://kochlik.netlify.app/images/kvetinac-kabin-maxi/kvetinac-kabin-maxi_3.webp', 'https://kochlik.netlify.app/images/kvetinac-kabin-maxi/kvetinac-kabin-maxi_4.webp']::text[],
  '[{"name":"ANTRACITE","hex":null,"image_url":null,"family":"Sivá"},{"name":"AZZURRO DI PROVENZA","hex":null,"image_url":null,"family":"Modrá"},{"name":"LACCATO BIANCO","hex":null,"image_url":null,"family":"Biela"},{"name":"ROSSO","hex":null,"image_url":null,"family":"Červená"},{"name":"SALVIA DI SARDEGNA","hex":null,"image_url":null,"family":"Zelená"},{"name":"TERRACOTTA SCURA","hex":null,"image_url":null,"family":"Červená"},{"name":"TORTORA DI TORINO","hex":null,"image_url":null,"family":"Hnedá"},{"name":"VERDE PAVONE","hex":null,"image_url":null,"family":"Zelená"},{"name":"BIANCO","hex":null,"image_url":null,"family":"Biela"},{"name":"TERRACOTTA TOSCANA","hex":null,"image_url":null,"family":"Červená"},{"name":"GIALLO SAHARA","hex":null,"image_url":null,"family":"Žltá"},{"name":"VERDE BRITISH","hex":null,"image_url":null,"family":"Zelená"},{"name":"ROSSO POMPEIANO","hex":null,"image_url":null,"family":"Červená"}]'::jsonb,
  ARRAY['Biela', 'Červená', 'Hnedá', 'Modrá', 'Sivá', 'Zelená', 'Žltá']::text[],
  ARRAY['44x44x100 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[{"label":"44x44x100 cm","dimensions":"44x44x100 cm","price_cents":49300,"attributes":{"rozmer":"44x44x100 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"44x44x100 cm"}]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/en/products/kabin-maxi-planter?_pos=1&_psq=KABIN+MAXI&_ss=e&_v=1.0',
  'https://serralunga.com/en/products/kabin-maxi-planter?_pos=1&_psq=KABIN+MAXI&_ss=e&_v=1.0',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'dizajnove' LIMIT 1),
  'Kvetináč Santavase',
  'kvetinac-santavase',
  'Serralunga',
  56500,
  NULL,
  'Kvetináč Santavase, navrhnutý Denisom Santachiarom pre Serralunga, prináša revolučný pohľad na pojem kvetináča. Môže kvetináč vyrastať priamo zo zeme, namiesto toho, aby bol len položený na povrch? Santavase odpovedá: áno. Tento jedinečný dizajn sa „zaskrutkuje“ do zeme pomocou oceľového tŕňa, čím sa stáva organickým predĺžením prírody – protézou, ktorá spája rastlinu so zemou. Kvetináč Santavase zdobí záhradu nečakaným a hravým spôsobom – samostatne alebo v skupinách, rovno alebo mierne naklonene. Pre interiérové aranžmány je dostupný aj na kovovom podstavci, ktorý zachováva jeho ikonický výraz aj v interiéri.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/en/products/santavase?_pos=1&_psq=Santavase&_ss=e&_v=1.0)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/kvetinac-santavase/kvetinac-santavase_1.webp',
  ARRAY['https://kochlik.netlify.app/images/kvetinac-santavase/kvetinac-santavase_1.webp', 'https://kochlik.netlify.app/images/kvetinac-santavase/kvetinac-santavase_2.webp']::text[],
  '[{"name":"LACQUERED WHITE","hex":null,"image_url":null,"family":"Biela"},{"name":"TERRACOTTA TOSCANA","hex":null,"image_url":null,"family":"Červená"},{"name":"ANTRACITE","hex":null,"image_url":null,"family":"Sivá"},{"name":"TORTORA DI TORINO","hex":null,"image_url":null,"family":"Hnedá"},{"name":"ROSSO","hex":null,"image_url":null,"family":"Červená"},{"name":"BIANCO","hex":null,"image_url":null,"family":"Biela"}]'::jsonb,
  ARRAY['Biela', 'Červená', 'Hnedá', 'Sivá']::text[],
  ARRAY['40x40x85cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[{"label":"40x40x85cm","dimensions":"40x40x85cm","price_cents":56500,"attributes":{"rozmer":"40x40x85cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"40x40x85cm"}]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/en/products/santavase?_pos=1&_psq=Santavase&_ss=e&_v=1.0',
  'https://serralunga.com/en/products/santavase?_pos=1&_psq=Santavase&_ss=e&_v=1.0',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'nabytok' LIMIT 1),
  'Barový stôl Fura',
  'barovy-stol-fura',
  'Plust',
  41000,
  NULL,
  'Stôl Fura je navrhnutý ako doplnok k stoličke Fura. Jeho kužeľová základňa zaručuje vysokú stabilitu a doska z HPL materiálu prináša odolnosť a jednoduchú údržbu. Vhodný na použitie v interiéri aj exteriéri. V svietiacej verzii je všestranný a ľahko sa prispôsobí akémukoľvek štýlu, vďaka LED osvetleniu na batériu, ktoré odstraňuje potrebu napájacích káblov a umožňuje nezávislé používanie každého prvku.
Rozmer
38 x 38 x 97 cm
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.plust.it/en/products/fura-table-structure/)',
  'https://kochlik.netlify.app/images/barovy-stol-fura/barovy-stol-fura_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/barovy-stol-fura/barovy-stol-fura_1.jpg', 'https://kochlik.netlify.app/images/barovy-stol-fura/barovy-stol-fura_2.jpg', 'https://kochlik.netlify.app/images/barovy-stol-fura/barovy-stol-fura_3.jpg', 'https://kochlik.netlify.app/images/barovy-stol-fura/barovy-stol-fura_4.jpg', 'https://kochlik.netlify.app/images/barovy-stol-fura/barovy-stol-fura_5.jpg']::text[],
  '[{"name":"Pearl black","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_87_pearlblack.jpg","family":"Čierna"},{"name":"White C2","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_c2_whitec2.jpg","family":"Biela"},{"name":"Rosemary","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_l4_rosemary.jpg","family":"Zelená"},{"name":"Sandy","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_m9_sandy.jpg","family":"Béžová"},{"name":"Black","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_black_black.jpg","family":"Čierna"},{"name":"White","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_white_white.jpg","family":"Biela"},{"name":"Neutral","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_98_neutral.jpg","family":"Biela"},{"name":"White light","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_u1_whitelight.jpg","family":"Biela"}]'::jsonb,
  ARRAY['Béžová', 'Biela', 'Čierna', 'Zelená']::text[],
  ARRAY['38 x 97 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb,
  'https://www.plust.it/en/products/fura-table-structure/',
  'https://www.plust.it/en/products/fura-table-structure/',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'svietiace-kvetinace' LIMIT 1),
  'Kvetináč Liscio Siena svietiaci',
  'kvetinac-liscio-siena-svietiaci',
  'Serralunga',
  35900,
  NULL,
  'Materiál: Vyrobené z LLDPE (lineárny nízkohustotný polyetylén) Spôsob výroby: Rotačné tvarovanie Vhodnosť: Určené na vonkajšie použitie, odolné voči všetkým poveternostným podmienkam. Poskytuje UV ochranu, je 100 % recyklovateľné a farbené v hmote. Vyznačuje sa vysokou mechanickou pevnosťou a odolnosťou voči nárazom. Materiál je tepelne odolný, znáša teploty od –35 °C do +80 °C.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/en/products/liscio-siena-with-light?_pos=3&_psq=Liscio+Siena&_ss=e&_v=1.0)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/kvetinac-liscio-siena-svietiaci/kvetinac-liscio-siena-svietiaci_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/kvetinac-liscio-siena-svietiaci/kvetinac-liscio-siena-svietiaci_1.jpg']::text[],
  '[{"name":"RGB light wireless","hex":null,"image_url":null,"family":null},{"name":"RGB light with cable","hex":null,"image_url":null,"family":null},{"name":"White light with cable","hex":null,"image_url":null,"family":"Biela"}]'::jsonb,
  ARRAY['Biela']::text[],
  ARRAY['52x52x80 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[{"label":"52x52x80 cm","dimensions":"52x52x80 cm","price_cents":38900,"attributes":{"rozmer":"52x52x80 cm","typ-ziarovky":"LED"}},{"label":"52x52x80 cm","dimensions":"52x52x80 cm","price_cents":35900,"attributes":{"rozmer":"52x52x80 cm","typ-ziarovky":"RGB"}}]'::jsonb,
  '[{"key":"Rozmer","value":"52x52x80 cm"},{"key":"Typ žiarovky","value":"LED, RGB"}]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/en/products/liscio-siena-with-light?_pos=3&_psq=Liscio+Siena&_ss=e&_v=1.0',
  'https://serralunga.com/en/products/liscio-siena-with-light?_pos=3&_psq=Liscio+Siena&_ss=e&_v=1.0',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'dizajnove' LIMIT 1),
  'Rebelot',
  'rebelot',
  'Plust',
  5000,
  NULL,
  'Váza s nepravidelným dizajnom. V milánskom nárečí slovo „rebelot“ znamená „chaos“, čo sa odráža aj v zdanlivo neusporiadanom tvare tejto vázy. Dostupná je v piatich veľkostiach, vďaka čomu je ideálna na rôzne druhy rastlín a dekorácií, pričom verzia Maxi sa obzvlášť hodí do priestranných hál, verejných priestorov alebo exteriérov. V svietiacej verzii prerušované línie vytvárajú kontrast svetla a tieňa, čím vzniká dynamické osvetlenie s pôsobivou atmosférou.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.plust.it/en/products/rebelot/)',
  'https://kochlik.netlify.app/images/rebelot/rebelot_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/rebelot/rebelot_1.jpg', 'https://kochlik.netlify.app/images/rebelot/rebelot_2.jpg']::text[],
  '[{"name":"Fuchsia","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_74_fuchsia.jpg","family":"Ružová"},{"name":"Acid green","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_86_acidgreen.jpg","family":"Zelená"},{"name":"White C2","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_c2_whitec2.jpg","family":"Biela"},{"name":"Granite","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_s4_granite.jpg","family":"Sivá"},{"name":"White light","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_u1_whitelight.jpg","family":"Biela"},{"name":"Stone","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_u4_stone.jpg","family":"Sivá"},{"name":"Neutral","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_98_neutral.jpg","family":"Biela"}]'::jsonb,
  ARRAY['Biela', 'Ružová', 'Sivá', 'Zelená']::text[],
  ARRAY['135x135x102 cm', '20x20x15 cm', '45x45x34 cm', '55x55x42 cm', '65x65x50 cm']::text[],
  ARRAY['Do 50 cm', '51-100 cm', '101-150 cm']::text[],
  '[{"label":"135x135x102 cm","dimensions":"135x135x102 cm","price_cents":115000,"attributes":{"rozmer":"135x135x102 cm"}},{"label":"20x20x15 cm","dimensions":"20x20x15 cm","price_cents":5000,"attributes":{"rozmer":"20x20x15 cm"}},{"label":"45x45x34 cm","dimensions":"45x45x34 cm","price_cents":12000,"attributes":{"rozmer":"45x45x34 cm"}},{"label":"55x55x42 cm","dimensions":"55x55x42 cm","price_cents":15500,"attributes":{"rozmer":"55x55x42 cm"}},{"label":"65x65x50 cm","dimensions":"65x65x50 cm","price_cents":21000,"attributes":{"rozmer":"65x65x50 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"135x135x102 cm, 20x20x15 cm, 45x45x34 cm, 55x55x42 cm, 65x65x50 cm"}]'::jsonb,
  '[]'::jsonb,
  'https://www.plust.it/en/products/rebelot/',
  'https://www.plust.it/en/products/rebelot/',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'nabytok' LIMIT 1),
  'Sedačka Balzac',
  'sedacka-balzac',
  'Serralunga',
  110000,
  NULL,
  'Balzac predstavuje prvú spoluprácu medzi značkou Serralunga a dizajnérom Patrickom Norguetom, ktorá prináša výraznú kolekciu spájajúcu pevnosť, eleganciu a komfort. Dizajn sa vyznačuje jemnými krivkami a protikladnými líniami, ktoré odkazujú na štýl vonkajšieho nábytku z počiatku 20. storočia. Pohovka Balzac so svojím rozpoznateľným a jednotným tvarom je vhodná na terasy, verandy či záhradné priestory, ale aj do interiérových zón, ako sú hotelové lobby alebo salóniky. Balzac sa plynulo začleňuje do interiérov aj exteriérov, pričom zachováva harmonický a nadčasový vzhľad. Dostupná je s vankúšmi alebo bez nich.
Rozmer
96 x 150 x 86 cm
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/en/products/balzac-sofa?_pos=3&_psq=Balzac&_ss=e&_v=1.0)',
  'https://kochlik.netlify.app/images/sedacka-balzac/sedacka-balzac_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/sedacka-balzac/sedacka-balzac_1.jpg', 'https://kochlik.netlify.app/images/sedacka-balzac/sedacka-balzac_2.webp', 'https://kochlik.netlify.app/images/sedacka-balzac/sedacka-balzac_3.jpg']::text[],
  '[{"name":"RED CLAY Without Cushion","hex":null,"image_url":null,"family":"Červená"},{"name":"RED CLAY With Red Clay Cushion","hex":null,"image_url":null,"family":"Červená"},{"name":"RED CLAY With Half Moon White Cushion","hex":null,"image_url":null,"family":"Biela"},{"name":"SALVIA DI SARDEGNA without Cushion","hex":null,"image_url":null,"family":"Zelená"},{"name":"SALVIA DI SARDEGNA with Half Moon White Cushion","hex":null,"image_url":null,"family":"Biela"},{"name":"PIETRA DI MATERA without Cushion","hex":null,"image_url":null,"family":"Sivá"},{"name":"PIETRA DI MATERA with Half Moon White Cushion","hex":null,"image_url":null,"family":"Biela"},{"name":"TORTORA DI TORINO without Cushion","hex":null,"image_url":null,"family":"Hnedá"},{"name":"TORTORA DI TORINO with Half Moon White Cushion","hex":null,"image_url":null,"family":"Biela"},{"name":"MORE DI ROVO without Cushion","hex":null,"image_url":null,"family":"Ružová"},{"name":"MORE DI ROVO with Half Moon White Cushion","hex":null,"image_url":null,"family":"Biela"}]'::jsonb,
  ARRAY['Biela', 'Červená', 'Hnedá', 'Ružová', 'Sivá', 'Zelená']::text[],
  ARRAY['150 x 86 cm']::text[],
  ARRAY['101-150 cm']::text[],
  '[]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/en/products/balzac-sofa?_pos=3&_psq=Balzac&_ss=e&_v=1.0',
  'https://serralunga.com/en/products/balzac-sofa?_pos=3&_psq=Balzac&_ss=e&_v=1.0',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'nabytok' LIMIT 1),
  'Barová stolička Frozen štvorcová',
  'barova-stolicka-frozen-stvorcova',
  'Plust',
  20000,
  NULL,
  'Štvornohá verzia stoličky Frozen. Stabilná a pevná vďaka štyrom nohám, predstavuje vyváženú kombináciu jemných a ostrých tvarov, ktoré jej dodávajú moderný a harmonický vzhľad.
Rozmer
37 x 37 x 74 cm
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.plust.it/en/products/frozen-square-stool/)',
  'https://kochlik.netlify.app/images/barova-stolicka-frozen-stvorcova/barova-stolicka-frozen-stvorcova_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/barova-stolicka-frozen-stvorcova/barova-stolicka-frozen-stvorcova_1.jpg', 'https://kochlik.netlify.app/images/barova-stolicka-frozen-stvorcova/barova-stolicka-frozen-stvorcova_2.jpg', 'https://kochlik.netlify.app/images/barova-stolicka-frozen-stvorcova/barova-stolicka-frozen-stvorcova_3.jpg']::text[],
  '[{"name":"Night blue","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_16_nightblue.jpg","family":"Modrá"},{"name":"Sage green","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_34_sagegreen.jpg","family":"Zelená"},{"name":"Pearl black","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_87_pearlblack.jpg","family":"Čierna"},{"name":"White C2","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_c2_whitec2.jpg","family":"Biela"},{"name":"Sandy","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_m9_sandy.jpg","family":"Béžová"},{"name":"Golden rust","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_n4_goldenrust.jpg","family":"Hnedá"},{"name":"White light","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_u1_whitelight.jpg","family":"Biela"}]'::jsonb,
  ARRAY['Béžová', 'Biela', 'Čierna', 'Hnedá', 'Modrá', 'Zelená']::text[],
  ARRAY['37 x 74 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb,
  'https://www.plust.it/en/products/frozen-square-stool/',
  'https://www.plust.it/en/products/frozen-square-stool/',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'nabytok' LIMIT 1),
  'Sedačka Gumball junior',
  'sedacka-gumball-junior',
  'Plust',
  39000,
  NULL,
  'Navrhnutá dizajnérom Albertom Brogliatom, kolekcia Gumball Junior Family je venovaná detskému svetu a pozostáva z kresla, pohovky a nízkeho stolíka. Všetky prvky sú plne ergonomické, bez ostrých hrán, a poskytujú deťom bezpečné a pohodlné miesto na oddych po veľkých dobrodružstvách či ako základňu pre plánovanie nových hier a výprav.
Rozmer
122 x 65 x 49 cm
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.plust.it/en/products/gumball-sofa-junior/)',
  'https://kochlik.netlify.app/images/sedacka-gumball-junior/sedacka-gumball-junior_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/sedacka-gumball-junior/sedacka-gumball-junior_1.jpg', 'https://kochlik.netlify.app/images/sedacka-gumball-junior/sedacka-gumball-junior_2.jpg']::text[],
  '[{"name":"Blue","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_11_blue.jpg","family":"Modrá"},{"name":"Emerald green","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_43_emeraldgreen.jpg","family":"Zelená"},{"name":"Fuchsia","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_74_fuchsia.jpg","family":"Ružová"},{"name":"Green A2","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_a2_greena2.jpg","family":"Zelená"},{"name":"Yellow","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_b3_yellow.jpg","family":"Žltá"},{"name":"Orange C1","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_c1_orangec1.jpg","family":"Oranžová"},{"name":"White C2","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_c2_whitec2.jpg","family":"Biela"}]'::jsonb,
  ARRAY['Biela', 'Modrá', 'Oranžová', 'Ružová', 'Zelená', 'Žltá']::text[],
  ARRAY['65 x 49 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb,
  'https://www.plust.it/en/products/gumball-sofa-junior/',
  'https://www.plust.it/en/products/gumball-sofa-junior/',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'nabytok' LIMIT 1),
  'Konferenčný stolík Fade HPL',
  'konferencny-stolik-fade-hpl-2',
  'Plust',
  50000,
  NULL,
  'Nízky stolík, ku ktorému je potrebné samostatne zvoliť dosku z HPL materiálu. Vyznačuje sa jemnými líniami a jedinečným pruhovaným povrchom so špeciálnymi úpravami pripomínajúcimi prírodné materiály. V bielej svietiacej verzii možno stolík vybaviť špeciálnou svetelnou sadou pre elegantný osvetlený efekt.
Rozmer
71 x 71 x 33 cm
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.plust.it/en/products/fade-coffee-table-structure/)',
  'https://kochlik.netlify.app/images/konferencny-stolik-fade-hpl-2/konferencny-stolik-fade-hpl-2_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/konferencny-stolik-fade-hpl-2/konferencny-stolik-fade-hpl-2_1.jpg', 'https://kochlik.netlify.app/images/konferencny-stolik-fade-hpl-2/konferencny-stolik-fade-hpl-2_2.jpg', 'https://kochlik.netlify.app/images/konferencny-stolik-fade-hpl-2/konferencny-stolik-fade-hpl-2_3.jpg', 'https://kochlik.netlify.app/images/konferencny-stolik-fade-hpl-2/konferencny-stolik-fade-hpl-2_4.jpg']::text[],
  '[{"name":"Granite","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_s4_granite.jpg","family":"Sivá"},{"name":"Lava","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_u0_lava.jpg","family":"Sivá"},{"name":"Stone","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_u4_stone.jpg","family":"Sivá"},{"name":"Creta","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_v7_creta.jpg","family":"Béžová"},{"name":"Black","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_black_black.jpg","family":"Čierna"},{"name":"White","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_white_white.jpg","family":"Biela"},{"name":"White light","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_u1_whitelight.jpg","family":"Biela"}]'::jsonb,
  ARRAY['Béžová', 'Biela', 'Čierna', 'Sivá']::text[],
  ARRAY['71 x 33 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb,
  'https://www.plust.it/en/products/fade-coffee-table-structure/',
  'https://www.plust.it/en/products/fade-coffee-table-structure/',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'nabytok' LIMIT 1),
  'Sedačka Canisse',
  'sedacka-canisse',
  'Serralunga',
  499900,
  NULL,
  'Súčasťou balenia sú 3 operadlové vankúše a 2 bočné vankúše. V spolupráci s francúzskym dizajnérom Philippom Nigrom vytvorila spoločnosť Serralunga kolekciu Canisse – vonkajšiu pohovku s prirodzeným, organickým dizajnom, ktorá prináša pocit útočiska pod otvoreným nebom. Veľké mäkké vankúše pozývajú k odpočinku, zatiaľ čo výrazne dekoratívne operadlo sa stáva centrálnym dizajnovým prvkom, typickým pre moderný taliansky nábytok. Pohovka Canisse je ako stvorená pre exteriérové prostredie, no zároveň dokáže v interiéri vytvoriť eklektickú atmosféru plnú charakteru – v duchu filozofie značky Serralunga – “The First, The Original.” Inšpiráciou pre dizajn sa stali trstiny rastúce na pobreží Stredozemného mora – vysoké a pružné rastliny, ktoré sa kedysi viazali do rohoží, poskytujúcich ochranu pred slnkom, vetrom a zvedavými pohľadmi. Tieto tzv. „cannes de Provence“, premenené na „les canisses“, sa pretavili do podoby vonkajšieho sedenia s jednoduchým, no prirodzene elegantným vzhľadom.
Rozmer
175 x 88 x 80 cm
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/en/products/canisse-sofa?_pos=1&_psq=Canisse&_ss=e&_v=1.0)',
  'https://kochlik.netlify.app/images/sedacka-canisse/sedacka-canisse_1.webp',
  ARRAY['https://kochlik.netlify.app/images/sedacka-canisse/sedacka-canisse_1.webp', 'https://kochlik.netlify.app/images/sedacka-canisse/sedacka-canisse_2.webp', 'https://kochlik.netlify.app/images/sedacka-canisse/sedacka-canisse_3.webp', 'https://kochlik.netlify.app/images/sedacka-canisse/sedacka-canisse_4.webp']::text[],
  '[{"name":"BIANCO","hex":null,"image_url":null,"family":"Biela"},{"name":"TORTORA DI TORINO","hex":null,"image_url":null,"family":"Hnedá"},{"name":"ANTRACITE","hex":null,"image_url":null,"family":"Sivá"}]'::jsonb,
  ARRAY['Biela', 'Hnedá', 'Sivá']::text[],
  ARRAY['88 x 80 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/en/products/canisse-sofa?_pos=1&_psq=Canisse&_ss=e&_v=1.0',
  'https://serralunga.com/en/products/canisse-sofa?_pos=1&_psq=Canisse&_ss=e&_v=1.0',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  NULL,
  'Eclipse',
  'eclipse',
  'Vecagarden',
  NULL,
  NULL,
  'Svojím plynulým eliptickým tvarom a dynamicky tvarovaným povrchom spája Eclipse sochársky dizajn so súčasnou funkčnosťou. Obklopujúce línie prechádzajú celou konštrukciou a vytvárajú jemnú hru svetla a tieňa, ktorá sa mení v závislosti od uhla pohľadu a prirodzeného osvetlenia. Ideálne sa hodí na zútulnenie záhrad, terás a vonkajších priestorov – vyniká svojou harmonickou, no výraznou prítomnosťou. Jeho pôsobivá silueta pripomína tvary prírody, zatiaľ čo rotačné formovanie zaručuje pevnosť, ľahkosť a dlhú životnosť. Dostupný v rôznych veľkostiach, Eclipse je navrhnutý na pestovanie zelene či tvorbu sofistikovaných aranžmánov, ktoré premieňajú každý priestor na miesto rovnováhy a krásy.',
  'https://kochlik.netlify.app/images/eclipse/eclipse_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/eclipse/eclipse_1.jpg']::text[],
  '[]'::jsonb,
  ARRAY[]::text[],
  ARRAY[]::text[],
  ARRAY[]::text[],
  '[]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb,
  'https://kochlik.sk/produkt/eclipse/',
  'https://kochlik.sk/produkt/eclipse/',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'dizajnove' LIMIT 1),
  'Kvetináč Ming',
  'kvetinac-ming',
  'Serralunga',
  25000,
  NULL,
  'Kvetináč Ming, navrhnutý Rodolfo Dordoni pre Serralunga, je oceňovaný pre svoje veľkorysé rozmery, ktoré zvýrazňuje široký horný okraj a tvar spájajúci tradičné a moderné línie. Vďaka tomu sa dokonale hodí do verejných aj súkromných priestorov. Dordoni navrhol túto kolekciu špeciálne pre sukulentné rastliny ako agáve či kaktusy, ktorých ostré línie kontrastujú s mäkkými a oble zaoblenými tvarmi kvetináča. Kvetináč Ming je dostupný v troch veľkostiach – Small, Large a Extra Large a ponúka možnosť vytvoriť harmonické kombinácie rôznych proporcií. Táto verzia je dostupná aj s povrchovou úpravou Moleskin – registrovaný dizajn, ktorý produktu dodáva teplo, šarm a sofistikovaný charakter.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/en/products/ming-planter?_pos=1&_psq=Vaso+Ming&_ss=e&_v=1.0)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/kvetinac-ming/kvetinac-ming_1.webp',
  ARRAY['https://kochlik.netlify.app/images/kvetinac-ming/kvetinac-ming_1.webp', 'https://kochlik.netlify.app/images/kvetinac-ming/kvetinac-ming_2.webp', 'https://kochlik.netlify.app/images/kvetinac-ming/kvetinac-ming_3.webp']::text[],
  '[{"name":"BIANCO","hex":null,"image_url":null,"family":"Biela"},{"name":"ANTRACITE","hex":null,"image_url":null,"family":"Sivá"},{"name":"TORTORA DI TORINO","hex":null,"image_url":null,"family":"Hnedá"},{"name":"VERDE PAVONE","hex":null,"image_url":null,"family":"Zelená"},{"name":"AZZURRO DI PROVENZA","hex":null,"image_url":null,"family":"Modrá"},{"name":"LACQUEROSSO BIANCO","hex":null,"image_url":null,"family":"Biela"},{"name":"ROSSO","hex":null,"image_url":null,"family":"Červená"},{"name":"SALVIA DI SARDEGNA","hex":null,"image_url":null,"family":"Zelená"},{"name":"TERRACOTTA SCURA","hex":null,"image_url":null,"family":"Červená"},{"name":"GIALLO SAHARA","hex":null,"image_url":null,"family":"Žltá"},{"name":"VERDE BRITISH","hex":null,"image_url":null,"family":"Zelená"},{"name":"ROSSO POMPEIANO","hex":null,"image_url":null,"family":"Červená"},{"name":"NEVE DI SAN CANDIDO","hex":null,"image_url":null,"family":"Biela"}]'::jsonb,
  ARRAY['Biela', 'Červená', 'Hnedá', 'Modrá', 'Sivá', 'Zelená', 'Žltá']::text[],
  ARRAY['113x113x75 cm', '56,5x56,5x33 cm', '80x80x50 cm']::text[],
  ARRAY['51-100 cm', '101-150 cm']::text[],
  '[{"label":"113x113x75 cm","dimensions":"113x113x75 cm","price_cents":75000,"attributes":{"rozmer":"113x113x75 cm"}},{"label":"56,5x56,5x33 cm","dimensions":"56,5x56,5x33 cm","price_cents":25000,"attributes":{"rozmer":"56,5x56,5x33 cm"}},{"label":"80x80x50 cm","dimensions":"80x80x50 cm","price_cents":31000,"attributes":{"rozmer":"80x80x50 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"113x113x75 cm, 56,5×56,5×33 cm, 80x80x50 cm"}]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/en/products/ming-planter?_pos=1&_psq=Vaso+Ming&_ss=e&_v=1.0',
  'https://serralunga.com/en/products/ming-planter?_pos=1&_psq=Vaso+Ming&_ss=e&_v=1.0',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'klasicke-kvetinace' LIMIT 1),
  'Kvetináč Uva Spina',
  'kvetinac-uva-spina',
  'Serralunga',
  11100,
  NULL,
  'Kvetináč Uva Spina od Serralunga pripomína tradičný taliansky kvetináč, no zároveň ho povyšuje na elegantný dizajnový prvok. Jeho jemné zemité odtiene a precízne klasické detaily vytvárajú pastorálnu atmosféru, ktorá spája anglickú záhradnú tradíciu s pôvabom talianskeho vidieka. Vďaka novému a prekvapivému povrchovému spracovaniu zaujme svojou krištáľovo jemnou textúrou, ktorá odhaľuje nadčasovú krásu starobylých kvetináčov v modernom poňatí.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/en/products/uva-spina-planter?_pos=1&_psq=Uva+Spina&_ss=e&_v=1.0)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/kvetinac-uva-spina/kvetinac-uva-spina_1.webp',
  ARRAY['https://kochlik.netlify.app/images/kvetinac-uva-spina/kvetinac-uva-spina_1.webp']::text[],
  '[{"name":"AZZURRO DI PROVENZA","hex":null,"image_url":null,"family":"Modrá"},{"name":"PIETRA DELLA DOLOMITI","hex":null,"image_url":null,"family":"Sivá"},{"name":"TERRACOTTA TOSCANA","hex":null,"image_url":null,"family":"Červená"},{"name":"BIANCO","hex":null,"image_url":null,"family":"Biela"},{"name":"SALVIA DI SARDEGNA","hex":null,"image_url":null,"family":"Zelená"},{"name":"ANTRACITE","hex":null,"image_url":null,"family":"Sivá"},{"name":"TERRACOTTA SCURA","hex":null,"image_url":null,"family":"Červená"},{"name":"TORTORA DI TORINO","hex":null,"image_url":null,"family":"Hnedá"},{"name":"VERDE PAVONE","hex":null,"image_url":null,"family":"Zelená"},{"name":"GIALLO SAHARA","hex":null,"image_url":null,"family":"Žltá"},{"name":"VERDE BRITISH","hex":null,"image_url":null,"family":"Zelená"},{"name":"ROSSO POMPEIANO","hex":null,"image_url":null,"family":"Červená"}]'::jsonb,
  ARRAY['Biela', 'Červená', 'Hnedá', 'Modrá', 'Sivá', 'Zelená', 'Žltá']::text[],
  ARRAY['42x42x32 cm', '52x52x40 cm']::text[],
  ARRAY['Do 50 cm', '51-100 cm']::text[],
  '[{"label":"42x42x32 cm","dimensions":"42x42x32 cm","price_cents":11100,"attributes":{"rozmer":"42x42x32 cm"}},{"label":"52x52x40 cm","dimensions":"52x52x40 cm","price_cents":15900,"attributes":{"rozmer":"52x52x40 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"42x42x32 cm, 52x52x40 cm"}]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/en/products/uva-spina-planter?_pos=1&_psq=Uva+Spina&_ss=e&_v=1.0',
  'https://serralunga.com/en/products/uva-spina-planter?_pos=1&_psq=Uva+Spina&_ss=e&_v=1.0',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'dizajnove' LIMIT 1),
  'Kvetináč Lluna Nova',
  'kvetinac-lluna-nova',
  'Serralunga',
  61000,
  NULL,
  'Kvetináč LLUNA Nova, ktorý pre značku Serralunga navrhol Joan Gaspar, je ideálny na členenie vonkajších priestorov a vytváranie vizuálneho prepojenia medzi jednotlivými zónami. Vynikajúco sa hodí na terasy, záhrady, verejné priestranstvá či okolie bazénov. Model LLUNA Nova predstavuje menšiu a vyššiu verziu pôvodnej kolekcie a ponúka rovnakú elegantnú jednoduchosť a funkčnosť. Dostupný je aj v svietiacej verzii, ktorá kombinuje kvetináč a lampu v jednom dizajnovom prvku, čím prináša estetiku aj praktické osvetlenie do každého exteriéru.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/en/products/lluna-nova-planter?_pos=3&_psq=Lluna&_ss=e&_v=1.0)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/kvetinac-lluna-nova/kvetinac-lluna-nova_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/kvetinac-lluna-nova/kvetinac-lluna-nova_1.jpg']::text[],
  '[{"name":"LACQUEROSSO BIANCO","hex":null,"image_url":null,"family":"Biela"},{"name":"TORTORA DI TORINO","hex":null,"image_url":null,"family":"Hnedá"},{"name":"ROSSO","hex":null,"image_url":null,"family":"Červená"},{"name":"BIANCO","hex":null,"image_url":null,"family":"Biela"},{"name":"VERDE PAVONE","hex":null,"image_url":null,"family":"Zelená"},{"name":"ANTHRACITE","hex":null,"image_url":null,"family":"Sivá"},{"name":"GIALLO SAHARA","hex":null,"image_url":null,"family":"Žltá"},{"name":"VERDE BRITISH","hex":null,"image_url":null,"family":"Zelená"},{"name":"ROSSO POMPEIANO","hex":null,"image_url":null,"family":"Červená"}]'::jsonb,
  ARRAY['Biela', 'Červená', 'Hnedá', 'Sivá', 'Zelená', 'Žltá']::text[],
  ARRAY['40x40x120 cm']::text[],
  ARRAY['101-150 cm']::text[],
  '[{"label":"40x40x120 cm","dimensions":"40x40x120 cm","price_cents":61000,"attributes":{"rozmer":"40x40x120 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"40x40x120 cm"}]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/en/products/lluna-nova-planter?_pos=3&_psq=Lluna&_ss=e&_v=1.0',
  'https://serralunga.com/en/products/lluna-nova-planter?_pos=3&_psq=Lluna&_ss=e&_v=1.0',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'klasicke-kvetinace' LIMIT 1),
  'Kvetináč CILINDER',
  'kvetinac-cilinder',
  'Euro3plast',
  11400,
  NULL,
  'Kolekcia Style je elegantná a nadčasová: tieto kvetináče a dekorácie s klasickým šarmom dodajú záhradám a terasám sofistikovaný vzhľad a po prvom použití sa stanú nepostrádateľné. Dokonale dopĺňajú priestory, ktoré sa rady nechávajú obdivovať.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.euro3plast.com/gb/products/406-5240-cilindro.html#/377-colour-taupe/637-significant_measure-90)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/kvetinac-cilinder/kvetinac-cilinder_1.webp',
  ARRAY['https://kochlik.netlify.app/images/kvetinac-cilinder/kvetinac-cilinder_1.webp', 'https://kochlik.netlify.app/images/kvetinac-cilinder/kvetinac-cilinder_2.webp']::text[],
  '[{"name":"TAUPE","hex":"#706961","image_url":null,"family":"Hnedá"},{"name":"TERRA DI SIENA","hex":"#e3945b","image_url":null,"family":"Červená"}]'::jsonb,
  ARRAY['Červená', 'Hnedá']::text[],
  ARRAY['110x77 cm', '130x91 cm', '150x102 cm', '52x38 cm', '62x43 cm', '72x50 cm', '90x63 cm']::text[],
  ARRAY['51-100 cm', '101-150 cm']::text[],
  '[{"label":"110x77 cm","dimensions":"110x77 cm","price_cents":62100,"attributes":{"rozmer":"110x77 cm"}},{"label":"130x91 cm","dimensions":"130x91 cm","price_cents":83500,"attributes":{"rozmer":"130x91 cm"}},{"label":"150x102 cm","dimensions":"150x102 cm","price_cents":108600,"attributes":{"rozmer":"150x102 cm"}},{"label":"52x38 cm","dimensions":"52x38 cm","price_cents":11400,"attributes":{"rozmer":"52x38 cm"}},{"label":"62x43 cm","dimensions":"62x43 cm","price_cents":13500,"attributes":{"rozmer":"62x43 cm"}},{"label":"72x50 cm","dimensions":"72x50 cm","price_cents":18900,"attributes":{"rozmer":"72x50 cm"}},{"label":"90x63 cm","dimensions":"90x63 cm","price_cents":40700,"attributes":{"rozmer":"90x63 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"110×77 cm, 130×91 cm, 150×102 cm, 52×38 cm, 62×43 cm, 72×50 cm, 90×63 cm"}]'::jsonb,
  '[{"label":"Technický dokument","url":"https://www.euro3plast.com/sheets/cilindro_rot_vaso.pdf"},{"label":"Informačný dokument","url":"https://www.euro3plast.com/sheets/cilindro_rot_pot_info_en.pdf"}]'::jsonb,
  'https://www.euro3plast.com/gb/products/406-5240-cilindro.html#/377-colour-taupe/637-significant_measure-90',
  'https://www.euro3plast.com/gb/products/406-5240-cilindro.html#/377-colour-taupe/637-significant_measure-90',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'nabytok' LIMIT 1),
  'Stôl Chloé',
  'stol-chloe',
  'Plust',
  58000,
  NULL,
  'Súprava stolov s nosnou konštrukciou z rotačne tvarovaného polyetylénu (PE) v kombinácii s čiernymi doskami z HPL materiálu. Vhodná na použitie v interiéri aj exteriéri. Moderné, minimalistické línie z nej robia univerzálny doplnok pre každé súčasné prostredie.
Rozmer
79 x 29 x 74 cm
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.plust.it/en/products/chloe-table/)',
  'https://kochlik.netlify.app/images/stol-chloe/stol-chloe_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/stol-chloe/stol-chloe_1.jpg', 'https://kochlik.netlify.app/images/stol-chloe/stol-chloe_2.jpg']::text[],
  '[{"name":"Pearl black","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_87_pearlblack.jpg","family":"Čierna"},{"name":"White C2","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_c2_whitec2.jpg","family":"Biela"},{"name":"Sandy","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_m9_sandy.jpg","family":"Béžová"},{"name":"Black","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_black_black.jpg","family":"Čierna"}]'::jsonb,
  ARRAY['Béžová', 'Biela', 'Čierna']::text[],
  ARRAY['29 x 74 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb,
  'https://www.plust.it/en/products/chloe-table/',
  'https://www.plust.it/en/products/chloe-table/',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'klasicke-kvetinace' LIMIT 1),
  'FESTONATO',
  'festonato',
  'Euro3plast',
  4200,
  NULL,
  'Kolekcia Style je elegantná a nadčasová: tieto kvetináče a dekorácie s klasickým šarmom dodajú záhradám a terasám sofistikovaný vzhľad a po prvom použití sa stanú nepostrádateľné. Dokonale dopĺňajú priestory, ktoré sa rady nechávajú obdivovať.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.euro3plast.com/gb/-/305-festonato.html)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/festonato/festonato_1.webp',
  ARRAY['https://kochlik.netlify.app/images/festonato/festonato_1.webp']::text[],
  '[{"name":"TERRA DI SIENA","hex":"#e3945b","image_url":null,"family":"Červená"}]'::jsonb,
  ARRAY['Červená']::text[],
  ARRAY['106x85 cm', '39x32 cm', '46x37 cm', '50x39 cm', '55x45 cm', '64x52 cm', '69x57 cm', '75x60 cm', '85x68 cm', '94x77 cm']::text[],
  ARRAY['Do 50 cm', '51-100 cm', '101-150 cm']::text[],
  '[{"label":"106x85 cm","dimensions":"106x85 cm","price_cents":49600,"attributes":{"rozmer":"106x85 cm"}},{"label":"39x32 cm","dimensions":"39x32 cm","price_cents":4200,"attributes":{"rozmer":"39x32 cm"}},{"label":"46x37 cm","dimensions":"46x37 cm","price_cents":4900,"attributes":{"rozmer":"46x37 cm"}},{"label":"50x39 cm","dimensions":"50x39 cm","price_cents":5900,"attributes":{"rozmer":"50x39 cm"}},{"label":"55x45 cm","dimensions":"55x45 cm","price_cents":9300,"attributes":{"rozmer":"55x45 cm"}},{"label":"64x52 cm","dimensions":"64x52 cm","price_cents":13000,"attributes":{"rozmer":"64x52 cm"}},{"label":"69x57 cm","dimensions":"69x57 cm","price_cents":16300,"attributes":{"rozmer":"69x57 cm"}},{"label":"75x60 cm","dimensions":"75x60 cm","price_cents":17600,"attributes":{"rozmer":"75x60 cm"}},{"label":"85x68 cm","dimensions":"85x68 cm","price_cents":26000,"attributes":{"rozmer":"85x68 cm"}},{"label":"94x77 cm","dimensions":"94x77 cm","price_cents":37400,"attributes":{"rozmer":"94x77 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"106×85 cm, 39×32 cm, 46×37 cm, 50×39 cm, 55×45 cm, 60×48 cm, 64×52 cm, 69×57 cm, 75×60 cm, 85×68 cm, 94×77 cm"}]'::jsonb,
  '[{"label":"Technický dokument","url":"https://www.euro3plast.com/sheets/festonato_vaso.pdf"},{"label":"Informačný dokument","url":"https://www.euro3plast.com/sheets/festonato_pot_info_en.pdf"}]'::jsonb,
  'https://www.euro3plast.com/gb/-/305-festonato.html',
  'https://www.euro3plast.com/gb/-/305-festonato.html',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'dizajnove' LIMIT 1),
  'Cactus',
  'cactus',
  'Plust',
  44000,
  NULL,
  'Dve menšie vázy na rastliny, inšpirované štylizovaným tvarom nadrozmerného kaktusu so stabilnou základňou v štýle 60. rokov. Ideálne na originálne oživenie interiéru aj exteriéru a dodanie priestoru jedinečného charakteru.
 
Rozmer
78 x 74 x 126 cm
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.plust.it/en/products/cactus/)',
  'https://kochlik.netlify.app/images/cactus/cactus_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/cactus/cactus_1.jpg']::text[],
  '[{"name":"Acid green","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_86_acidgreen.jpg","family":"Zelená"},{"name":"White C2","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_c2_whitec2.jpg","family":"Biela"}]'::jsonb,
  ARRAY['Biela', 'Zelená']::text[],
  ARRAY['78 x 74 x 126 cm']::text[],
  ARRAY['101-150 cm']::text[],
  '[{"label":"78 x 74 x 126 cm","dimensions":"78 x 74 x 126 cm","price_cents":44000,"attributes":{"rozmer":"78 x 74 x 126 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"78 x 74 x 126 cm"}]'::jsonb,
  '[]'::jsonb,
  'https://www.plust.it/en/products/cactus/',
  'https://www.plust.it/en/products/cactus/',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'svietiace-kvetinace' LIMIT 1),
  'Kvetináč Cone svietiaci',
  'kvetinac-cone-svietiaci',
  'Serralunga',
  108100,
  NULL,
  'Materiál: Vyrobené z LLDPE (lineárny nízkohustotný polyetylén) Spôsob výroby: Rotačné tvarovanie Vhodnosť: Určené na vonkajšie použitie, odolné voči všetkým poveternostným podmienkam. Poskytuje UV ochranu, je 100 % recyklovateľné a farbené v hmote. Vyznačuje sa vysokou mechanickou pevnosťou a odolnosťou voči nárazom. Materiál odoláva teplotám od –35 °C do +80 °C.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/en/products/cone-planter-with-light?_pos=2&_psq=Cone&_ss=e&_v=1.0)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/kvetinac-cone-svietiaci/kvetinac-cone-svietiaci_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/kvetinac-cone-svietiaci/kvetinac-cone-svietiaci_1.jpg']::text[],
  '[{"name":"White light with cable","hex":null,"image_url":null,"family":"Biela"},{"name":"RGB light with cable","hex":null,"image_url":null,"family":null}]'::jsonb,
  ARRAY['Biela']::text[],
  ARRAY['130x130x90 cm']::text[],
  ARRAY['101-150 cm']::text[],
  '[{"label":"130x130x90 cm","dimensions":"130x130x90 cm","price_cents":108100,"attributes":{"rozmer":"130x130x90 cm","typ-ziarovky":"LED"}}]'::jsonb,
  '[{"key":"Rozmer","value":"130x130x90 cm"},{"key":"Typ žiarovky","value":"LED"}]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/en/products/cone-planter-with-light?_pos=2&_psq=Cone&_ss=e&_v=1.0',
  'https://serralunga.com/en/products/cone-planter-with-light?_pos=2&_psq=Cone&_ss=e&_v=1.0',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'nabytok' LIMIT 1),
  'Lehátko Gumball',
  'lehatko-gumball',
  'Plust',
  101200,
  NULL,
  'Ležadlo určené na použitie v záhrade alebo v oddychových zónach, ako sú bazény, wellness centrá, rezorty či kúpele. Naklonenie operadla umožňuje správne a pohodlné držanie tela, vďaka čomu je ideálne na relaxáciu a oddych.
Rozmer
206 x 83 x 42 cm
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.plust.it/en/products/)',
  'https://kochlik.netlify.app/images/lehatko-gumball/lehatko-gumball_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/lehatko-gumball/lehatko-gumball_1.jpg', 'https://kochlik.netlify.app/images/lehatko-gumball/lehatko-gumball_2.jpg']::text[],
  '[]'::jsonb,
  ARRAY[]::text[],
  ARRAY['83 x 42 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb,
  'https://www.plust.it/en/products/',
  'https://www.plust.it/en/products/',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'moderne-kvetinace' LIMIT 1),
  'Kvetináč KABIN LONG',
  'kvetinac-kabin-long',
  'Serralunga',
  40200,
  NULL,
  'Kvetináč Kabin Long, navrhnutý Luisou Bocchietto pre značku Serralunga, je impozantným archetypálnym dizajnovým prvkom. Tento model stelesňuje zenový minimalizmus v jeho čistej a vyváženej podobe, kde sa geometrická presnosť tvaru a jemne brúsený povrch prelínajú s mäkkosťou zamatového dojmu. Výsledkom je elegantný, harmonický a nadčasový kúsok, ktorý dokonale dopĺňa moderné architektonické priestory aj exteriéry.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/en/products/kabin-rectangular-planter?_pos=1&_psq=KABIN+LONG&_ss=e&_v=1.0)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/kvetinac-kabin-long/kvetinac-kabin-long_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/kvetinac-kabin-long/kvetinac-kabin-long_1.jpg']::text[],
  '[{"name":"ANTRACITE","hex":null,"image_url":null,"family":"Sivá"},{"name":"AZZURRO DI PROVENZA","hex":null,"image_url":null,"family":"Modrá"},{"name":"ROSSO","hex":null,"image_url":null,"family":"Červená"},{"name":"SALVIA DI SARDEGNA","hex":null,"image_url":null,"family":"Zelená"},{"name":"TERRACOTTA TOSCANA","hex":null,"image_url":null,"family":"Červená"},{"name":"TERRACOTTA SCURA","hex":null,"image_url":null,"family":"Červená"},{"name":"TORTORA DI TORINO","hex":null,"image_url":null,"family":"Hnedá"},{"name":"VERDE PAVONE","hex":null,"image_url":null,"family":"Zelená"},{"name":"BIANCO","hex":null,"image_url":null,"family":"Biela"},{"name":"GIALLO SAHARA","hex":null,"image_url":null,"family":"Žltá"},{"name":"VERDE BRITISH","hex":null,"image_url":null,"family":"Zelená"},{"name":"ROSSO POMPEIANO","hex":null,"image_url":null,"family":"Červená"}]'::jsonb,
  ARRAY['Biela', 'Červená', 'Hnedá', 'Modrá', 'Sivá', 'Zelená', 'Žltá']::text[],
  ARRAY['88x44x38cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[{"label":"88x44x38cm","dimensions":"88x44x38cm","price_cents":40200,"attributes":{"rozmer":"88x44x38cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"88x44x38cm"}]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/en/products/kabin-rectangular-planter?_pos=1&_psq=KABIN+LONG&_ss=e&_v=1.0',
  'https://serralunga.com/en/products/kabin-rectangular-planter?_pos=1&_psq=KABIN+LONG&_ss=e&_v=1.0',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'klasicke-kvetinace' LIMIT 1),
  'Kvetináč ORCIO FESTONATO',
  'kvetinac-orcio-festonato',
  'Serralunga',
  14600,
  NULL,
  'Kvetináč Orcio Festonato od značky Serralunga predstavuje tradičný taliansky nadčasový kvetináč v jemných zemistých tónoch, ktoré vytvárajú idylickú vidiecku atmosféru na pomedzí anglickej záhrady a talianskeho vidieka. Jeho elegantne zaoblený tvar a precízne spracované detaily robia z modelu Orcio Festonato skutočnú klasickú krásu, ktorá dodá každému priestoru dôstojnosť, štýl a harmonický šarm.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/en/products/decorati-orcio-festonato-planter?_pos=4&_psq=FESTONATO&_ss=e&_v=1.0)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/kvetinac-orcio-festonato/kvetinac-orcio-festonato_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/kvetinac-orcio-festonato/kvetinac-orcio-festonato_1.jpg']::text[],
  '[{"name":"TORTORA DI TORINO","hex":null,"image_url":null,"family":"Hnedá"},{"name":"GESSO DI BOLOGNA","hex":null,"image_url":null,"family":"Biela"},{"name":"ANTRACITE","hex":null,"image_url":null,"family":"Sivá"},{"name":"AZZURRO DI PROVENZA","hex":null,"image_url":null,"family":"Modrá"},{"name":"SALVIA DI SARDEGNA","hex":null,"image_url":null,"family":"Zelená"},{"name":"TERRACOTTA TOSCANA","hex":null,"image_url":null,"family":"Červená"},{"name":"TERRACOTTA SCURA","hex":null,"image_url":null,"family":"Červená"},{"name":"VERDE PAVONE","hex":null,"image_url":null,"family":"Zelená"},{"name":"PIETRA DELLA DOLOMITI","hex":null,"image_url":null,"family":"Sivá"},{"name":"PIETRA DI MATERA","hex":null,"image_url":null,"family":"Sivá"},{"name":"GIALLO SAHARA","hex":null,"image_url":null,"family":"Žltá"},{"name":"VERDE BRITISH","hex":null,"image_url":null,"family":"Zelená"},{"name":"ROSSO POMPEIANO","hex":null,"image_url":null,"family":"Červená"}]'::jsonb,
  ARRAY['Biela', 'Červená', 'Hnedá', 'Modrá', 'Sivá', 'Zelená', 'Žltá']::text[],
  ARRAY['60x60x50cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[{"label":"60x60x50cm","dimensions":"60x60x50cm","price_cents":14600,"attributes":{"rozmer":"60x60x50cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"60x60x50cm"}]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/en/products/decorati-orcio-festonato-planter?_pos=4&_psq=FESTONATO&_ss=e&_v=1.0',
  'https://serralunga.com/en/products/decorati-orcio-festonato-planter?_pos=4&_psq=FESTONATO&_ss=e&_v=1.0',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'klasicke-kvetinace' LIMIT 1),
  'Kvetináč SIEPI k stene',
  'kvetinac-siepi-k-stene',
  'Euro3plast',
  14500,
  NULL,
  'Kolekcia Style je elegantná a nadčasová: tieto kvetináče a dekorácie s klasickým šarmom dodajú záhradám a terasám sofistikovaný vzhľad a po prvom použití sa stanú nepostrádateľné. Dokonale dopĺňajú priestory, ktoré sa rady nechávajú obdivovať.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.euro3plast.com/gb/products/492-siepi.html)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/kvetinac-siepi-k-stene/kvetinac-siepi-k-stene_1.webp',
  ARRAY['https://kochlik.netlify.app/images/kvetinac-siepi-k-stene/kvetinac-siepi-k-stene_1.webp']::text[],
  '[{"name":"TERRA DI SIENA","hex":"#e3945b","image_url":null,"family":"Červená"}]'::jsonb,
  ARRAY['Červená']::text[],
  ARRAY['52x27x56 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[{"label":"52x27x56 cm","dimensions":"52x27x56 cm","price_cents":14500,"attributes":{"rozmer":"52x27x56 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"52x27x56 cm"}]'::jsonb,
  '[{"label":"Technický dokument","url":"https://www.euro3plast.com/sheets/siepi_vaso_a_muro.pdf"},{"label":"Informačný dokument","url":"https://www.euro3plast.com/sheets/siepi_wall_pot_info_en.pdf"}]'::jsonb,
  'https://www.euro3plast.com/gb/products/492-siepi.html',
  'https://www.euro3plast.com/gb/products/492-siepi.html',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'nabytok' LIMIT 1),
  'Barový stôl Armillaria',
  'barovy-stol-armillaria',
  'Plust',
  41000,
  NULL,
  'Kolekcia produktov vyrastá z jedného spoločného základu, z ktorého sa rozvetvujú a nadobúdajú rôzne formy s vlastnými funkciami. Jednotlivé kusy tejto série tak zdieľajú spoločnú základňu, z ktorej symbolicky „vyrastajú“. Stolička Armillaria je vyrobená technológiou rotačného tvarovania (rotomoulding) a je dostupná vo viacerých farebných prevedeniach. Vďaka svojej odolnosti a dizajnu je obzvlášť vhodná pre verejné priestory a komerčné využitie.
Rozmer
63 x 63 x 96 cm
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.plust.it/en/products/armillaria-table-structure/)',
  'https://kochlik.netlify.app/images/barovy-stol-armillaria/barovy-stol-armillaria_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/barovy-stol-armillaria/barovy-stol-armillaria_1.jpg', 'https://kochlik.netlify.app/images/barovy-stol-armillaria/barovy-stol-armillaria_2.jpg', 'https://kochlik.netlify.app/images/barovy-stol-armillaria/barovy-stol-armillaria_3.jpg', 'https://kochlik.netlify.app/images/barovy-stol-armillaria/barovy-stol-armillaria_4.jpg', 'https://kochlik.netlify.app/images/barovy-stol-armillaria/barovy-stol-armillaria_5.jpg']::text[],
  '[{"name":"Pearl black","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_87_pearlblack.jpg","family":"Čierna"},{"name":"White C2","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_c2_whitec2.jpg","family":"Biela"},{"name":"Taupe","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_g9_taupe.jpg","family":"Hnedá"},{"name":"Golden rust","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_n4_goldenrust.jpg","family":"Hnedá"},{"name":"Tortora","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_g9_tortora.jpg","family":"Hnedá"}]'::jsonb,
  ARRAY['Biela', 'Čierna', 'Hnedá']::text[],
  ARRAY['63 x 96 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb,
  'https://www.plust.it/en/products/armillaria-table-structure/',
  'https://www.plust.it/en/products/armillaria-table-structure/',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'nabytok' LIMIT 1),
  'KUBE lavička',
  'kube-lavicka',
  'Euro3plast',
  23800,
  NULL,
  'Štýl je synonymom minimalizmu – dokonale zhrnutý v čistých a jednoduchých líniách našich kvetináčov a doplnkov. Skombinovali sme čisté profily s farebnou paletou pre každý vkus – od výraznej kyslej zelene a červenej po klasické odtiene – aby ste obohatili svoje obľúbené priestory harmóniou a eleganciou.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.euro3plast.com/gb/-/328-3161-kube.html#/332-colour-white_c2/621-significant_measure-100)',
  'https://kochlik.netlify.app/images/kube-lavicka/kube-lavicka_1.webp',
  ARRAY['https://kochlik.netlify.app/images/kube-lavicka/kube-lavicka_1.webp']::text[],
  '[{"name":"WHITE C2","hex":"#ffffff","image_url":null,"family":"Biela"},{"name":"PEARL BLACK","hex":"#4a4a49","image_url":null,"family":"Čierna"}]'::jsonb,
  ARRAY['Biela', 'Čierna']::text[],
  ARRAY['100x40x40 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[{"label":"100x40x40 cm","dimensions":"100x40x40 cm","price_cents":23800,"attributes":{"rozmer":"100x40x40 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"100x40x40 cm"}]'::jsonb,
  '[{"label":"Technický dokument","url":"https://www.euro3plast.com/sheets/kube_panca.pdf"},{"label":"Informačný dokument","url":"https://www.euro3plast.com/sheets/kube_bench_info_en.pdf"}]'::jsonb,
  'https://www.euro3plast.com/gb/-/328-3161-kube.html#/332-colour-white_c2/621-significant_measure-100',
  'https://www.euro3plast.com/gb/-/328-3161-kube.html#/332-colour-white_c2/621-significant_measure-100',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'moderne-kvetinace' LIMIT 1),
  'Kvetináč ILIE',
  'kvetina-ilie',
  'Euro3plast',
  14400,
  NULL,
  'Štýl je synonymom minimalizmu – dokonale zhrnutý v čistých a jednoduchých líniách našich kvetináčov a doplnkov. Skombinovali sme čisté profily s farebnou paletou pre každý vkus – od výraznej kyslej zelene a červenej po klasické odtiene – aby ste obohatili svoje obľúbené priestory harmóniou a eleganciou.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.euro3plast.com/gb/-/321-ilie.html)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/kvetina-ilie/kvetina-ilie_1.webp',
  ARRAY['https://kochlik.netlify.app/images/kvetina-ilie/kvetina-ilie_1.webp', 'https://kochlik.netlify.app/images/kvetina-ilie/kvetina-ilie_2.webp', 'https://kochlik.netlify.app/images/kvetina-ilie/kvetina-ilie_3.webp', 'https://kochlik.netlify.app/images/kvetina-ilie/kvetina-ilie_4.webp']::text[],
  '[{"name":"WHITE C2","hex":"#ffffff","image_url":null,"family":"Biela"},{"name":"RUST","hex":"#543920","image_url":null,"family":"Hnedá"},{"name":"PEARL BLACK","hex":"#4a4a49","image_url":null,"family":"Čierna"}]'::jsonb,
  ARRAY['Biela', 'Čierna', 'Hnedá']::text[],
  ARRAY['37x75 cm', '42x90 cm', '47x98 cm', '57x126 cm']::text[],
  ARRAY['51-100 cm', '101-150 cm']::text[],
  '[{"label":"37x75 cm","dimensions":"37x75 cm","price_cents":14400,"attributes":{"rozmer":"37x75 cm"}},{"label":"42x90 cm","dimensions":"42x90 cm","price_cents":20900,"attributes":{"rozmer":"42x90 cm"}},{"label":"47x98 cm","dimensions":"47x98 cm","price_cents":24400,"attributes":{"rozmer":"47x98 cm"}},{"label":"57x126 cm","dimensions":"57x126 cm","price_cents":37700,"attributes":{"rozmer":"57x126 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"37×75 cm, 42×90 cm, 47×98 cm, 57×126 cm"}]'::jsonb,
  '[{"label":"Technický dokument","url":"https://www.euro3plast.com/sheets/ilie_vaso_con_doppia_parete.pdf"},{"label":"Informačný dokument","url":"https://www.euro3plast.com/sheets/ilie_pot_with_double_wall_info_en.pdf"}]'::jsonb,
  'https://www.euro3plast.com/gb/-/321-ilie.html',
  'https://www.euro3plast.com/gb/-/321-ilie.html',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'nabytok' LIMIT 1),
  'Stohovateľná stolička Fade',
  'stohovatelna-stolicka-fade',
  'Plust',
  25000,
  NULL,
  'Vďaka technológii rotačného tvarovania spája stolička Fade Stack Chair komfort s pevnosťou a stabilitou sedenia, pričom si zachováva sochársky a elegantný vzhľad. Jej stohovateľnosť ju robí ideálnou voľbou pre priestory, ktoré vyžadujú flexibilitu a funkčnosť, bez kompromisov v štýle typickom pre kolekciu Fade. Rafinovaný rebrovaný povrch sedadla je farebne zladený s pozinkovanými lakovanými kovovými nohami, čím vzniká harmonický celok. Výsledkom je pôsobivá, pohodlná a prakticky stohovateľná stolička, ktorá spája dizajn, eleganciu a funkčnosť v jednom.
Rozmer
49 x 54 x 80 cm
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.plust.it/en/products/fade-stack-chair/)',
  'https://kochlik.netlify.app/images/stohovatelna-stolicka-fade/stohovatelna-stolicka-fade_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/stohovatelna-stolicka-fade/stohovatelna-stolicka-fade_1.jpg', 'https://kochlik.netlify.app/images/stohovatelna-stolicka-fade/stohovatelna-stolicka-fade_2.jpg']::text[],
  '[{"name":"Granite","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_s4_granite.jpg","family":"Sivá"},{"name":"Lava","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_u0_lava.jpg","family":"Sivá"},{"name":"White light","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_u1_whitelight.jpg","family":"Biela"},{"name":"Stone","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_u4_stone.jpg","family":"Sivá"},{"name":"Creta","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_v7_creta.jpg","family":"Béžová"}]'::jsonb,
  ARRAY['Béžová', 'Biela', 'Sivá']::text[],
  ARRAY['54 x 80 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb,
  'https://www.plust.it/en/products/fade-stack-chair/',
  'https://www.plust.it/en/products/fade-stack-chair/',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'nabytok' LIMIT 1),
  'Stolík OASI',
  'stolik-oasi',
  'Euro3plast',
  24800,
  NULL,
  'Kolekcia Style je elegantná a stále aktuálna: tieto nadčasové kvetináče a doplnky dodajú záhradám, ktoré sa rady nechajú obdivovať, šik nádych. Sú úplne talianske svojou tradíciou, ponúkajú širokú škálu veľkostí a vkusne klasické dekorácie, ktoré sa po prvom pohľade stanú nepostrádateľnými.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.euro3plast.com/gb/products/375-3517-oasi.html#/569-colour-white)',
  'https://kochlik.netlify.app/images/stolik-oasi/stolik-oasi_1.webp',
  ARRAY['https://kochlik.netlify.app/images/stolik-oasi/stolik-oasi_1.webp']::text[],
  '[{"name":"WHITE","hex":"#ffffff","image_url":null,"family":"Biela"}]'::jsonb,
  ARRAY['Biela']::text[],
  ARRAY['68x50 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[{"label":"68x50 cm","dimensions":"68x50 cm","price_cents":24800,"attributes":{"rozmer":"68x50 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"68×50 cm"}]'::jsonb,
  '[{"label":"Technický dokument","url":"https://www.euro3plast.com/sheets/oasi_poltroncina_&_tavolino.pdf"},{"label":"Informačný dokument","url":"https://www.euro3plast.com/sheets/oasi_small_armchair_&_small_table_info_en.pdf"}]'::jsonb,
  'https://www.euro3plast.com/gb/products/375-3517-oasi.html#/569-colour-white',
  'https://www.euro3plast.com/gb/products/375-3517-oasi.html#/569-colour-white',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'svietiace-kvetinace' LIMIT 1),
  'Stolová lampa Fade 30 cm',
  'stolova-lampa-fade-30-cm',
  'Plust',
  15000,
  NULL,
  'Stolová lampa Fade je elegantný vodopád svetla, ktorý možno voľne umiestniť kamkoľvek podľa potreby. Rebrovaný povrch základne vytvára jedinečnú hru svetla a tieňov, zatiaľ čo špeciálne povrchové úpravy pripomínajú prírodné materiály. Lampa je vybavená LED svetelným zdrojom a ľahko nabíjateľnou batériou s magnetickým nabíjacím káblom.
Rozmer
13 x 13 x 30 cm
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.plust.it/en/products/fade-table-lamp-high/)',
  'https://kochlik.netlify.app/images/stolova-lampa-fade-30-cm/stolova-lampa-fade-30-cm_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/stolova-lampa-fade-30-cm/stolova-lampa-fade-30-cm_1.jpg', 'https://kochlik.netlify.app/images/stolova-lampa-fade-30-cm/stolova-lampa-fade-30-cm_2.jpg']::text[],
  '[{"name":"Old stone","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_04_oldstone.jpg","family":"Sivá"},{"name":"Golden rust","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_n4_goldenrust.jpg","family":"Hnedá"},{"name":"Granite","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_s4_granite.jpg","family":"Sivá"},{"name":"Aquamarina","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_s8_aquamarina.jpg","family":"Modrá"},{"name":"Lava","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_u0_lava.jpg","family":"Sivá"},{"name":"White light","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_u1_whitelight.jpg","family":"Biela"},{"name":"Coral sand","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_u2_coralsand.jpg","family":"Ružová"},{"name":"Ochre","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_u3_ochre.jpg","family":"Žltá"},{"name":"Stone","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_u4_stone.jpg","family":"Sivá"},{"name":"Creta","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_v7_creta.jpg","family":"Béžová"}]'::jsonb,
  ARRAY['Béžová', 'Biela', 'Hnedá', 'Modrá', 'Ružová', 'Sivá', 'Žltá']::text[],
  ARRAY['13 x 30 cm']::text[],
  ARRAY['Do 50 cm']::text[],
  '[]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb,
  'https://www.plust.it/en/products/fade-table-lamp-high/',
  'https://www.plust.it/en/products/fade-table-lamp-high/',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'klasicke-kvetinace' LIMIT 1),
  'Kvetináč Quadro Fiore',
  'kvetinac-quadro-fiore',
  'Serralunga',
  7600,
  NULL,
  'Kvetináč Quadro Fiore od Serralunga vyžaruje tradičný charakter a klasickú eleganciu. Jeho jemné tón v tóne zemité farby vytvárajú vidiecku atmosféru, ktorá sa nesie na pomedzí anglickej záhrady a talianskeho vidieka. Tento model spája čaro nečakaného s krištáľovou krásou historických kvetináčov, čo mu dodáva prekvapivý a ušľachtilý vzhľad. Quadro Fiore je vďaka tomu všestranne použiteľný doplnok, vhodný pre akýkoľvek štýl prostredia – od klasického po moderný.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/en/products/quadro-fiore-planter?_pos=1&_psq=+Quadro+Fiore&_ss=e&_v=1.0)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/kvetinac-quadro-fiore/kvetinac-quadro-fiore_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/kvetinac-quadro-fiore/kvetinac-quadro-fiore_1.jpg']::text[],
  '[{"name":"TORTORA DI TORINO","hex":null,"image_url":null,"family":"Hnedá"},{"name":"GESSO DI BOLOGNA","hex":null,"image_url":null,"family":"Biela"},{"name":"ANTRACITE","hex":null,"image_url":null,"family":"Sivá"},{"name":"AZZURRO DI PROVENZA","hex":null,"image_url":null,"family":"Modrá"},{"name":"PIETRA DELLA DOLOMITI","hex":null,"image_url":null,"family":"Sivá"},{"name":"SALVIA DI SARDEGNA","hex":null,"image_url":null,"family":"Zelená"},{"name":"TERRACOTTA TOSCANA","hex":null,"image_url":null,"family":"Červená"},{"name":"TERRACOTTA SCURA","hex":null,"image_url":null,"family":"Červená"},{"name":"BIANCO","hex":null,"image_url":null,"family":"Biela"},{"name":"VERDE PAVONE","hex":null,"image_url":null,"family":"Zelená"}]'::jsonb,
  ARRAY['Biela', 'Červená', 'Hnedá', 'Modrá', 'Sivá', 'Zelená']::text[],
  ARRAY['35x35x32 cm', '42x42x40 cm']::text[],
  ARRAY['Do 50 cm']::text[],
  '[{"label":"35x35x32 cm","dimensions":"35x35x32 cm","price_cents":7600,"attributes":{"rozmer":"35x35x32 cm"}},{"label":"42x42x40 cm","dimensions":"42x42x40 cm","price_cents":8200,"attributes":{"rozmer":"42x42x40 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"35x35x32 cm, 42x42x40 cm"}]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/en/products/quadro-fiore-planter?_pos=1&_psq=+Quadro+Fiore&_ss=e&_v=1.0',
  'https://serralunga.com/en/products/quadro-fiore-planter?_pos=1&_psq=+Quadro+Fiore&_ss=e&_v=1.0',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'nabytok' LIMIT 1),
  'Sedačka Sirchester',
  'sedacka-sirchester',
  'Serralunga',
  120000,
  NULL,
  'Pohovka Sirchester, inšpirovaná pôvodným anglickým kreslom známym svojím čalúneným efektom, je nadčasovým kúskom, ktorý bol znovu interpretovaný prostredníctvom inovatívnej filozofie talianskej spoločnosti Serralunga. Za vznikom tohto luxusného nábytku stoja talianski dizajnéri Matteo Bazzicalupo a Raffaella Mangiarotti, ktorých cieľ bol od začiatku jasný – vytvoriť pohodlné a funkčné vonkajšie sedenie. Synergia medzi dizajnom a tvarom bola dosiahnutá vďaka odborným znalostiam spoločnosti Serralunga v oblasti rotačného formovania, čím vznikol pôsobivý tvar zachovávajúci charakteristický prešívaný vzhľad pôvodného anglického kresla. Spoločnosť Serralunga spolu s dizajnérmi prekročila hranice funkčnosti a vdýchla tomuto dielu emocionálnu kreativitu. Kolekcia Sirchester – pozostávajúca z kresla a pohovky – prináša hravú a zároveň sofistikovanú atmosféru do interiérov aj oddychových priestorov, spájajúc eleganciu, pohodlie a odolnosť. Táto verzia je dostupná aj v osvetlenom prevedení a vo vyhotovení Moleskin (registrovaný dizajn), ktoré dodáva produktu teplo, textúru a šarm.
Rozmer
193 x 82 x 72 cm
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/en/products/sirchester-sofa?_pos=3&_psq=Sirchester&_ss=e&_v=1.0)',
  'https://kochlik.netlify.app/images/sedacka-sirchester/sedacka-sirchester_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/sedacka-sirchester/sedacka-sirchester_1.jpg', 'https://kochlik.netlify.app/images/sedacka-sirchester/sedacka-sirchester_2.jpg']::text[],
  '[{"name":"BIANCO","hex":null,"image_url":null,"family":"Biela"},{"name":"ANTRACITE","hex":null,"image_url":null,"family":"Sivá"},{"name":"TORTORA DI TORINO","hex":null,"image_url":null,"family":"Hnedá"},{"name":"TERRACOTTA SCURA","hex":null,"image_url":null,"family":"Červená"},{"name":"VERDE PAVONE","hex":null,"image_url":null,"family":"Zelená"},{"name":"VERDE OLIVE DI CERIGNOLA","hex":null,"image_url":null,"family":"Zelená"},{"name":"AZZURRO DI PROVENZA","hex":null,"image_url":null,"family":"Modrá"},{"name":"ROSSO","hex":null,"image_url":null,"family":"Červená"},{"name":"SALVIA DI SARDEGNA","hex":null,"image_url":null,"family":"Zelená"},{"name":"TERRACOTTA TOSCANA","hex":null,"image_url":null,"family":"Červená"},{"name":"GIALLO SAHARA","hex":null,"image_url":null,"family":"Žltá"},{"name":"VERDE BRITISH","hex":null,"image_url":null,"family":"Zelená"},{"name":"ROSSO POMPEIANO","hex":null,"image_url":null,"family":"Červená"}]'::jsonb,
  ARRAY['Biela', 'Červená', 'Hnedá', 'Modrá', 'Sivá', 'Zelená', 'Žltá']::text[],
  ARRAY['82 x 72 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/en/products/sirchester-sofa?_pos=3&_psq=Sirchester&_ss=e&_v=1.0',
  'https://serralunga.com/en/products/sirchester-sofa?_pos=3&_psq=Sirchester&_ss=e&_v=1.0',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'nabytok' LIMIT 1),
  'Pouf Big Cut',
  'pouf-big-cut',
  'Plust',
  61000,
  NULL,
  'V kombinácii s ostatnými prvkami kolekcie Big Cut môže slúžiť ako pohodlná podnožka alebo ako doplnok na vytváranie ostrovčekov a rôznych zostáv. Možno ho použiť samostatne alebo v spojení s inými modulmi na vytvorenie neformálnych sedení. Súčasťou je vankúš vhodný na použitie v interiéri aj exteriéri.
Rozmer
60 x 60 x 41 cm
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.plust.it/en/products/big-cut-pouf/)',
  'https://kochlik.netlify.app/images/pouf-big-cut/pouf-big-cut_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/pouf-big-cut/pouf-big-cut_1.jpg', 'https://kochlik.netlify.app/images/pouf-big-cut/pouf-big-cut_2.jpg', 'https://kochlik.netlify.app/images/pouf-big-cut/pouf-big-cut_3.jpg']::text[],
  '[{"name":"White-White","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_l6_white-white.jpg","family":"Biela"},{"name":"White-Orange","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_l7_white-orange.jpg","family":"Biela"},{"name":"White-Taupe","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_l8_white-taupe.jpg","family":"Biela"},{"name":"Taupe-White","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_m6_taupe-white.jpg","family":"Biela"},{"name":"Taupe-Orange","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_m7_taupe-orange.jpg","family":"Hnedá"},{"name":"Taupe-Taupe","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_m8_taupe-taupe.jpg","family":"Hnedá"},{"name":"White Light-White","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_v8_whitelight-white.jpg","family":"Biela"},{"name":"White Light-Orange","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_x3_whitelight-orange.jpg","family":"Biela"},{"name":"White Light-Tortora","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_x4_whitelight-tortora.jpg","family":"Biela"}]'::jsonb,
  ARRAY['Biela', 'Hnedá']::text[],
  ARRAY['60 x 41 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb,
  'https://www.plust.it/en/products/big-cut-pouf/',
  'https://www.plust.it/en/products/big-cut-pouf/',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'klasicke-kvetinace' LIMIT 1),
  'Fontána MUŠĽA CONCHIGLIA',
  'fontana-musla-conchiglia',
  'Euro3plast',
  31800,
  NULL,
  'Kolekcia Style je elegantná a stále aktuálna: tieto nadčasové kvetináče a doplnky dodajú záhradám, ktoré sa rady nechajú obdivovať, šik nádych. Sú úplne talianske svojou tradíciou, ponúkajú širokú škálu veľkostí a vkusne klasické dekorácie, ktoré sa po prvom pohľade stanú nepostrádateľnými.
Rozmer
67 x 45 x 121 cm
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.euro3plast.com/gb/products/382-conchiglia.html)',
  'https://kochlik.netlify.app/images/fontana-musla-conchiglia/fontana-musla-conchiglia_1.webp',
  ARRAY['https://kochlik.netlify.app/images/fontana-musla-conchiglia/fontana-musla-conchiglia_1.webp']::text[],
  '[{"name":"WHITE","hex":"#ffffff","image_url":null,"family":"Biela"}]'::jsonb,
  ARRAY['Biela']::text[],
  ARRAY['45 x 121 cm']::text[],
  ARRAY['101-150 cm']::text[],
  '[{"label":null,"dimensions":null,"price_cents":31800,"attributes":{"napojenie":"bez pripojenia na vodu"}},{"label":null,"dimensions":null,"price_cents":43000,"attributes":{"napojenie":"s pripojením na vodu"}}]'::jsonb,
  '[{"key":"Napojenie","value":"s pripojením na vodu, bez pripojenia na vodu"}]'::jsonb,
  '[{"label":"Technický dokument","url":"https://www.euro3plast.com/sheets/conchiglia_fontana.pdf"},{"label":"Informačný dokument","url":"https://www.euro3plast.com/sheets/conchiglia_fountain_info_en.pdf"}]'::jsonb,
  'https://www.euro3plast.com/gb/products/382-conchiglia.html',
  'https://www.euro3plast.com/gb/products/382-conchiglia.html',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'nabytok' LIMIT 1),
  'Barový stôl Fade HPL',
  'barovy-stol-fade-hpl',
  'Plust',
  52000,
  NULL,
  'Vysoký stôl s výbornou stabilitou, ku ktorému je potrebné samostatne zvoliť dosku z HPL materiálu. Rebrovaný povrch vytvára jedinečnú hru svetla a tieňov, zatiaľ čo špeciálne povrchové úpravy pripomínajú prírodné materiály. V bielej svietiacej verzii je možné stôl vybaviť špeciálnou svetelnou sadou pre pôsobivý vizuálny efekt.
Rozmer
61 x 61 x 130 cm
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.plust.it/en/products/fade-table-structure/)',
  'https://kochlik.netlify.app/images/barovy-stol-fade-hpl/barovy-stol-fade-hpl_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/barovy-stol-fade-hpl/barovy-stol-fade-hpl_1.jpg', 'https://kochlik.netlify.app/images/barovy-stol-fade-hpl/barovy-stol-fade-hpl_2.jpg', 'https://kochlik.netlify.app/images/barovy-stol-fade-hpl/barovy-stol-fade-hpl_3.jpg']::text[],
  '[{"name":"Granite","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_s4_granite.jpg","family":"Sivá"},{"name":"Lava","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_u0_lava.jpg","family":"Sivá"},{"name":"Stone","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_u4_stone.jpg","family":"Sivá"},{"name":"Creta","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_v7_creta.jpg","family":"Béžová"},{"name":"Black","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_black_black.jpg","family":"Čierna"},{"name":"White","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_white_white.jpg","family":"Biela"},{"name":"White light","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_u1_whitelight.jpg","family":"Biela"}]'::jsonb,
  ARRAY['Béžová', 'Biela', 'Čierna', 'Sivá']::text[],
  ARRAY['61 x 130 cm']::text[],
  ARRAY['101-150 cm']::text[],
  '[]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb,
  'https://www.plust.it/en/products/fade-table-structure/',
  'https://www.plust.it/en/products/fade-table-structure/',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'nabytok' LIMIT 1),
  'Stolička Chloé',
  'stolicka-chloe',
  'Plust',
  18000,
  NULL,
  'Pohodlná stolička s dizajnom, ktorý odkazuje na neoklasické umenie. Sedadlo z rotačne tvarovaného polyetylénu (PE) posúva hranice technológie – prináša minimálnu hrúbku, elegantné krivky a ľahkosť. Vhodná na použitie v interiéri aj exteriéri.
Rozmer
49 x 53 x 87 cm
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.plust.it/en/products/chloe-chair/)',
  'https://kochlik.netlify.app/images/stolicka-chloe/stolicka-chloe_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/stolicka-chloe/stolicka-chloe_1.jpg', 'https://kochlik.netlify.app/images/stolicka-chloe/stolicka-chloe_2.jpg', 'https://kochlik.netlify.app/images/stolicka-chloe/stolicka-chloe_3.jpg']::text[],
  '[{"name":"Pearl black","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_87_pearlblack.jpg","family":"Čierna"},{"name":"White C2","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_c2_whitec2.jpg","family":"Biela"},{"name":"Sandy","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_m9_sandy.jpg","family":"Béžová"},{"name":"Coral","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_t3_coral.jpg","family":"Červená"}]'::jsonb,
  ARRAY['Béžová', 'Biela', 'Červená', 'Čierna']::text[],
  ARRAY['53 x 87 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb,
  'https://www.plust.it/en/products/chloe-chair/',
  'https://www.plust.it/en/products/chloe-chair/',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'moderne-kvetinace' LIMIT 1),
  'Kvetináč New Pot stredný',
  'kvetinac-new-pot-stredny',
  'Serralunga',
  13900,
  NULL,
  'Kvetináč New Pot stredný, navrhnutý Paolom Rizzattom pre Serralunga, vychádza z tradičného tvaru zrezaného kužeľa – archetypu kvetináča, ktorý je znovu interpretovaný v modernom a sofistikovanom duchu. Myšlienkou kolekcie New Pot je spojiť funkčnú dokonalosť s estetickou eleganciou, čím vzniká harmonický a nadčasový dizajn, vhodný do interiérov aj exteriérov. Model Medium je dostupný vo veľkostiach od 34 cm do 60 cm a predstavuje univerzálne riešenie pre moderné aj klasické aranžmány.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/en/products/new-pot-planter-medium?_pos=1&_psq=new+pot&_ss=e&_v=1.0)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/kvetinac-new-pot-stredny/kvetinac-new-pot-stredny_1.webp',
  ARRAY['https://kochlik.netlify.app/images/kvetinac-new-pot-stredny/kvetinac-new-pot-stredny_1.webp', 'https://kochlik.netlify.app/images/kvetinac-new-pot-stredny/kvetinac-new-pot-stredny_2.webp', 'https://kochlik.netlify.app/images/kvetinac-new-pot-stredny/kvetinac-new-pot-stredny_3.webp']::text[],
  '[{"name":"BIANCO","hex":null,"image_url":null,"family":"Biela"},{"name":"ANTRACITE","hex":null,"image_url":null,"family":"Sivá"},{"name":"TORTORA DI TORINO","hex":null,"image_url":null,"family":"Hnedá"},{"name":"TERRACOTTA SCURA","hex":null,"image_url":null,"family":"Červená"},{"name":"VERDE PAVONE","hex":null,"image_url":null,"family":"Zelená"},{"name":"PIETRA DELLA DOLOMITI","hex":null,"image_url":null,"family":"Sivá"},{"name":"NEVE DI SAN CANDIDO","hex":null,"image_url":null,"family":"Biela"},{"name":"AZZURRO DI PROVENZA","hex":null,"image_url":null,"family":"Modrá"},{"name":"ROSSO","hex":null,"image_url":null,"family":"Červená"},{"name":"SALVIA DI SARDEGNA","hex":null,"image_url":null,"family":"Zelená"},{"name":"LACQUEROSSO BIANCO","hex":null,"image_url":null,"family":"Biela"},{"name":"TERRACOTTA TOSCANA","hex":null,"image_url":null,"family":"Červená"},{"name":"MORE DI ROVO","hex":null,"image_url":null,"family":"Ružová"},{"name":"GIALLO SAHARA","hex":null,"image_url":null,"family":"Žltá"},{"name":"VERDE BRITISH","hex":null,"image_url":null,"family":"Zelená"},{"name":"ROSSO POMPEIANO","hex":null,"image_url":null,"family":"Červená"}]'::jsonb,
  ARRAY['Biela', 'Červená', 'Hnedá', 'Modrá', 'Ružová', 'Sivá', 'Zelená', 'Žltá']::text[],
  ARRAY['34x34x34 cm', '40x40x40 cm', '50x50x50 cm', '60x60x60 cm']::text[],
  ARRAY['Do 50 cm', '51-100 cm']::text[],
  '[{"label":"34x34x34 cm","dimensions":"34x34x34 cm","price_cents":13900,"attributes":{"rozmer":"34x34x34 cm"}},{"label":"40x40x40 cm","dimensions":"40x40x40 cm","price_cents":16400,"attributes":{"rozmer":"40x40x40 cm"}},{"label":"50x50x50 cm","dimensions":"50x50x50 cm","price_cents":19700,"attributes":{"rozmer":"50x50x50 cm"}},{"label":"60x60x60 cm","dimensions":"60x60x60 cm","price_cents":24600,"attributes":{"rozmer":"60x60x60 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"34x34x34 cm, 40x40x40 cm, 50x50x50 cm, 60x60x60 cm"}]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/en/products/new-pot-planter-medium?_pos=1&_psq=new+pot&_ss=e&_v=1.0',
  'https://serralunga.com/en/products/new-pot-planter-medium?_pos=1&_psq=new+pot&_ss=e&_v=1.0',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'nabytok' LIMIT 1),
  'Stolička Solea 2',
  'stolicka-solea-2',
  'Serralunga',
  37000,
  NULL,
  'Kreslo Solea, navrhnuté dizajnérmi Giovannim Giacobonem a Massimom Rojom pre Serralunga, v sebe spája eleganciu minulosti s modernosťou súčasného dizajnu. Kovová rúrková konštrukcia spolu s jednoliatou polypropylénovou škrupinou pripomína harmonické viedenské línie z konca devätnásteho storočia. Jeho jemné, objímajúce tvary sú znovu interpretované s moderným akcentom, čo z kresla robí ideálny doplnok pre vonkajšie priestory aj neformálne interiéry, ktoré si žiadajú jednoduchosť a nadčasovú eleganciu. Dôkazom jeho všestrannosti je možnosť dodania s opierkami alebo bez nich, s rôznymi typmi podnoží, ako aj kombinovanie s ďalšími prvkami z rovnakej kolekcie.
Rozmer
64 x 55 x 73 cm
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/en/products/solea-armchair-set-of-4?_pos=2&_psq=solea&_ss=e&_v=1.0)',
  'https://kochlik.netlify.app/images/stolicka-solea-2/stolicka-solea-2_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/stolicka-solea-2/stolicka-solea-2_1.jpg']::text[],
  '[]'::jsonb,
  ARRAY[]::text[],
  ARRAY['55 x 73 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/en/products/solea-armchair-set-of-4?_pos=2&_psq=solea&_ss=e&_v=1.0',
  'https://serralunga.com/en/products/solea-armchair-set-of-4?_pos=2&_psq=solea&_ss=e&_v=1.0',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'nabytok' LIMIT 1),
  'Kreslo Gumball',
  'kreslo-gumball',
  'Plust',
  41200,
  NULL,
  'Ergonomicky tvarované a obklopujúce kreslo, ideálne pre oddychové a spoločenské priestory. Dostupné aj v svietiacej verzii, ktorá vďaka jemnému rozptýlenému svetlu vytvára teplú a príjemnú atmosféru – ideálnu najmä pre verejné a komerčné prostredia.
Rozmer
92 x 86 x 65 cm
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.plust.it/en/products/gumball-armchair/)',
  'https://kochlik.netlify.app/images/kreslo-gumball/kreslo-gumball_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/kreslo-gumball/kreslo-gumball_1.jpg', 'https://kochlik.netlify.app/images/kreslo-gumball/kreslo-gumball_2.gif', 'https://kochlik.netlify.app/images/kreslo-gumball/kreslo-gumball_3.jpg']::text[],
  '[{"name":"Pearl black","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_87_pearlblack.jpg","family":"Čierna"},{"name":"White C2","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_c2_whitec2.jpg","family":"Biela"},{"name":"Taupe","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_g9_taupe.jpg","family":"Hnedá"},{"name":"Sandy","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_m9_sandy.jpg","family":"Béžová"},{"name":"Golden rust","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_n4_goldenrust.jpg","family":"Hnedá"},{"name":"Aquamarina","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_s8_aquamarina.jpg","family":"Modrá"},{"name":"Lava","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_u0_lava.jpg","family":"Sivá"},{"name":"Ochre","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_u3_ochre.jpg","family":"Žltá"},{"name":"Decor","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_z3_decor.jpg","family":"Béžová"},{"name":"Neutral","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_98_neutral.jpg","family":"Biela"},{"name":"White light","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_u1_whitelight.jpg","family":"Biela"}]'::jsonb,
  ARRAY['Béžová', 'Biela', 'Čierna', 'Hnedá', 'Modrá', 'Sivá', 'Žltá']::text[],
  ARRAY['86 x 65 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb,
  'https://www.plust.it/en/products/gumball-armchair/',
  'https://www.plust.it/en/products/gumball-armchair/',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'klasicke-kvetinace' LIMIT 1),
  'Kalich CALICE FOGLIATO',
  'kalich-calice-fogliato',
  'Serralunga',
  17100,
  NULL,
  'Kvetináč Calice Fogliato od značky Serralunga je nádherný tradičný kvetináč – klasika s dokonale prepracovanými detailmi. Jeho jemné zemité odtiene vytvárajú harmonickú atmosféru, ktorá sa nesie na pomedzí anglickej záhrady a talianskeho vidieka, čím vzniká moderný, no zároveň nadčasový doplnok vhodný do akéhokoľvek prostredia.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/en/products/decorati-calice-fogliato-planter?_pos=1&_psq=CALICE+FOGLIATO&_ss=e&_v=1.0)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/kalich-calice-fogliato/kalich-calice-fogliato_1.webp',
  ARRAY['https://kochlik.netlify.app/images/kalich-calice-fogliato/kalich-calice-fogliato_1.webp']::text[],
  '[{"name":"TORTORA DI TORINO","hex":null,"image_url":null,"family":"Hnedá"},{"name":"TERRACOTTA TOSCANA","hex":null,"image_url":null,"family":"Červená"},{"name":"GESSO DI BOLOGNA","hex":null,"image_url":null,"family":"Biela"},{"name":"ANTRACITE","hex":null,"image_url":null,"family":"Sivá"},{"name":"AZZURRO DI PROVENZA","hex":null,"image_url":null,"family":"Modrá"},{"name":"ROSSO","hex":null,"image_url":null,"family":"Červená"},{"name":"SALVIA DI SARDEGNA","hex":null,"image_url":null,"family":"Zelená"},{"name":"TERRACOTTA SCURA","hex":null,"image_url":null,"family":"Červená"},{"name":"VERDE PAVONE","hex":null,"image_url":null,"family":"Zelená"},{"name":"PIETRA DELLA DOLOMITI","hex":null,"image_url":null,"family":"Sivá"},{"name":"PIETRA DI MATERA","hex":null,"image_url":null,"family":"Sivá"},{"name":"GIALLO SAHARA","hex":null,"image_url":null,"family":"Žltá"},{"name":"VERDE BRITISH","hex":null,"image_url":null,"family":"Zelená"},{"name":"ROSSO POMPEIANO","hex":null,"image_url":null,"family":"Červená"}]'::jsonb,
  ARRAY['Biela', 'Červená', 'Hnedá', 'Modrá', 'Sivá', 'Zelená', 'Žltá']::text[],
  ARRAY['50x60 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[{"label":"50x60 cm","dimensions":"50x60 cm","price_cents":17100,"attributes":{"rozmer":"50x60 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"50×60 cm"}]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/en/products/decorati-calice-fogliato-planter?_pos=1&_psq=CALICE+FOGLIATO&_ss=e&_v=1.0',
  'https://serralunga.com/en/products/decorati-calice-fogliato-planter?_pos=1&_psq=CALICE+FOGLIATO&_ss=e&_v=1.0',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'dizajnove' LIMIT 1),
  'Kvetináč Ming High',
  'kvetinac-ming-high',
  'Serralunga',
  42500,
  NULL,
  'Kvetináč Ming High, navrhnutý Rodolfo Dordoni, je cenený pre svoje veľkorysé rozmery, ktoré zvýrazňuje široký horný okraj a tvar spájajúci tradičné prvky s modernou estetikou. Vďaka tomu sa dokonale hodí do verejných aj súkromných priestorov. Dordoni navrhol túto kolekciu špeciálne pre výrazné sukulentné rastliny, ako sú agáve a kaktusy, ktorých ostnité línie krásne kontrastujú s mäkkými, zaoblenými tvarmi kvetináča. Táto vysoká verzia je dostupná v dvoch veľkostiach – High a Extra High a dá sa skvele kombinovať s modelmi Ming v prevedeniach Small, Large a Extra-Large. Dostupná je aj verzia s povrchovou úpravou Moleskin – registrovaný dizajn, ktorý dodáva produktu šarm, teplý dotyk a luxusný vzhľad.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/en/products/ming-planter?_pos=1&_psq=Vaso+Ming&_ss=e&_v=1.0)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/kvetinac-ming-high/kvetinac-ming-high_1.webp',
  ARRAY['https://kochlik.netlify.app/images/kvetinac-ming-high/kvetinac-ming-high_1.webp', 'https://kochlik.netlify.app/images/kvetinac-ming-high/kvetinac-ming-high_2.webp']::text[],
  '[{"name":"BIANCO","hex":null,"image_url":null,"family":"Biela"},{"name":"ANTRACITE","hex":null,"image_url":null,"family":"Sivá"},{"name":"TORTORA DI TORINO","hex":null,"image_url":null,"family":"Hnedá"},{"name":"VERDE PAVONE","hex":null,"image_url":null,"family":"Zelená"},{"name":"AZZURRO DI PROVENZA","hex":null,"image_url":null,"family":"Modrá"},{"name":"LACQUEROSSO BIANCO","hex":null,"image_url":null,"family":"Biela"},{"name":"ROSSO","hex":null,"image_url":null,"family":"Červená"},{"name":"SALVIA DI SARDEGNA","hex":null,"image_url":null,"family":"Zelená"},{"name":"TERRACOTTA SCURA","hex":null,"image_url":null,"family":"Červená"},{"name":"GIALLO SAHARA","hex":null,"image_url":null,"family":"Žltá"},{"name":"VERDE BRITISH","hex":null,"image_url":null,"family":"Zelená"},{"name":"ROSSO POMPEIANO","hex":null,"image_url":null,"family":"Červená"},{"name":"NEVE DI SAN CANDIDO","hex":null,"image_url":null,"family":"Biela"}]'::jsonb,
  ARRAY['Biela', 'Červená', 'Hnedá', 'Modrá', 'Sivá', 'Zelená', 'Žltá']::text[],
  ARRAY['66x66x100 cm', '93x93x140 cm']::text[],
  ARRAY['51-100 cm', '101-150 cm']::text[],
  '[{"label":"66x66x100 cm","dimensions":"66x66x100 cm","price_cents":42500,"attributes":{"rozmer":"66x66x100 cm"}},{"label":"93x93x140 cm","dimensions":"93x93x140 cm","price_cents":92300,"attributes":{"rozmer":"93x93x140 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"66x66x100 cm, 93x93x140 cm"}]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/en/products/ming-planter?_pos=1&_psq=Vaso+Ming&_ss=e&_v=1.0',
  'https://serralunga.com/en/products/ming-planter?_pos=1&_psq=Vaso+Ming&_ss=e&_v=1.0',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'klasicke-kvetinace' LIMIT 1),
  'Kvetináč FESTONATO MAXI',
  'kvetinac-festonato-maxi',
  'Serralunga',
  54200,
  NULL,
  'Kvetináč Festonato Maxi od značky Serralunga je impozantný a nádherný kúsok s precízne spracovanými tradičnými detailmi. V kombinácii s jemnými zemistými tónmi vytvára pastorálnu atmosféru, ktorá evokuje anglické záhrady aj taliansky vidiek. Festonato Maior je výrazný dizajnový prvok, ktorý vynikne najmä vo väčších a reprezentatívnych priestoroch, kde dodá prostrediu eleganciu, majestátnosť a charakter.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/en/products/decorati-festonato-maior-planter?_pos=5&_psq=FESTONATO&_ss=e&_v=1.0)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/kvetinac-festonato-maxi/kvetinac-festonato-maxi_1.webp',
  ARRAY['https://kochlik.netlify.app/images/kvetinac-festonato-maxi/kvetinac-festonato-maxi_1.webp']::text[],
  '[{"name":"TORTORA DI TORINO","hex":null,"image_url":null,"family":"Hnedá"},{"name":"GESSO DI BOLOGNA","hex":null,"image_url":null,"family":"Biela"},{"name":"ANTRACITE","hex":null,"image_url":null,"family":"Sivá"},{"name":"AZZURRO DI PROVENZA","hex":null,"image_url":null,"family":"Modrá"},{"name":"PIETRA DELLA DOLOMITI","hex":null,"image_url":null,"family":"Sivá"},{"name":"SALVIA DI SARDEGNA","hex":null,"image_url":null,"family":"Zelená"},{"name":"TERRACOTTA TOSCANA","hex":null,"image_url":null,"family":"Červená"},{"name":"TERRACOTTA SCURA","hex":null,"image_url":null,"family":"Červená"},{"name":"BIANCO","hex":null,"image_url":null,"family":"Biela"},{"name":"VERDE PAVONE","hex":null,"image_url":null,"family":"Zelená"},{"name":"PIETRA DI MATERA","hex":null,"image_url":null,"family":"Sivá"},{"name":"GIALLO SAHARA","hex":null,"image_url":null,"family":"Žltá"},{"name":"VERDE BRITISH","hex":null,"image_url":null,"family":"Zelená"},{"name":"ROSSO POMPEIANO","hex":null,"image_url":null,"family":"Červená"}]'::jsonb,
  ARRAY['Biela', 'Červená', 'Hnedá', 'Modrá', 'Sivá', 'Zelená', 'Žltá']::text[],
  ARRAY['130x130x82cm']::text[],
  ARRAY['101-150 cm']::text[],
  '[{"label":"130x130x82cm","dimensions":"130x130x82cm","price_cents":54200,"attributes":{"rozmer":"130x130x82cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"130x130x82cm"}]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/en/products/decorati-festonato-maior-planter?_pos=5&_psq=FESTONATO&_ss=e&_v=1.0',
  'https://serralunga.com/en/products/decorati-festonato-maior-planter?_pos=5&_psq=FESTONATO&_ss=e&_v=1.0',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'doplnky' LIMIT 1),
  'Paloma',
  'paloma',
  'Serralunga',
  26600,
  NULL,
  'Paloma je dekoratívny objekt, ktorý vnáša do záhrady aj do nášho každodenného života štipku živosti a evokuje prvky, ktoré nás vracajú k prírode a detstvu.
Úlomky reality, metafyzické objekty, snové miesta – na zemi… keď sa vo vašom každodennom živote objaví surrealistický prvok záhradného nábytku. Dizajn: Eero Aarnio pre Serralunga.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/products/paloma?_pos=2&_psq=paloma&_ss=e&_v=1.0)',
  'https://kochlik.netlify.app/images/paloma/paloma_1.webp',
  ARRAY['https://kochlik.netlify.app/images/paloma/paloma_1.webp', 'https://kochlik.netlify.app/images/paloma/paloma_2.jpg', 'https://kochlik.netlify.app/images/paloma/paloma_3.webp', 'https://kochlik.netlify.app/images/paloma/paloma_4.webp', 'https://kochlik.netlify.app/images/paloma/paloma_5.webp', 'https://kochlik.netlify.app/images/paloma/paloma_6.webp', 'https://kochlik.netlify.app/images/paloma/paloma_7.webp', 'https://kochlik.netlify.app/images/paloma/paloma_8.webp', 'https://kochlik.netlify.app/images/paloma/paloma_9.webp']::text[],
  '[{"name":"BIANCO","hex":null,"image_url":null,"family":"Biela"},{"name":"AZZURRO DI PROVENZA","hex":null,"image_url":null,"family":"Modrá"},{"name":"SALVIA DI SARDEGNA","hex":null,"image_url":null,"family":"Zelená"},{"name":"TORTORA DI TORINO","hex":null,"image_url":null,"family":"Hnedá"},{"name":"VERDE PAVONE","hex":null,"image_url":null,"family":"Zelená"},{"name":"ROSSO","hex":null,"image_url":null,"family":"Červená"},{"name":"ANTRACITE","hex":null,"image_url":null,"family":"Sivá"},{"name":"ACQUA DELLA MADDALENA","hex":null,"image_url":null,"family":"Modrá"},{"name":"TERRACOTTA SCURA","hex":null,"image_url":null,"family":"Červená"},{"name":"GIALLO SAHARA","hex":null,"image_url":null,"family":"Žltá"},{"name":"VERDE BRITISH","hex":null,"image_url":null,"family":"Zelená"},{"name":"ROSSO POMPEIANO","hex":null,"image_url":null,"family":"Červená"},{"name":"CORTEN","hex":null,"image_url":null,"family":"Hnedá"}]'::jsonb,
  ARRAY['Biela', 'Červená', 'Hnedá', 'Modrá', 'Sivá', 'Zelená', 'Žltá']::text[],
  ARRAY['130x37.5x52.5 cm']::text[],
  ARRAY['101-150 cm']::text[],
  '[{"label":"130x37.5x52.5 cm","dimensions":"130x37.5x52.5 cm","price_cents":26600,"attributes":{"rozmer":"130x37.5x52.5 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"130×37.5×52.5 cm"}]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/products/paloma?_pos=2&_psq=paloma&_ss=e&_v=1.0',
  'https://serralunga.com/products/paloma?_pos=2&_psq=paloma&_ss=e&_v=1.0',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'dizajnove' LIMIT 1),
  'Kvetináč Primavera',
  'kvetinac-primavera',
  'Serralunga',
  118500,
  NULL,
  'Kvetináč Primavera, navrhnutý Eerom Aarnio pre Serralunga, patrí medzi „veľkú štvorku“ ikonických kvetináčov značky. Je vhodný na interiérové aj exteriérové použitie a svojím impozantným tvarom poskytuje ideálnu oporu pre rôzne druhy rastlín – od visiacej zelene a sukulentov až po menšie stromy. Vyrobený je z ľahkého, no odolného rotačne tvarovaného polyetylénu, s UV ochranou, je 100 % recyklovateľný a farbený v hmote.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/en/products/primavera-planter?_pos=1&_psq=Primavera&_ss=e&_v=1.0)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/kvetinac-primavera/kvetinac-primavera_1.webp',
  ARRAY['https://kochlik.netlify.app/images/kvetinac-primavera/kvetinac-primavera_1.webp', 'https://kochlik.netlify.app/images/kvetinac-primavera/kvetinac-primavera_2.webp', 'https://kochlik.netlify.app/images/kvetinac-primavera/kvetinac-primavera_3.webp']::text[],
  '[{"name":"BIANCO","hex":null,"image_url":null,"family":"Biela"},{"name":"ANTRACITE","hex":null,"image_url":null,"family":"Sivá"},{"name":"LACQUEROSSO BIANCO","hex":null,"image_url":null,"family":"Biela"},{"name":"ROSSO","hex":null,"image_url":null,"family":"Červená"},{"name":"SALVIA DI SARDEGNA","hex":null,"image_url":null,"family":"Zelená"},{"name":"TORTORA DI TORINO","hex":null,"image_url":null,"family":"Hnedá"}]'::jsonb,
  ARRAY['Biela', 'Červená', 'Hnedá', 'Sivá', 'Zelená']::text[],
  ARRAY['130x130x120 cm']::text[],
  ARRAY['101-150 cm']::text[],
  '[{"label":"130x130x120 cm","dimensions":"130x130x120 cm","price_cents":118500,"attributes":{"rozmer":"130x130x120 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"130x130x120 cm"}]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/en/products/primavera-planter?_pos=1&_psq=Primavera&_ss=e&_v=1.0',
  'https://serralunga.com/en/products/primavera-planter?_pos=1&_psq=Primavera&_ss=e&_v=1.0',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'nabytok' LIMIT 1),
  'Lavička Giuletta',
  'lavicka-giuletta',
  'Serralunga',
  150000,
  NULL,
  'Lavička Giulietta, ktorú pre Serralunga navrhol talentovaný Paolo Rizzatto, presahuje v záhrade rámec čistej funkčnosti. Slúži zároveň ako príjemné sedenie na vychutnávanie krásy života vonku aj ako výrazný dominantný prvok, ktorý upúta pozornosť svojím luxusným dizajnom. Vďaka svojej prispôsobivosti sa bez problémov hodí do každej záhrady či priestoru a vyniká neutrálnou, jednoduchou siluetou.
Tento kúsok, inšpirovaný klasickou anglickou drevenou „bench“ lavičkou, vytvára formálny aj konceptuálny základ. Cieľom projektu bolo riešiť rôzne formálne, funkčné a komerčné výzvy a zároveň zachytiť samotnú podstatu záhradnej lavičky – povzbudiť každého, aby sa na chvíľu zastavil a ocenil pokoj prírody.\
Rozmer
186 x 67 x 100 cm
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/products/giulietta-bench?_pos=1&_psq=Giuletta&_ss=e&_v=1.0)',
  'https://kochlik.netlify.app/images/lavicka-giuletta/lavicka-giuletta_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/lavicka-giuletta/lavicka-giuletta_1.jpg', 'https://kochlik.netlify.app/images/lavicka-giuletta/lavicka-giuletta_2.webp', 'https://kochlik.netlify.app/images/lavicka-giuletta/lavicka-giuletta_3.webp', 'https://kochlik.netlify.app/images/lavicka-giuletta/lavicka-giuletta_4.webp', 'https://kochlik.netlify.app/images/lavicka-giuletta/lavicka-giuletta_5.webp', 'https://kochlik.netlify.app/images/lavicka-giuletta/lavicka-giuletta_6.webp', 'https://kochlik.netlify.app/images/lavicka-giuletta/lavicka-giuletta_7.webp']::text[],
  '[{"name":"BIANCO","hex":null,"image_url":null,"family":"Biela"},{"name":"TORTORA DI TORINO","hex":null,"image_url":null,"family":"Hnedá"},{"name":"ROSSO","hex":null,"image_url":null,"family":"Červená"},{"name":"SALVIA DI SARDEGNA","hex":null,"image_url":null,"family":"Zelená"},{"name":"ANTRACITE","hex":null,"image_url":null,"family":"Sivá"},{"name":"ACQUA DELLA MADDALENA","hex":null,"image_url":null,"family":"Modrá"},{"name":"AZZURRO DI PROVENZA","hex":null,"image_url":null,"family":"Modrá"},{"name":"VERDE PAVONE","hex":null,"image_url":null,"family":"Zelená"},{"name":"GIALLO SAHARA","hex":null,"image_url":null,"family":"Žltá"},{"name":"VERDE BRITISH","hex":null,"image_url":null,"family":"Zelená"},{"name":"ROSSO POMPEIANO","hex":null,"image_url":null,"family":"Červená"}]'::jsonb,
  ARRAY['Biela', 'Červená', 'Hnedá', 'Modrá', 'Sivá', 'Zelená', 'Žltá']::text[],
  ARRAY['67 x 100 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/products/giulietta-bench?_pos=1&_psq=Giuletta&_ss=e&_v=1.0',
  'https://serralunga.com/products/giulietta-bench?_pos=1&_psq=Giuletta&_ss=e&_v=1.0',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'nabytok' LIMIT 1),
  'Stolík Enta',
  'stolik-enta',
  'Plust',
  21000,
  NULL,
  'Konferenčný stolík z polyetylénu, ľahký a jednoducho premiestniteľný. Dostupný vo viacerých farebných prevedeniach.
Rozmer
40 x 54 40 cm
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.plust.it/en/products/enta/)',
  'https://kochlik.netlify.app/images/stolik-enta/stolik-enta_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/stolik-enta/stolik-enta_1.jpg', 'https://kochlik.netlify.app/images/stolik-enta/stolik-enta_2.jpg', 'https://kochlik.netlify.app/images/stolik-enta/stolik-enta_3.jpg', 'https://kochlik.netlify.app/images/stolik-enta/stolik-enta_4.jpg']::text[],
  '[{"name":"White C2","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_c2_whitec2.jpg","family":"Biela"},{"name":"Granite","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_s4_granite.jpg","family":"Sivá"},{"name":"White light","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_u1_whitelight.jpg","family":"Biela"},{"name":"Stone","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_u4_stone.jpg","family":"Sivá"}]'::jsonb,
  ARRAY['Biela', 'Sivá']::text[],
  ARRAY['40 cm']::text[],
  ARRAY['Do 50 cm']::text[],
  '[]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb,
  'https://www.plust.it/en/products/enta/',
  'https://www.plust.it/en/products/enta/',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'klasicke-kvetinace' LIMIT 1),
  'Hrantík TOSKÁNSKY s dvojitou stenou',
  'hrantik-toskansky-s-dvojitou-stenou',
  'Euro3plast',
  30600,
  NULL,
  'Kolekcia Style je elegantná a nadčasová: tieto kvetináče a dekorácie s klasickým šarmom dodajú záhradám a terasám sofistikovaný vzhľad a po prvom použití sa stanú nepostrádateľné. Dokonale dopĺňajú priestory, ktoré sa rady nechávajú obdivovať.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.euro3plast.com/gb/products/359-toscana.html)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/hrantik-toskansky-s-dvojitou-stenou/hrantik-toskansky-s-dvojitou-stenou_1.webp',
  ARRAY['https://kochlik.netlify.app/images/hrantik-toskansky-s-dvojitou-stenou/hrantik-toskansky-s-dvojitou-stenou_1.webp']::text[],
  '[{"name":"TERRA DI SIENA","hex":"#e3945b","image_url":null,"family":"Červená"}]'::jsonb,
  ARRAY['Červená']::text[],
  ARRAY['95x47x47 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[{"label":"95x47x47 cm","dimensions":"95x47x47 cm","price_cents":30600,"attributes":{"rozmer":"95x47x47 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"95x47x47 cm"}]'::jsonb,
  '[{"label":"Technický dokument","url":"https://www.euro3plast.com/sheets/toscana_cassetta_con_doppia_parete.pdf"},{"label":"Informačný dokument","url":"https://www.euro3plast.com/sheets/toscana_plant_box_with_double_wall_info_en.pdf"}]'::jsonb,
  'https://www.euro3plast.com/gb/products/359-toscana.html',
  'https://www.euro3plast.com/gb/products/359-toscana.html',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'svietiace-kvetinace' LIMIT 1),
  'Stolová lampa Fade metal',
  'stolova-lampa-fade-metal',
  'Plust',
  18000,
  NULL,
  'Stolová lampa Fade metal rozžiari každý priestor jemným prúdom svetla. Je vybavená LED svetelným zdrojom a ľahko nabíjateľnou batériou s magnetickým nabíjacím káblom. Odvážny, lineárny dizajn sa dokonale prispôsobí akémukoľvek prostrediu, zatiaľ čo špeciálne povrchové úpravy pripomínajú prírodné materiály. Farebné varianty White Light, Clay, Golden Rust a Granite dodávajú lampe jedinečný hmatový a vizuálny charakter.
Rozmer
12 x 13 x 38 cm
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.plust.it/en/products/fade-table-lamp-metal/)',
  'https://kochlik.netlify.app/images/stolova-lampa-fade-metal/stolova-lampa-fade-metal_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/stolova-lampa-fade-metal/stolova-lampa-fade-metal_1.jpg']::text[],
  '[{"name":"Golden rust","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_n4_goldenrust.jpg","family":"Hnedá"},{"name":"Granite","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_s4_granite.jpg","family":"Sivá"},{"name":"White light","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_u1_whitelight.jpg","family":"Biela"},{"name":"Creta","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_v7_creta.jpg","family":"Béžová"}]'::jsonb,
  ARRAY['Béžová', 'Biela', 'Hnedá', 'Sivá']::text[],
  ARRAY['13 x 38 cm']::text[],
  ARRAY['Do 50 cm']::text[],
  '[]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb,
  'https://www.plust.it/en/products/fade-table-lamp-metal/',
  'https://www.plust.it/en/products/fade-table-lamp-metal/',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'nabytok' LIMIT 1),
  'Stôl Cubalibre',
  'stol-cubalibre',
  'Plust',
  80000,
  NULL,
  'Predmet inšpirovaný tvarom pohára na nápoje. Vďaka svojej veľkosti je ideálny na umiestnenie rastlín alebo stredne až veľkých dekorácií, no rovnako dobre poslúži ako originálny prvok na podujatiach – napríklad ako obrovský ľadový vedierko na chladenie fliaš s nápojmi. Vyznačuje sa veselým, hravým a neformálnym štýlom. V svietiacej verzii je ideálny pre spoločenské priestory a verejné zóny, kde vytvára uvoľnenú atmosféru.
Rozmer
88 x 88 x 98 cm
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.plust.it/en/products/cubalibre/)',
  'https://kochlik.netlify.app/images/stol-cubalibre/stol-cubalibre_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/stol-cubalibre/stol-cubalibre_1.jpg', 'https://kochlik.netlify.app/images/stol-cubalibre/stol-cubalibre_2.jpg']::text[],
  '[{"name":"White C2","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_c2_whitec2.jpg","family":"Biela"},{"name":"Neutral","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_98_neutral.jpg","family":"Biela"},{"name":"White light","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_u1_whitelight.jpg","family":"Biela"}]'::jsonb,
  ARRAY['Biela']::text[],
  ARRAY['88 x 98 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb,
  'https://www.plust.it/en/products/cubalibre/',
  'https://www.plust.it/en/products/cubalibre/',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'moderne-kvetinace' LIMIT 1),
  'Kvetináč NEWPOT malý',
  'kvetinac-new-pot-maly',
  'Serralunga',
  9800,
  NULL,
  'Kvetináč New Pot, navrhnutý Paolom Rizzattom pre Serralunga, vychádza z tradičného tvaru zrezaného kužeľa – archetypu klasického kvetináča, ktorý je znovu interpretovaný v modernom a sofistikovanom štýle. Cieľom kolekcie New Pot je spojiť funkčnú dokonalosť s estetickou eleganciou, čím vzniká harmonický a nadčasový dizajn, vhodný pre interiérové aj exteriérové priestory. Model Small je dostupný vo veľkostiach od 12 cm do 28 cm a je ideálny pre menšie rastliny alebo jemné aranžmány, ktoré si vyžadujú vkusný a minimalistický doplnok.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/en/products/new-pot-planter-small?_pos=4&_psq=NEW+POT&_ss=e&_v=1.0)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/kvetinac-new-pot-maly/kvetinac-new-pot-maly_1.webp',
  ARRAY['https://kochlik.netlify.app/images/kvetinac-new-pot-maly/kvetinac-new-pot-maly_1.webp', 'https://kochlik.netlify.app/images/kvetinac-new-pot-maly/kvetinac-new-pot-maly_2.webp', 'https://kochlik.netlify.app/images/kvetinac-new-pot-maly/kvetinac-new-pot-maly_3.webp']::text[],
  '[{"name":"BIANCO","hex":null,"image_url":null,"family":"Biela"},{"name":"ANTRACITE","hex":null,"image_url":null,"family":"Sivá"},{"name":"TORTORA DI TORINO","hex":null,"image_url":null,"family":"Hnedá"},{"name":"TERRACOTTA SCURA","hex":null,"image_url":null,"family":"Červená"},{"name":"VERDE PAVONE","hex":null,"image_url":null,"family":"Zelená"},{"name":"PIETRA DELLA DOLOMITI","hex":null,"image_url":null,"family":"Sivá"},{"name":"NEVE DI SAN CANDIDO","hex":null,"image_url":null,"family":"Biela"},{"name":"AZZURRO DI PROVENZA","hex":null,"image_url":null,"family":"Modrá"},{"name":"ROSSO","hex":null,"image_url":null,"family":"Červená"},{"name":"SALVIA DI SARDEGNA","hex":null,"image_url":null,"family":"Zelená"},{"name":"LACQUEROSSO BIANCO","hex":null,"image_url":null,"family":"Biela"},{"name":"TERRACOTTA TOSCANA","hex":null,"image_url":null,"family":"Červená"},{"name":"GIALLO SAHARA","hex":null,"image_url":null,"family":"Žltá"},{"name":"VERDE BRITISH","hex":null,"image_url":null,"family":"Zelená"},{"name":"ROSSO POMPEIANO","hex":null,"image_url":null,"family":"Červená"}]'::jsonb,
  ARRAY['Biela', 'Červená', 'Hnedá', 'Modrá', 'Sivá', 'Zelená', 'Žltá']::text[],
  ARRAY['23x23x23 cm', '28x28x28 cm']::text[],
  ARRAY['Do 50 cm']::text[],
  '[{"label":"23x23x23 cm","dimensions":"23x23x23 cm","price_cents":9800,"attributes":{"rozmer":"23x23x23 cm"}},{"label":"28x28x28 cm","dimensions":"28x28x28 cm","price_cents":11500,"attributes":{"rozmer":"28x28x28 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"23x23x23 cm, 28x28x28 cm"}]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/en/products/new-pot-planter-small?_pos=4&_psq=NEW+POT&_ss=e&_v=1.0',
  'https://serralunga.com/en/products/new-pot-planter-small?_pos=4&_psq=NEW+POT&_ss=e&_v=1.0',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  NULL,
  'Kvetináč IKON xxl zatvorený s dierkami',
  'kvetinac-ikon-xxl-zatvoreny-s-dierkami',
  'Euro3plast',
  245600,
  NULL,
  'Štýl je synonymom minimalistického dizajnu – čisté, jednoduché línie kvetináčov a doplnkov dopĺňa farebná škála pre každý vkus. Vytvára harmonické a elegantné kompozície vo vašich obľúbených priestoroch.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.euro3plast.com/gb/indoor-pots/510-5045-ikon.html#/332-colour-white_c2/735-significant_measure-200)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom.',
  'https://kochlik.netlify.app/images/kvetinac-ikon-xxl-zatvoreny-s-dierkami/kvetinac-ikon-xxl-zatvoreny-s-dierkami_1.webp',
  ARRAY['https://kochlik.netlify.app/images/kvetinac-ikon-xxl-zatvoreny-s-dierkami/kvetinac-ikon-xxl-zatvoreny-s-dierkami_1.webp', 'https://kochlik.netlify.app/images/kvetinac-ikon-xxl-zatvoreny-s-dierkami/kvetinac-ikon-xxl-zatvoreny-s-dierkami_2.webp']::text[],
  '[{"name":"WHITE C2","hex":"#ffffff","image_url":null,"family":"Biela"},{"name":"RUST","hex":"#543920","image_url":null,"family":"Hnedá"},{"name":"TAUPE","hex":"#706961","image_url":null,"family":"Hnedá"},{"name":"PEARL BLACK","hex":"#4a4a49","image_url":null,"family":"Čierna"}]'::jsonb,
  ARRAY['Biela', 'Čierna', 'Hnedá']::text[],
  ARRAY['200x178 cm']::text[],
  ARRAY['Nad 150 cm']::text[],
  '[{"label":"200x178 cm","dimensions":"200x178 cm","price_cents":245600,"attributes":{"rozmer":"200x178 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"140×125 cm, 160×143 cm, 200×178 cm"}]'::jsonb,
  '[{"label":"Technický dokument","url":"https://www.euro3plast.com/sheets/ikon_vaso_xxl.pdf"},{"label":"Informačný dokument","url":"https://www.euro3plast.com/sheets/ikon_pot_xxl_info_en.pdf"}]'::jsonb,
  'https://www.euro3plast.com/gb/indoor-pots/510-5045-ikon.html#/332-colour-white_c2/735-significant_measure-200',
  'https://www.euro3plast.com/gb/indoor-pots/510-5045-ikon.html#/332-colour-white_c2/735-significant_measure-200',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'moderne-kvetinace' LIMIT 1),
  'KUBE TOWER vysoký',
  'kube-tower-vysoky',
  'Euro3plast',
  19900,
  NULL,
  'Štýl je synonymom minimalizmu – dokonale zhrnutý v čistých a jednoduchých líniách našich kvetináčov a doplnkov. Skombinovali sme čisté profily s farebnou paletou pre každý vkus – od výraznej kyslej zelene a červenej po klasické odtiene – aby ste obohatili svoje obľúbené priestory harmóniou a eleganciou.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.euro3plast.com/gb/-/353-3369-kube-tower.html#/332-colour-white_c2/612-significant_measure-30)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/kube-tower-vysoky/kube-tower-vysoky_1.webp',
  ARRAY['https://kochlik.netlify.app/images/kube-tower-vysoky/kube-tower-vysoky_1.webp']::text[],
  '[{"name":"WHITE C2","hex":"#ffffff","image_url":null,"family":"Biela"},{"name":"RUST","hex":"#543920","image_url":null,"family":"Hnedá"},{"name":"TAUPE","hex":"#706961","image_url":null,"family":"Hnedá"},{"name":"CEMENT","hex":"#999390","image_url":null,"family":"Sivá"},{"name":"GRANITE","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/e3p_kube-tower-vysoky_granite.jpg","family":"Sivá"},{"name":"PEARL BLACK","hex":"#4a4a49","image_url":null,"family":"Čierna"}]'::jsonb,
  ARRAY['Biela', 'Čierna', 'Hnedá', 'Sivá']::text[],
  ARRAY['30x30x90 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[{"label":"30x30x90 cm","dimensions":"30x30x90 cm","price_cents":19900,"attributes":{"rozmer":"30x30x90 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"30x30x90 cm"}]'::jsonb,
  '[{"label":"Technický dokument","url":"https://www.euro3plast.com/sheets/kube_tower_vaso_con_doppia_parete.pdf"},{"label":"Informačný dokument","url":"https://www.euro3plast.com/sheets/kube_tower_pot_with_double_wall_info_en.pdf"}]'::jsonb,
  'https://www.euro3plast.com/gb/-/353-3369-kube-tower.html#/332-colour-white_c2/612-significant_measure-30',
  'https://www.euro3plast.com/gb/-/353-3369-kube-tower.html#/332-colour-white_c2/612-significant_measure-30',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'nabytok' LIMIT 1),
  'Kreslo Barceloneta',
  'kreslo-barceloneta',
  'Serralunga',
  125000,
  NULL,
  'Serralunga v spolupráci s dizajnérkou Raffaellou Mangiarotti prepracovala túto klasiku tak, aby bola inovatívna, pohodlná a po prvýkrát prakticky využiteľná aj vo vonkajšom prostredí. Stolička Barceloneta od Serralunga je jedinečnou reinterpretáciou ikonickej stoličky Barcelona, ktorú v roku 1929 navrhli Ludwig Mies van der Rohe a Lilly Reich. Pôvodné prešívané kožené čalúnenie nahrádza praktický plast, pričom si zachováva efekt kapitonáže na operadle. Kúzlo tohto klasického kúsku bolo umožnené sofistikovanou technológiou rotačného liatia plastov, v ktorej je spoločnosť Serralunga svetovým lídrom. Stolička má lakovaný oceľový rám a sedaciu časť z vysokohustotného polyuretánu s UV ochranou, čo z nej robí ideálnu voľbu pre exteriérové, námorné a verejné priestory. Nová Barceloneta je modernou reedíciou, ktorá reaguje na súčasné potreby vonkajšieho bývania, pričom si zachováva štýlový, súčasný charakter verný duchu pôvodného dizajnu. Tento výnimočný projekt bol vybraný na vystavenie v Mies van der Rohe Foundation Museum v Barcelone – pocta, ktorou sa môže pochváliť len veľmi málo výrobcov na svete. „Len málo spoločností na svete sa môže pochváliť tým, že má svoje produkty vystavené v barcelonskom múzeu venovanom tomuto slávnemu dizajnérovi,“ uviedol Marco Serralunga, CEO spoločnosti Serralunga 1825. „Sme poctení a nadšení, že môžeme osláviť reedíciu tohto ikonického objektu – mimoriadneho úspechu dosiahnutého vďaka spolupráci s Raffaellou Mangiarotti, našou dizajnérkou a umeleckou riaditeľkou do roku 2020, s ktorou sme vytvorili približne desať produktov.“
Rozmer
77 x 75 x 77 cm
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/en/products/barceloneta-armchair?_pos=1&_psq=Barceloneta&_ss=e&_v=1.0)',
  'https://kochlik.netlify.app/images/kreslo-barceloneta/kreslo-barceloneta_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/kreslo-barceloneta/kreslo-barceloneta_1.jpg', 'https://kochlik.netlify.app/images/kreslo-barceloneta/kreslo-barceloneta_2.jpg', 'https://kochlik.netlify.app/images/kreslo-barceloneta/kreslo-barceloneta_3.jpg', 'https://kochlik.netlify.app/images/kreslo-barceloneta/kreslo-barceloneta_4.jpg', 'https://kochlik.netlify.app/images/kreslo-barceloneta/kreslo-barceloneta_5.jpg']::text[],
  '[]'::jsonb,
  ARRAY[]::text[],
  ARRAY['75 x 77 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/en/products/barceloneta-armchair?_pos=1&_psq=Barceloneta&_ss=e&_v=1.0',
  'https://serralunga.com/en/products/barceloneta-armchair?_pos=1&_psq=Barceloneta&_ss=e&_v=1.0',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'klasicke-kvetinace' LIMIT 1),
  'Hrantík RETTANGOLO FESTONATO',
  'hrantik-rettangolo-festonato',
  'Serralunga',
  8700,
  NULL,
  'Hrantík Rettangolo Festonato od Serralunga je impozantný a elegantný kúsok s precíznymi tradičnými detailmi, ktorý vyniká svojou klasickou estetikou. V kombinácii so zemitými tónmi v štýle tón v tóne vytvára pastorálnu atmosféru, pripomínajúcu anglické záhrady a taliansky vidiek. Svojimi veľkorysými proporciami a ušľachtilým vzhľadom je Rettangolo Festonato ideálny pre reprezentatívne a veľkorysé priestory, kde sa stáva dominantným prvkom elegantného prostredia.',
  'https://kochlik.netlify.app/images/hrantik-rettangolo-festonato/hrantik-rettangolo-festonato_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/hrantik-rettangolo-festonato/hrantik-rettangolo-festonato_1.jpg']::text[],
  '[]'::jsonb,
  ARRAY[]::text[],
  ARRAY['100x42x40cm', '50x22x24cm', '60x30x25cm', '80x35x32cm']::text[],
  ARRAY['Do 50 cm', '51-100 cm']::text[],
  '[{"label":"100x42x40cm","dimensions":"100x42x40cm","price_cents":21900,"attributes":{"rozmer":"100x42x40cm"}},{"label":"50x22x24cm","dimensions":"50x22x24cm","price_cents":8700,"attributes":{"rozmer":"50x22x24cm"}},{"label":"60x30x25cm","dimensions":"60x30x25cm","price_cents":13000,"attributes":{"rozmer":"60x30x25cm"}},{"label":"80x35x32cm","dimensions":"80x35x32cm","price_cents":17600,"attributes":{"rozmer":"80x35x32cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"100x42x40cm, 50x22x24cm, 60x30x25cm, 80x35x32cm"}]'::jsonb,
  '[]'::jsonb,
  'https://kochlik.sk/produkt/hrantik-rettangolo-festonato/',
  'https://kochlik.sk/produkt/hrantik-rettangolo-festonato/',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'moderne-kvetinace' LIMIT 1),
  'Misa CIOTOLA RUVIDA',
  'misa-ciotola-ruvida',
  'Serralunga',
  5300,
  NULL,
  'Misa Ciotola Ruvida od značky Serralunga svojím drsným a nepravidelným povrchom evokuje prírodný charakter a pôsobí vznešene a nadčasovo. Tento dizajn odráža vzhľad kvetináčov Graniglia z kolekcie Serralunga 1825. Ich textúra pripomína starobylé kamenné nádoby, ktoré zdôrazňujú prirodzenú krásu materiálu a autentický vzhľad kameňa.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/en/products/ciotola-ruvida-planter?_pos=1&_psq=CIOTOLA+RUVIDA&_ss=e&_v=1.0)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/misa-ciotola-ruvida/misa-ciotola-ruvida_1.webp',
  ARRAY['https://kochlik.netlify.app/images/misa-ciotola-ruvida/misa-ciotola-ruvida_1.webp']::text[],
  '[{"name":"TORTORA DI TORINO","hex":null,"image_url":null,"family":"Hnedá"},{"name":"AZZURRO DI PROVENZA","hex":null,"image_url":null,"family":"Modrá"},{"name":"PIETRA DELLA DOLOMITI","hex":null,"image_url":null,"family":"Sivá"},{"name":"GESSO DI BOLOGNA","hex":null,"image_url":null,"family":"Biela"},{"name":"ANTRACITE","hex":null,"image_url":null,"family":"Sivá"},{"name":"ROSSO","hex":null,"image_url":null,"family":"Červená"},{"name":"SALVIA DI SARDEGNA","hex":null,"image_url":null,"family":"Zelená"},{"name":"TERRACOTTA TOSCANA","hex":null,"image_url":null,"family":"Červená"},{"name":"TERRACOTTA SCURA","hex":null,"image_url":null,"family":"Červená"},{"name":"BIANCO","hex":null,"image_url":null,"family":"Biela"},{"name":"VERDE PAVONE","hex":null,"image_url":null,"family":"Zelená"},{"name":"GIALLO SAHARA","hex":null,"image_url":null,"family":"Žltá"},{"name":"VERDE BRITISH","hex":null,"image_url":null,"family":"Zelená"},{"name":"ROSSO POMPEIANO","hex":null,"image_url":null,"family":"Červená"},{"name":"NEVE DI SAN CANDIDO","hex":null,"image_url":null,"family":"Biela"},{"name":"PIETRA DI MATERA","hex":null,"image_url":null,"family":"Sivá"}]'::jsonb,
  ARRAY['Biela', 'Červená', 'Hnedá', 'Modrá', 'Sivá', 'Zelená', 'Žltá']::text[],
  ARRAY['53x25 cm', '42x20 cm']::text[],
  ARRAY['Do 50 cm', '51-100 cm']::text[],
  '[{"label":"53x25 cm","dimensions":"53x25 cm","price_cents":7300,"attributes":{"rozmer":"53x25 cm"}},{"label":"42x20 cm","dimensions":"42x20 cm","price_cents":5300,"attributes":{"rozmer":"42x20 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"42×20 cm, 53×25 cm"}]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/en/products/ciotola-ruvida-planter?_pos=1&_psq=CIOTOLA+RUVIDA&_ss=e&_v=1.0',
  'https://serralunga.com/en/products/ciotola-ruvida-planter?_pos=1&_psq=CIOTOLA+RUVIDA&_ss=e&_v=1.0',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'klasicke-kvetinace' LIMIT 1),
  'Kvetináč ANJELI',
  'kvetinac-anjeli',
  'Euro3plast',
  22100,
  NULL,
  'Kolekcia Style je elegantná a nadčasová: tieto kvetináče a dekorácie s klasickým šarmom dodajú záhradám a terasám sofistikovaný vzhľad a po prvom použití sa stanú nepostrádateľné. Dokonale dopĺňajú priestory, ktoré sa rady nechávajú obdivovať.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.euro3plast.com/gb/products/397-3569-angeli.html#/547-colour-terra_di_siena/617-significant_measure-60)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/kvetinac-anjeli/kvetinac-anjeli_1.webp',
  ARRAY['https://kochlik.netlify.app/images/kvetinac-anjeli/kvetinac-anjeli_1.webp']::text[],
  '[{"name":"TERRA DI SIENA","hex":"#e3945b","image_url":null,"family":"Červená"}]'::jsonb,
  ARRAY['Červená']::text[],
  ARRAY['103x76 cm', '147x114 cm', '60x45 cm', '80x60 cm']::text[],
  ARRAY['51-100 cm', '101-150 cm']::text[],
  '[{"label":"103x76 cm","dimensions":"103x76 cm","price_cents":56900,"attributes":{"rozmer":"103x76 cm"}},{"label":"147x114 cm","dimensions":"147x114 cm","price_cents":116200,"attributes":{"rozmer":"147x114 cm"}},{"label":"60x45 cm","dimensions":"60x45 cm","price_cents":22100,"attributes":{"rozmer":"60x45 cm"}},{"label":"80x60 cm","dimensions":"80x60 cm","price_cents":40700,"attributes":{"rozmer":"80x60 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"103×76 cm, 147×114 cm, 60×45 cm, 80×60 cm"}]'::jsonb,
  '[{"label":"Technický dokument","url":"https://www.euro3plast.com/sheets/angeli_vaso.pdf"},{"label":"Informačný dokument","url":"https://www.euro3plast.com/sheets/angeli_pot_info_en.pdf"}]'::jsonb,
  'https://www.euro3plast.com/gb/products/397-3569-angeli.html#/547-colour-terra_di_siena/617-significant_measure-60',
  'https://www.euro3plast.com/gb/products/397-3569-angeli.html#/547-colour-terra_di_siena/617-significant_measure-60',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'nabytok' LIMIT 1),
  'Stolička Croisette',
  'stolicka-croisette',
  'Serralunga',
  18000,
  NULL,
  'Kreslo Croisette, ktoré navrhol Florent Coirier pre Serralunga, je vyrobené z technopolyméru alebo recyklovaných materiálov. Vyznačuje sa silnou osobnosťou, no zároveň jemnou eleganciou, vďaka ktorej pôsobí prístupne a harmonicky v akomkoľvek prostredí. Jeho dizajn je prispôsobený každodennému používaniu a zaručuje dlhotrvajúcu odolnosť. Projekt vznikol z myšlienky vytvoriť stoličku s lamelovou konštrukciou. Inšpirované podvedomým obrazom tradičných stoličiek, kreslo Croisette vnáša do klasického tvaru moderný a súčasný výraz. Cieľom bolo znovu interpretovať tradičné drevené vonkajšie stoličky, so zameraním na precízne detaily spojov a plynulé prechody materiálu. Croisette Armchair je pevné, odolné a zároveň ľahké, čo z neho robí ideálnu voľbu pre domáce aj komerčné priestory. Dostupné je v sete po štyroch kusoch, s možnosťou výberu s podrúčkami alebo bez nich.
Rozmer
52.8 x 50.3 x 77.8 cm
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/en/products/croisette-chair?_pos=1&_psq=Croisette&_ss=e&_v=1.0)',
  'https://kochlik.netlify.app/images/stolicka-croisette/stolicka-croisette_1.webp',
  ARRAY['https://kochlik.netlify.app/images/stolicka-croisette/stolicka-croisette_1.webp', 'https://kochlik.netlify.app/images/stolicka-croisette/stolicka-croisette_2.webp', 'https://kochlik.netlify.app/images/stolicka-croisette/stolicka-croisette_3.webp', 'https://kochlik.netlify.app/images/stolicka-croisette/stolicka-croisette_4.webp', 'https://kochlik.netlify.app/images/stolicka-croisette/stolicka-croisette_5.webp']::text[],
  '[{"name":"ANTRACITE","hex":null,"image_url":null,"family":"Sivá"},{"name":"MENTA VERDE","hex":null,"image_url":null,"family":"Zelená"},{"name":"CAPPUCCINO","hex":null,"image_url":null,"family":"Hnedá"},{"name":"BIANCO","hex":null,"image_url":null,"family":"Biela"}]'::jsonb,
  ARRAY['Biela', 'Hnedá', 'Sivá', 'Zelená']::text[],
  ARRAY['8 cm']::text[],
  ARRAY['Do 50 cm']::text[],
  '[]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/en/products/croisette-chair?_pos=1&_psq=Croisette&_ss=e&_v=1.0',
  'https://serralunga.com/en/products/croisette-chair?_pos=1&_psq=Croisette&_ss=e&_v=1.0',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'nabytok' LIMIT 1),
  'Stolička Fade',
  'stolicka-fade',
  'Plust',
  25000,
  NULL,
  'Táto stolička sa vyznačuje elegantnými líniami a jedinečným pruhovaným povrchom so špeciálnymi úpravami, ktoré pripomínajú prírodné materiály. Nohy sú vyrobené z lakovaného kovu.
Rozmer
49 x 54 x 80 cm
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.plust.it/en/products/fade-chair/)',
  'https://kochlik.netlify.app/images/stolicka-fade/stolicka-fade_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/stolicka-fade/stolicka-fade_1.jpg', 'https://kochlik.netlify.app/images/stolicka-fade/stolicka-fade_2.gif', 'https://kochlik.netlify.app/images/stolicka-fade/stolicka-fade_3.jpg']::text[],
  '[{"name":"Granite","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_s4_granite.jpg","family":"Sivá"},{"name":"Lava","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_u0_lava.jpg","family":"Sivá"},{"name":"White light","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_u1_whitelight.jpg","family":"Biela"},{"name":"Stone","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_u4_stone.jpg","family":"Sivá"},{"name":"Creta","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_v7_creta.jpg","family":"Béžová"}]'::jsonb,
  ARRAY['Béžová', 'Biela', 'Sivá']::text[],
  ARRAY['54 x 80 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb,
  'https://www.plust.it/en/products/fade-chair/',
  'https://www.plust.it/en/products/fade-chair/',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'doplnky' LIMIT 1),
  'Vešiak Godot',
  'vesiak-godot',
  'Plust',
  43000,
  NULL,
  'Vešiak Godot odkazuje na prírodný a fantazijný svet. Je vybavený centrálnou miskou na drobnosti a farebnými, vymeniteľnými háčikmi, vďaka čomu sa skvele prispôsobí súkromným aj verejným priestorom – napríklad čakárňam či hotelovým lobby. V svietiacej verzii prispieva k vytvoreniu rozprávkovej atmosféry a stáva sa výrazným dizajnovým prvkom každého interiéru.
Rozmer
43 x 40 x 176 cm
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.plust.it/en/products/godot/)',
  'https://kochlik.netlify.app/images/vesiak-godot/vesiak-godot_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/vesiak-godot/vesiak-godot_1.jpg', 'https://kochlik.netlify.app/images/vesiak-godot/vesiak-godot_2.jpg']::text[],
  '[{"name":"White C2","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_c2_whitec2.jpg","family":"Biela"},{"name":"Taupe","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_g9_taupe.jpg","family":"Hnedá"},{"name":"White light","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_u1_whitelight.jpg","family":"Biela"}]'::jsonb,
  ARRAY['Biela', 'Hnedá']::text[],
  ARRAY['40 x 176 cm']::text[],
  ARRAY['Nad 150 cm']::text[],
  '[]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb,
  'https://www.plust.it/en/products/godot/',
  'https://www.plust.it/en/products/godot/',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'dizajnove' LIMIT 1),
  'Saving',
  'saving',
  'Plust',
  38000,
  NULL,
  'Váza “Saving” prechádza procesom „kompresie“ ihneď po vybratí z formy, keď je materiál ešte niekoľko minút čiastočne tvárny. Pôvodne priemyselne vyrábaný predmet tak získava nový estetický rozmer, ktorý sa pri každom kuse mierne líši – ide o remeselný zásah, vďaka ktorému vznikajú unikátne, no sériovo vyrábané diela. V svietiacej verzii tieto plynulé a nepravidelné tvary vytvárajú jemnú svetelnú atmosféru, pričom každá lampa je originálom, jedinečným, no stále súčasťou série.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.plust.it/en/products/saving-space-vase/)',
  'https://kochlik.netlify.app/images/saving/saving_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/saving/saving_1.jpg', 'https://kochlik.netlify.app/images/saving/saving_2.jpg', 'https://kochlik.netlify.app/images/saving/saving_3.jpg']::text[],
  '[{"name":"White C2","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_c2_whitec2.jpg","family":"Biela"},{"name":"Granite","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_s4_granite.jpg","family":"Sivá"},{"name":"Stone","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_u4_stone.jpg","family":"Sivá"},{"name":"White light","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_u1_whitelight.jpg","family":"Biela"}]'::jsonb,
  ARRAY['Biela', 'Sivá']::text[],
  ARRAY['57x57x122 cm']::text[],
  ARRAY['101-150 cm']::text[],
  '[{"label":"57x57x122 cm","dimensions":"57x57x122 cm","price_cents":38000,"attributes":{"rozmer":"57x57x122 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"57x57x122 cm"}]'::jsonb,
  '[]'::jsonb,
  'https://www.plust.it/en/products/saving-space-vase/',
  'https://www.plust.it/en/products/saving-space-vase/',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'nabytok' LIMIT 1),
  'Stolička Porcino',
  'stolicka-porcino',
  'Serralunga',
  23000,
  NULL,
  'Stolička Porcino, navrhnutá Aldom Cibicom pre Serralunga, je multifunkčný prvok, ktorý môže slúžiť nielen ako sedadlo, ale aj ako konferenčný stolík alebo odkladacia či výstavná plocha. Jej názov odkazuje na hríb (porcino), ktorý sa stal inšpiráciou dizajnu – s jemne zaoblenými tvarmi a prirodzenou eleganciou. Stolička Porcino má decentný maskáčový efekt, ktorý jej dodáva osobitý a štýlový vzhľad. Táto verzia je dostupná aj v povrchovej úprave Moleskin, registrovaný dizajn, ktorá dodáva produktu teplo, štruktúru a vizuálnu hĺbku.
Rozmer
35 x 35 x 50 cm
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/en/products/porcino-stool?_pos=1&_psq=Porcino&_ss=e&_v=1.0)',
  'https://kochlik.netlify.app/images/stolicka-porcino/stolicka-porcino_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/stolicka-porcino/stolicka-porcino_1.jpg', 'https://kochlik.netlify.app/images/stolicka-porcino/stolicka-porcino_2.jpg']::text[],
  '[{"name":"BIANCO","hex":null,"image_url":null,"family":"Biela"},{"name":"VERDE PAVONE","hex":null,"image_url":null,"family":"Zelená"},{"name":"ANTRACITE","hex":null,"image_url":null,"family":"Sivá"},{"name":"AZZURRO DI PROVENZA","hex":null,"image_url":null,"family":"Modrá"},{"name":"SALVIA DI SARDEGNA","hex":null,"image_url":null,"family":"Zelená"},{"name":"TORTORA DI TORINO","hex":null,"image_url":null,"family":"Hnedá"},{"name":"VERDE OLIVE DI CERIGNOLA","hex":null,"image_url":null,"family":"Zelená"},{"name":"ROSSO","hex":null,"image_url":null,"family":"Červená"},{"name":"TERRACOTTA TOSCANA","hex":null,"image_url":null,"family":"Červená"},{"name":"TERRACOTTA SCURA","hex":null,"image_url":null,"family":"Červená"},{"name":"GIALLO SAHARA","hex":null,"image_url":null,"family":"Žltá"},{"name":"VERDE BRITISH","hex":null,"image_url":null,"family":"Zelená"},{"name":"ROSSO POMPEIANO","hex":null,"image_url":null,"family":"Červená"}]'::jsonb,
  ARRAY['Biela', 'Červená', 'Hnedá', 'Modrá', 'Sivá', 'Zelená', 'Žltá']::text[],
  ARRAY['35 x 50 cm']::text[],
  ARRAY['Do 50 cm']::text[],
  '[]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/en/products/porcino-stool?_pos=1&_psq=Porcino&_ss=e&_v=1.0',
  'https://serralunga.com/en/products/porcino-stool?_pos=1&_psq=Porcino&_ss=e&_v=1.0',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'moderne-kvetinace' LIMIT 1),
  'Hrantik vysoký KUBE s kolieskami',
  'hrantik-vysoky-kube-s-kolieskami',
  'Euro3plast',
  32400,
  NULL,
  'Štýl je synonymom minimalizmu – dokonale zhrnutý v čistých a jednoduchých líniách našich kvetináčov a doplnkov. Skombinovali sme čisté profily s farebnou paletou pre každý vkus – od výraznej kyslej zelene a červenej po klasické odtiene – aby ste obohatili svoje obľúbené priestory harmóniou a eleganciou.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.euro3plast.com/gb/-/333-3197-kube-high.html#/332-colour-white_c2/621-significant_measure-100)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/hrantik-vysoky-kube-s-kolieskami/hrantik-vysoky-kube-s-kolieskami_1.webp',
  ARRAY['https://kochlik.netlify.app/images/hrantik-vysoky-kube-s-kolieskami/hrantik-vysoky-kube-s-kolieskami_1.webp']::text[],
  '[{"name":"WHITE C2","hex":"#ffffff","image_url":null,"family":"Biela"},{"name":"RUST","hex":"#543920","image_url":null,"family":"Hnedá"},{"name":"TAUPE","hex":"#706961","image_url":null,"family":"Hnedá"},{"name":"CEMENT","hex":"#999390","image_url":null,"family":"Sivá"},{"name":"GRANITE","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/e3p_hrantik-vysoky-kube-s-kolieskami_granite.jpg","family":"Sivá"},{"name":"LAVA","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/e3p_hrantik-vysoky-kube-s-kolieskami_lava.jpg","family":"Sivá"},{"name":"STONE","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/e3p_hrantik-vysoky-kube-s-kolieskami_stone.jpg","family":"Sivá"},{"name":"CRETA","hex":"#786e69","image_url":null,"family":"Béžová"},{"name":"PEARL BLACK","hex":"#4a4a49","image_url":null,"family":"Čierna"}]'::jsonb,
  ARRAY['Béžová', 'Biela', 'Čierna', 'Hnedá', 'Sivá']::text[],
  ARRAY['100x40x70 cm', '80x30x71 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[{"label":"100x40x70 cm","dimensions":"100x40x70 cm","price_cents":39100,"attributes":{"rozmer":"100x40x70 cm"}},{"label":"80x30x71 cm","dimensions":"80x30x71 cm","price_cents":32400,"attributes":{"rozmer":"80x30x71 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"100x40x70 cm, 80x30x71 cm"}]'::jsonb,
  '[{"label":"Technický dokument","url":"https://www.euro3plast.com/sheets/kube_high_cassetta_con_doppia_parete_+_ruote.pdf"},{"label":"Informačný dokument","url":"https://www.euro3plast.com/sheets/kube_high_plant_box_with_double_wall_+_castors_info_en.pdf"}]'::jsonb,
  'https://www.euro3plast.com/gb/-/333-3197-kube-high.html#/332-colour-white_c2/621-significant_measure-100',
  'https://www.euro3plast.com/gb/-/333-3197-kube-high.html#/332-colour-white_c2/621-significant_measure-100',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'moderne-kvetinace' LIMIT 1),
  'Kvetináč KUBE HIGH SLIM',
  'kvetinac-kube-high-slim',
  'Euro3plast',
  12000,
  NULL,
  'Štýl je synonymom minimalizmu – dokonale zhrnutý v čistých a jednoduchých líniách našich kvetináčov a doplnkov. Skombinovali sme čisté profily s farebnou paletou pre každý vkus – od výraznej kyslej zelene a červenej po klasické odtiene – aby ste obohatili svoje obľúbené priestory harmóniou a eleganciou.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.euro3plast.com/gb/-/348-3345-kube-high-slim.html#/332-colour-white_c2/623-significant_measure-25)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/kvetinac-kube-high-slim/kvetinac-kube-high-slim_1.webp',
  ARRAY['https://kochlik.netlify.app/images/kvetinac-kube-high-slim/kvetinac-kube-high-slim_1.webp']::text[],
  '[{"name":"WHITE C2","hex":"#ffffff","image_url":null,"family":"Biela"},{"name":"RUST","hex":"#543920","image_url":null,"family":"Hnedá"},{"name":"TAUPE","hex":"#706961","image_url":null,"family":"Hnedá"},{"name":"CEMENT","hex":"#999390","image_url":null,"family":"Sivá"},{"name":"GRANITE","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/e3p_kvetinac-kube-high-slim_granite.jpg","family":"Sivá"},{"name":"PEARL BLACK","hex":"#4a4a49","image_url":null,"family":"Čierna"}]'::jsonb,
  ARRAY['Biela', 'Čierna', 'Hnedá', 'Sivá']::text[],
  ARRAY['25x25x70 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[{"label":"25x25x70 cm","dimensions":"25x25x70 cm","price_cents":12000,"attributes":{"rozmer":"25x25x70 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"25x25x70 cm"}]'::jsonb,
  '[{"label":"Technický dokument","url":"https://www.euro3plast.com/sheets/kube_high_slim_vaso_con_doppia_parete.pdf"},{"label":"Informačný dokument","url":"https://www.euro3plast.com/sheets/kube_high_slim_pot_with_double_wall_info_en.pdf"}]'::jsonb,
  'https://www.euro3plast.com/gb/-/348-3345-kube-high-slim.html#/332-colour-white_c2/623-significant_measure-25',
  'https://www.euro3plast.com/gb/-/348-3345-kube-high-slim.html#/332-colour-white_c2/623-significant_measure-25',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'moderne-kvetinace' LIMIT 1),
  'Kvetináč KABIN',
  'kvetinac-kabin',
  'Serralunga',
  16300,
  NULL,
  'Kvetináč Kabin, ktorý pre značku Serralunga navrhla Luisa Bocchietto, je menším modelom z kolekcie Kabin a predstavuje archetypálny dizajnový objekt, v ktorom sa spájajú klasické geometrické tvary s jemne brúseným povrchom. Presne tvarované línie a rohy sa tu prelínajú s jemnosťou zamatového vzhľadu a čistotou zenového minimalizmu, čo robí z kvetináča Kabin elegantný a harmonický doplnok pre moderné interiéry aj exteriéry.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/en/products/kabin-planter?_pos=2&_psq=KABIN&_ss=e&_v=1.0)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/kvetinac-kabin/kvetinac-kabin_1.webp',
  ARRAY['https://kochlik.netlify.app/images/kvetinac-kabin/kvetinac-kabin_1.webp', 'https://kochlik.netlify.app/images/kvetinac-kabin/kvetinac-kabin_2.webp', 'https://kochlik.netlify.app/images/kvetinac-kabin/kvetinac-kabin_3.webp', 'https://kochlik.netlify.app/images/kvetinac-kabin/kvetinac-kabin_4.webp', 'https://kochlik.netlify.app/images/kvetinac-kabin/kvetinac-kabin_5.webp']::text[],
  '[]'::jsonb,
  ARRAY[]::text[],
  ARRAY['35x35x30cm', '45x45x39cm', '55x55x50cm']::text[],
  ARRAY['Do 50 cm', '51-100 cm']::text[],
  '[{"label":"35x35x30cm","dimensions":"35x35x30cm","price_cents":16300,"attributes":{"rozmer":"35x35x30cm"}},{"label":"45x45x39cm","dimensions":"45x45x39cm","price_cents":22100,"attributes":{"rozmer":"45x45x39cm"}},{"label":"55x55x50cm","dimensions":"55x55x50cm","price_cents":30300,"attributes":{"rozmer":"55x55x50cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"35x35x30cm, 45x45x39cm, 55x55x50cm"}]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/en/products/kabin-planter?_pos=2&_psq=KABIN&_ss=e&_v=1.0',
  'https://serralunga.com/en/products/kabin-planter?_pos=2&_psq=KABIN&_ss=e&_v=1.0',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'moderne-kvetinace' LIMIT 1),
  'Kvetináč KIAM',
  'kvetinac-kiam',
  'Euro3plast',
  16300,
  NULL,
  'Štýl je synonymom minimalizmu – dokonale zhrnutý v čistých a jednoduchých líniách našich kvetináčov a doplnkov. Skombinovali sme čisté profily s farebnou paletou pre každý vkus – od výraznej kyslej zelene a červenej po klasické odtiene – aby ste obohatili svoje obľúbené priestory harmóniou a eleganciou.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.euro3plast.com/gb/-/322-kiam.html)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/kvetinac-kiam/kvetinac-kiam_1.webp',
  ARRAY['https://kochlik.netlify.app/images/kvetinac-kiam/kvetinac-kiam_1.webp', 'https://kochlik.netlify.app/images/kvetinac-kiam/kvetinac-kiam_2.webp', 'https://kochlik.netlify.app/images/kvetinac-kiam/kvetinac-kiam_3.webp', 'https://kochlik.netlify.app/images/kvetinac-kiam/kvetinac-kiam_4.webp']::text[],
  '[{"name":"WHITE C2","hex":"#ffffff","image_url":null,"family":"Biela"},{"name":"RUST","hex":"#543920","image_url":null,"family":"Hnedá"},{"name":"PEARL BLACK","hex":"#4a4a49","image_url":null,"family":"Čierna"}]'::jsonb,
  ARRAY['Biela', 'Čierna', 'Hnedá']::text[],
  ARRAY['35x35x75 cm', '40x40x90 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[{"label":"35x35x75 cm","dimensions":"35x35x75 cm","price_cents":16300,"attributes":{"rozmer":"35x35x75 cm"}},{"label":"40x40x90 cm","dimensions":"40x40x90 cm","price_cents":21600,"attributes":{"rozmer":"40x40x90 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"35x35x75 cm, 40x40x90 cm"}]'::jsonb,
  '[{"label":"Technický dokument","url":"https://www.euro3plast.com/sheets/kiam_vaso_quadro_con_doppia_parete.pdf"},{"label":"Informačný dokument","url":"https://www.euro3plast.com/sheets/kiam_square_pot_with_double_wall_info_en.pdf"}]'::jsonb,
  'https://www.euro3plast.com/gb/-/322-kiam.html',
  'https://www.euro3plast.com/gb/-/322-kiam.html',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'nabytok' LIMIT 1),
  'Twist Box',
  'twist-box',
  'Plust',
  35000,
  NULL,
  'Kvetináč Twist je univerzálny prvok, určený na umiestnenie rastlín a menších stromov. V kombinácii so sedačkou a lavicou Twist vytvára plynulú a harmonickú kompozíciu, ktorá spája estetiku s funkčnosťou. Modulárny systém umožňuje vytvárať dynamické, sochárske zostavy, ktoré pozývajú k odpočinku aj spoločenskému kontaktu. Spojenie zakrivených a uhlových tvarov vytvára elegantný rytmický vizuálny tok, ideálny pre verejné priestory, ako sú námestia, záhrady či moderné mestské prostredia. Vďaka integrácii zelene získava projekt prirodzený charakter, pričom sa kvetináč Twist mení na plnohodnotný dizajnový systém. Dostupný je v novej textúrovanej povrchovej úprave Grain a vo farbách Z7 Red, White Light, Stone a Ground.
Rozmer
104 x 47 x 38 cm
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.plust.it/en/products/twist-box/)',
  'https://kochlik.netlify.app/images/twist-box/twist-box_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/twist-box/twist-box_1.jpg', 'https://kochlik.netlify.app/images/twist-box/twist-box_2.gif', 'https://kochlik.netlify.app/images/twist-box/twist-box_3.gif', 'https://kochlik.netlify.app/images/twist-box/twist-box_4.gif', 'https://kochlik.netlify.app/images/twist-box/twist-box_5.gif']::text[],
  '[{"name":"White light","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_u1_whitelight.jpg","family":"Biela"},{"name":"Stone","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_u4_stone.jpg","family":"Sivá"},{"name":"Ground","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_x8_ground.jpg","family":"Sivá"},{"name":"Grain","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_z6_grain.jpg","family":"Béžová"},{"name":"Red","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_z7_red.jpg","family":"Červená"}]'::jsonb,
  ARRAY['Béžová', 'Biela', 'Červená', 'Sivá']::text[],
  ARRAY['47 x 38 cm']::text[],
  ARRAY['Do 50 cm']::text[],
  '[]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb,
  'https://www.plust.it/en/products/twist-box/',
  'https://www.plust.it/en/products/twist-box/',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'moderne-kvetinace' LIMIT 1),
  'Kvetináč MEMORY POT',
  'kvetinac-memory-pot',
  'Serralunga',
  18500,
  NULL,
  'Kvetináč Memory Pot, navrhnutý Martou Daza Fernandez pre Serralunga, evokuje suchú popraskanú zem – jeho povrch má štruktúru mozaiky inšpirovanej slávnymi dielami Gaudího, čím vytvára výrazný materiálový efekt. Práve z tohto nápadu vznikla kolekcia Memory Pot v línii Serralunga 1825 garden décor. Povrch kvetináčov Memory Pot pripomína efekt craquelure na keramike – jemné prasklinky vytvárajú jedinečný mozaikový vzor, ktorý sa rozprestiera po mäkko zaoblenej siluete kvetináča. Táto verzia je dostupná aj s povrchovou úpravou Moleskin – registrovaný dizajn, ktorý dodáva výrobku šarm, teplý dotyk a elegantný charakter.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/en/products/memory-pot-planter?_pos=1&_psq=MEMORY+POT&_ss=e&_v=1.0)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/kvetinac-memory-pot/kvetinac-memory-pot_1.webp',
  ARRAY['https://kochlik.netlify.app/images/kvetinac-memory-pot/kvetinac-memory-pot_1.webp']::text[],
  '[{"name":"BIANCO","hex":null,"image_url":null,"family":"Biela"},{"name":"ANTRACITE","hex":null,"image_url":null,"family":"Sivá"},{"name":"AZZURRO DI PROVENZA","hex":null,"image_url":null,"family":"Modrá"},{"name":"ROSSO","hex":null,"image_url":null,"family":"Červená"},{"name":"SALVIA DI SARDEGNA","hex":null,"image_url":null,"family":"Zelená"},{"name":"TERRACOTTA TOSCANA","hex":null,"image_url":null,"family":"Červená"},{"name":"TERRACOTTA SCURA","hex":null,"image_url":null,"family":"Červená"},{"name":"TORTORA DI TORINO","hex":null,"image_url":null,"family":"Hnedá"},{"name":"VERDE PAVONE","hex":null,"image_url":null,"family":"Zelená"},{"name":"GIALLO SAHARA","hex":null,"image_url":null,"family":"Žltá"},{"name":"VERDE BRITISH","hex":null,"image_url":null,"family":"Zelená"},{"name":"ROSSO POMPEIANO","hex":null,"image_url":null,"family":"Červená"}]'::jsonb,
  ARRAY['Biela', 'Červená', 'Hnedá', 'Modrá', 'Sivá', 'Zelená', 'Žltá']::text[],
  ARRAY['49x43 cm', '62x80 cm']::text[],
  ARRAY['Do 50 cm', '51-100 cm']::text[],
  '[{"label":"49x43 cm","dimensions":"49x43 cm","price_cents":18500,"attributes":{"rozmer":"49x43 cm"}},{"label":"62x80 cm","dimensions":"62x80 cm","price_cents":37600,"attributes":{"rozmer":"62x80 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"49×43 cm, 62×80 cm"}]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/en/products/memory-pot-planter?_pos=1&_psq=MEMORY+POT&_ss=e&_v=1.0',
  'https://serralunga.com/en/products/memory-pot-planter?_pos=1&_psq=MEMORY+POT&_ss=e&_v=1.0',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'dizajnove' LIMIT 1),
  'Kvetináč Pisa',
  'kvetinac-pisa',
  'Serralunga',
  23000,
  NULL,
  'Kvetináč Pisa, navrhnutý Denisom Santachiarom pre Serralunga, je originálnym dizajnovým dielom, ktoré prevracia tradičné vnímanie rovnováhy. Zatiaľ čo kvetináč Santavase ostáva rovný aj na šikmom teréne, Pisa naopak – aj na rovnom povrchu sa nakláňa, čím vytvára zámerne asymetrický efekt. Rastlina rastie kolmo nahor, no samotný kvetináč si zachováva svoju jedinečnú formálnu identitu vďaka hornému okraju, ktorý nie je rovnobežný so zemou. Zvyšok tvaru je zámerne minimalistický, no práve táto jediná šikmá línia robí z modelu Pisa rozpoznateľný a ikonický objekt moderného dizajnu.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/en/products/pisa-planter?_pos=1&_psq=Pisa&_ss=e&_v=1.0)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/kvetinac-pisa/kvetinac-pisa_1.webp',
  ARRAY['https://kochlik.netlify.app/images/kvetinac-pisa/kvetinac-pisa_1.webp', 'https://kochlik.netlify.app/images/kvetinac-pisa/kvetinac-pisa_2.webp']::text[],
  '[{"name":"ANTRACITE","hex":null,"image_url":null,"family":"Sivá"},{"name":"ROSSO","hex":null,"image_url":null,"family":"Červená"},{"name":"BIANCO","hex":null,"image_url":null,"family":"Biela"},{"name":"NEVE DI SAN CANDIDO","hex":null,"image_url":null,"family":"Biela"},{"name":"SALVIA DI SARDEGNA","hex":null,"image_url":null,"family":"Zelená"},{"name":"TERRACOTTA SCURA","hex":null,"image_url":null,"family":"Červená"},{"name":"TORTORA DI TORINO","hex":null,"image_url":null,"family":"Hnedá"},{"name":"GIALLO SAHARA","hex":null,"image_url":null,"family":"Žltá"},{"name":"VERDE BRITISH","hex":null,"image_url":null,"family":"Zelená"},{"name":"ROSSO POMPEIANO","hex":null,"image_url":null,"family":"Červená"}]'::jsonb,
  ARRAY['Biela', 'Červená', 'Hnedá', 'Sivá', 'Zelená', 'Žltá']::text[],
  ARRAY['51x51x58 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[{"label":"51x51x58 cm","dimensions":"51x51x58 cm","price_cents":23000,"attributes":{"rozmer":"51x51x58 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"51x51x58 cm"}]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/en/products/pisa-planter?_pos=1&_psq=Pisa&_ss=e&_v=1.0',
  'https://serralunga.com/en/products/pisa-planter?_pos=1&_psq=Pisa&_ss=e&_v=1.0',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'nabytok' LIMIT 1),
  'Konferenčný stolík Fade',
  'konferencny-stolik-fade-hpl',
  'Plust',
  26000,
  NULL,
  'Tento odkladací stolík s jemnými líniami má jedinečný pruhovaný povrch a špeciálne povrchové úpravy pripomínajúce prírodné materiály. V bielej svietiacej verzii je možné stolík vybaviť špeciálnou svetelnou sadou pre pôsobivý efekt osvetlenia.
Rozmer
71 x 71 x 33 cm
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.plust.it/en/products/fade-coffee-table/)',
  'https://kochlik.netlify.app/images/konferencny-stolik-fade-hpl/konferencny-stolik-fade-hpl_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/konferencny-stolik-fade-hpl/konferencny-stolik-fade-hpl_1.jpg', 'https://kochlik.netlify.app/images/konferencny-stolik-fade-hpl/konferencny-stolik-fade-hpl_2.jpg', 'https://kochlik.netlify.app/images/konferencny-stolik-fade-hpl/konferencny-stolik-fade-hpl_3.jpg', 'https://kochlik.netlify.app/images/konferencny-stolik-fade-hpl/konferencny-stolik-fade-hpl_4.jpg']::text[],
  '[{"name":"Granite","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_s4_granite.jpg","family":"Sivá"},{"name":"Lava","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_u0_lava.jpg","family":"Sivá"},{"name":"Stone","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_u4_stone.jpg","family":"Sivá"},{"name":"Creta","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_v7_creta.jpg","family":"Béžová"},{"name":"White light","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_u1_whitelight.jpg","family":"Biela"}]'::jsonb,
  ARRAY['Béžová', 'Biela', 'Sivá']::text[],
  ARRAY['71 x 33 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb,
  'https://www.plust.it/en/products/fade-coffee-table/',
  'https://www.plust.it/en/products/fade-coffee-table/',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'nabytok' LIMIT 1),
  'Kreslo Kubrick',
  'kreslo-kubrick',
  'Serralunga',
  79000,
  NULL,
  'Kubrick je dizajnové kreslo, ktoré navrhol Marc Sadler pre Serralunga. „Elegantný, športový a moderný kúsok nábytku,“ Kubrick sa ľahko prispôsobí akémukoľvek prostrediu vďaka kontrastu medzi klasickým štýlom a rozmanitosťou použitých materiálov. Navrhnuté ako vonkajší aj interiérový dizajnový prvok, stelesňuje všestrannosť ako základný koncept. Dostupné je aj vo verzii hojdacieho kresla, bazénového modelu alebo ako osvetlené kreslo/sofa, ktoré dodá priestoru jedinečný vizuálny efekt.
Rozmer
64 x 62 x 72 cm
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/en/products/kubrick-armchair?_pos=1&_psq=Kubrick&_ss=e&_v=1.0)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/kreslo-kubrick/kreslo-kubrick_1.webp',
  ARRAY['https://kochlik.netlify.app/images/kreslo-kubrick/kreslo-kubrick_1.webp', 'https://kochlik.netlify.app/images/kreslo-kubrick/kreslo-kubrick_2.webp', 'https://kochlik.netlify.app/images/kreslo-kubrick/kreslo-kubrick_3.webp']::text[],
  '[{"name":"NERO","hex":null,"image_url":null,"family":"Čierna"},{"name":"ROSSO","hex":null,"image_url":null,"family":"Červená"},{"name":"BIANCO","hex":null,"image_url":null,"family":"Biela"},{"name":"ANTRACITE","hex":null,"image_url":null,"family":"Sivá"},{"name":"AZZURRO DI PROVENZA","hex":null,"image_url":null,"family":"Modrá"},{"name":"LACQUEROSSO BIANCO","hex":null,"image_url":null,"family":"Biela"},{"name":"SALVIA DI SARDEGNA","hex":null,"image_url":null,"family":"Zelená"},{"name":"TORTORA DI TORINO","hex":null,"image_url":null,"family":"Hnedá"},{"name":"VERDE PAVONE","hex":null,"image_url":null,"family":"Zelená"},{"name":"GIALLO SAHARA","hex":null,"image_url":null,"family":"Žltá"},{"name":"VERDE BRITISH","hex":null,"image_url":null,"family":"Zelená"},{"name":"ROSSO POMPEIANO","hex":null,"image_url":null,"family":"Červená"}]'::jsonb,
  ARRAY['Biela', 'Červená', 'Čierna', 'Hnedá', 'Modrá', 'Sivá', 'Zelená', 'Žltá']::text[],
  ARRAY['62 x 72 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/en/products/kubrick-armchair?_pos=1&_psq=Kubrick&_ss=e&_v=1.0',
  'https://serralunga.com/en/products/kubrick-armchair?_pos=1&_psq=Kubrick&_ss=e&_v=1.0',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'moderne-kvetinace' LIMIT 1),
  'Kvetináč KIAM GLOSS',
  'kvetinac-kiam-gloss',
  'Euro3plast',
  8300,
  NULL,
  'Lesklé povrchy a žiarivé farby sú výrazným prvkom kolekcie Style Gloss – moderná línia s mladistvým, no výrazným charakterom. Kvetináče nie sú dodatočne glazované; vyrábajú sa priamo v lesklej farebnej verzii, pripravené ozdobiť každý priestor svojou jedinečnou osobitosťou.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.euro3plast.com/gb/-/329-kiam.html)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/kvetinac-kiam-gloss/kvetinac-kiam-gloss_1.webp',
  ARRAY['https://kochlik.netlify.app/images/kvetinac-kiam-gloss/kvetinac-kiam-gloss_1.webp']::text[],
  '[{"name":"WHITE C2","hex":"#ffffff","image_url":null,"family":"Biela"}]'::jsonb,
  ARRAY['Biela']::text[],
  ARRAY['30x30x67 cm', '35x35x75 cm', '40x40x90 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[{"label":"30x30x67 cm","dimensions":"30x30x67 cm","price_cents":8300,"attributes":{"rozmer":"30x30x67 cm"}},{"label":"35x35x75 cm","dimensions":"35x35x75 cm","price_cents":14600,"attributes":{"rozmer":"35x35x75 cm"}},{"label":"40x40x90 cm","dimensions":"40x40x90 cm","price_cents":20900,"attributes":{"rozmer":"40x40x90 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"30x30x67 cm, 35x35x75 cm, 40x40x90 cm"}]'::jsonb,
  '[{"label":"Technický dokument","url":"https://www.euro3plast.com/sheets/kiam_vaso_gloss_quadro_con_doppia_parete.pdf"},{"label":"Informačný dokument","url":"https://www.euro3plast.com/sheets/kiam_gloss_square_pot_with_double_wall_info_en.pdf"}]'::jsonb,
  'https://www.euro3plast.com/gb/-/329-kiam.html',
  'https://www.euro3plast.com/gb/-/329-kiam.html',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'nabytok' LIMIT 1),
  'Konferenčný stolík Meteor',
  'konferencny-stolik-meteor',
  'Serralunga',
  29000,
  NULL,
  'Kolekcia Meteor, ktorú pre Serralunga navrhol Arik Levy, predstavuje akýsi „mimozemský“ prvok interiérového a exteriérového dizajnu – objekt, ktorý akoby spadol z neba na Zem. Ide o reinterpretáciu prírodného kameňa, bežne sa vyskytujúceho v krajine, ktorý bol pretvorený na súčasný dizajnový objekt určený pre domáce aj mestské prostredie. Meteor možno využiť ako neformálnu záhradnú lavicu – dostupnú v rôznych verziách a veľkostiach, ideálnu na zariadenie exteriérových priestorov, záhrad či terás, a to aj vo veľkých plochách. Tvarovo ide o facettované formy, ktoré podľa slov autora „evokujú kryštály aj úlomky skál opracovaných ľudskou rukou“ („Ces formes facettées qui évoquent à la fois des cristaux et des fragments de roche taillés par la main humaine“ – Arik Levy). Meteor spája umenie, prírodu a dizajn, čím prináša do priestoru sochársky a zároveň funkčný prvok – ikonický doplnok moderného vonkajšieho bývania.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/en/products/meteor-coffee-table?_pos=2&_psq=Meteor&_ss=e&_v=1.0)',
  'https://kochlik.netlify.app/images/konferencny-stolik-meteor/konferencny-stolik-meteor_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/konferencny-stolik-meteor/konferencny-stolik-meteor_1.jpg', 'https://kochlik.netlify.app/images/konferencny-stolik-meteor/konferencny-stolik-meteor_2.webp', 'https://kochlik.netlify.app/images/konferencny-stolik-meteor/konferencny-stolik-meteor_3.jpg']::text[],
  '[{"name":"BIANCO","hex":null,"image_url":null,"family":"Biela"},{"name":"ANTRACITE","hex":null,"image_url":null,"family":"Sivá"},{"name":"MORE DI ROVO","hex":null,"image_url":null,"family":"Ružová"},{"name":"TORTORA DI TORINO","hex":null,"image_url":null,"family":"Hnedá"},{"name":"VERDE PAVONE","hex":null,"image_url":null,"family":"Zelená"},{"name":"ACQUA DELLA MADDALENA","hex":null,"image_url":null,"family":"Modrá"},{"name":"AZZURRO DI PROVENZA","hex":null,"image_url":null,"family":"Modrá"},{"name":"LACQUEROSSO BIANCO","hex":null,"image_url":null,"family":"Biela"},{"name":"ROSSO","hex":null,"image_url":null,"family":"Červená"},{"name":"TERRACOTTA SCURA","hex":null,"image_url":null,"family":"Červená"},{"name":"SALVIA DI SARDEGNA","hex":null,"image_url":null,"family":"Zelená"},{"name":"GIALLO SAHARA","hex":null,"image_url":null,"family":"Žltá"},{"name":"VERDE BRITISH","hex":null,"image_url":null,"family":"Zelená"},{"name":"ROSSO POMPEIANO","hex":null,"image_url":null,"family":"Červená"}]'::jsonb,
  ARRAY['Biela', 'Červená', 'Hnedá', 'Modrá', 'Ružová', 'Sivá', 'Zelená', 'Žltá']::text[],
  ARRAY['117x69x34 cm', '57x50x30 cm', '87x52x32 cm']::text[],
  ARRAY['51-100 cm', '101-150 cm']::text[],
  '[{"label":"117x69x34 cm","dimensions":"117x69x34 cm","price_cents":62000,"attributes":{"rozmer":"117x69x34 cm"}},{"label":"57x50x30 cm","dimensions":"57x50x30 cm","price_cents":29000,"attributes":{"rozmer":"57x50x30 cm"}},{"label":"87x52x32 cm","dimensions":"87x52x32 cm","price_cents":40000,"attributes":{"rozmer":"87x52x32 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"117x69x34 cm, 57x50x30 cm, 87x52x32 cm"}]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/en/products/meteor-coffee-table?_pos=2&_psq=Meteor&_ss=e&_v=1.0',
  'https://serralunga.com/en/products/meteor-coffee-table?_pos=2&_psq=Meteor&_ss=e&_v=1.0',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'klasicke-kvetinace' LIMIT 1),
  'Nádoba ETRUSCA',
  'nadoba-etrusca',
  'Euro3plast',
  15800,
  NULL,
  'Kolekcia Style je elegantná a nadčasová: tieto kvetináče a dekorácie s klasickým šarmom dodajú záhradám a terasám sofistikovaný vzhľad a po prvom použití sa stanú nepostrádateľné. Dokonale dopĺňajú priestory, ktoré sa rady nechávajú obdivovať.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.euro3plast.com/gb/indoor-pots/361-etrusca.html)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/nadoba-etrusca/nadoba-etrusca_1.webp',
  ARRAY['https://kochlik.netlify.app/images/nadoba-etrusca/nadoba-etrusca_1.webp']::text[],
  '[{"name":"WHITE","hex":"#ffffff","image_url":null,"family":"Biela"}]'::jsonb,
  ARRAY['Biela']::text[],
  ARRAY['38x42 cm', '48x54 cm', '61x71 cm']::text[],
  ARRAY['Do 50 cm', '51-100 cm']::text[],
  '[{"label":"38x42 cm","dimensions":"38x42 cm","price_cents":15800,"attributes":{"rozmer":"38x42 cm"}},{"label":"48x54 cm","dimensions":"48x54 cm","price_cents":20300,"attributes":{"rozmer":"48x54 cm"}},{"label":"61x71 cm","dimensions":"61x71 cm","price_cents":30400,"attributes":{"rozmer":"61x71 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"38×42 cm, 48×54 cm, 61×71 cm"}]'::jsonb,
  '[{"label":"Technický dokument","url":"https://www.euro3plast.com/sheets/etrusca_fioriera.pdf"},{"label":"Informačný dokument","url":"https://www.euro3plast.com/sheets/etrusca_vase_info_en.pdf"}]'::jsonb,
  'https://www.euro3plast.com/gb/indoor-pots/361-etrusca.html',
  'https://www.euro3plast.com/gb/indoor-pots/361-etrusca.html',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'dizajnove' LIMIT 1),
  'Kvetináč MARCANTONIO',
  'kvetinac-marcantonio',
  'Serralunga',
  26700,
  NULL,
  'Marcantonio je rad kvetináčov Serralunga 1825 – nadrozmerný valcový kvetináč s proporčne štíhlym tvarom. Vďaka intenzívnemu emocionálnemu účinku sa hodí na dekoráciu záhrady. Ľahko sa umiestňuje, pretože na zemi zaberá málo miesta; dá sa použiť ako obal na kvetináč, na priame sadenie a tiež – vo verzii so svetlom – na hydroponické pestovanie. Je dostupný v troch veľkostiach a existuje aj nástenná verzia „Au Mur“.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/en/products/marcantonio-planter?_pos=1&_psq=MARCANTONIO&_ss=e&_v=1.0)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/kvetinac-marcantonio/kvetinac-marcantonio_1.webp',
  ARRAY['https://kochlik.netlify.app/images/kvetinac-marcantonio/kvetinac-marcantonio_1.webp']::text[],
  '[{"name":"ANTRACITE","hex":null,"image_url":null,"family":"Sivá"},{"name":"PIETRA DELLA DOLOMITI","hex":null,"image_url":null,"family":"Sivá"},{"name":"SALVIA DI SARDEGNA","hex":null,"image_url":null,"family":"Zelená"},{"name":"TORTORA DI TORINO","hex":null,"image_url":null,"family":"Hnedá"},{"name":"BIANCO","hex":null,"image_url":null,"family":"Biela"},{"name":"VERDE PAVONE","hex":null,"image_url":null,"family":"Zelená"},{"name":"AZZURRO DI PROVENZA","hex":null,"image_url":null,"family":"Modrá"},{"name":"ROSSO","hex":null,"image_url":null,"family":"Červená"},{"name":"TERRACOTTA TOSCANA","hex":null,"image_url":null,"family":"Červená"},{"name":"TERRACOTTA SCURA","hex":null,"image_url":null,"family":"Červená"},{"name":"OLIVE DI CERIGNOLA","hex":null,"image_url":null,"family":"Zelená"},{"name":"GIALLO SAHARA","hex":null,"image_url":null,"family":"Žltá"},{"name":"VERDE BRITISH","hex":null,"image_url":null,"family":"Zelená"},{"name":"ROSSO POMPEIANO","hex":null,"image_url":null,"family":"Červená"}]'::jsonb,
  ARRAY['Biela', 'Červená', 'Hnedá', 'Modrá', 'Sivá', 'Zelená', 'Žltá']::text[],
  ARRAY['39x39x90 cm', '50x50x120 cm', '63x63x150 cm']::text[],
  ARRAY['51-100 cm', '101-150 cm']::text[],
  '[{"label":"39x39x90 cm","dimensions":"39x39x90 cm","price_cents":26700,"attributes":{"rozmer":"39x39x90 cm"}},{"label":"50x50x120 cm","dimensions":"50x50x120 cm","price_cents":31000,"attributes":{"rozmer":"50x50x120 cm"}},{"label":"63x63x150 cm","dimensions":"63x63x150 cm","price_cents":43200,"attributes":{"rozmer":"63x63x150 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"39x39x90 cm, 50x50x120 cm, 63x63x150 cm"}]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/en/products/marcantonio-planter?_pos=1&_psq=MARCANTONIO&_ss=e&_v=1.0',
  'https://serralunga.com/en/products/marcantonio-planter?_pos=1&_psq=MARCANTONIO&_ss=e&_v=1.0',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'dizajnove' LIMIT 1),
  'Kvetináč VASES',
  'kvetinac-vases',
  'Serralunga',
  125000,
  NULL,
  'Kvetináč Vases, navrhnutý Ronom Aradom pre Serralunga, je skutočnou sochárskou interpretáciou morského dna. Je tvorený piatimi kužeľmi s rôznymi textúrami, ktoré spolu vytvárajú organický a dynamický tvar. Tieto veľkoformátové kvetináče sú vyrobené z lineárneho nízkohustotného polyetylénu (LLDPE) pomocou rotačného tvarovania, čo im zaručuje pevnosť, ľahkosť a odolnosť voči poveternostným vplyvom. Model Vases spája umenie, dizajn a funkčnosť, čím sa stáva výrazným prvkom moderných záhrad a architektonických priestorov.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/en/products/the-vases-planter?_pos=1&_psq=VASES&_ss=e&_v=1.0)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/kvetinac-vases/kvetinac-vases_1.webp',
  ARRAY['https://kochlik.netlify.app/images/kvetinac-vases/kvetinac-vases_1.webp', 'https://kochlik.netlify.app/images/kvetinac-vases/kvetinac-vases_2.webp', 'https://kochlik.netlify.app/images/kvetinac-vases/kvetinac-vases_3.webp']::text[],
  '[{"name":"NERO","hex":null,"image_url":null,"family":"Čierna"},{"name":"BIANCO","hex":null,"image_url":null,"family":"Biela"},{"name":"ANTRACITE","hex":null,"image_url":null,"family":"Sivá"},{"name":"ROSSO","hex":null,"image_url":null,"family":"Červená"},{"name":"TORTORA DI TORINO","hex":null,"image_url":null,"family":"Hnedá"}]'::jsonb,
  ARRAY['Biela', 'Červená', 'Čierna', 'Hnedá', 'Sivá']::text[],
  ARRAY['80x63x110 cm']::text[],
  ARRAY['101-150 cm']::text[],
  '[{"label":"80x63x110 cm","dimensions":"80x63x110 cm","price_cents":125000,"attributes":{"rozmer":"80x63x110 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"80x63x110 cm"}]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/en/products/the-vases-planter?_pos=1&_psq=VASES&_ss=e&_v=1.0',
  'https://serralunga.com/en/products/the-vases-planter?_pos=1&_psq=VASES&_ss=e&_v=1.0',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'klasicke-kvetinace' LIMIT 1),
  'Kvetináč DOPPIO BORDO – e3p',
  'kvetinac-doppio-bordo-e3p',
  'Euro3plast',
  5600,
  NULL,
  'Kolekcia Style je elegantná a nadčasová: tieto nadčasové kvetináče a doplnky dodajú šarm záhradám, ktoré si zaslúžia obdiv. V duchu čisto talianskej tradície ponúka širokú škálu veľkostí a vkusne klasických dekorácií, ktoré sa po prvom vzhliadnutí stanú nepostrádateľnými.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.euro3plast.com/gb/-/307-doppio-bordo.html)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/kvetinac-doppio-bordo-e3p/kvetinac-doppio-bordo-e3p_1.webp',
  ARRAY['https://kochlik.netlify.app/images/kvetinac-doppio-bordo-e3p/kvetinac-doppio-bordo-e3p_1.webp', 'https://kochlik.netlify.app/images/kvetinac-doppio-bordo-e3p/kvetinac-doppio-bordo-e3p_2.webp']::text[],
  '[{"name":"TERRA DI SIENA","hex":"#e3945b","image_url":null,"family":"Červená"}]'::jsonb,
  ARRAY['Červená']::text[],
  ARRAY['35x32 cm', '42x37 cm', '45x40 cm', '51x44 cm', '55x47 cm', '60x51 cm', '65x56 cm', '77x61 cm', '85x68 cm']::text[],
  ARRAY['Do 50 cm', '51-100 cm']::text[],
  '[{"label":"35x32 cm","dimensions":"35x32 cm","price_cents":5600,"attributes":{"rozmer":"35x32 cm"}},{"label":"42x37 cm","dimensions":"42x37 cm","price_cents":8000,"attributes":{"rozmer":"42x37 cm"}},{"label":"45x40 cm","dimensions":"45x40 cm","price_cents":8400,"attributes":{"rozmer":"45x40 cm"}},{"label":"51x44 cm","dimensions":"51x44 cm","price_cents":9300,"attributes":{"rozmer":"51x44 cm"}},{"label":"55x47 cm","dimensions":"55x47 cm","price_cents":10800,"attributes":{"rozmer":"55x47 cm"}},{"label":"60x51 cm","dimensions":"60x51 cm","price_cents":11100,"attributes":{"rozmer":"60x51 cm"}},{"label":"65x56 cm","dimensions":"65x56 cm","price_cents":12100,"attributes":{"rozmer":"65x56 cm"}},{"label":"77x61 cm","dimensions":"77x61 cm","price_cents":18800,"attributes":{"rozmer":"77x61 cm"}},{"label":"85x68 cm","dimensions":"85x68 cm","price_cents":28700,"attributes":{"rozmer":"85x68 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"35×32 cm, 42×37 cm, 45×40 cm, 51×44 cm, 55×47 cm, 60×51 cm, 65×56 cm, 77×61 cm, 85×68 cm"}]'::jsonb,
  '[{"label":"Technický dokument","url":"https://www.euro3plast.com/sheets/doppio_bordo_vaso.pdf"},{"label":"Informačný dokument","url":"https://www.euro3plast.com/sheets/doppio_bordo_pot_info_en.pdf"}]'::jsonb,
  'https://www.euro3plast.com/gb/-/307-doppio-bordo.html',
  'https://www.euro3plast.com/gb/-/307-doppio-bordo.html',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'klasicke-kvetinace' LIMIT 1),
  'Kvetináč Millerighe Alto',
  'kvetinac-millerighe-alto',
  'Serralunga',
  13300,
  NULL,
  'Kvetináč Millerighe Alto od Serralunga je nadčasová klasika. O jeho výnimočnosti rozhoduje farba – jemné tón v tóne odtiene a výrazné farebné akcenty vytvárajú nečakané, harmonické kombinácie. Kolekcia Millerighe patrí do línie Serralunga garden décor a predstavuje elegantné riešenie pre moderné aj tradičné záhrady.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/en/products/millerighe-alto-planter?_pos=1&_psq=Millerighe+Alto&_ss=e&_v=1.0)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/kvetinac-millerighe-alto/kvetinac-millerighe-alto_1.webp',
  ARRAY['https://kochlik.netlify.app/images/kvetinac-millerighe-alto/kvetinac-millerighe-alto_1.webp']::text[],
  '[{"name":"TORTORA DI TORINO","hex":null,"image_url":null,"family":"Hnedá"},{"name":"TERRACOTTA TOSCANA","hex":null,"image_url":null,"family":"Červená"},{"name":"PIETRA DELLE DOLOMITI","hex":null,"image_url":null,"family":"Sivá"},{"name":"ANTRACITE","hex":null,"image_url":null,"family":"Sivá"},{"name":"AZZURRO DI PROVENZA","hex":null,"image_url":null,"family":"Modrá"},{"name":"ROSSO","hex":null,"image_url":null,"family":"Červená"},{"name":"SALVIA DI SARDEGNA","hex":null,"image_url":null,"family":"Zelená"},{"name":"TERRACOTTA SCURA","hex":null,"image_url":null,"family":"Červená"},{"name":"BIANCO","hex":null,"image_url":null,"family":"Biela"},{"name":"VERDE PAVONE","hex":null,"image_url":null,"family":"Zelená"},{"name":"GIALLO SAHARA","hex":null,"image_url":null,"family":"Žltá"},{"name":"VERDE BRITISH","hex":null,"image_url":null,"family":"Zelená"},{"name":"ROSSO POMPEIANO","hex":null,"image_url":null,"family":"Červená"}]'::jsonb,
  ARRAY['Biela', 'Červená', 'Hnedá', 'Modrá', 'Sivá', 'Zelená', 'Žltá']::text[],
  ARRAY['42x42x59 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[{"label":"42x42x59 cm","dimensions":"42x42x59 cm","price_cents":13300,"attributes":{"rozmer":"42x42x59 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"42x42x59 cm"}]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/en/products/millerighe-alto-planter?_pos=1&_psq=Millerighe+Alto&_ss=e&_v=1.0',
  'https://serralunga.com/en/products/millerighe-alto-planter?_pos=1&_psq=Millerighe+Alto&_ss=e&_v=1.0',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'klasicke-kvetinace' LIMIT 1),
  'Hrantík CASSETTA FOGLIATA',
  'hrantik-cassetta-fogliata',
  'Serralunga',
  7900,
  NULL,
  'Hrantík Cassetta Fogliata od značky Serralunga predstavuje nadčasový dizajn, ktorý si zachováva svoju pôvodnú krásu – a dnes ešte viac vyniká. Vďaka kombinácii jemných pastorálnych farieb vytvára novú vidiecku atmosféru, ktorá sa nesie na pomedzí anglickej záhrady a talianskeho vidieka. Jeho nová, prekvapivá povrchová úprava prináša pôvab nečakaného a odhaľuje kryštalickú krásu starobylých kvetináčov, čím dodáva priestoru autentickosť a noblesu.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/en/products/decorati-cassetta-fogliata-planter?_pos=1&_psq=CASSETTA+FOGLIATA&_ss=e&_v=1.0)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/hrantik-cassetta-fogliata/hrantik-cassetta-fogliata_1.webp',
  ARRAY['https://kochlik.netlify.app/images/hrantik-cassetta-fogliata/hrantik-cassetta-fogliata_1.webp']::text[],
  '[{"name":"TORTORA DI TORINO","hex":null,"image_url":null,"family":"Hnedá"},{"name":"TERRACOTTA TOSCANA","hex":null,"image_url":null,"family":"Červená"},{"name":"GESSO DI BOLOGNA","hex":null,"image_url":null,"family":"Biela"},{"name":"ANTRACITE","hex":null,"image_url":null,"family":"Sivá"},{"name":"AZZURRO DI PROVENZA","hex":null,"image_url":null,"family":"Modrá"},{"name":"ROSSO","hex":null,"image_url":null,"family":"Červená"},{"name":"SALVIA DI SARDEGNA","hex":null,"image_url":null,"family":"Zelená"},{"name":"TERRACOTTA SCURA","hex":null,"image_url":null,"family":"Červená"},{"name":"VERDE PAVONE","hex":null,"image_url":null,"family":"Zelená"},{"name":"PIETRA DELLA DOLOMITI","hex":null,"image_url":null,"family":"Sivá"},{"name":"BIANCO","hex":null,"image_url":null,"family":"Biela"},{"name":"GIALLO SAHARA","hex":null,"image_url":null,"family":"Žltá"},{"name":"VERDE BRITISH","hex":null,"image_url":null,"family":"Zelená"},{"name":"ROSSO POMPEIANO","hex":null,"image_url":null,"family":"Červená"}]'::jsonb,
  ARRAY['Biela', 'Červená', 'Hnedá', 'Modrá', 'Sivá', 'Zelená', 'Žltá']::text[],
  ARRAY['51,5x19,5x18,5 cm', '60x30x27 cm', '70x32x28,5 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[{"label":"51,5x19,5x18,5 cm","dimensions":"51,5x19,5x18,5 cm","price_cents":7900,"attributes":{"rozmer":"51,5x19,5x18,5 cm"}},{"label":"60x30x27 cm","dimensions":"60x30x27 cm","price_cents":8400,"attributes":{"rozmer":"60x30x27 cm"}},{"label":"70x32x28,5 cm","dimensions":"70x32x28,5 cm","price_cents":11400,"attributes":{"rozmer":"70x32x28,5 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"51,5×19,5×18,5 cm, 60x30x27 cm, 70x32x28,5 cm"}]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/en/products/decorati-cassetta-fogliata-planter?_pos=1&_psq=CASSETTA+FOGLIATA&_ss=e&_v=1.0',
  'https://serralunga.com/en/products/decorati-cassetta-fogliata-planter?_pos=1&_psq=CASSETTA+FOGLIATA&_ss=e&_v=1.0',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'moderne-kvetinace' LIMIT 1),
  'Kvetináč Cup malý',
  'kvetinac-cup-maly',
  'Serralunga',
  14600,
  NULL,
  'Kolekcia Cup zahŕňa sériu kvetináčov inšpirovaných nadčasovými tvarmi, pripomínajúcimi precízne vyrezávané drevené misy. Vďaka čistým líniám a minimalistickému dizajnu vyžarujú klasickú eleganciu a harmonicky dopĺňajú akýkoľvek priestor. Dizajn od Naota Fukasawu pre značku Serralunga robí z kolekcie Cup ideálny doplnok vonkajšieho nábytku a moderných exteriérov. Model Cup Small je najmenším kvetináčom z celej kolekcie. Vyrobené z ľahkého, no odolného polyetylénu, tvarovaného technológiou rotačného liatia. Poskytuje UV ochranu, je 100 % recyklovateľné a farbené v hmote.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/en/products/cup-small-planter?_pos=3&_psq=Cup&_ss=e&_v=1.0)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/kvetinac-cup-maly/kvetinac-cup-maly_1.webp',
  ARRAY['https://kochlik.netlify.app/images/kvetinac-cup-maly/kvetinac-cup-maly_1.webp', 'https://kochlik.netlify.app/images/kvetinac-cup-maly/kvetinac-cup-maly_2.webp', 'https://kochlik.netlify.app/images/kvetinac-cup-maly/kvetinac-cup-maly_3.webp']::text[],
  '[{"name":"BIANCO","hex":null,"image_url":null,"family":"Biela"},{"name":"TORTORA DI TORINO","hex":null,"image_url":null,"family":"Hnedá"},{"name":"ANTRACITE","hex":null,"image_url":null,"family":"Sivá"},{"name":"AZZURRO DI PROVENZA","hex":null,"image_url":null,"family":"Modrá"},{"name":"ACQUA DELLA MADDALENA","hex":null,"image_url":null,"family":"Modrá"},{"name":"SALVIA DI SARDEGNA","hex":null,"image_url":null,"family":"Zelená"},{"name":"ROSSO","hex":null,"image_url":null,"family":"Červená"},{"name":"TERRACOTTA TOSCANA","hex":null,"image_url":null,"family":"Červená"},{"name":"TERRACOTTA SCURA","hex":null,"image_url":null,"family":"Červená"},{"name":"VERDE OLIVE DI CERIGNOLA","hex":null,"image_url":null,"family":"Zelená"},{"name":"VERDE PAVONE","hex":null,"image_url":null,"family":"Zelená"},{"name":"NEVE DI SAN CANDIDO","hex":null,"image_url":null,"family":"Biela"},{"name":"GIALLO SAHARA","hex":null,"image_url":null,"family":"Žltá"},{"name":"VERDE BRITISH","hex":null,"image_url":null,"family":"Zelená"},{"name":"ROSSO POMPEIANO","hex":null,"image_url":null,"family":"Červená"}]'::jsonb,
  ARRAY['Biela', 'Červená', 'Hnedá', 'Modrá', 'Sivá', 'Zelená', 'Žltá']::text[],
  ARRAY['47x47x25 cm']::text[],
  ARRAY['Do 50 cm']::text[],
  '[{"label":"47x47x25 cm","dimensions":"47x47x25 cm","price_cents":14600,"attributes":{"rozmer":"47x47x25 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"47x47x25 cm"}]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/en/products/cup-small-planter?_pos=3&_psq=Cup&_ss=e&_v=1.0',
  'https://serralunga.com/en/products/cup-small-planter?_pos=3&_psq=Cup&_ss=e&_v=1.0',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'klasicke-kvetinace' LIMIT 1),
  'Kvetináč ORNAMENTOVÝ',
  'kvetinac-ornamentovy',
  'Euro3plast',
  40700,
  NULL,
  'Kolekcia Style je elegantná a nadčasová: tieto kvetináče a dekorácie s klasickým šarmom dodajú záhradám a terasám sofistikovaný vzhľad a po prvom použití sa stanú nepostrádateľné. Dokonale dopĺňajú priestory, ktoré sa rady nechávajú obdivovať.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.euro3plast.com/gb/products/399-ornato.html)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/kvetinac-ornamentovy/kvetinac-ornamentovy_1.webp',
  ARRAY['https://kochlik.netlify.app/images/kvetinac-ornamentovy/kvetinac-ornamentovy_1.webp']::text[],
  '[{"name":"WHITE C2","hex":"#ffffff","image_url":null,"family":"Biela"},{"name":"TERRA DI SIENA","hex":"#e3945b","image_url":null,"family":"Červená"}]'::jsonb,
  ARRAY['Biela', 'Červená']::text[],
  ARRAY['102x78 cm', '114x88 cm', '150x115 cm', '87x67 cm']::text[],
  ARRAY['51-100 cm', '101-150 cm']::text[],
  '[{"label":"102x78 cm","dimensions":"102x78 cm","price_cents":56900,"attributes":{"rozmer":"102x78 cm"}},{"label":"114x88 cm","dimensions":"114x88 cm","price_cents":96200,"attributes":{"rozmer":"114x88 cm"}},{"label":"150x115 cm","dimensions":"150x115 cm","price_cents":117300,"attributes":{"rozmer":"150x115 cm"}},{"label":"87x67 cm","dimensions":"87x67 cm","price_cents":40700,"attributes":{"rozmer":"87x67 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"102×78 cm, 114×88 cm, 150×115 cm, 87×67 cm"}]'::jsonb,
  '[{"label":"Technický dokument","url":"https://www.euro3plast.com/sheets/ornato_vaso.pdf"},{"label":"Informačný dokument","url":"https://www.euro3plast.com/sheets/ornato_pot_info_en.pdf"}]'::jsonb,
  'https://www.euro3plast.com/gb/products/399-ornato.html',
  'https://www.euro3plast.com/gb/products/399-ornato.html',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'nabytok' LIMIT 1),
  'Stolička Croisette s operadlom',
  'stolicka-croisette-s-operadlom',
  'Serralunga',
  19000,
  NULL,
  'Kreslo Croisette, navrhnuté Florentom Coirierom pre Serralunga, je vyrobené z technopolyméru alebo recyklovaných materiálov. Vyznačuje sa silným charakterom, no zároveň jemnosťou a univerzálnosťou, vďaka ktorým sa prirodzene hodí do každého prostredia. Jeho dizajn je prispôsobený každodennému používaniu a zaručuje dlhú životnosť. Projekt vznikol z myšlienky vytvoriť stoličku s lamelovou štruktúrou. Inšpirovaný klasickým obrazom tradičných stoličiek, Croisette prináša moderný a súčasný pohľad na tvar a materiál. Cieľom bolo znovu interpretovať klasické drevené vonkajšie sedenie, pričom dôraz sa kládol na prepracované detaily spojov a prechody materiálu. Croisette Armchair je odolné, pevné a zároveň ľahké, čo z neho robí ideálnu voľbu pre domácnosti aj komerčné priestory. Dostupné je v sete po štyroch kusoch, s možnosťou výberu s podrúčkami alebo bez nich.
Rozmer
59.8 x 50.3 x 77.8
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/en/products/croisette-armchair?_pos=2&_psq=croisette&_ss=e&_v=1.0)',
  'https://kochlik.netlify.app/images/stolicka-croisette-s-operadlom/stolicka-croisette-s-operadlom_1.webp',
  ARRAY['https://kochlik.netlify.app/images/stolicka-croisette-s-operadlom/stolicka-croisette-s-operadlom_1.webp', 'https://kochlik.netlify.app/images/stolicka-croisette-s-operadlom/stolicka-croisette-s-operadlom_2.webp', 'https://kochlik.netlify.app/images/stolicka-croisette-s-operadlom/stolicka-croisette-s-operadlom_3.webp', 'https://kochlik.netlify.app/images/stolicka-croisette-s-operadlom/stolicka-croisette-s-operadlom_4.webp', 'https://kochlik.netlify.app/images/stolicka-croisette-s-operadlom/stolicka-croisette-s-operadlom_5.webp', 'https://kochlik.netlify.app/images/stolicka-croisette-s-operadlom/stolicka-croisette-s-operadlom_6.webp']::text[],
  '[{"name":"ANTRACITE","hex":null,"image_url":null,"family":"Sivá"},{"name":"MENTA VERDE","hex":null,"image_url":null,"family":"Zelená"},{"name":"CAPPUCCINO","hex":null,"image_url":null,"family":"Hnedá"},{"name":"BIANCO","hex":null,"image_url":null,"family":"Biela"}]'::jsonb,
  ARRAY['Biela', 'Hnedá', 'Sivá', 'Zelená']::text[],
  ARRAY[]::text[],
  ARRAY[]::text[],
  '[]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/en/products/croisette-armchair?_pos=2&_psq=croisette&_ss=e&_v=1.0',
  'https://serralunga.com/en/products/croisette-armchair?_pos=2&_psq=croisette&_ss=e&_v=1.0',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'moderne-kvetinace' LIMIT 1),
  'Kvetináč FENCE',
  'kvetinac-fence',
  'Serralunga',
  42200,
  NULL,
  'Kvetináč Fence, navrhnutý Raffaellou Mangiarotti pre značku Serralunga, prináša do priestoru nádych Provence v podobe tradičného tvaru dreveného plota, ktorý definuje jeho jedinečný dizajn. Tento kvetináč – pripomínajúci záhradnú debničku – ponúka modernú interpretáciu klasiky a zároveň vytvára pocit súkromia a útulného priestoru. Jeho ľahký, trojrozmerný dizajn dodáva povrchu hĺbku a zaujímavú textúru, vďaka čomu sa ľahko kombinuje s akýmkoľvek štýlom či prostredím. Model Fence je dostupný aj v menšej verzii.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/en/products/fence-planter?_pos=1&_psq=fence&_ss=e&_v=1.0)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/kvetinac-fence/kvetinac-fence_1.webp',
  ARRAY['https://kochlik.netlify.app/images/kvetinac-fence/kvetinac-fence_1.webp']::text[],
  '[{"name":"PIETRA DELLA DOLOMITI","hex":null,"image_url":null,"family":"Sivá"},{"name":"SALVIA DI SARDEGNA","hex":null,"image_url":null,"family":"Zelená"},{"name":"TERRACOTTA TOSCANA","hex":null,"image_url":null,"family":"Červená"},{"name":"ANTRACITE","hex":null,"image_url":null,"family":"Sivá"},{"name":"AZZURRO DI PROVENZA","hex":null,"image_url":null,"family":"Modrá"},{"name":"ROSSO","hex":null,"image_url":null,"family":"Červená"},{"name":"TERRACOTTA SCURA","hex":null,"image_url":null,"family":"Červená"},{"name":"TORTORA DI TORINO","hex":null,"image_url":null,"family":"Hnedá"},{"name":"BIANCO","hex":null,"image_url":null,"family":"Biela"},{"name":"VERDE PAVONE","hex":null,"image_url":null,"family":"Zelená"},{"name":"GIALLO SAHARA","hex":null,"image_url":null,"family":"Žltá"},{"name":"VERDE BRITISH","hex":null,"image_url":null,"family":"Zelená"},{"name":"ROSSO POMPEIANO","hex":null,"image_url":null,"family":"Červená"},{"name":"ACQUA DELLA MADDALENA","hex":null,"image_url":null,"family":"Modrá"}]'::jsonb,
  ARRAY['Biela', 'Červená', 'Hnedá', 'Modrá', 'Sivá', 'Zelená', 'Žltá']::text[],
  ARRAY['100x45x60 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[{"label":"100x45x60 cm","dimensions":"100x45x60 cm","price_cents":42200,"attributes":{"rozmer":"100x45x60 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"100x45x60 cm"}]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/en/products/fence-planter?_pos=1&_psq=fence&_ss=e&_v=1.0',
  'https://serralunga.com/en/products/fence-planter?_pos=1&_psq=fence&_ss=e&_v=1.0',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'nabytok' LIMIT 1),
  'KUBE stolička',
  'kube-stolicka',
  'Euro3plast',
  11400,
  NULL,
  'Štýl je synonymom minimalizmu – dokonale zhrnutý v čistých a jednoduchých líniách našich kvetináčov a doplnkov. Skombinovali sme čisté profily s farebnou paletou pre každý vkus – od výraznej kyslej zelene a červenej po klasické odtiene – aby ste obohatili svoje obľúbené priestory harmóniou a eleganciou.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.euro3plast.com/gb/products/325-3129-kube.html#/589-colour-pearl_black/614-significant_measure-40)',
  'https://kochlik.netlify.app/images/kube-stolicka/kube-stolicka_1.webp',
  ARRAY['https://kochlik.netlify.app/images/kube-stolicka/kube-stolicka_1.webp']::text[],
  '[{"name":"WHITE C2","hex":"#ffffff","image_url":null,"family":"Biela"},{"name":"PEARL BLACK","hex":"#4a4a49","image_url":null,"family":"Čierna"}]'::jsonb,
  ARRAY['Biela', 'Čierna']::text[],
  ARRAY['40x40x40 cm', '50x50x50 cm']::text[],
  ARRAY['Do 50 cm']::text[],
  '[{"label":"40x40x40 cm","dimensions":"40x40x40 cm","price_cents":11400,"attributes":{"rozmer":"40x40x40 cm"}},{"label":"50x50x50 cm","dimensions":"50x50x50 cm","price_cents":14500,"attributes":{"rozmer":"50x50x50 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"40x40x40 cm, 50x50x50 cm"}]'::jsonb,
  '[{"label":"Technický dokument","url":"https://www.euro3plast.com/sheets/kube_sgabello.pdf"},{"label":"Informačný dokument","url":"https://www.euro3plast.com/sheets/kube_stool_info_en.pdf"}]'::jsonb,
  'https://www.euro3plast.com/gb/products/325-3129-kube.html#/589-colour-pearl_black/614-significant_measure-40',
  'https://www.euro3plast.com/gb/products/325-3129-kube.html#/589-colour-pearl_black/614-significant_measure-40',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'nabytok' LIMIT 1),
  'Stôl Fade metal',
  'stol-fade-metal',
  'Plust',
  48000,
  NULL,
  'Tento stôl má centrálnu nosnú nohu a štyri ramená s nastaviteľnými pätkami. Plochý krížový podstavec z liateho hliníka umožňuje výber dosky z HPL materiálu – v okrúhlom (Ø 80 cm) alebo štvorcovom (80 × 80 cm) vyhotovení. Špeciálne povrchové úpravy zaručujú vhodnosť na použitie v interiéri aj exteriéri.
Rozmer
73 x 73 x 71 cm
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.plust.it/en/products/fade-table-metal-structure/)',
  'https://kochlik.netlify.app/images/stol-fade-metal/stol-fade-metal_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/stol-fade-metal/stol-fade-metal_1.jpg', 'https://kochlik.netlify.app/images/stol-fade-metal/stol-fade-metal_2.jpg', 'https://kochlik.netlify.app/images/stol-fade-metal/stol-fade-metal_3.jpg', 'https://kochlik.netlify.app/images/stol-fade-metal/stol-fade-metal_4.jpg']::text[],
  '[{"name":"Bianco","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_bianco_bianco.jpg","family":"Biela"},{"name":"Nero","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_nero_nero.jpg","family":"Čierna"},{"name":"Black","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_black_black.jpg","family":"Čierna"},{"name":"White","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_white_white.jpg","family":"Biela"}]'::jsonb,
  ARRAY['Biela', 'Čierna']::text[],
  ARRAY['80 cm', '80 × 80 cm', '73 x 71 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb,
  'https://www.plust.it/en/products/fade-table-metal-structure/',
  'https://www.plust.it/en/products/fade-table-metal-structure/',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'moderne-kvetinace' LIMIT 1),
  'Kvetináč KUBE s kolieskami',
  'kvetinac-kube-s-kolieskami',
  'Euro3plast',
  9300,
  NULL,
  'Štýl je synonymom minimalizmu – dokonale zhrnutý v čistých a jednoduchých líniách našich kvetináčov a doplnkov. Skombinovali sme čisté profily s farebnou paletou pre každý vkus – od výraznej kyslej zelene a červenej po klasické odtiene – aby ste obohatili svoje obľúbené priestory harmóniou a eleganciou.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.euro3plast.com/gb/-/331-3173-kube.html#/332-colour-white_c2/612-significant_measure-30)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/kvetinac-kube-s-kolieskami/kvetinac-kube-s-kolieskami_1.webp',
  ARRAY['https://kochlik.netlify.app/images/kvetinac-kube-s-kolieskami/kvetinac-kube-s-kolieskami_1.webp', 'https://kochlik.netlify.app/images/kvetinac-kube-s-kolieskami/kvetinac-kube-s-kolieskami_2.webp']::text[],
  '[{"name":"WHITE C2","hex":"#ffffff","image_url":null,"family":"Biela"},{"name":"RUST","hex":"#543920","image_url":null,"family":"Hnedá"},{"name":"TAUPE","hex":"#706961","image_url":null,"family":"Hnedá"},{"name":"CEMENT","hex":"#999390","image_url":null,"family":"Sivá"},{"name":"GRANITE","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/e3p_kvetinac-kube-s-kolieskami_granite.jpg","family":"Sivá"},{"name":"LAVA","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/e3p_kvetinac-kube-s-kolieskami_lava.jpg","family":"Sivá"},{"name":"STONE","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/e3p_kvetinac-kube-s-kolieskami_stone.jpg","family":"Sivá"},{"name":"CRETA","hex":"#786e69","image_url":null,"family":"Béžová"},{"name":"PEARL BLACK","hex":"#4a4a49","image_url":null,"family":"Čierna"}]'::jsonb,
  ARRAY['Béžová', 'Biela', 'Čierna', 'Hnedá', 'Sivá']::text[],
  ARRAY['30x30x31 cm', '40x40x41 cm', '50x50x51 cm']::text[],
  ARRAY['Do 50 cm', '51-100 cm']::text[],
  '[{"label":"30x30x31 cm","dimensions":"30x30x31 cm","price_cents":9300,"attributes":{"rozmer":"30x30x31 cm"}},{"label":"40x40x41 cm","dimensions":"40x40x41 cm","price_cents":12900,"attributes":{"rozmer":"40x40x41 cm"}},{"label":"50x50x51 cm","dimensions":"50x50x51 cm","price_cents":18400,"attributes":{"rozmer":"50x50x51 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"30x30x31 cm, 40x40x41 cm, 50x50x51 cm"}]'::jsonb,
  '[{"label":"Technický dokument","url":"https://www.euro3plast.com/sheets/kube_vaso_con_doppia_parete_+_ruote.pdf"},{"label":"Informačný dokument","url":"https://www.euro3plast.com/sheets/kube_pot_with_double_wall_+_castors_info_en.pdf"}]'::jsonb,
  'https://www.euro3plast.com/gb/-/331-3173-kube.html#/332-colour-white_c2/612-significant_measure-30',
  'https://www.euro3plast.com/gb/-/331-3173-kube.html#/332-colour-white_c2/612-significant_measure-30',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'nabytok' LIMIT 1),
  'Kreslo Pine Beach',
  'kreslo-pine-beach',
  'Serralunga',
  48000,
  NULL,
  'Kreslo Pine Beach, navrhnuté Christophe Pilletom pre Serralunga, je inšpirované pobrežím mora so svojimi mäkkými, zaoblenými tvarmi. Ide o obopínajúce kreslo s ergonomickým tvarom, ktoré kopíruje línie ľudského tela a spája jemnosť s futuristickým dizajnom. Kolekcia Pine Beach pozostáva z pohovky a kresla, ktoré sú vhodné do interiéru aj exteriéru. Vďaka integrovanému odtokovému systému – malému otvoru na odvod vody – je možné na nábytku pohodlne sedieť aj po daždi. Táto verzia je dostupná aj v povrchovej úprave Moleskin, registrovaný dizajn, ktorá pridáva výrobku teplo, štruktúru a eleganciu.
Rozmer
70 x 66 x 76 cm
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/en/products/pine-beach-armchair?_pos=2&_psq=Pine+Beach&_ss=e&_v=1.0)',
  'https://kochlik.netlify.app/images/kreslo-pine-beach/kreslo-pine-beach_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/kreslo-pine-beach/kreslo-pine-beach_1.jpg']::text[],
  '[{"name":"BIANCO","hex":null,"image_url":null,"family":"Biela"},{"name":"ANTRACITE","hex":null,"image_url":null,"family":"Sivá"},{"name":"SALVIA DI SARDEGNA","hex":null,"image_url":null,"family":"Zelená"},{"name":"TERRACOTTA SCURA","hex":null,"image_url":null,"family":"Červená"},{"name":"TORTORA DI TORINO","hex":null,"image_url":null,"family":"Hnedá"},{"name":"VERDE OLIVE DI CERIGNOLA","hex":null,"image_url":null,"family":"Zelená"},{"name":"VERDE PAVONE","hex":null,"image_url":null,"family":"Zelená"},{"name":"ACQUA DELLA MADDALENA","hex":null,"image_url":null,"family":"Modrá"},{"name":"AZZURRO DI PROVENZA","hex":null,"image_url":null,"family":"Modrá"},{"name":"ROSSO","hex":null,"image_url":null,"family":"Červená"},{"name":"CASTORO","hex":null,"image_url":null,"family":"Hnedá"},{"name":"GIALLO SAHARA","hex":null,"image_url":null,"family":"Žltá"},{"name":"VERDE BRITISH","hex":null,"image_url":null,"family":"Zelená"},{"name":"ROSSO POMPEIANO","hex":null,"image_url":null,"family":"Červená"},{"name":"CORTEN","hex":null,"image_url":null,"family":"Hnedá"}]'::jsonb,
  ARRAY['Biela', 'Červená', 'Hnedá', 'Modrá', 'Sivá', 'Zelená', 'Žltá']::text[],
  ARRAY['66 x 76 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/en/products/pine-beach-armchair?_pos=2&_psq=Pine+Beach&_ss=e&_v=1.0',
  'https://serralunga.com/en/products/pine-beach-armchair?_pos=2&_psq=Pine+Beach&_ss=e&_v=1.0',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'nabytok' LIMIT 1),
  'Lavička Romeo',
  'lavicka-romeo',
  'Serralunga',
  85000,
  NULL,
  'Dizajn od Paolo Rizzatto pre Serralunga Lavička Romeo je jedným z najrozšírenejších kúskov súčasného nábytku. Môže stáť samostatne ako dizajnový prvok na terase alebo v tieni stromu, no rovnako dobre sa dá umiestniť do skupín alebo do línií. Zúžené nohy s pevným prierezom zaručujú stabilitu na každom type povrchu, zatiaľ čo mierne naklonené sedadlo zabraňuje hromadeniu vody. Operadlo s lamelami umožňuje prúdenie vzduchu a vytvára vizuálnu ľahkosť. Vďaka jemne zakrivenej konštrukcii poskytuje lavička výnimočné pohodlie. Inovatívnym prvkom je technológia rotačného formovania, ktorá umožňuje výrobu lavičky z jedného celistvého kusu materiálu. Serralunga Romeo je brat lavičky Serralunga Giulietta.
Rozmer
115 x 61 x 96 cm
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/en/products/romeo-bench?_pos=1&_psq=Romeo&_ss=e&_v=1.0)',
  'https://kochlik.netlify.app/images/lavicka-romeo/lavicka-romeo_1.webp',
  ARRAY['https://kochlik.netlify.app/images/lavicka-romeo/lavicka-romeo_1.webp', 'https://kochlik.netlify.app/images/lavicka-romeo/lavicka-romeo_2.webp', 'https://kochlik.netlify.app/images/lavicka-romeo/lavicka-romeo_3.webp']::text[],
  '[{"name":"BIANCO","hex":null,"image_url":null,"family":"Biela"},{"name":"ROSSO","hex":null,"image_url":null,"family":"Červená"},{"name":"ANTRACITE","hex":null,"image_url":null,"family":"Sivá"},{"name":"ACQUA DELLA MADDALENA","hex":null,"image_url":null,"family":"Modrá"},{"name":"AZZURRO DI PROVENZA","hex":null,"image_url":null,"family":"Modrá"},{"name":"SALVIA DI SARDEGNA","hex":null,"image_url":null,"family":"Zelená"},{"name":"TORTORA DI TORINO","hex":null,"image_url":null,"family":"Hnedá"},{"name":"VERDE PAVONE","hex":null,"image_url":null,"family":"Zelená"},{"name":"GIALLO SAHARA","hex":null,"image_url":null,"family":"Žltá"},{"name":"VERDE BRITISH","hex":null,"image_url":null,"family":"Zelená"},{"name":"ROSSO POMPEIANO","hex":null,"image_url":null,"family":"Červená"},{"name":"CORTEN","hex":null,"image_url":null,"family":"Hnedá"}]'::jsonb,
  ARRAY['Biela', 'Červená', 'Hnedá', 'Modrá', 'Sivá', 'Zelená', 'Žltá']::text[],
  ARRAY['61 x 96 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/en/products/romeo-bench?_pos=1&_psq=Romeo&_ss=e&_v=1.0',
  'https://serralunga.com/en/products/romeo-bench?_pos=1&_psq=Romeo&_ss=e&_v=1.0',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'dizajnove' LIMIT 1),
  'Kvetináč Uovo di Colombo',
  'kvetinac-uovo-di-colombo',
  'Serralunga',
  47500,
  NULL,
  'Kvetináč Uovo di Colombo, navrhnutý Carlom Colombom pre Serralunga, predstavuje spojenie avantgardného dizajnu a čistej estetiky. Typický pre značku Serralunga, aj tento jednoduchý, no dekoratívny kvetináč sa stáva dominantným prvkom vonkajšieho priestoru, ktorý pôsobí ako samostatný umelecký objekt. Uovo di Colombo sa zameriava na esencialitu a formálnu čistotu, čo dokonale vystihuje štýl dizajnéra Carla Colomba – elegantný minimalizmus, ktorý zdôrazňuje tvar, rovnováhu a harmóniu.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/en/products/uovo-di-colombo-planter?_pos=1&_psq=Uovo+di+Colombo&_ss=e&_v=1.0)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/kvetinac-uovo-di-colombo/kvetinac-uovo-di-colombo_1.webp',
  ARRAY['https://kochlik.netlify.app/images/kvetinac-uovo-di-colombo/kvetinac-uovo-di-colombo_1.webp']::text[],
  '[{"name":"ANTHRACITE","hex":null,"image_url":null,"family":"Sivá"},{"name":"TERRACOTTA SCURA","hex":null,"image_url":null,"family":"Červená"},{"name":"BIANCO","hex":null,"image_url":null,"family":"Biela"},{"name":"TERRACOTTA TOSCANA","hex":null,"image_url":null,"family":"Červená"},{"name":"GIALLO SAHARA","hex":null,"image_url":null,"family":"Žltá"},{"name":"VERDE BRITISH","hex":null,"image_url":null,"family":"Zelená"},{"name":"ROSSO POMPEIANO","hex":null,"image_url":null,"family":"Červená"}]'::jsonb,
  ARRAY['Biela', 'Červená', 'Sivá', 'Zelená', 'Žltá']::text[],
  ARRAY['80x80x55 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[{"label":"80x80x55 cm","dimensions":"80x80x55 cm","price_cents":47500,"attributes":{"rozmer":"80x80x55 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"80x80x55 cm"}]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/en/products/uovo-di-colombo-planter?_pos=1&_psq=Uovo+di+Colombo&_ss=e&_v=1.0',
  'https://serralunga.com/en/products/uovo-di-colombo-planter?_pos=1&_psq=Uovo+di+Colombo&_ss=e&_v=1.0',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'dizajnove' LIMIT 1),
  'Kvetináč Grand Jane',
  'kvetinac-grand-jane',
  'Serralunga',
  43500,
  NULL,
  'Kvetináč Grand Jane, navrhnutý Marcom Sadlerom pre Serralunga, je určený do interiéru aj exteriéru a vyznačuje sa povrchom zdobeným jemnými zakrivenými špirálovými reliéfmi. Grand Jane má strohý, no zároveň príťažlivý tvar, ktorý svojou krásou doplní akékoľvek prostredie.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/products/grand-jane-planter)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/kvetinac-grand-jane/kvetinac-grand-jane_1.webp',
  ARRAY['https://kochlik.netlify.app/images/kvetinac-grand-jane/kvetinac-grand-jane_1.webp']::text[],
  '[{"name":"ANTRACITE","hex":null,"image_url":null,"family":"Sivá"},{"name":"LACCATO ROSSO","hex":null,"image_url":null,"family":"Červená"},{"name":"ROSSO","hex":null,"image_url":null,"family":"Červená"},{"name":"TERRACOTTA SCURA","hex":null,"image_url":null,"family":"Červená"},{"name":"BIANCO","hex":null,"image_url":null,"family":"Biela"}]'::jsonb,
  ARRAY['Biela', 'Červená', 'Sivá']::text[],
  ARRAY['55x55x70 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[{"label":"55x55x70 cm","dimensions":"55x55x70 cm","price_cents":43500,"attributes":{"rozmer":"55x55x70 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"55x55x70 cm"}]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/products/grand-jane-planter',
  'https://serralunga.com/products/grand-jane-planter',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'moderne-kvetinace' LIMIT 1),
  'Kvetináč Tubini',
  'kvetinac-tubini',
  'Serralunga',
  15900,
  NULL,
  'Kvetináč Tubini, navrhnutý Nat Wave pre Serralunga, predstavuje kompozíciu základných tvarov inšpirovaných objemom. Kvetináče Tubini z kolekcie Serralunga 1825 vynikajú čistými, jednoduchými líniami, ktoré pripomínajú priemyselnú architektúru v minimalistickej podobe. Povrch pôsobí, akoby bol posypaný zrnami piesku, čo odkazuje na materiálovú podstatu a autentickú štruktúru typickú pre kvetináče Serralunga, ktoré sú už roky ikonami záhradného dizajnu.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/en/products/tubini-planter?_pos=2&_psq=tubini&_ss=e&_v=1.0)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/kvetinac-tubini/kvetinac-tubini_1.webp',
  ARRAY['https://kochlik.netlify.app/images/kvetinac-tubini/kvetinac-tubini_1.webp']::text[],
  '[{"name":"BIANCO","hex":null,"image_url":null,"family":"Biela"},{"name":"AZZURRO DI PROVENZA","hex":null,"image_url":null,"family":"Modrá"},{"name":"PIETRA DELLA DOLOMITI","hex":null,"image_url":null,"family":"Sivá"},{"name":"ANTRACITE","hex":null,"image_url":null,"family":"Sivá"},{"name":"ROSSO","hex":null,"image_url":null,"family":"Červená"},{"name":"SALVIA DI SARDEGNA","hex":null,"image_url":null,"family":"Zelená"},{"name":"TERRACOTTA TOSCANA","hex":null,"image_url":null,"family":"Červená"},{"name":"TERRACOTTA SCURA","hex":null,"image_url":null,"family":"Červená"},{"name":"TORTORA DI TORINO","hex":null,"image_url":null,"family":"Hnedá"},{"name":"VERDE PAVONE","hex":null,"image_url":null,"family":"Zelená"},{"name":"GIALLO SAHARA","hex":null,"image_url":null,"family":"Žltá"},{"name":"VERDE BRITISH","hex":null,"image_url":null,"family":"Zelená"},{"name":"ROSSO POMPEIANO","hex":null,"image_url":null,"family":"Červená"}]'::jsonb,
  ARRAY['Biela', 'Červená', 'Hnedá', 'Modrá', 'Sivá', 'Zelená', 'Žltá']::text[],
  ARRAY['46x46x90 cm', '50x50x48 cm']::text[],
  ARRAY['Do 50 cm', '51-100 cm']::text[],
  '[{"label":"46x46x90 cm","dimensions":"46x46x90 cm","price_cents":21900,"attributes":{"rozmer":"46x46x90 cm"}},{"label":"50x50x48 cm","dimensions":"50x50x48 cm","price_cents":15900,"attributes":{"rozmer":"50x50x48 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"46x46x90 cm, 50x50x48 cm"}]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/en/products/tubini-planter?_pos=2&_psq=tubini&_ss=e&_v=1.0',
  'https://serralunga.com/en/products/tubini-planter?_pos=2&_psq=tubini&_ss=e&_v=1.0',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'moderne-kvetinace' LIMIT 1),
  'Hrantík vysoký KUBE',
  'hrantik-vysoky-kube',
  'Euro3plast',
  26600,
  NULL,
  'Štýl je synonymom minimalizmu – dokonale zhrnutý v čistých a jednoduchých líniách našich kvetináčov a doplnkov. Skombinovali sme čisté profily s farebnou paletou pre každý vkus – od výraznej kyslej zelene a červenej po klasické odtiene – aby ste obohatili svoje obľúbené priestory harmóniou a eleganciou.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.euro3plast.com/gb/-/341-3295-kube-high.html#/332-colour-white_c2/612-significant_measure-30)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/hrantik-vysoky-kube/hrantik-vysoky-kube_1.webp',
  ARRAY['https://kochlik.netlify.app/images/hrantik-vysoky-kube/hrantik-vysoky-kube_1.webp']::text[],
  '[{"name":"WHITE C2","hex":"#ffffff","image_url":null,"family":"Biela"},{"name":"RUST","hex":"#543920","image_url":null,"family":"Hnedá"},{"name":"TAUPE","hex":"#706961","image_url":null,"family":"Hnedá"},{"name":"CEMENT","hex":"#999390","image_url":null,"family":"Sivá"},{"name":"GRANITE","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/e3p_hrantik-vysoky-kube_granite.jpg","family":"Sivá"},{"name":"LAVA","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/e3p_hrantik-vysoky-kube_lava.jpg","family":"Sivá"},{"name":"STONE","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/e3p_hrantik-vysoky-kube_stone.jpg","family":"Sivá"},{"name":"CRETA","hex":"#786e69","image_url":null,"family":"Béžová"},{"name":"PEARL BLACK","hex":"#4a4a49","image_url":null,"family":"Čierna"}]'::jsonb,
  ARRAY['Béžová', 'Biela', 'Čierna', 'Hnedá', 'Sivá']::text[],
  ARRAY['100x40x70 cm', '80x30x70 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[{"label":"100x40x70 cm","dimensions":"100x40x70 cm","price_cents":36200,"attributes":{"rozmer":"100x40x70 cm"}},{"label":"80x30x70 cm","dimensions":"80x30x70 cm","price_cents":26600,"attributes":{"rozmer":"80x30x70 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"100x40x70 cm, 80x30x70 cm"}]'::jsonb,
  '[{"label":"Technický dokument","url":"https://www.euro3plast.com/sheets/kube_high_vaso_con_doppia_parete_+_ruote.pdf"},{"label":"Informačný dokument","url":"https://www.euro3plast.com/sheets/kube_high_pot_with_double_wall_+_castors_info_en.pdf"}]'::jsonb,
  'https://www.euro3plast.com/gb/-/341-3295-kube-high.html#/332-colour-white_c2/612-significant_measure-30',
  'https://www.euro3plast.com/gb/-/341-3295-kube-high.html#/332-colour-white_c2/612-significant_measure-30',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'moderne-kvetinace' LIMIT 1),
  'Kvetináč Versailles',
  'kvetinac-versailles',
  'Serralunga',
  88300,
  NULL,
  'Versailles prináša ľahkosť a eleganciu v modernej interpretácii ikonického kvetináča z oranžérie Ľudovíta XIV. Pôvodne navrhnutý tak, aby sa dal počas chladného obdobia jednoducho premiestniť, dnes predstavuje ideálne riešenie pre mobilné a stohovateľné kvetináče – vhodné pre záhradnú architektúru, námestia, promenády a verejné priestory. Svojím čistým kubickým tvarom, stojacim na štyroch nohách, s typickými vertikálnymi a horizontálnymi líniami pripomínajúcimi drevené latovanie, vytvára harmonické spojenie klasického dizajnu a moderného materiálu. Vyrobený z ľahkej živice, Versailles je dokonalým prvkom pre vonkajšie priestory, ktoré chcú pôsobiť elegantne, no zároveň uvoľnene. Dizajn: Serralunga.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/en/products/versailles-planter?_pos=1&_psq=Versailles&_ss=e&_v=1.0)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/kvetinac-versailles/kvetinac-versailles_1.webp',
  ARRAY['https://kochlik.netlify.app/images/kvetinac-versailles/kvetinac-versailles_1.webp', 'https://kochlik.netlify.app/images/kvetinac-versailles/kvetinac-versailles_2.webp']::text[],
  '[{"name":"NEVE DI SAN CANDIDO","hex":null,"image_url":null,"family":"Biela"},{"name":"SALVIA DI SARDEGNA","hex":null,"image_url":null,"family":"Zelená"},{"name":"ANTRACITE","hex":null,"image_url":null,"family":"Sivá"},{"name":"VERDE PAVONE","hex":null,"image_url":null,"family":"Zelená"},{"name":"GIALLO SAHARA","hex":null,"image_url":null,"family":"Žltá"},{"name":"VERDE BRITISH","hex":null,"image_url":null,"family":"Zelená"},{"name":"ROSSO POMPEIANO","hex":null,"image_url":null,"family":"Červená"}]'::jsonb,
  ARRAY['Biela', 'Červená', 'Sivá', 'Zelená', 'Žltá']::text[],
  ARRAY['90x90x98 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[{"label":"90x90x98 cm","dimensions":"90x90x98 cm","price_cents":88300,"attributes":{"rozmer":"90x90x98 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"90x90x98 cm"}]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/en/products/versailles-planter?_pos=1&_psq=Versailles&_ss=e&_v=1.0',
  'https://serralunga.com/en/products/versailles-planter?_pos=1&_psq=Versailles&_ss=e&_v=1.0',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'doplnky' LIMIT 1),
  'Jazvečík Otto',
  'jazvecik-otto',
  'Serralunga',
  16000,
  NULL,
  'Otto je rozkošný jazvečík, navrhnutý Alessandrou Baldereschi pre Serralunga. Otto je súčasťou dvojice Bonnie a Otto, ktorá predstavuje dve štylizované zvieratá s jednoduchým a zároveň ironickým charakterom. Sú to domáci miláčikovia – tichí a múdri. Majú zatvorené oči, no nespia; čakajú a pokojne nás pozorujú, zhovievavo.
Rozmer
17.5 x 66 x 38 cm
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/products/otto?_pos=1&_psq=otto&_ss=e&_v=1.0)',
  'https://kochlik.netlify.app/images/jazvecik-otto/jazvecik-otto_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/jazvecik-otto/jazvecik-otto_1.jpg', 'https://kochlik.netlify.app/images/jazvecik-otto/jazvecik-otto_2.webp']::text[],
  '[{"name":"TERRACOTTA SCURA","hex":null,"image_url":null,"family":"Červená"},{"name":"TORTORA DI TORINO","hex":null,"image_url":null,"family":"Hnedá"},{"name":"VERDE OLIVA DI CERIGNOLA","hex":null,"image_url":null,"family":"Zelená"},{"name":"PIETRA DELLE DOLOMITI","hex":null,"image_url":null,"family":"Sivá"},{"name":"AZZURRO DI PROVENZA","hex":null,"image_url":null,"family":"Modrá"},{"name":"ANTRACITE","hex":null,"image_url":null,"family":"Sivá"},{"name":"ROSSO","hex":null,"image_url":null,"family":"Červená"},{"name":"SALVIA DI SARDEGNA","hex":null,"image_url":null,"family":"Zelená"},{"name":"TERRACOTTA TOSCANA","hex":null,"image_url":null,"family":"Červená"},{"name":"BIANCO","hex":null,"image_url":null,"family":"Biela"},{"name":"VERDE PAVONE","hex":null,"image_url":null,"family":"Zelená"},{"name":"GIALLO SAHARA","hex":null,"image_url":null,"family":"Žltá"},{"name":"VERDE BRITISH","hex":null,"image_url":null,"family":"Zelená"},{"name":"ROSSO POMPEIANO","hex":null,"image_url":null,"family":"Červená"},{"name":"ACQUA DELLA MADDALENA","hex":null,"image_url":null,"family":"Modrá"},{"name":"CORTEN","hex":null,"image_url":null,"family":"Hnedá"}]'::jsonb,
  ARRAY['Biela', 'Červená', 'Hnedá', 'Modrá', 'Sivá', 'Zelená', 'Žltá']::text[],
  ARRAY['66 x 38 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/products/otto?_pos=1&_psq=otto&_ss=e&_v=1.0',
  'https://serralunga.com/products/otto?_pos=1&_psq=otto&_ss=e&_v=1.0',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'klasicke-kvetinace' LIMIT 1),
  'Kvetináč Millerighe Angolo Orizzontale',
  'kvetinac-millerighe-angolo-orizzontale',
  'Serralunga',
  10900,
  NULL,
  'Kvetináč Millerighe Angolo Orizzontale od Serralunga je večná klasika, ktorá spája jednoduchosť a eleganciu. Práve farba dodáva tejto kolekcii jedinečný charakter – jemné prechody tón v tóne a farebné akcenty vytvárajú zaujímavé vizuálne kontrasty a nečakané kombinácie. Kvetináče Millerighe patria do kolekcie Serralunga garden décor a sú ideálnou voľbou pre štýlové záhradné aranžmány aj moderné exteriéry.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/en/products/millerighe-angolo-orizzontale-planter?_pos=1&_psq=Millerighe+Angolo+Orizzontale&_ss=e&_v=1.0)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/kvetinac-millerighe-angolo-orizzontale/kvetinac-millerighe-angolo-orizzontale_1.webp',
  ARRAY['https://kochlik.netlify.app/images/kvetinac-millerighe-angolo-orizzontale/kvetinac-millerighe-angolo-orizzontale_1.webp']::text[],
  '[{"name":"TORTORA DI TORINO","hex":null,"image_url":null,"family":"Hnedá"},{"name":"TERRACOTTA TOSCANA","hex":null,"image_url":null,"family":"Červená"},{"name":"GESSO DI BOLOGNA","hex":null,"image_url":null,"family":"Biela"},{"name":"ANTRACITE","hex":null,"image_url":null,"family":"Sivá"},{"name":"AZZURRO DI PROVENZA","hex":null,"image_url":null,"family":"Modrá"},{"name":"SALVIA DI SARDEGNA","hex":null,"image_url":null,"family":"Zelená"},{"name":"TERRACOTTA SCURA","hex":null,"image_url":null,"family":"Červená"},{"name":"VERDE PAVONE","hex":null,"image_url":null,"family":"Zelená"},{"name":"GIALLO SAHARA","hex":null,"image_url":null,"family":"Žltá"},{"name":"VERDE BRITISH","hex":null,"image_url":null,"family":"Zelená"},{"name":"ROSSO POMPEIANO","hex":null,"image_url":null,"family":"Červená"}]'::jsonb,
  ARRAY['Biela', 'Červená', 'Hnedá', 'Modrá', 'Sivá', 'Zelená', 'Žltá']::text[],
  ARRAY['42x42x40 cm']::text[],
  ARRAY['Do 50 cm']::text[],
  '[{"label":"42x42x40 cm","dimensions":"42x42x40 cm","price_cents":10900,"attributes":{"rozmer":"42x42x40 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"42x42x40 cm"}]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/en/products/millerighe-angolo-orizzontale-planter?_pos=1&_psq=Millerighe+Angolo+Orizzontale&_ss=e&_v=1.0',
  'https://serralunga.com/en/products/millerighe-angolo-orizzontale-planter?_pos=1&_psq=Millerighe+Angolo+Orizzontale&_ss=e&_v=1.0',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'dizajnove' LIMIT 1),
  'Kvetináč Scarlett',
  'kvetinac-scarlett',
  'Serralunga',
  58000,
  NULL,
  'Kvetináče s jemne zvlnenou siluetou, vhodné pre interiér aj exteriér, zaujmú svojím nariaseným povrchom, ktorý im dodáva mäkkosť a elegantný „oblečený“ vzhľad. Tieto záhradné kvetináče, ktoré navrhol Christophe Pillet pre Serralunga, sú dostupné v dvoch veľkostiach a vyrobené z lineárneho nízkohustotného polyetylénu (LLDPE) pomocou rotačného tvarovania, čo zaručuje ich ľahkosť, pevnosť a odolnosť voči poveternostným vplyvom.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/en/products/scarlett-planter?_pos=1&_psq=Scarlett&_ss=e&_v=1.0)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/kvetinac-scarlett/kvetinac-scarlett_1.webp',
  ARRAY['https://kochlik.netlify.app/images/kvetinac-scarlett/kvetinac-scarlett_1.webp', 'https://kochlik.netlify.app/images/kvetinac-scarlett/kvetinac-scarlett_2.webp', 'https://kochlik.netlify.app/images/kvetinac-scarlett/kvetinac-scarlett_3.webp']::text[],
  '[{"name":"BIANCO","hex":null,"image_url":null,"family":"Biela"},{"name":"ANTRACITE","hex":null,"image_url":null,"family":"Sivá"},{"name":"TORTORA DI TORINO","hex":null,"image_url":null,"family":"Hnedá"},{"name":"AZZURRO DI PROVENZA","hex":null,"image_url":null,"family":"Modrá"},{"name":"LACQUERED ROSSO","hex":null,"image_url":null,"family":"Červená"},{"name":"LACQUERED BIANCO","hex":null,"image_url":null,"family":"Biela"},{"name":"ROSSO","hex":null,"image_url":null,"family":"Červená"},{"name":"SALVIA DI SARDEGNA","hex":null,"image_url":null,"family":"Zelená"},{"name":"VERDE PAVONE","hex":null,"image_url":null,"family":"Zelená"},{"name":"PIETRA DELLA DOLOMITI","hex":null,"image_url":null,"family":"Sivá"},{"name":"TERRACOTTA TOSCANA","hex":null,"image_url":null,"family":"Červená"},{"name":"NEVE DI SAN CANDIDO","hex":null,"image_url":null,"family":"Biela"},{"name":"GIALLO SAHARA","hex":null,"image_url":null,"family":"Žltá"},{"name":"VERDE BRITISH","hex":null,"image_url":null,"family":"Zelená"},{"name":"ROSSO POMPEIANO","hex":null,"image_url":null,"family":"Červená"}]'::jsonb,
  ARRAY['Biela', 'Červená', 'Hnedá', 'Modrá', 'Sivá', 'Zelená', 'Žltá']::text[],
  ARRAY['28x28x140 cm', '28x28x180 cm']::text[],
  ARRAY['101-150 cm', 'Nad 150 cm']::text[],
  '[{"label":"28x28x140 cm","dimensions":"28x28x140 cm","price_cents":58000,"attributes":{"rozmer":"28x28x140 cm"}},{"label":"28x28x180 cm","dimensions":"28x28x180 cm","price_cents":62000,"attributes":{"rozmer":"28x28x180 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"28x28x140 cm, 28x28x180 cm"}]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/en/products/scarlett-planter?_pos=1&_psq=Scarlett&_ss=e&_v=1.0',
  'https://serralunga.com/en/products/scarlett-planter?_pos=1&_psq=Scarlett&_ss=e&_v=1.0',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'nabytok' LIMIT 1),
  'Kreslo Big Cut',
  'kreslo-big-cut',
  'Plust',
  118000,
  NULL,
  'Toto pohodlné kreslo predstavuje hlavný prvok systému Big Cut. Mäkký vankúš zaručuje maximálne pohodlie pri použití v interiéri aj exteriéri. Typický „V-rez“ je spoločným prvkom všetkých komponentov kolekcie, ktorý vytvára útulný a zároveň funkčný priestor – ideálny pre moderné komerčné prostredia. Dostupné aj v svietiacej verzii.
Rozmer
102 x 81 x 73 cm
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.plust.it/en/products/big-cut-armchair/)',
  'https://kochlik.netlify.app/images/kreslo-big-cut/kreslo-big-cut_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/kreslo-big-cut/kreslo-big-cut_1.jpg', 'https://kochlik.netlify.app/images/kreslo-big-cut/kreslo-big-cut_2.jpg', 'https://kochlik.netlify.app/images/kreslo-big-cut/kreslo-big-cut_3.jpg', 'https://kochlik.netlify.app/images/kreslo-big-cut/kreslo-big-cut_4.jpg', 'https://kochlik.netlify.app/images/kreslo-big-cut/kreslo-big-cut_5.jpg', 'https://kochlik.netlify.app/images/kreslo-big-cut/kreslo-big-cut_6.jpg']::text[],
  '[{"name":"White-White","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_l6_white-white.jpg","family":"Biela"},{"name":"White-Orange","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_l7_white-orange.jpg","family":"Biela"},{"name":"White-Taupe","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_l8_white-taupe.jpg","family":"Biela"},{"name":"Taupe-White","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_m6_taupe-white.jpg","family":"Biela"},{"name":"Taupe-Orange","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_m7_taupe-orange.jpg","family":"Hnedá"},{"name":"Taupe-Taupe","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_m8_taupe-taupe.jpg","family":"Hnedá"},{"name":"White Light-White","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_v8_whitelight-white.jpg","family":"Biela"},{"name":"White Light-Orange","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_x3_whitelight-orange.jpg","family":"Biela"},{"name":"White Light-Tortora","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_x4_whitelight-tortora.jpg","family":"Biela"}]'::jsonb,
  ARRAY['Biela', 'Hnedá']::text[],
  ARRAY['81 x 73 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb,
  'https://www.plust.it/en/products/big-cut-armchair/',
  'https://www.plust.it/en/products/big-cut-armchair/',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  NULL,
  'MINI KUBE kvetináč štvorcový',
  'kube-mini-kvetinac-stvorcovy',
  'Euro3plast',
  1500,
  NULL,
  'Malé farebné kvetináče do interiéru aj exteriéru, ktoré zvýraznia stoly, poličky či okenné parapety v súkromných aj verejných priestoroch. Táto produktová línia ponúka rovnakú kvalitu ako kolekcia Style, len v menších rozmeroch.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.euro3plast.com/gb/indoor-pots/570-5643-mini-kube.html#/377-colour-taupe/606-significant_measure-18)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/kube-mini-kvetinac-stvorcovy/kube-mini-kvetinac-stvorcovy_1.webp',
  ARRAY['https://kochlik.netlify.app/images/kube-mini-kvetinac-stvorcovy/kube-mini-kvetinac-stvorcovy_1.webp', 'https://kochlik.netlify.app/images/kube-mini-kvetinac-stvorcovy/kube-mini-kvetinac-stvorcovy_2.webp']::text[],
  '[{"name":"WHITE C2","hex":"#ffffff","image_url":null,"family":"Biela"},{"name":"RUST","hex":"#543920","image_url":null,"family":"Hnedá"},{"name":"TAUPE","hex":"#706961","image_url":null,"family":"Hnedá"},{"name":"PEARL BLACK","hex":"#4a4a49","image_url":null,"family":"Čierna"}]'::jsonb,
  ARRAY['Biela', 'Čierna', 'Hnedá']::text[],
  ARRAY['18x18x18 cm']::text[],
  ARRAY['Do 50 cm']::text[],
  '[{"label":"18x18x18 cm","dimensions":"18x18x18 cm","price_cents":1500,"attributes":{"rozmer":"18x18x18 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"18x18x18 cm"}]'::jsonb,
  '[{"label":"Technický dokument","url":"https://www.euro3plast.com/sheets/kube_aromatika_vaso_con_doppia_parete.pdf"}]'::jsonb,
  'https://www.euro3plast.com/gb/indoor-pots/570-5643-mini-kube.html#/377-colour-taupe/606-significant_measure-18',
  'https://www.euro3plast.com/gb/indoor-pots/570-5643-mini-kube.html#/377-colour-taupe/606-significant_measure-18',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'klasicke-kvetinace' LIMIT 1),
  'Kvetináč Millerighe Angolo',
  'kvetinac-millerighe-angolo',
  'Serralunga',
  12800,
  NULL,
  'Kvetináč Millerighe Angolo od Serralunga predstavuje nadčasový dizajn, ktorý z neho robí skutočnú klasiku. O jeho jedinečnosti rozhoduje farebné spracovanie – jemné tón v tóne prechody a chromatické akcenty dodávajú klasickému tvaru svieži, moderný charakter a umožňujú nečakané kombinácie v sérii. Kvetináče Millerighe sú súčasťou kolekcie Serralunga garden décor a dokonale sa hodia do elegantných záhradných aj interiérových priestorov.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/en/products/millerighe-angolo-planter?_pos=1&_psq=Millerighe+Angolo&_ss=e&_v=1.0)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/kvetinac-millerighe-angolo/kvetinac-millerighe-angolo_1.webp',
  ARRAY['https://kochlik.netlify.app/images/kvetinac-millerighe-angolo/kvetinac-millerighe-angolo_1.webp']::text[],
  '[{"name":"TORTORA DI TORINO","hex":null,"image_url":null,"family":"Hnedá"},{"name":"TERRACOTTA TOSCANA","hex":null,"image_url":null,"family":"Červená"},{"name":"GESSO DI BOLOGNA","hex":null,"image_url":null,"family":"Biela"},{"name":"ANTRACITE","hex":null,"image_url":null,"family":"Sivá"},{"name":"AZZURRO DI PROVENZA","hex":null,"image_url":null,"family":"Modrá"},{"name":"ROSSO","hex":null,"image_url":null,"family":"Červená"},{"name":"SALVIA DI SARDEGNA","hex":null,"image_url":null,"family":"Zelená"},{"name":"TERRACOTTA SCURA","hex":null,"image_url":null,"family":"Červená"},{"name":"VERDE PAVONE","hex":null,"image_url":null,"family":"Zelená"},{"name":"GIALLO SAHARA","hex":null,"image_url":null,"family":"Žltá"},{"name":"VERDE BRITISH","hex":null,"image_url":null,"family":"Zelená"},{"name":"ROSSO POMPEIANO","hex":null,"image_url":null,"family":"Červená"}]'::jsonb,
  ARRAY['Biela', 'Červená', 'Hnedá', 'Modrá', 'Sivá', 'Zelená', 'Žltá']::text[],
  ARRAY['41x41x54 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[{"label":"41x41x54 cm","dimensions":"41x41x54 cm","price_cents":12800,"attributes":{"rozmer":"41x41x54 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"41x41x54 cm"}]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/en/products/millerighe-angolo-planter?_pos=1&_psq=Millerighe+Angolo&_ss=e&_v=1.0',
  'https://serralunga.com/en/products/millerighe-angolo-planter?_pos=1&_psq=Millerighe+Angolo&_ss=e&_v=1.0',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'dizajnove' LIMIT 1),
  'Diamond',
  'diamond',
  'Plust',
  14000,
  NULL,
  'Váza s čistými líniami, ktoré pripomínajú tvar drahokamov. Dostupná v dvoch veľkostiach, ideálne zapadne do architektonických priestorov a moderného štýlu. Vhodná na rastliny alebo menšie až stredne veľké dekorácie.
 
Rozmer:
26 x 26 x 72 cm
36 x 36 x 98 cm
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.plust.it/en/products/diamond/)',
  'https://kochlik.netlify.app/images/diamond/diamond_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/diamond/diamond_1.jpg']::text[],
  '[{"name":"White C2","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_c2_whitec2.jpg","family":"Biela"},{"name":"Granite","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_s4_granite.jpg","family":"Sivá"},{"name":"White light","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_u1_whitelight.jpg","family":"Biela"},{"name":"Stone","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_u4_stone.jpg","family":"Sivá"}]'::jsonb,
  ARRAY['Biela', 'Sivá']::text[],
  ARRAY['26x26x78 cm', '36x36x98 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[{"label":"26x26x78 cm","dimensions":"26x26x78 cm","price_cents":14000,"attributes":{"rozmer":"26x26x78 cm"}},{"label":"36x36x98 cm","dimensions":"36x36x98 cm","price_cents":26000,"attributes":{"rozmer":"36x36x98 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"26x26x78 cm, 36x36x98 cm"}]'::jsonb,
  '[]'::jsonb,
  'https://www.plust.it/en/products/diamond/',
  'https://www.plust.it/en/products/diamond/',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'svietiace-kvetinace' LIMIT 1),
  'Stojaca lampa Bonheur',
  'stojaca-lampa-bonheur',
  'Serralunga',
  125000,
  NULL,
  'Bonheur je stojacia lampa na použitie v interiéri aj exteriéri. Má difúzor z dvoch polyetylénových častí vyrobených rotačným tvarovaním a konštrukciu zo sivého lakovaného kovu. Biela matná plocha polyméru jemne rozptyľuje svetlo a vytvára kontrast s hlbokou sivou farbou konštrukcie. Táto stojacia lampa, navrhnutá na vonkajšie použitie, je vyrobená z nárazuvzdorného polyetylénu a má širokú základňu pre vyššiu stabilitu. Lampa patrí do kategórie stojacích lámp a moderných lámp Serralunga a je dostupná aj v závesnej verzii, ktorá je obzvlášť vhodná na osvetlenie kolonád. Navrhol ju Michele De Lucchi a je krásnym príkladom talianskeho interiérového dizajnu.
Rozmer
56 x 56 x 180 cm
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/products/bonheur-floorlamp?_pos=2&_psq=Bonheur&_ss=e&_v=1.0)',
  'https://kochlik.netlify.app/images/stojaca-lampa-bonheur/stojaca-lampa-bonheur_1.webp',
  ARRAY['https://kochlik.netlify.app/images/stojaca-lampa-bonheur/stojaca-lampa-bonheur_1.webp', 'https://kochlik.netlify.app/images/stojaca-lampa-bonheur/stojaca-lampa-bonheur_2.webp', 'https://kochlik.netlify.app/images/stojaca-lampa-bonheur/stojaca-lampa-bonheur_3.webp', 'https://kochlik.netlify.app/images/stojaca-lampa-bonheur/stojaca-lampa-bonheur_4.webp']::text[],
  '[{"name":"Luce RGB con cavo","hex":null,"image_url":null,"family":null},{"name":"luce bianca con cavo","hex":null,"image_url":null,"family":"Biela"}]'::jsonb,
  ARRAY['Biela']::text[],
  ARRAY['56 x 180 cm']::text[],
  ARRAY['Nad 150 cm']::text[],
  '[]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/products/bonheur-floorlamp?_pos=2&_psq=Bonheur&_ss=e&_v=1.0',
  'https://serralunga.com/products/bonheur-floorlamp?_pos=2&_psq=Bonheur&_ss=e&_v=1.0',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'nabytok' LIMIT 1),
  'Ripple Table',
  'ripple-table',
  'Serralunga',
  43700,
  NULL,
  'Súprava „Ripple“ – exteriérový stolík a pohovka – bola navrhnutá štúdiom Zaha Hadid Architects pre Serralunga. Stolík Ripple sa vyznačuje charakteristickou vlnitou formou, inšpirovanou pohybom vody. Hladké krivky a plynulé línie vytvárajú dojem toku, ľahkosti a dynamiky. Tvar stolíka evokuje vysokú vlnu prichádzajúcu na breh, ktorá sa postupne znižuje v elegantnom pohybe. Tento mestský exteriérový stolík je navrhnutý tak, aby harmonicky zapadol do vonkajších priestorov a vniesol do nich pocit pohybu, energie a modernej estetiky. Ripple Table je dostupný aj v povrchovej úprave Moleskin, registrovaný dizajn, ktorá dodáva produktu teplo, textúru a sofistikovaný charakter.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/en/products/ripple-table?_pos=1&_psq=Ripple+Table&_ss=e&_v=1.0)',
  'https://kochlik.netlify.app/images/ripple-table/ripple-table_1.webp',
  ARRAY['https://kochlik.netlify.app/images/ripple-table/ripple-table_1.webp']::text[],
  '[{"name":"ANTRACITE","hex":null,"image_url":null,"family":"Sivá"},{"name":"NEVE DI SAN CANDIDO","hex":null,"image_url":null,"family":"Biela"},{"name":"SALVA DI SARDEGNA","hex":null,"image_url":null,"family":"Zelená"},{"name":"AZZURRO DI PROVENZA","hex":null,"image_url":null,"family":"Modrá"},{"name":"ACQUA DELLA MADDALENA","hex":null,"image_url":null,"family":"Modrá"},{"name":"VERDE PAVONE","hex":null,"image_url":null,"family":"Zelená"}]'::jsonb,
  ARRAY['Biela', 'Modrá', 'Sivá', 'Zelená']::text[],
  ARRAY[]::text[],
  ARRAY[]::text[],
  '[]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/en/products/ripple-table?_pos=1&_psq=Ripple+Table&_ss=e&_v=1.0',
  'https://serralunga.com/en/products/ripple-table?_pos=1&_psq=Ripple+Table&_ss=e&_v=1.0',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'nabytok' LIMIT 1),
  'Stolička Regista',
  'stolicka-regista',
  'Serralunga',
  56000,
  NULL,
  'Typická režisérska stolička bola znovu interpretovaná v exteriérovej verzii z polyamidu, ktorú navrhol Michel Boucquillon pre Serralunga. Použitý materiál robí túto záhradnú stoličku mimoriadne ľahkou, pričom po zložení má hrúbku iba 14 cm. Vysoko odolná zváraná tkanina je rovnakého typu, aký sa bežne používa v nábytkových textíliách na lodiach, čo zaručuje dlhú životnosť aj pri vonkajšom použití. Stolička Regista sa dodáva ako súprava 2 kusov.
Rozmer
52 x 44 x 83 cm
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/en/products/regista-chair?_pos=1&_psq=Regista&_ss=e&_v=1.0)',
  'https://kochlik.netlify.app/images/stolicka-regista/stolicka-regista_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/stolicka-regista/stolicka-regista_1.jpg']::text[],
  '[{"name":"BIANCO","hex":null,"image_url":null,"family":"Biela"}]'::jsonb,
  ARRAY['Biela']::text[],
  ARRAY['14 cm', '44 x 83 cm']::text[],
  ARRAY['Do 50 cm', '51-100 cm']::text[],
  '[]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/en/products/regista-chair?_pos=1&_psq=Regista&_ss=e&_v=1.0',
  'https://serralunga.com/en/products/regista-chair?_pos=1&_psq=Regista&_ss=e&_v=1.0',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'nabytok' LIMIT 1),
  'Sedadlo Boom',
  'sedadlo-boom',
  'Plust',
  14500,
  NULL,
  'Sedadlo Boom bola navrhnutá ako univerzálny prvok, ktorý možno použiť buď ako malú stoličku, alebo ako odkladací stolík ku kreslu. Jej charakteristický dizajn ju robí ľahko rozpoznateľným doplnkom, ktorý sa harmonicky začlení do širokej škály prostredí.
Rozmer
51 x 51 x 40 cm
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.plust.it/en/products/boom-low-stool/)',
  'https://kochlik.netlify.app/images/sedadlo-boom/sedadlo-boom_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/sedadlo-boom/sedadlo-boom_1.jpg', 'https://kochlik.netlify.app/images/sedadlo-boom/sedadlo-boom_2.gif', 'https://kochlik.netlify.app/images/sedadlo-boom/sedadlo-boom_3.gif', 'https://kochlik.netlify.app/images/sedadlo-boom/sedadlo-boom_4.gif', 'https://kochlik.netlify.app/images/sedadlo-boom/sedadlo-boom_5.gif', 'https://kochlik.netlify.app/images/sedadlo-boom/sedadlo-boom_6.gif']::text[],
  '[{"name":"White C2","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_c2_whitec2.jpg","family":"Biela"},{"name":"Mint","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_v5_mint.jpg","family":"Zelená"},{"name":"Tide","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_v6_tide.jpg","family":"Béžová"},{"name":"Creta","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_v7_creta.jpg","family":"Béžová"},{"name":"Decor","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_z3_decor.jpg","family":"Béžová"},{"name":"Grain","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_z6_grain.jpg","family":"Béžová"},{"name":"White light","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_u1_whitelight.jpg","family":"Biela"}]'::jsonb,
  ARRAY['Béžová', 'Biela', 'Zelená']::text[],
  ARRAY['51 x 40 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb,
  'https://www.plust.it/en/products/boom-low-stool/',
  'https://www.plust.it/en/products/boom-low-stool/',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'dizajnove' LIMIT 1),
  'Buba',
  'buba',
  'Plust',
  60000,
  NULL,
  'Elegantná váza so štíhlym, no výrazným tvarom, ktorá vynikne po oboch stranách vstupu alebo chodníka – či už v minimalistickom štýle, alebo ako dominantný dizajnový prvok. Ideálna na rastliny a stredne vysoké dekorácie so zvislým rastom, vhodná do interiéru aj exteriéru. V svietiacej verzii vytvára jemné, rozptýlené svetlo a dodáva priestoru pôsobivú atmosféru.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.plust.it/en/products/buba/)',
  'https://kochlik.netlify.app/images/buba/buba_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/buba/buba_1.jpg', 'https://kochlik.netlify.app/images/buba/buba_2.jpg', 'https://kochlik.netlify.app/images/buba/buba_3.jpg']::text[],
  '[{"name":"White C2","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_c2_whitec2.jpg","family":"Biela"},{"name":"Granite","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_s4_granite.jpg","family":"Sivá"},{"name":"Stone","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_u4_stone.jpg","family":"Sivá"},{"name":"White light","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_u1_whitelight.jpg","family":"Biela"}]'::jsonb,
  ARRAY['Biela', 'Sivá']::text[],
  ARRAY[]::text[],
  ARRAY[]::text[],
  '[]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb,
  'https://www.plust.it/en/products/buba/',
  'https://www.plust.it/en/products/buba/',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'dizajnove' LIMIT 1),
  'Kvetináč Missed Tree I',
  'kvetinac-missed-tree-i',
  'Serralunga',
  153000,
  NULL,
  'Kvetináč Missed Tree, navrhnutý Jean-Marie Massaud pre Serralunga, vdychuje život fantazijnej „duchovnej“ lesnej krajine. Vytvára pôsobivé exteriérové priestory, ktoré spájajú technologické a etnické tvary, čím dáva interiérovým aj exteriérovým rastlinám dôstojnosť a výraz stromu. Missed Tree je dizajnový kvetináč výrazných rozmerov, ktorý pôsobí ako sochársky prvok a dodáva priestoru umelecký aj prirodzený charakter.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/en/products/missed-tree-planter-i?_pos=1&_psq=Missed+Tree+I&_ss=e&_v=1.0)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/kvetinac-missed-tree-i/kvetinac-missed-tree-i_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/kvetinac-missed-tree-i/kvetinac-missed-tree-i_1.jpg']::text[],
  '[{"name":"ANTRACITE","hex":null,"image_url":null,"family":"Sivá"},{"name":"AZZURRO DI PROVENZA","hex":null,"image_url":null,"family":"Modrá"},{"name":"ROSSO","hex":null,"image_url":null,"family":"Červená"},{"name":"SALVIA DI SARDEGNA","hex":null,"image_url":null,"family":"Zelená"},{"name":"TORTORA DI TORINO","hex":null,"image_url":null,"family":"Hnedá"},{"name":"BIANCO","hex":null,"image_url":null,"family":"Biela"},{"name":"VERDE PAVONE","hex":null,"image_url":null,"family":"Zelená"},{"name":"LACQUEROSSO BIANCO","hex":null,"image_url":null,"family":"Biela"},{"name":"GIALLO SAHARA","hex":null,"image_url":null,"family":"Žltá"},{"name":"VERDE BRITISH","hex":null,"image_url":null,"family":"Zelená"},{"name":"ROSSO POMPEIANO","hex":null,"image_url":null,"family":"Červená"}]'::jsonb,
  ARRAY['Biela', 'Červená', 'Hnedá', 'Modrá', 'Sivá', 'Zelená', 'Žltá']::text[],
  ARRAY['50x42x259 cm']::text[],
  ARRAY['Nad 150 cm']::text[],
  '[{"label":"50x42x259 cm","dimensions":"50x42x259 cm","price_cents":153000,"attributes":{"rozmer":"50x42x259 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"50x42x259 cm"}]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/en/products/missed-tree-planter-i?_pos=1&_psq=Missed+Tree+I&_ss=e&_v=1.0',
  'https://serralunga.com/en/products/missed-tree-planter-i?_pos=1&_psq=Missed+Tree+I&_ss=e&_v=1.0',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'nabytok' LIMIT 1),
  'Stolík T ball',
  'stolik-t-ball',
  'Plust',
  36000,
  NULL,
  'Navrhnutá dizajnérom Albertom Brogliatom, kolekcia Gumball Junior Family je venovaná detskému svetu a zahŕňa kreslo, pohovku a nízky stolík. Všetky prvky sú plne ergonomické, bez ostrých hrán, a poskytujú deťom bezpečné a pohodlné miesto na oddych po veľkých dobrodružstvách – alebo ako základňu pre nové hry a fantazijné výpravy.
Rozmer
77 x 77 x 33 cm
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.plust.it/en/products/t-ball-2/)',
  'https://kochlik.netlify.app/images/stolik-t-ball/stolik-t-ball_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/stolik-t-ball/stolik-t-ball_1.jpg', 'https://kochlik.netlify.app/images/stolik-t-ball/stolik-t-ball_2.jpg', 'https://kochlik.netlify.app/images/stolik-t-ball/stolik-t-ball_3.jpg', 'https://kochlik.netlify.app/images/stolik-t-ball/stolik-t-ball_4.jpg', 'https://kochlik.netlify.app/images/stolik-t-ball/stolik-t-ball_5.jpg', 'https://kochlik.netlify.app/images/stolik-t-ball/stolik-t-ball_6.jpg', 'https://kochlik.netlify.app/images/stolik-t-ball/stolik-t-ball_7.jpg']::text[],
  '[{"name":"Pearl black","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_87_pearlblack.jpg","family":"Čierna"},{"name":"White C2","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_c2_whitec2.jpg","family":"Biela"},{"name":"Taupe","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_g9_taupe.jpg","family":"Hnedá"},{"name":"Sandy","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_m9_sandy.jpg","family":"Béžová"},{"name":"Golden rust","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_n4_goldenrust.jpg","family":"Hnedá"},{"name":"Aquamarina","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_s8_aquamarina.jpg","family":"Modrá"},{"name":"Lava","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_u0_lava.jpg","family":"Sivá"},{"name":"White light","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_u1_whitelight.jpg","family":"Biela"},{"name":"Ochre","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_u3_ochre.jpg","family":"Žltá"},{"name":"Mint","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_v5_mint.jpg","family":"Zelená"},{"name":"Tide","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_v6_tide.jpg","family":"Béžová"},{"name":"Creta","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_v7_creta.jpg","family":"Béžová"},{"name":"Decor","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_z3_decor.jpg","family":"Béžová"},{"name":"White Light-White","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_v8_whitelight-white.jpg","family":"Biela"},{"name":"White Light-Tortora","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_x4_whitelight-tortora.jpg","family":"Biela"},{"name":"White Light-Pearl black","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_x5_whitelight-pearlblack.jpg","family":"Biela"},{"name":"White Light-Golden rust","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_x6_whitelight-goldenrust.jpg","family":"Biela"},{"name":"Decor","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_z5_decor.jpg","family":"Béžová"},{"name":"Tortora","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_g9_tortora.jpg","family":"Hnedá"}]'::jsonb,
  ARRAY['Béžová', 'Biela', 'Čierna', 'Hnedá', 'Modrá', 'Sivá', 'Zelená', 'Žltá']::text[],
  ARRAY['77 x 33 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb,
  'https://www.plust.it/en/products/t-ball-2/',
  'https://www.plust.it/en/products/t-ball-2/',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'nabytok' LIMIT 1),
  'Lavička Twist',
  'lavickatwist',
  'Plust',
  35000,
  NULL,
  'Lavica Twist sa vyznačuje zaobleným a kompaktným tvarom, ktorý sa dokonale začleňuje do zložitejších kompozícií nábytkovej kolekcie Twist. Slúži ako spojovací prvok medzi zakrivenými modulmi a kvetináčmi. Jej čistý geometrický profil kopíruje plynulý pohyb celého usporiadania, čím pomáha vytvárať harmonický a funkčný priestor. Lavica Twist je dostupná aj ako samostatný prvok – svojím kompaktným a elegantným tvarom je ideálna do verejných priestorov, vstupných hál či komerčných zón, kde sa vyžaduje decentné, no sofistikované sedenie. Modulárny systém Twist, pozostávajúci zo sedačky, lavice a kvetináča, vytvára plynulé a organické kompozície, ktoré pozývajú k oddychu. Vďaka svojej univerzálnosti nie je lavica len doplnkom, ale skutočným architektonickým prvkom, ktorý obohacuje verejné aj súkromné, mestské aj zmluvné priestory. Dostupná je v novej textúrovanej povrchovej úprave Grain a vo farbách Z7 Red, White Light, Stone a Ground.
Rozmer
104 x 47 x 38 cm
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.plust.it/en/products/twist-bench/)',
  'https://kochlik.netlify.app/images/lavickatwist/lavickatwist_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/lavickatwist/lavickatwist_1.jpg']::text[],
  '[{"name":"Stone","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_u4_stone.jpg","family":"Sivá"},{"name":"Ground","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_x8_ground.jpg","family":"Sivá"},{"name":"Grain","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_z6_grain.jpg","family":"Béžová"},{"name":"Red","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_z7_red.jpg","family":"Červená"},{"name":"White light","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_u1_whitelight.jpg","family":"Biela"}]'::jsonb,
  ARRAY['Béžová', 'Biela', 'Červená', 'Sivá']::text[],
  ARRAY['47 x 38 cm']::text[],
  ARRAY['Do 50 cm']::text[],
  '[]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb,
  'https://www.plust.it/en/products/twist-bench/',
  'https://www.plust.it/en/products/twist-bench/',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'moderne-kvetinace' LIMIT 1),
  'KUBE TOWER',
  'kube-tower',
  'Euro3plast',
  28900,
  NULL,
  'Štýl je synonymom minimalizmu – dokonale zhrnutý v čistých a jednoduchých líniách našich kvetináčov a doplnkov. Skombinovali sme čisté profily s farebnou paletou pre každý vkus – od výraznej kyslej zelene a červenej po klasické odtiene – aby ste obohatili svoje obľúbené priestory harmóniou a eleganciou.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.euro3plast.com/gb/-/352-3363-kube-tower.html#/332-colour-white_c2/626-significant_measure-70)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/kube-tower/kube-tower_1.webp',
  ARRAY['https://kochlik.netlify.app/images/kube-tower/kube-tower_1.webp']::text[],
  '[{"name":"WHITE C2","hex":"#ffffff","image_url":null,"family":"Biela"},{"name":"RUST","hex":"#543920","image_url":null,"family":"Hnedá"},{"name":"TAUPE","hex":"#706961","image_url":null,"family":"Hnedá"},{"name":"CEMENT","hex":"#999390","image_url":null,"family":"Sivá"},{"name":"GRANITE","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/e3p_kube-tower_granite.jpg","family":"Sivá"},{"name":"PEARL BLACK","hex":"#4a4a49","image_url":null,"family":"Čierna"}]'::jsonb,
  ARRAY['Biela', 'Čierna', 'Hnedá', 'Sivá']::text[],
  ARRAY['70x30x90 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[{"label":"70x30x90 cm","dimensions":"70x30x90 cm","price_cents":28900,"attributes":{"rozmer":"70x30x90 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"70x30x90 cm"}]'::jsonb,
  '[{"label":"Technický dokument","url":"https://www.euro3plast.com/sheets/kube_tower_cassetta_con_doppia_parete.pdf"},{"label":"Informačný dokument","url":"https://www.euro3plast.com/sheets/kube_tower_plant_box_with_double_wall_info_en.pdf"}]'::jsonb,
  'https://www.euro3plast.com/gb/-/352-3363-kube-tower.html#/332-colour-white_c2/626-significant_measure-70',
  'https://www.euro3plast.com/gb/-/352-3363-kube-tower.html#/332-colour-white_c2/626-significant_measure-70',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'nabytok' LIMIT 1),
  'Rohové kreslo Big Cut',
  'rohove-kreslo-big-cut',
  'Plust',
  110000,
  NULL,
  'Modul bez opierok na ruky, ktorý možno použiť samostatne alebo v kombinácii s ďalšími prvkami kolekcie Big Cut. V spojení s rohovým modulom Big Cut Corner vytvorí pohovku s požadovanými rozmermi a tvarom. Súčasťou je vankúš vhodný na použitie v interiéri aj exteriéri. Dostupné aj v svietiacej verzii.
Rozmer
81 x 81 x 73 cm
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.plust.it/en/products/big-cut-corner/)',
  'https://kochlik.netlify.app/images/rohove-kreslo-big-cut/rohove-kreslo-big-cut_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/rohove-kreslo-big-cut/rohove-kreslo-big-cut_1.jpg', 'https://kochlik.netlify.app/images/rohove-kreslo-big-cut/rohove-kreslo-big-cut_2.jpg', 'https://kochlik.netlify.app/images/rohove-kreslo-big-cut/rohove-kreslo-big-cut_3.jpg', 'https://kochlik.netlify.app/images/rohove-kreslo-big-cut/rohove-kreslo-big-cut_4.jpg']::text[],
  '[{"name":"White-White","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_l6_white-white.jpg","family":"Biela"},{"name":"White-Orange","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_l7_white-orange.jpg","family":"Biela"},{"name":"White-Taupe","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_l8_white-taupe.jpg","family":"Biela"},{"name":"Taupe-White","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_m6_taupe-white.jpg","family":"Biela"},{"name":"Taupe-Orange","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_m7_taupe-orange.jpg","family":"Hnedá"},{"name":"Taupe-Taupe","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_m8_taupe-taupe.jpg","family":"Hnedá"},{"name":"White Light-White","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_v8_whitelight-white.jpg","family":"Biela"},{"name":"White Light-Orange","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_x3_whitelight-orange.jpg","family":"Biela"},{"name":"White Light-Tortora","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_x4_whitelight-tortora.jpg","family":"Biela"}]'::jsonb,
  ARRAY['Biela', 'Hnedá']::text[],
  ARRAY['81 x 73 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb,
  'https://www.plust.it/en/products/big-cut-corner/',
  'https://www.plust.it/en/products/big-cut-corner/',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'moderne-kvetinace' LIMIT 1),
  'Kvetináč TISÍCRIADKOVÝ  štvorec',
  'kvetinac-tisicriadkovy-stvorec',
  'Euro3plast',
  14500,
  NULL,
  'Kolekcia Style je elegantná a nadčasová: tieto kvetináče a dekorácie s klasickým šarmom dodajú záhradám a terasám sofistikovaný vzhľad a po prvom použití sa stanú nepostrádateľné. Dokonale dopĺňajú priestory, ktoré sa rady nechávajú obdivovať.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.euro3plast.com/gb/-/310-millerighe.html)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/kvetinac-tisicriadkovy-stvorec/kvetinac-tisicriadkovy-stvorec_1.webp',
  ARRAY['https://kochlik.netlify.app/images/kvetinac-tisicriadkovy-stvorec/kvetinac-tisicriadkovy-stvorec_1.webp']::text[],
  '[{"name":"TERRA DI SIENA","hex":"#e3945b","image_url":null,"family":"Červená"}]'::jsonb,
  ARRAY['Červená']::text[],
  ARRAY['55x55x45 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[{"label":"55x55x45 cm","dimensions":"55x55x45 cm","price_cents":14500,"attributes":{"rozmer":"55x55x45 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"55x55x45 cm"}]'::jsonb,
  '[{"label":"Technický dokument","url":"https://www.euro3plast.com/sheets/millerighe_vaso_quadro.pdf"},{"label":"Informačný dokument","url":"https://www.euro3plast.com/sheets/millerighe_square_pot_info_en.pdf"}]'::jsonb,
  'https://www.euro3plast.com/gb/-/310-millerighe.html',
  'https://www.euro3plast.com/gb/-/310-millerighe.html',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'nabytok' LIMIT 1),
  'Kreslo Canisse',
  'kreslo-canisse',
  'Serralunga',
  336000,
  NULL,
  'Súčasťou balenia je 1 operadlový vankúš a 2 bočné vankúše. V spolupráci s francúzskym dizajnérom Philippom Nigrom vytvorila spoločnosť Serralunga kolekciu Canisse – vonkajšie kreslo s prirodzeným, organickým charakterom, ktoré evokuje pocit útočiska pod otvorenou oblohou. Veľké mäkké vankúše pozývajú k odpočinku, zatiaľ čo dekoratívne operadlo pôsobí ako umelecký prvok súčasného talianskeho dizajnu. Kreslo Canisse sa ideálne hodí do exteriérových priestorov, no v interiéri vytvára eklektickú atmosféru s dôrazom na originalitu – v duchu hesla „The First, The Original“ značky Serralunga. Dizajn je inšpirovaný rastlinou z pobrežia Stredozemného mora – trstinou, ktorá sa v minulosti sušila a viazala do rohoží slúžiacich ako ochrana pred slnkom, vetrom a zvedavými pohľadmi. Tieto „cannes de Provence“, premenené na symbolické „les canisses“, ožívajú v podobe vonkajšieho sedenia, ktoré pripomína jemnú ohradu z prepletených prútov – ľahkú, prirodzenú a zároveň pevnú konštrukciu.
Rozmer
97 x 88 x 80 cm
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/en/products/canisse-armchair?_pos=2&_psq=Canisse&_ss=e&_v=1.0)',
  'https://kochlik.netlify.app/images/kreslo-canisse/kreslo-canisse_1.webp',
  ARRAY['https://kochlik.netlify.app/images/kreslo-canisse/kreslo-canisse_1.webp', 'https://kochlik.netlify.app/images/kreslo-canisse/kreslo-canisse_2.webp', 'https://kochlik.netlify.app/images/kreslo-canisse/kreslo-canisse_3.webp', 'https://kochlik.netlify.app/images/kreslo-canisse/kreslo-canisse_4.webp', 'https://kochlik.netlify.app/images/kreslo-canisse/kreslo-canisse_5.webp']::text[],
  '[{"name":"BIANCO","hex":null,"image_url":null,"family":"Biela"},{"name":"TORTORA DI TORINO","hex":null,"image_url":null,"family":"Hnedá"},{"name":"ANTRACITE","hex":null,"image_url":null,"family":"Sivá"}]'::jsonb,
  ARRAY['Biela', 'Hnedá', 'Sivá']::text[],
  ARRAY['88 x 80 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/en/products/canisse-armchair?_pos=2&_psq=Canisse&_ss=e&_v=1.0',
  'https://serralunga.com/en/products/canisse-armchair?_pos=2&_psq=Canisse&_ss=e&_v=1.0',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'nabytok' LIMIT 1),
  'Stolík T ball 2',
  'stolik-t-ball-2',
  'Plust',
  36000,
  NULL,
  'Stôl / Kontajner Vďaka pridaniu uzatváracej dosky k váze T Ball získava tento prvok nové funkcie a možnosti využitia. Môže slúžiť ako konferenčný stolík alebo úložný kontajner, najmä v kombinácii s kreslami Gumball, Settembre a Boom. Dostupný je aj v svietiacej verzii a možno ho kombinovať s ktorýmkoľvek prvkom kolekcie PLUST, čím sa stáva univerzálnym doplnkom do moderných interiérov aj exteriérov.
Rozmer
77 x 77 x 33 cm
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.plust.it/en/products/t-ball/)',
  'https://kochlik.netlify.app/images/stolik-t-ball-2/stolik-t-ball-2_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/stolik-t-ball-2/stolik-t-ball-2_1.jpg', 'https://kochlik.netlify.app/images/stolik-t-ball-2/stolik-t-ball-2_2.jpg', 'https://kochlik.netlify.app/images/stolik-t-ball-2/stolik-t-ball-2_3.jpg']::text[],
  '[{"name":"White C2","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_c2_whitec2.jpg","family":"Biela"}]'::jsonb,
  ARRAY['Biela']::text[],
  ARRAY['77 x 33 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb,
  'https://www.plust.it/en/products/t-ball/',
  'https://www.plust.it/en/products/t-ball/',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'dizajnove' LIMIT 1),
  'Ninfea',
  'ninfea',
  'Plust',
  15000,
  NULL,
  'Plávajúca váza dostupná v dvoch veľkostiach. Ideálna na použitie v exteriéroch s prírodnými alebo umelými vodnými plochami. Okrem funkcie kvetináča môže slúžiť aj ako plávajúca nádoba v prostrediach, ako sú vonkajšie bazény alebo wellness centrá.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.plust.it/en/products/ninfea/)',
  'https://kochlik.netlify.app/images/ninfea/ninfea_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/ninfea/ninfea_1.jpg', 'https://kochlik.netlify.app/images/ninfea/ninfea_2.png', 'https://kochlik.netlify.app/images/ninfea/ninfea_3.jpg']::text[],
  '[{"name":"Acid green","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_86_acidgreen.jpg","family":"Zelená"},{"name":"Orange A5","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_a5_orangea5.jpg","family":"Oranžová"},{"name":"White C2","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_c2_whitec2.jpg","family":"Biela"}]'::jsonb,
  ARRAY['Biela', 'Oranžová', 'Zelená']::text[],
  ARRAY['57x57x29 cm', '72x72x36 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[{"label":"57x57x29 cm","dimensions":"57x57x29 cm","price_cents":15000,"attributes":{"rozmer":"57x57x29 cm"}},{"label":"72x72x36 cm","dimensions":"72x72x36 cm","price_cents":30000,"attributes":{"rozmer":"72x72x36 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"57x57x29 cm, 72x72x36 cm"}]'::jsonb,
  '[]'::jsonb,
  'https://www.plust.it/en/products/ninfea/',
  'https://www.plust.it/en/products/ninfea/',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'moderne-kvetinace' LIMIT 1),
  'Kvetináč SIEPI štvorcový s dvojitou stenou',
  'kvetinac-siepi-stvorcovy-s-dvojitou-stenou',
  'Euro3plast',
  17600,
  NULL,
  'Kolekcia Style je elegantná a nadčasová: tieto kvetináče a dekorácie s klasickým šarmom dodajú záhradám a terasám sofistikovaný vzhľad a po prvom použití sa stanú nepostrádateľné. Dokonale dopĺňajú priestory, ktoré sa rady nechávajú obdivovať.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.euro3plast.com/gb/products/316-3040-siepi.html#/377-colour-taupe/618-significant_measure-55)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/kvetinac-siepi-stvorcovy-s-dvojitou-stenou/kvetinac-siepi-stvorcovy-s-dvojitou-stenou_1.webp',
  ARRAY['https://kochlik.netlify.app/images/kvetinac-siepi-stvorcovy-s-dvojitou-stenou/kvetinac-siepi-stvorcovy-s-dvojitou-stenou_1.webp']::text[],
  '[{"name":"TAUPE","hex":"#706961","image_url":null,"family":"Hnedá"},{"name":"TERRA DI SIENA","hex":"#e3945b","image_url":null,"family":"Červená"},{"name":"PEARL BLACK","hex":"#4a4a49","image_url":null,"family":"Čierna"}]'::jsonb,
  ARRAY['Červená', 'Čierna', 'Hnedá']::text[],
  ARRAY['55x55x48 cm', '71x71x62 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[{"label":"55x55x48 cm","dimensions":"55x55x48 cm","price_cents":17600,"attributes":{"rozmer":"55x55x48 cm"}},{"label":"71x71x62 cm","dimensions":"71x71x62 cm","price_cents":29100,"attributes":{"rozmer":"71x71x62 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"55x55x48 cm, 71x71x62 cm"}]'::jsonb,
  '[{"label":"Technický dokument","url":"https://www.euro3plast.com/sheets/siepi_vaso_quadro_con_doppia_parete.pdf"},{"label":"Informačný dokument","url":"https://www.euro3plast.com/sheets/siepi_square_pot_with_double_wall_info_en.pdf"}]'::jsonb,
  'https://www.euro3plast.com/gb/products/316-3040-siepi.html#/377-colour-taupe/618-significant_measure-55',
  'https://www.euro3plast.com/gb/products/316-3040-siepi.html#/377-colour-taupe/618-significant_measure-55',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'klasicke-kvetinace' LIMIT 1),
  'Hrantík RETTANGOLARE RUVIDA',
  'hrantik-rettangolare-ruvida',
  'Serralunga',
  7100,
  NULL,
  'Hrantík Rettangolare Ruvida od Serralunga evokuje prírodný charakter svojím drsným, nepravidelným povrchom, ktorý mu dodáva vážny a ušľachtilý vzhľad. Je súčasťou línie Graniglia z kolekcie Serralunga 1825, ktorej povrchová štruktúra pripomína staré kamenné kvetináče. Tento dizajn zdôrazňuje prirodzenú krásu materiálu a prináša do priestoru autentický dotyk tradície a elegancie.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/en/products/rettangolare-ruvida?_pos=1&_psq=RETTANGOLARE+RUVIDA&_ss=e&_v=1.0)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/hrantik-rettangolare-ruvida/hrantik-rettangolare-ruvida_1.webp',
  ARRAY['https://kochlik.netlify.app/images/hrantik-rettangolare-ruvida/hrantik-rettangolare-ruvida_1.webp']::text[],
  '[{"name":"TORTORA DI TORINO","hex":null,"image_url":null,"family":"Hnedá"},{"name":"GESSO DI BOLOGNA","hex":null,"image_url":null,"family":"Biela"},{"name":"ANTRACITE","hex":null,"image_url":null,"family":"Sivá"},{"name":"AZZURRO DI PROVENZA","hex":null,"image_url":null,"family":"Modrá"},{"name":"PIETRA DELLE DOLOMITI","hex":null,"image_url":null,"family":"Sivá"},{"name":"SALVIA DI SARDEGNA","hex":null,"image_url":null,"family":"Zelená"},{"name":"TERRACOTTA TOSCANA","hex":null,"image_url":null,"family":"Červená"},{"name":"TERRACOTTA SCURA","hex":null,"image_url":null,"family":"Červená"},{"name":"VERDE PAVONE","hex":null,"image_url":null,"family":"Zelená"},{"name":"ROSSO","hex":null,"image_url":null,"family":"Červená"},{"name":"BIANCO","hex":null,"image_url":null,"family":"Biela"}]'::jsonb,
  ARRAY['Biela', 'Červená', 'Hnedá', 'Modrá', 'Sivá', 'Zelená']::text[],
  ARRAY['60x25cm', '80x31 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[{"label":"60x25cm","dimensions":"60x25cm","price_cents":7100,"attributes":{"rozmer":"60x25cm"}},{"label":"80x31 cm","dimensions":"80x31 cm","price_cents":8400,"attributes":{"rozmer":"80x31 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"60x25cm, 80×31 cm"}]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/en/products/rettangolare-ruvida?_pos=1&_psq=RETTANGOLARE+RUVIDA&_ss=e&_v=1.0',
  'https://serralunga.com/en/products/rettangolare-ruvida?_pos=1&_psq=RETTANGOLARE+RUVIDA&_ss=e&_v=1.0',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'nabytok' LIMIT 1),
  'Konferenčný stolík Vela',
  'konferencny-stolik-vela',
  'Plust',
  34000,
  NULL,
  'Konferenčný stolík VELA, navrhnutý umeleckými riaditeľmi BrogliatoTraverso, je doplnkom ku kreslu VELA. Inšpirovaný poetickým pozorovaním plachiet napnutých vetrom, pretvára tento pohyb do harmonického a elegantného tvaru, ktorý vyniká v každom priestore. VELA Coffee Table v sebe ukrýva praktický úložný priestor, ktorý zvyšuje funkčnosť bez kompromisov v štýle. Medzi najprepracovanejšie detaily patrí vyvýšený šev – vizuálny aj hmatový prvok, ktorý sleduje okraje a zvýrazňuje kontúry konštrukcie. Tento spojovací detail má lesklú povrchovú úpravu, ktorá kontrastuje s matným telom stolíka, čím podčiarkuje precíznosť a hodnotu dizajnu. Trojrozmerný efekt dodáva stolíku hĺbku a eleganciu, zatiaľ čo prešívanie odkazuje na remeselnú starostlivosť typickú pre taliansku výrobu. VELA Coffee Table je dostupný v rôznych povrchových úpravách: Lava, Grain, Pietra a Creta. Kolekcia VELA sa vyznačuje aj svojím vizuálnym pôvabom – v bielej svietiacej verzii (White Light) môžu byť jednotlivé kusy vybavené svetelnou sadou, ktorá ich premieňa na svietiace objekty vytvárajúce jedinečnú večernú atmosféru. Jemné svetlo prenikajúce materiálom zvýrazňuje švy ako grafický prvok, ktorý podčiarkuje geometriu kresla a konferenčného stolíka.
Rozmer
70 x 70 x 33 cm
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.plust.it/en/products/vela-coffee-table-structure/)',
  'https://kochlik.netlify.app/images/konferencny-stolik-vela/konferencny-stolik-vela_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/konferencny-stolik-vela/konferencny-stolik-vela_1.jpg', 'https://kochlik.netlify.app/images/konferencny-stolik-vela/konferencny-stolik-vela_2.gif', 'https://kochlik.netlify.app/images/konferencny-stolik-vela/konferencny-stolik-vela_3.gif']::text[],
  '[{"name":"Lava","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_u0_lava.jpg","family":"Sivá"},{"name":"White light","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_u1_whitelight.jpg","family":"Biela"},{"name":"Stone","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_u4_stone.jpg","family":"Sivá"},{"name":"Creta","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_v7_creta.jpg","family":"Béžová"},{"name":"Grain","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_z6_grain.jpg","family":"Béžová"},{"name":"Grain","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_grain_grain.jpg","family":"Béžová"},{"name":"White","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_white_white.jpg","family":"Biela"},{"name":"White Light-Grain","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_j0_whitelight-grain.jpg","family":"Biela"},{"name":"White Light-White","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_v8_whitelight-white.jpg","family":"Biela"}]'::jsonb,
  ARRAY['Béžová', 'Biela', 'Sivá']::text[],
  ARRAY['70 x 33 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb,
  'https://www.plust.it/en/products/vela-coffee-table-structure/',
  'https://www.plust.it/en/products/vela-coffee-table-structure/',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'nabytok' LIMIT 1),
  'Twist',
  'twist',
  'Plust',
  165000,
  NULL,
  'Twist je nová modulárna sedacia skulptúra značky Plust Outdoor Attitude, navrhnutá dizajnérskym duom BrogliatoTraverso. S odvážnymi líniami a silnou vizuálnou identitou prináša nový pohľad na exteriérový dizajn prostredníctvom trojrozmerného grafického tvaru. Vyrobený z rotačne tvarovaného polyetylénu, spája sochársku estetiku s ergonomickým komfortom, čím zaručuje výrazný vizuálny efekt aj praktickú funkčnosť. Modulárny systém, pozostávajúci zo sedačky, lavice a kvetináča, umožňuje prispôsobiteľné konfigurácie, ideálne pre lounge zóny, verejné priestory, zelené inštalácie či komerčné prostredia. Twist je dostupný v novej textúrovanej povrchovej úprave Grain a vo farbách Z7 Red, White Light, Stone a nadčasovej Ground.
Rozmer
189 x 113 x 84 cm',
  'https://kochlik.netlify.app/images/twist/twist_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/twist/twist_1.jpg']::text[],
  '[]'::jsonb,
  ARRAY[]::text[],
  ARRAY['113 x 84 cm']::text[],
  ARRAY['101-150 cm']::text[],
  '[]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb,
  'https://kochlik.sk/produkt/twist/',
  'https://kochlik.sk/produkt/twist/',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'moderne-kvetinace' LIMIT 1),
  'Kvetináč vysoký KUBE s kolieskami',
  'kvetinac-vysoky-kube-s-kolieskami',
  'Euro3plast',
  18100,
  NULL,
  'Štýl je synonymom minimalizmu – dokonale zhrnutý v čistých a jednoduchých líniách našich kvetináčov a doplnkov. Skombinovali sme čisté profily s farebnou paletou pre každý vkus – od výraznej kyslej zelene a červenej po klasické odtiene – aby ste obohatili svoje obľúbené priestory harmóniou a eleganciou.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.euro3plast.com/gb/-/341-3295-kube-high.html#/332-colour-white_c2/612-significant_measure-30)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/kvetinac-vysoky-kube-s-kolieskami/kvetinac-vysoky-kube-s-kolieskami_1.webp',
  ARRAY['https://kochlik.netlify.app/images/kvetinac-vysoky-kube-s-kolieskami/kvetinac-vysoky-kube-s-kolieskami_1.webp']::text[],
  '[{"name":"WHITE C2","hex":"#ffffff","image_url":null,"family":"Biela"},{"name":"RUST","hex":"#543920","image_url":null,"family":"Hnedá"},{"name":"TAUPE","hex":"#706961","image_url":null,"family":"Hnedá"},{"name":"CEMENT","hex":"#999390","image_url":null,"family":"Sivá"},{"name":"GRANITE","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/e3p_kvetinac-vysoky-kube-s-kolieskami_granite.jpg","family":"Sivá"},{"name":"LAVA","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/e3p_kvetinac-vysoky-kube-s-kolieskami_lava.jpg","family":"Sivá"},{"name":"STONE","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/e3p_kvetinac-vysoky-kube-s-kolieskami_stone.jpg","family":"Sivá"},{"name":"CRETA","hex":"#786e69","image_url":null,"family":"Béžová"},{"name":"PEARL BLACK","hex":"#4a4a49","image_url":null,"family":"Čierna"}]'::jsonb,
  ARRAY['Béžová', 'Biela', 'Čierna', 'Hnedá', 'Sivá']::text[],
  ARRAY['30x30x71 cm', '40x40x71 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[{"label":"30x30x71 cm","dimensions":"30x30x71 cm","price_cents":18100,"attributes":{"rozmer":"30x30x71 cm"}},{"label":"40x40x71 cm","dimensions":"40x40x71 cm","price_cents":23000,"attributes":{"rozmer":"40x40x71 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"30x30x71 cm, 40x40x71 cm"}]'::jsonb,
  '[{"label":"Technický dokument","url":"https://www.euro3plast.com/sheets/kube_high_vaso_con_doppia_parete_+_ruote.pdf"},{"label":"Informačný dokument","url":"https://www.euro3plast.com/sheets/kube_high_pot_with_double_wall_+_castors_info_en.pdf"}]'::jsonb,
  'https://www.euro3plast.com/gb/-/341-3295-kube-high.html#/332-colour-white_c2/612-significant_measure-30',
  'https://www.euro3plast.com/gb/-/341-3295-kube-high.html#/332-colour-white_c2/612-significant_measure-30',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'nabytok' LIMIT 1),
  'Sedačka Ohla',
  'sedacka-ohla',
  'Plust',
  95000,
  NULL,
  'Pohodlná trojmiestna pohovka s dynamickými a modernými líniami dopĺňa kolekciu Ohla a umožňuje vytvárať elegantné oddychové zóny. Perfektne ladí so stolíkom T Ball, ktorý slúži ako konferenčný stolík. Pohovka je vybavená dvoma svetelnými sadami, ktoré dodávajú priestoru charakter a štýlovú atmosféru.
Rozmer
160 x 80 x 78 cm
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.plust.it/en/products/ohla-sofa/)',
  'https://kochlik.netlify.app/images/sedacka-ohla/sedacka-ohla_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/sedacka-ohla/sedacka-ohla_1.jpg', 'https://kochlik.netlify.app/images/sedacka-ohla/sedacka-ohla_2.jpg', 'https://kochlik.netlify.app/images/sedacka-ohla/sedacka-ohla_3.jpg', 'https://kochlik.netlify.app/images/sedacka-ohla/sedacka-ohla_4.jpg']::text[],
  '[{"name":"White C2","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_c2_whitec2.jpg","family":"Biela"},{"name":"Granite","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_s4_granite.jpg","family":"Sivá"},{"name":"Stone","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_u4_stone.jpg","family":"Sivá"},{"name":"White light","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_u1_whitelight.jpg","family":"Biela"}]'::jsonb,
  ARRAY['Biela', 'Sivá']::text[],
  ARRAY['80 x 78 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb,
  'https://www.plust.it/en/products/ohla-sofa/',
  'https://www.plust.it/en/products/ohla-sofa/',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'nabytok' LIMIT 1),
  'Kreslo Ohla',
  'kreslo-ohla',
  'Plust',
  48000,
  NULL,
  'Kreslo z polyetylénu s dynamickými a modernými líniami predstavuje dokonalú kombináciu tvaru a funkcie, ktorá dodá priestoru elegantný a súčasný vzhľad. Vhodné na použitie v interiéri aj exteriéri, kde pôsobí štýlovo a osobito. Dokonale ladí so stolíkom T Ball, ktorý možno použiť ako konferenčný stolík. Dostupné aj v svietiacej verzii.
Rozmer
94 x 78 x 78 cm
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.plust.it/en/products/ohla-armchair/)',
  'https://kochlik.netlify.app/images/kreslo-ohla/kreslo-ohla_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/kreslo-ohla/kreslo-ohla_1.jpg', 'https://kochlik.netlify.app/images/kreslo-ohla/kreslo-ohla_2.jpg', 'https://kochlik.netlify.app/images/kreslo-ohla/kreslo-ohla_3.jpg', 'https://kochlik.netlify.app/images/kreslo-ohla/kreslo-ohla_4.jpg', 'https://kochlik.netlify.app/images/kreslo-ohla/kreslo-ohla_5.jpg']::text[],
  '[{"name":"White C2","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_c2_whitec2.jpg","family":"Biela"},{"name":"Granite","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_s4_granite.jpg","family":"Sivá"},{"name":"Stone","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_u4_stone.jpg","family":"Sivá"},{"name":"White light","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_u1_whitelight.jpg","family":"Biela"}]'::jsonb,
  ARRAY['Biela', 'Sivá']::text[],
  ARRAY['78 x 78 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb,
  'https://www.plust.it/en/products/ohla-armchair/',
  'https://www.plust.it/en/products/ohla-armchair/',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'nabytok' LIMIT 1),
  'Odkladací stolík Aqua',
  'odkladaci-stolik-aqua',
  'Serralunga',
  34000,
  NULL,
  'Aqua Table, navrhnutý Marcom Sadlerom pre Serralunga, je ideálnym doplnkom k ležadlu Aqua Sunlounger. Tento elegantný stolík je navrhnutý tak, aby dokonale ladil s dizajnom ležadla a ponúkal rovnakú flexibilitu – je vhodný na použitie pri bazéne aj priamo vo vode. Jeho čisté línie a harmonické proporcie vytvárajú dojem ľahkosti a súčasne poskytujú praktické miesto pre odkladanie nápojov alebo osobných vecí počas relaxu. Táto verzia je dostupná aj v povrchovej úprave Moleskin, s registrovaným dizajnom, ktorá dodáva produktu sofistikovaný a teplý charakter.
Rozmer
45 x 45 x 50cm
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/en/products/aqua-table?_pos=7&_sid=037cde17f&_ss=r)',
  'https://kochlik.netlify.app/images/odkladaci-stolik-aqua/odkladaci-stolik-aqua_1.webp',
  ARRAY['https://kochlik.netlify.app/images/odkladaci-stolik-aqua/odkladaci-stolik-aqua_1.webp', 'https://kochlik.netlify.app/images/odkladaci-stolik-aqua/odkladaci-stolik-aqua_2.webp', 'https://kochlik.netlify.app/images/odkladaci-stolik-aqua/odkladaci-stolik-aqua_3.webp', 'https://kochlik.netlify.app/images/odkladaci-stolik-aqua/odkladaci-stolik-aqua_4.webp', 'https://kochlik.netlify.app/images/odkladaci-stolik-aqua/odkladaci-stolik-aqua_5.webp']::text[],
  '[{"name":"BIANCO","hex":null,"image_url":null,"family":"Biela"},{"name":"AZZURRO DI PROVENZA","hex":null,"image_url":null,"family":"Modrá"},{"name":"SALVIA DI SARDEGNA","hex":null,"image_url":null,"family":"Zelená"},{"name":"MORE DI ROVO","hex":null,"image_url":null,"family":"Ružová"}]'::jsonb,
  ARRAY['Biela', 'Modrá', 'Ružová', 'Zelená']::text[],
  ARRAY['45 x 50cm']::text[],
  ARRAY['Do 50 cm']::text[],
  '[]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/en/products/aqua-table?_pos=7&_sid=037cde17f&_ss=r',
  'https://serralunga.com/en/products/aqua-table?_pos=7&_sid=037cde17f&_ss=r',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'nabytok' LIMIT 1),
  'Stolička Russel',
  'stolicka-russel',
  'Serralunga',
  46000,
  NULL,
  'Dizajn od Vico Magistretti pre Serralunga Stolička Russel predstavuje reinterpretáciu klasickej záhradnej stoličky – spája tradičné prvky s modernou technológiou, vďaka čomu pôsobí nadčasovo a odolne. Je to kúsok súčasného nábytku, ktorý je ideálny pre vonkajšie priestory aj moderné interiéry, pričom zvýrazňuje význam estetického a funkčného dizajnu v bývaní.
Rozmer
59 x 66 x 81 cm
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/en/products/russel-chair?_pos=2&_psq=Russel&_ss=e&_v=1.0)',
  'https://kochlik.netlify.app/images/stolicka-russel/stolicka-russel_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/stolicka-russel/stolicka-russel_1.jpg']::text[],
  '[{"name":"ANTHRACITE","hex":null,"image_url":null,"family":"Sivá"},{"name":"TORTORA DI TORINO","hex":null,"image_url":null,"family":"Hnedá"},{"name":"BIANCO","hex":null,"image_url":null,"family":"Biela"},{"name":"AZZURRO DI PROVENZA","hex":null,"image_url":null,"family":"Modrá"},{"name":"ROSSO","hex":null,"image_url":null,"family":"Červená"},{"name":"GIALLO SAHARA","hex":null,"image_url":null,"family":"Žltá"},{"name":"VERDE BRITISH","hex":null,"image_url":null,"family":"Zelená"},{"name":"ROSSO POMPEIANO","hex":null,"image_url":null,"family":"Červená"}]'::jsonb,
  ARRAY['Biela', 'Červená', 'Hnedá', 'Modrá', 'Sivá', 'Zelená', 'Žltá']::text[],
  ARRAY['66 x 81 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/en/products/russel-chair?_pos=2&_psq=Russel&_ss=e&_v=1.0',
  'https://serralunga.com/en/products/russel-chair?_pos=2&_psq=Russel&_ss=e&_v=1.0',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'nabytok' LIMIT 1),
  'Stôl Plust metal',
  'stol-plust-metal',
  'Plust',
  40000,
  NULL,
  '.
Rozmer
72 x 72 x 66 cm
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.plust.it/en/products/plust-table-metal-structure/)',
  'https://kochlik.netlify.app/images/stol-plust-metal/stol-plust-metal_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/stol-plust-metal/stol-plust-metal_1.jpg', 'https://kochlik.netlify.app/images/stol-plust-metal/stol-plust-metal_2.jpg']::text[],
  '[{"name":"Bianco","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_bianco_bianco.jpg","family":"Biela"},{"name":"Nero","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_nero_nero.jpg","family":"Čierna"},{"name":"Black","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_black_black.jpg","family":"Čierna"},{"name":"White","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_white_white.jpg","family":"Biela"}]'::jsonb,
  ARRAY['Biela', 'Čierna']::text[],
  ARRAY['72 x 66 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb,
  'https://www.plust.it/en/products/plust-table-metal-structure/',
  'https://www.plust.it/en/products/plust-table-metal-structure/',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'nabytok' LIMIT 1),
  'Sedačka Airball',
  'sedacka-airball',
  'Plust',
  152000,
  NULL,
  'Pohovka pre 2–3 osoby z kolekcie Gumball pôsobí výrazne a je ideálna do priestorov, ktoré si vyžadujú nábytok s osobitým charakterom. V kombinácii s kreslom vytvára atraktívnu zónu na oddych. Otvory na nepriehľadnom povrchu jej dodávajú výnimočnú ľahkosť v porovnaní s bežným nábytkom. Možno ju vybaviť dvoma RGB svetelnými sadami, ktoré vďaka širokej škále farieb vytvárajú svetelné efekty s výrazným emocionálnym nábojom.
Rozmer
165 x 88 x 66 cm
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.plust.it/en/products/airball-sofa/)',
  'https://kochlik.netlify.app/images/sedacka-airball/sedacka-airball_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/sedacka-airball/sedacka-airball_1.jpg', 'https://kochlik.netlify.app/images/sedacka-airball/sedacka-airball_2.jpg']::text[],
  '[{"name":"White C2","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_c2_whitec2.jpg","family":"Biela"}]'::jsonb,
  ARRAY['Biela']::text[],
  ARRAY['88 x 66 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb,
  'https://www.plust.it/en/products/airball-sofa/',
  'https://www.plust.it/en/products/airball-sofa/',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'svietiace-kvetinace' LIMIT 1),
  'GUĽA atmosféra so svetlom',
  'gula-atmosfera-so-svetlom',
  'Euro3plast',
  20200,
  NULL,
  'Funguje cez deň, scenografický v noci – lampy sú vybavené svetelnými sadami s garanciou a certifikáciou pre vonkajšie použitie. Finálny efekt je exkluzívny a podmanivý.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.euro3plast.com/gb/products/456-4255-sfera.html#/600-colour-neutral/615-significant_measure-45)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/gula-atmosfera-so-svetlom/gula-atmosfera-so-svetlom_1.webp',
  ARRAY['https://kochlik.netlify.app/images/gula-atmosfera-so-svetlom/gula-atmosfera-so-svetlom_1.webp']::text[],
  '[{"name":"NEUTRAL","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/e3p_gula-atmosfera-so-svetlom_neutral.jpg","family":"Biela"}]'::jsonb,
  ARRAY['Biela']::text[],
  ARRAY['40x40x38 cm', '55x55x53 cm', '71x71x69 cm']::text[],
  ARRAY['Do 50 cm', '51-100 cm']::text[],
  '[{"label":"40x40x38 cm","dimensions":"40x40x38 cm","price_cents":23200,"attributes":{"typ-ziarovky":"LED","rozmer":"40x40x38 cm"}},{"label":"55x55x53 cm","dimensions":"55x55x53 cm","price_cents":27300,"attributes":{"typ-ziarovky":"LED","rozmer":"55x55x53 cm"}},{"label":"71x71x69 cm","dimensions":"71x71x69 cm","price_cents":34000,"attributes":{"typ-ziarovky":"LED","rozmer":"71x71x69 cm"}},{"label":"40x40x38 cm","dimensions":"40x40x38 cm","price_cents":20200,"attributes":{"typ-ziarovky":"RGB","rozmer":"40x40x38 cm"}},{"label":"55x55x53 cm","dimensions":"55x55x53 cm","price_cents":24300,"attributes":{"typ-ziarovky":"RGB","rozmer":"55x55x53 cm"}},{"label":"71x71x69 cm","dimensions":"71x71x69 cm","price_cents":31000,"attributes":{"typ-ziarovky":"RGB","rozmer":"71x71x69 cm"}}]'::jsonb,
  '[{"key":"Typ žiarovky","value":"LED, RGB"},{"key":"Rozmer","value":"40x40x38 cm, 55x55x53 cm, 71x71x69 cm"}]'::jsonb,
  '[{"label":"Technický dokument","url":"https://www.euro3plast.com/sheets/sfera_lampada.pdf"},{"label":"Informačný dokument","url":"https://www.euro3plast.com/sheets/sfera_light_info_en.pdf"}]'::jsonb,
  'https://www.euro3plast.com/gb/products/456-4255-sfera.html#/600-colour-neutral/615-significant_measure-45',
  'https://www.euro3plast.com/gb/products/456-4255-sfera.html#/600-colour-neutral/615-significant_measure-45',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'doplnky' LIMIT 1),
  'Paraván Gradient',
  'paravan-gradient',
  'Plust',
  24000,
  NULL,
  'Modulárny deliaci prvok dostupný v dvoch výškach. Spájaním modulov pomocou strán hexagonálnej základne možno vytvárať stenové priečky na rozdelenie priestoru – pravidelné alebo nepravidelné, podľa potreby. Kombináciou dvoch alebo viacerých prvkov vznikajú pôsobivé kompozície, ktoré môžu pripomínať malé záhradky či rady nadrozmernej trávy, čím dodávajú priestoru hravosť a originalitu.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.plust.it/en/products/gradient/)',
  'https://kochlik.netlify.app/images/paravan-gradient/paravan-gradient_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/paravan-gradient/paravan-gradient_1.jpg', 'https://kochlik.netlify.app/images/paravan-gradient/paravan-gradient_2.jpg', 'https://kochlik.netlify.app/images/paravan-gradient/paravan-gradient_3.jpg']::text[],
  '[{"name":"Acid green","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_86_acidgreen.jpg","family":"Zelená"},{"name":"Green A2","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_a2_greena2.jpg","family":"Zelená"},{"name":"Green B7","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_b7_greenb7.jpg","family":"Zelená"},{"name":"White C2","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_c2_whitec2.jpg","family":"Biela"}]'::jsonb,
  ARRAY['Biela', 'Zelená']::text[],
  ARRAY['36x40x160 cm', '36x40x180 cm']::text[],
  ARRAY['Nad 150 cm']::text[],
  '[{"label":"36x40x160 cm","dimensions":"36x40x160 cm","price_cents":24000,"attributes":{"rozmer":"36x40x160 cm"}},{"label":"36x40x180 cm","dimensions":"36x40x180 cm","price_cents":27000,"attributes":{"rozmer":"36x40x180 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"36x40x160 cm, 36x40x180 cm"}]'::jsonb,
  '[]'::jsonb,
  'https://www.plust.it/en/products/gradient/',
  'https://www.plust.it/en/products/gradient/',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'moderne-kvetinace' LIMIT 1),
  'Kvetináč Liscio Siena',
  'kvetinac-liscio-siena',
  'Serralunga',
  5300,
  NULL,
  'Kvetináč Liscio Siena od značky Serralunga predstavuje dokonalú rovnováhu proporcií v kontraste s prirodzeným povrchom materiálu. Spája tóny vypálenej hliny a harmonické farby, ktoré evokujú jemnosť toskánskej terakoty. Tento kvetináč z kolekcie Serralunga 1825 Garden Décor má vrásčitý povrch, akoby bol ručnej výroby. Vďaka špeciálnemu spracovaniu pôsobí zámerne „nedokončeným“ dojmom, zatiaľ čo brúsený povrch mu dodáva elegantný keramický vzhľad. Model Liscio Siena patrí medzi klasické typy kvetináčov par excellence – vyznačuje sa štíhlym tvarom a jednoduchým dizajnom. Vďaka svojej univerzálnej veľkosti je ideálny na výsadbu kvetov a rastlín, ale aj na aranžovanie rezaných kvetov s dlhými stonkami. Je vhodný na použitie v interiéri aj exteriéri a môže slúžiť aj ako dekoratívny obal na kvetináč (cache-pot).
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/en/products/liscio-siena-planter?_pos=1&_psq=Liscio+Siena&_ss=e&_v=1.0)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/kvetinac-liscio-siena/kvetinac-liscio-siena_1.webp',
  ARRAY['https://kochlik.netlify.app/images/kvetinac-liscio-siena/kvetinac-liscio-siena_1.webp', 'https://kochlik.netlify.app/images/kvetinac-liscio-siena/kvetinac-liscio-siena_2.webp', 'https://kochlik.netlify.app/images/kvetinac-liscio-siena/kvetinac-liscio-siena_3.webp']::text[],
  '[{"name":"PIETRA DELLA DOLOMITI","hex":null,"image_url":null,"family":"Sivá"},{"name":"SALVIA DI SARDEGNA","hex":null,"image_url":null,"family":"Zelená"},{"name":"TERRACOTTA TOSCANA","hex":null,"image_url":null,"family":"Červená"},{"name":"GESSO DI BOLOGNA","hex":null,"image_url":null,"family":"Biela"},{"name":"ANTRACITE","hex":null,"image_url":null,"family":"Sivá"},{"name":"AZZURRO DI PROVENZA","hex":null,"image_url":null,"family":"Modrá"},{"name":"ROSSO","hex":null,"image_url":null,"family":"Červená"},{"name":"TERRACOTTA SCURA","hex":null,"image_url":null,"family":"Červená"},{"name":"TORTORA DI TORINO","hex":null,"image_url":null,"family":"Hnedá"},{"name":"BIANCO","hex":null,"image_url":null,"family":"Biela"},{"name":"VERDE PAVONE","hex":null,"image_url":null,"family":"Zelená"},{"name":"ACQUA DELLA MADDALENA","hex":null,"image_url":null,"family":"Modrá"},{"name":"GIALLO SAHARA","hex":null,"image_url":null,"family":"Žltá"},{"name":"VERDE BRITISH","hex":null,"image_url":null,"family":"Zelená"},{"name":"ROSSO POMPEIANO","hex":null,"image_url":null,"family":"Červená"}]'::jsonb,
  ARRAY['Biela', 'Červená', 'Hnedá', 'Modrá', 'Sivá', 'Zelená', 'Žltá']::text[],
  ARRAY['27x27x40,5 cm', '40x40x60,5 cm', '52,5x52,5x80 cm']::text[],
  ARRAY['Do 50 cm', '51-100 cm']::text[],
  '[{"label":"27x27x40,5 cm","dimensions":"27x27x40,5 cm","price_cents":5300,"attributes":{"rozmer":"27x27x40,5 cm"}},{"label":"40x40x60,5 cm","dimensions":"40x40x60,5 cm","price_cents":7900,"attributes":{"rozmer":"40x40x60,5 cm"}},{"label":"52,5x52,5x80 cm","dimensions":"52,5x52,5x80 cm","price_cents":28900,"attributes":{"rozmer":"52,5x52,5x80 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"27x27x40,5 cm, 40x40x60,5 cm, 52,5×52,5×80 cm"}]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/en/products/liscio-siena-planter?_pos=1&_psq=Liscio+Siena&_ss=e&_v=1.0',
  'https://serralunga.com/en/products/liscio-siena-planter?_pos=1&_psq=Liscio+Siena&_ss=e&_v=1.0',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'nabytok' LIMIT 1),
  'Taburetka Fade',
  'taburetka-fade',
  'Plust',
  11500,
  NULL,
  'Nízka stolička Fade je multifunkčný prvok, ktorý možno použiť aj ako odkladací stolík. Typická tieňovaná textúra, charakteristická pre celú kolekciu Fade, jej dodáva sochársky vzhľad a výnimočnú univerzálnosť. Dostupná je v piatich farebných odtieňoch – granite, clay, lava, stone a white light. V poslednej, svietiacej verzii, je možné ju vybaviť špeciálnou svetelnou sadou.
Rozmer
38 x 38 x 42 cm
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.plust.it/en/products/fade-low-stool/)',
  'https://kochlik.netlify.app/images/taburetka-fade/taburetka-fade_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/taburetka-fade/taburetka-fade_1.jpg', 'https://kochlik.netlify.app/images/taburetka-fade/taburetka-fade_2.jpg', 'https://kochlik.netlify.app/images/taburetka-fade/taburetka-fade_3.gif']::text[],
  '[{"name":"Granite","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_s4_granite.jpg","family":"Sivá"},{"name":"Lava","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_u0_lava.jpg","family":"Sivá"},{"name":"Stone","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_u4_stone.jpg","family":"Sivá"},{"name":"Creta","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_v7_creta.jpg","family":"Béžová"},{"name":"White light","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_u1_whitelight.jpg","family":"Biela"}]'::jsonb,
  ARRAY['Béžová', 'Biela', 'Sivá']::text[],
  ARRAY['38 x 42 cm']::text[],
  ARRAY['Do 50 cm']::text[],
  '[]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb,
  'https://www.plust.it/en/products/fade-low-stool/',
  'https://www.plust.it/en/products/fade-low-stool/',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'nabytok' LIMIT 1),
  'Kreslo Sirchster',
  'kresloosirchester',
  'Serralunga',
  71500,
  NULL,
  'Dizajn od Matteo Bazzicalupo a Raffaella Mangiarotti pre Serralunga Kreslo Sirchester je inšpirované pôvodným anglickým kreslom so známym „čalúneným efektom“. Táto nadčasová kolekcia, ktorá sa stala súčasťou histórie dizajnu, bola znovu interpretovaná v duchu modernej filozofie talianskej značky Serralunga. Pôvodná idea bola jasná – vytvoriť pohodlné a funkčné vonkajšie sedenie. Synergia medzi dizajnom a tvarom bola dosiahnutá vďaka know-how spoločnosti Serralunga, ktorá pomocou technológie rotačného formovania dokázala vytvoriť tvar evokujúci klasický čalúnený vzhľad. Výsledkom spolupráce dizajnérov Mangiarotti a Bazzicalupo je luxusný kus nábytku, ktorý spája emocionálnu tvorivosť s funkčnosťou, ideálny pre interiéry aj exteriéry, hotelové priestory či oddychové zóny. Toto prevedenie je dostupné aj v Moleskin úprave (Registered design), ktorá dodáva výrobku teplo, šarm a jedinečný charakter.
Rozmer
120 x 82 x 72 cm
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/en/products/sirchester-armchair?_pos=1&_psq=sirchester&_ss=e&_v=1.0)',
  'https://kochlik.netlify.app/images/kresloosirchester/kresloosirchester_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/kresloosirchester/kresloosirchester_1.jpg']::text[],
  '[{"name":"BIANCO","hex":null,"image_url":null,"family":"Biela"},{"name":"ANTRACITE","hex":null,"image_url":null,"family":"Sivá"},{"name":"TORTORA DI TORINO","hex":null,"image_url":null,"family":"Hnedá"},{"name":"TERRACOTTA SCURA","hex":null,"image_url":null,"family":"Červená"},{"name":"VERDE PAVONE","hex":null,"image_url":null,"family":"Zelená"},{"name":"VERDE OLIVE DI CERIGNOLA","hex":null,"image_url":null,"family":"Zelená"},{"name":"AZZURRO DI PROVENZA","hex":null,"image_url":null,"family":"Modrá"},{"name":"SALVIA DI SARDEGNA","hex":null,"image_url":null,"family":"Zelená"},{"name":"ROSSO","hex":null,"image_url":null,"family":"Červená"},{"name":"GIALLO SAHARA","hex":null,"image_url":null,"family":"Žltá"},{"name":"VERDE BRITISH","hex":null,"image_url":null,"family":"Zelená"},{"name":"ROSSO POMPEIANO","hex":null,"image_url":null,"family":"Červená"}]'::jsonb,
  ARRAY['Biela', 'Červená', 'Hnedá', 'Modrá', 'Sivá', 'Zelená', 'Žltá']::text[],
  ARRAY['82 x 72 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/en/products/sirchester-armchair?_pos=1&_psq=sirchester&_ss=e&_v=1.0',
  'https://serralunga.com/en/products/sirchester-armchair?_pos=1&_psq=sirchester&_ss=e&_v=1.0',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'moderne-kvetinace' LIMIT 1),
  'Kvetináč Cubotti Alto',
  'kvetinac-cubotti-alto',
  'Serralunga',
  21200,
  NULL,
  'Cubotti je minimalistická a moderná kolekcia kvetináčov, ktorú navrhla značka Serralunga. K dispozícii je v rôznych veľkostiach a tiež v svietiacej verzii. „Realita okolo nás pozostáva zo základných tvarov – gule, valca a kužeľa. Všetky tieto tvary sa objavujú aj v záhradnom dizajne. Na základe princípov veľkého Cézanna vznikla kolekcia Cubotti, ktorá vychádza z architektonického výrazu objemov a prináša do priestoru čistotu a geometriu.“ Kvetináče Cubotti patria medzi záhradné dekorácie a dizajnové nádoby na rastliny, vyrobené z ľahkého, no mimoriadne odolného polyetylénu, tvarovaného technológiou rotačného liatia. Poskytujú UV ochranu, sú 100 % recyklovateľné a farbené v hmote.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/en/products/cubotti-alto-planter?pr_prod_strat=e5_desc&pr_rec_id=3a16af608&pr_rec_pid=7003989999753&pr_ref_pid=7003990229129&pr_seq=uniform)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/kvetinac-cubotti-alto/kvetinac-cubotti-alto_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/kvetinac-cubotti-alto/kvetinac-cubotti-alto_1.jpg']::text[],
  '[{"name":"BIANCO","hex":null,"image_url":null,"family":"Biela"},{"name":"TORTORA DI TORINO","hex":null,"image_url":null,"family":"Hnedá"},{"name":"ANTRACITE","hex":null,"image_url":null,"family":"Sivá"},{"name":"TERRACOTTA SCURA","hex":null,"image_url":null,"family":"Červená"},{"name":"AZZURRO DI PROVENZA","hex":null,"image_url":null,"family":"Modrá"},{"name":"SALVIA DI SARDEGNA","hex":null,"image_url":null,"family":"Zelená"},{"name":"ROSSO","hex":null,"image_url":null,"family":"Červená"},{"name":"TERRACOTTA TOSCANA","hex":null,"image_url":null,"family":"Červená"},{"name":"VERDE PAVONE","hex":null,"image_url":null,"family":"Zelená"},{"name":"GIALLO SAHARA","hex":null,"image_url":null,"family":"Žltá"},{"name":"VERDE BRITISH","hex":null,"image_url":null,"family":"Zelená"},{"name":"ROSSO POMPEIANO","hex":null,"image_url":null,"family":"Červená"},{"name":"CORTEN","hex":null,"image_url":null,"family":"Hnedá"}]'::jsonb,
  ARRAY['Biela', 'Červená', 'Hnedá', 'Modrá', 'Sivá', 'Zelená', 'Žltá']::text[],
  ARRAY['37x37x90 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[{"label":"37x37x90 cm","dimensions":"37x37x90 cm","price_cents":21200,"attributes":{"rozmer":"37x37x90 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"37x37x90 cm"}]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/en/products/cubotti-alto-planter?pr_prod_strat=e5_desc&pr_rec_id=3a16af608&pr_rec_pid=7003989999753&pr_ref_pid=7003990229129&pr_seq=uniform',
  'https://serralunga.com/en/products/cubotti-alto-planter?pr_prod_strat=e5_desc&pr_rec_id=3a16af608&pr_rec_pid=7003989999753&pr_ref_pid=7003990229129&pr_seq=uniform',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'nabytok' LIMIT 1),
  'Konferenčný stolík Boom',
  'konferencny-stolik-boom',
  'Plust',
  35000,
  NULL,
  'Konferenčný stolík Boom, doplnok ku kreslám Boom, je určený pre tých, ktorí uprednostňujú minimalistický dizajn a vizuálne ľahký vzhľad v priestore. Nová doska z priehľadného tvrdeného skla dodáva stolíku eleganciu a robí ho vhodným pre rôzne typy interiérov a exteriérových prostredí.
Rozmer
84 x 84 x 33 cm
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.plust.it/en/products/boom-coffee-table-structure/)',
  'https://kochlik.netlify.app/images/konferencny-stolik-boom/konferencny-stolik-boom_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/konferencny-stolik-boom/konferencny-stolik-boom_1.jpg', 'https://kochlik.netlify.app/images/konferencny-stolik-boom/konferencny-stolik-boom_2.gif', 'https://kochlik.netlify.app/images/konferencny-stolik-boom/konferencny-stolik-boom_3.gif', 'https://kochlik.netlify.app/images/konferencny-stolik-boom/konferencny-stolik-boom_4.gif', 'https://kochlik.netlify.app/images/konferencny-stolik-boom/konferencny-stolik-boom_5.gif']::text[],
  '[{"name":"White C2","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_c2_whitec2.jpg","family":"Biela"},{"name":"White light","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_u1_whitelight.jpg","family":"Biela"},{"name":"Mint","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_v5_mint.jpg","family":"Zelená"},{"name":"Tide","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_v6_tide.jpg","family":"Béžová"},{"name":"Creta","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_v7_creta.jpg","family":"Béžová"},{"name":"Decor","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_z3_decor.jpg","family":"Béžová"},{"name":"Grain","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_z6_grain.jpg","family":"Béžová"}]'::jsonb,
  ARRAY['Béžová', 'Biela', 'Zelená']::text[],
  ARRAY['84 x 33 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb,
  'https://www.plust.it/en/products/boom-coffee-table-structure/',
  'https://www.plust.it/en/products/boom-coffee-table-structure/',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'moderne-kvetinace' LIMIT 1),
  'Kvetináč KABIN HIGH',
  'kvetinac-kabin-high',
  'Serralunga',
  29500,
  NULL,
  'Kvetináč Kabin High, ktorý pre značku Serralunga navrhla Luisa Bocchietto, je archetypálnym dizajnovým dielom, v ktorom sa spájajú klasické geometrické tvary s jemne brúseným povrchom a vznešeným prevedením. Presnosť ostrých línií a rohov sa tu stretáva s mäkkosťou zamatového dojmu a čistotou zenového minimalizmu. Model Kabin High predstavuje veľký, elegantný kvetináč, ktorý je neoddeliteľnou súčasťou každého dizajnového priestoru – symbolom rovnováhy, harmónie a nadčasovej elegancie.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/en/products/kabin-high-planter?_pos=1&_psq=KABIN+HIGH&_ss=e&_v=1.0)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/kvetinac-kabin-high/kvetinac-kabin-high_1.webp',
  ARRAY['https://kochlik.netlify.app/images/kvetinac-kabin-high/kvetinac-kabin-high_1.webp', 'https://kochlik.netlify.app/images/kvetinac-kabin-high/kvetinac-kabin-high_2.webp', 'https://kochlik.netlify.app/images/kvetinac-kabin-high/kvetinac-kabin-high_3.webp', 'https://kochlik.netlify.app/images/kvetinac-kabin-high/kvetinac-kabin-high_4.webp']::text[],
  '[{"name":"ANTRACITE","hex":null,"image_url":null,"family":"Sivá"},{"name":"AZZURRO DI PROVENZA","hex":null,"image_url":null,"family":"Modrá"},{"name":"LACCATO BIANCO","hex":null,"image_url":null,"family":"Biela"},{"name":"ROSSO","hex":null,"image_url":null,"family":"Červená"},{"name":"SALVIA DI SARDEGNA","hex":null,"image_url":null,"family":"Zelená"},{"name":"TERRACOTTA SCURA","hex":null,"image_url":null,"family":"Červená"},{"name":"TORTORA DI TORINO","hex":null,"image_url":null,"family":"Hnedá"},{"name":"VERDE PAVONE","hex":null,"image_url":null,"family":"Zelená"},{"name":"BIANCO","hex":null,"image_url":null,"family":"Biela"},{"name":"TERRACOTTA TOSCANA","hex":null,"image_url":null,"family":"Červená"},{"name":"GIALLO SAHARA","hex":null,"image_url":null,"family":"Žltá"},{"name":"VERDE BRITISH","hex":null,"image_url":null,"family":"Zelená"},{"name":"ROSSO POMPEIANO","hex":null,"image_url":null,"family":"Červená"}]'::jsonb,
  ARRAY['Biela', 'Červená', 'Hnedá', 'Modrá', 'Sivá', 'Zelená', 'Žltá']::text[],
  ARRAY['35x35x70cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[{"label":"35x35x70cm","dimensions":"35x35x70cm","price_cents":29500,"attributes":{"rozmer":"35x35x70cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"35x35x70cm"}]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/en/products/kabin-high-planter?_pos=1&_psq=KABIN+HIGH&_ss=e&_v=1.0',
  'https://serralunga.com/en/products/kabin-high-planter?_pos=1&_psq=KABIN+HIGH&_ss=e&_v=1.0',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'svietiace-kvetinace' LIMIT 1),
  'Kvetináč Tubini svietiaci',
  'kvetinac-tubini-svietiaci',
  'Serralunga',
  27200,
  NULL,
  'Materiál: Vyrobené z LLDPE (lineárny nízkohustotný polyetylén) Výrobný proces: Rotačné tvarovanie Vhodnosť použitia: Určené na vonkajšie použitie, odolné voči všetkým poveternostným podmienkam Ochrana: UV ochrana, 100 % recyklovateľný materiál, farba prefarbená v hmote Vlastnosti: • Vysoká mechanická pevnosť a odolnosť voči nárazom • Odolnosť voči teplotám od –35 °C do +80 °C
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/en/products/tubini-with-light?_pos=1&_psq=Tubini&_ss=e&_v=1.0)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/kvetinac-tubini-svietiaci/kvetinac-tubini-svietiaci_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/kvetinac-tubini-svietiaci/kvetinac-tubini-svietiaci_1.jpg']::text[],
  '[{"name":"RGB light with cable","hex":null,"image_url":null,"family":null},{"name":"White light with cable","hex":null,"image_url":null,"family":"Biela"}]'::jsonb,
  ARRAY['Biela']::text[],
  ARRAY['46x46x90 cm', '50x50x48 cm']::text[],
  ARRAY['Do 50 cm', '51-100 cm']::text[],
  '[{"label":"46x46x90 cm","dimensions":"46x46x90 cm","price_cents":37300,"attributes":{"typ-ziarovky":"LED","rozmer":"46x46x90 cm"}},{"label":"50x50x48 cm","dimensions":"50x50x48 cm","price_cents":30100,"attributes":{"typ-ziarovky":"LED","rozmer":"50x50x48 cm"}},{"label":"46x46x90 cm","dimensions":"46x46x90 cm","price_cents":34400,"attributes":{"typ-ziarovky":"RGB","rozmer":"46x46x90 cm"}},{"label":"50x50x48 cm","dimensions":"50x50x48 cm","price_cents":27200,"attributes":{"typ-ziarovky":"RGB","rozmer":"50x50x48 cm"}}]'::jsonb,
  '[{"key":"Typ žiarovky","value":"LED, RGB"},{"key":"Rozmer","value":"46x46x90 cm, 50x50x48 cm"}]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/en/products/tubini-with-light?_pos=1&_psq=Tubini&_ss=e&_v=1.0',
  'https://serralunga.com/en/products/tubini-with-light?_pos=1&_psq=Tubini&_ss=e&_v=1.0',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'moderne-kvetinace' LIMIT 1),
  'Kvetináč New Pot vysoký',
  'kvetinac-new-pot-vysoky',
  'Serralunga',
  26300,
  NULL,
  'Kvetináč New Pot, ktorý navrhol Paolo Rizzatto pre Serralunga, vychádza z tradičného tvaru zrezaného kužeľa – archetypu kvetináča – a prináša moderný, sofistikovaný pohľad na klasický dizajn. Myšlienkou kolekcie New Pot je spojiť funkčnú dokonalosť s estetickou eleganciou, čím vzniká kvetináč, ktorý pôsobí jednoducho, no zároveň mimoriadne kultivovane. Model New Pot High predstavuje vyššiu verziu kolekcie, dostupnú v rôznych veľkostiach, ideálnu na vytváranie harmonických kompozícií. Dostupný je aj v prevedení s povrchovou úpravou Moleskin – registrovaný dizajn, ktorý dodáva produktu šarm, teplo a nadčasový charakter.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/en/products/new-pot-high-planter?_pos=2&_psq=new+pot&_ss=e&_v=1.0)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/kvetinac-new-pot-vysoky/kvetinac-new-pot-vysoky_1.webp',
  ARRAY['https://kochlik.netlify.app/images/kvetinac-new-pot-vysoky/kvetinac-new-pot-vysoky_1.webp', 'https://kochlik.netlify.app/images/kvetinac-new-pot-vysoky/kvetinac-new-pot-vysoky_2.webp', 'https://kochlik.netlify.app/images/kvetinac-new-pot-vysoky/kvetinac-new-pot-vysoky_3.webp']::text[],
  '[{"name":"BIANCO","hex":null,"image_url":null,"family":"Biela"},{"name":"ANTRACITE","hex":null,"image_url":null,"family":"Sivá"},{"name":"TORTORA DI TORINO","hex":null,"image_url":null,"family":"Hnedá"},{"name":"TERRACOTTA SCURA","hex":null,"image_url":null,"family":"Červená"},{"name":"VERDE PAVONE","hex":null,"image_url":null,"family":"Zelená"},{"name":"LACQUEROSSO BIANCO","hex":null,"image_url":null,"family":"Biela"},{"name":"ROSSO","hex":null,"image_url":null,"family":"Červená"},{"name":"SALVIA DI SARDEGNA","hex":null,"image_url":null,"family":"Zelená"},{"name":"PIETRA DELLA DOLOMITI","hex":null,"image_url":null,"family":"Sivá"},{"name":"TERRACOTTA TOSCANA","hex":null,"image_url":null,"family":"Červená"},{"name":"GIALLO SAHARA","hex":null,"image_url":null,"family":"Žltá"},{"name":"VERDE BRITISH","hex":null,"image_url":null,"family":"Zelená"},{"name":"ROSSO POMPEIANO","hex":null,"image_url":null,"family":"Červená"}]'::jsonb,
  ARRAY['Biela', 'Červená', 'Hnedá', 'Sivá', 'Zelená', 'Žltá']::text[],
  ARRAY['35x35x90 cm', '44x44x120 cm']::text[],
  ARRAY['51-100 cm', '101-150 cm']::text[],
  '[{"label":"35x35x90 cm","dimensions":"35x35x90 cm","price_cents":26300,"attributes":{"rozmer":"35x35x90 cm"}},{"label":"44x44x120 cm","dimensions":"44x44x120 cm","price_cents":41100,"attributes":{"rozmer":"44x44x120 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"35x35x90 cm, 44x44x120 cm"}]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/en/products/new-pot-high-planter?_pos=2&_psq=new+pot&_ss=e&_v=1.0',
  'https://serralunga.com/en/products/new-pot-high-planter?_pos=2&_psq=new+pot&_ss=e&_v=1.0',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'nabytok' LIMIT 1),
  'Lehátko Aqua',
  'lehatko-aqua',
  'Serralunga',
  55000,
  NULL,
  'Aqua Lounger, navrhnuté Marcom Sadlerom pre Serralunga, predstavuje inovatívny prístup k dizajnu bazénového nábytku. Elegantné ležadlo s tvarom pripomínajúcim dokonale vyhladenú mušľu bolo precízne navrhnuté tak, aby poskytovalo maximálne pohodlie a zároveň ergonomickú stabilitu v dokonalej rovnováhe. Ležadlo Aqua je vhodné na použitie pri bazéne aj priamo vo vode – do hĺbky 15 cm. Dodáva sa ako súprava dvoch kusov. Pre ešte väčšie pohodlie je možné ho skombinovať s Aqua Riserom (voliteľný doplnok), ktorý umožňuje využitie až do hĺbky 20 cm. Riser sa jednoducho pripája cez štyri spojovacie body. Táto verzia je dostupná aj v povrchovej úprave Moleskin, s registrovaným dizajnom, ktorá dodáva výrobku teplo, jemnosť a luxusný vzhľad.
Rozmer
157 x 70 x 51.5 cm
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/en/products/aqua-lounger?_pos=3&_psq=aqua&_ss=e&_v=1.0)',
  'https://kochlik.netlify.app/images/lehatko-aqua/lehatko-aqua_1.webp',
  ARRAY['https://kochlik.netlify.app/images/lehatko-aqua/lehatko-aqua_1.webp', 'https://kochlik.netlify.app/images/lehatko-aqua/lehatko-aqua_2.webp', 'https://kochlik.netlify.app/images/lehatko-aqua/lehatko-aqua_3.webp', 'https://kochlik.netlify.app/images/lehatko-aqua/lehatko-aqua_4.webp', 'https://kochlik.netlify.app/images/lehatko-aqua/lehatko-aqua_5.webp', 'https://kochlik.netlify.app/images/lehatko-aqua/lehatko-aqua_6.jpg', 'https://kochlik.netlify.app/images/lehatko-aqua/lehatko-aqua_7.jpg']::text[],
  '[{"name":"BIANCO","hex":null,"image_url":null,"family":"Biela"},{"name":"AZZURRO DI PROVENZA","hex":null,"image_url":null,"family":"Modrá"},{"name":"SALVIA DI SARDEGNA","hex":null,"image_url":null,"family":"Zelená"},{"name":"ACQUA DELLA MADDALENA","hex":null,"image_url":null,"family":"Modrá"},{"name":"PIETRA DI MATERA","hex":null,"image_url":null,"family":"Sivá"},{"name":"TORTORA DI TORINO","hex":null,"image_url":null,"family":"Hnedá"},{"name":"ORIGANO DI SARDEGNA","hex":null,"image_url":null,"family":"Zelená"},{"name":"MORE DI ROVO","hex":null,"image_url":null,"family":"Ružová"}]'::jsonb,
  ARRAY['Biela', 'Hnedá', 'Modrá', 'Ružová', 'Sivá', 'Zelená']::text[],
  ARRAY['15 cm', '20 cm', '5 cm']::text[],
  ARRAY['Do 50 cm']::text[],
  '[]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/en/products/aqua-lounger?_pos=3&_psq=aqua&_ss=e&_v=1.0',
  'https://serralunga.com/en/products/aqua-lounger?_pos=3&_psq=aqua&_ss=e&_v=1.0',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'klasicke-kvetinace' LIMIT 1),
  'Kvetináč SIEPI',
  'kvetinac-siepi',
  'Euro3plast',
  7500,
  NULL,
  'Kolekcia Style je elegantná a nadčasová: tieto kvetináče a dekorácie s klasickým šarmom dodajú záhradám a terasám sofistikovaný vzhľad a po prvom použití sa stanú nepostrádateľné. Dokonale dopĺňajú priestory, ktoré sa rady nechávajú obdivovať.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.euro3plast.com/gb/products/502-siepi.html)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/kvetinac-siepi/kvetinac-siepi_1.webp',
  ARRAY['https://kochlik.netlify.app/images/kvetinac-siepi/kvetinac-siepi_1.webp']::text[],
  '[]'::jsonb,
  ARRAY[]::text[],
  ARRAY['38x35 cm', '47x41 cm', '52x56 cm']::text[],
  ARRAY['Do 50 cm', '51-100 cm']::text[],
  '[{"label":"38x35 cm","dimensions":"38x35 cm","price_cents":7500,"attributes":{"rozmer":"38x35 cm"}},{"label":"47x41 cm","dimensions":"47x41 cm","price_cents":8700,"attributes":{"rozmer":"47x41 cm"}},{"label":"52x56 cm","dimensions":"52x56 cm","price_cents":12800,"attributes":{"rozmer":"52x56 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"38×35 cm, 47×41 cm, 52×56 cm"}]'::jsonb,
  '[{"label":"Technický dokument","url":"https://www.euro3plast.com/sheets/siepi_vaso.pdf"},{"label":"Informačný dokument","url":"https://www.euro3plast.com/sheets/siepi_pot_info_en.pdf"}]'::jsonb,
  'https://www.euro3plast.com/gb/products/502-siepi.html',
  'https://www.euro3plast.com/gb/products/502-siepi.html',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'dizajnove' LIMIT 1),
  'New Wave',
  'new-wave',
  'Serralunga',
  88000,
  NULL,
  'Kvetináč New Wave, navrhnutý Rossom Lovegroveom pre Serralunga, vyniká tekutým a kompaktným tvarom, ktorý priestoru dodáva plynulú, organickú atmosféru. Tieto veľkoformátové kvetináče sú vyrobené z lineárneho nízkohustotného polyetylénu (LLDPE) pomocou rotačného tvarovania, čo zaručuje ich ľahkosť, pevnosť a odolnosť. Povrchová úprava s lakovaným efektom dodáva modelu elegantný, moderný vzhľad, ideálny pre súčasnú architektúru a dizajnové exteriéry.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/en/products/new-wave?_pos=1&_psq=New+Wave&_ss=e&_v=1.0)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/new-wave/new-wave_1.webp',
  ARRAY['https://kochlik.netlify.app/images/new-wave/new-wave_1.webp', 'https://kochlik.netlify.app/images/new-wave/new-wave_2.webp', 'https://kochlik.netlify.app/images/new-wave/new-wave_3.webp']::text[],
  '[{"name":"LACQUEROSSO BIANCO","hex":null,"image_url":null,"family":"Biela"},{"name":"BIANCO","hex":null,"image_url":null,"family":"Biela"},{"name":"ANTRACITE","hex":null,"image_url":null,"family":"Sivá"}]'::jsonb,
  ARRAY['Biela', 'Sivá']::text[],
  ARRAY['77x77x92 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[{"label":"77x77x92 cm","dimensions":"77x77x92 cm","price_cents":88000,"attributes":{"rozmer":"77x77x92 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"77x77x92 cm"}]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/en/products/new-wave?_pos=1&_psq=New+Wave&_ss=e&_v=1.0',
  'https://serralunga.com/en/products/new-wave?_pos=1&_psq=New+Wave&_ss=e&_v=1.0',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'svietiace-kvetinace' LIMIT 1),
  'Kvetináč MEMORY POT svietaci',
  'kvetinac-memory-pot-svietiaci',
  'Serralunga',
  29000,
  NULL,
  'Materiál: Vyrobené z LLDPE (lineárny nízkohustotný polyetylén) Výrobný proces: Rotačné tvarovanie Vhodné na vonkajšie použitie – odolné voči všetkým poveternostným vplyvom. Poskytuje UV ochranu, je 100 % recyklovateľné a farbené v hmote. Vyznačuje sa vysokou mechanickou pevnosťou a odolnosťou proti nárazom. Odoláva teplotám od -35 °C do +80 °C.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/en/products/memory-pot-with-light?_pos=2&_psq=MEMORY+POT&_ss=e&_v=1.0)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/kvetinac-memory-pot-svietiaci/kvetinac-memory-pot-svietiaci_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/kvetinac-memory-pot-svietiaci/kvetinac-memory-pot-svietiaci_1.jpg']::text[],
  '[{"name":"RGB light with cable","hex":null,"image_url":null,"family":null},{"name":"White light with cable","hex":null,"image_url":null,"family":"Biela"}]'::jsonb,
  ARRAY['Biela']::text[],
  ARRAY['49x53 cm', '62x80 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[{"label":"49x53 cm","dimensions":"49x53 cm","price_cents":29000,"attributes":{"rozmer":"49x53 cm"}},{"label":"62x80 cm","dimensions":"62x80 cm","price_cents":46500,"attributes":{"rozmer":"62x80 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"49×53 cm, 62×80 cm"}]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/en/products/memory-pot-with-light?_pos=2&_psq=MEMORY+POT&_ss=e&_v=1.0',
  'https://serralunga.com/en/products/memory-pot-with-light?_pos=2&_psq=MEMORY+POT&_ss=e&_v=1.0',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  NULL,
  'QUADRUM',
  'quadrum',
  'Euro3plast',
  16200,
  NULL,
  'Štýl je synonymom minimalizmu – dokonale zhrnutý v čistých a jednoduchých líniách našich kvetináčov a doplnkov. Skombinovali sme čisté profily s farebnou paletou pre každý vkus – od výraznej kyslej zelene a červenej po klasické odtiene – aby ste obohatili svoje obľúbené priestory harmóniou a eleganciou.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.euro3plast.com/gb/products/411-quadrum.html)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/quadrum/quadrum_1.webp',
  ARRAY['https://kochlik.netlify.app/images/quadrum/quadrum_1.webp']::text[],
  '[{"name":"IVORY","hex":"#ebe7d3","image_url":null,"family":"Biela"},{"name":"PEARL BLACK","hex":"#4a4a49","image_url":null,"family":"Čierna"}]'::jsonb,
  ARRAY['Biela', 'Čierna']::text[],
  ARRAY['51x51x100 cm', '37x37x73 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[{"label":"51x51x100 cm","dimensions":"51x51x100 cm","price_cents":33000,"attributes":{"rozmer":"51x51x100 cm"}},{"label":"37x37x73 cm","dimensions":"37x37x73 cm","price_cents":16200,"attributes":{"rozmer":"37x37x73 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"37x37x73 cm, 51x51x100 cm"}]'::jsonb,
  '[{"label":"Technický dokument","url":"https://www.euro3plast.com/sheets/quadrum_vaso_quadro_con_doppia_parete.pdf"},{"label":"Informačný dokument","url":"https://www.euro3plast.com/sheets/quadrum_square_pot_with_double_wall_info_en.pdf"}]'::jsonb,
  'https://www.euro3plast.com/gb/products/411-quadrum.html',
  'https://www.euro3plast.com/gb/products/411-quadrum.html',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'nabytok' LIMIT 1),
  'Barová stolička Armillaria',
  'barova-stolicka-armillaria',
  'Plust',
  16000,
  NULL,
  'Stôl s centrálnou základňou z polyetylénu. V kombinácii s rôznymi materiálmi a povrchovými úpravami dosky získava nový štýl a charakter, ktorý sa prispôsobí akémukoľvek prostrediu.
Rozmer
35 x 35 x 75 cm
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.plust.it/en/products/armillaria-stool/)',
  'https://kochlik.netlify.app/images/barova-stolicka-armillaria/barova-stolicka-armillaria_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/barova-stolicka-armillaria/barova-stolicka-armillaria_1.jpg', 'https://kochlik.netlify.app/images/barova-stolicka-armillaria/barova-stolicka-armillaria_2.jpg', 'https://kochlik.netlify.app/images/barova-stolicka-armillaria/barova-stolicka-armillaria_3.jpg', 'https://kochlik.netlify.app/images/barova-stolicka-armillaria/barova-stolicka-armillaria_4.jpg']::text[],
  '[{"name":"Pearl black","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_87_pearlblack.jpg","family":"Čierna"},{"name":"White C2","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_c2_whitec2.jpg","family":"Biela"},{"name":"Taupe","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_g9_taupe.jpg","family":"Hnedá"},{"name":"Golden rust","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_n4_goldenrust.jpg","family":"Hnedá"}]'::jsonb,
  ARRAY['Biela', 'Čierna', 'Hnedá']::text[],
  ARRAY['35 x 75 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb,
  'https://www.plust.it/en/products/armillaria-stool/',
  'https://www.plust.it/en/products/armillaria-stool/',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'dizajnove' LIMIT 1),
  'Tambo',
  'tambo',
  'Plust',
  37000,
  NULL,
  'Váza s výrazným povrchom, ktorý vytvára nádhernú hru svetla, najmä v lakovanej verzii. Vďaka svojej veľkosti je vhodná do akéhokoľvek priestoru – súkromného aj verejného, interiérového aj exteriérového.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.plust.it/en/products/tambo/)',
  'https://kochlik.netlify.app/images/tambo/tambo_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/tambo/tambo_1.jpg']::text[],
  '[{"name":"White C2","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_c2_whitec2.jpg","family":"Biela"},{"name":"Granite","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_s4_granite.jpg","family":"Sivá"},{"name":"White light","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_u1_whitelight.jpg","family":"Biela"},{"name":"Stone","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_u4_stone.jpg","family":"Sivá"}]'::jsonb,
  ARRAY['Biela', 'Sivá']::text[],
  ARRAY['75x73x73 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[{"label":"75x73x73 cm","dimensions":"75x73x73 cm","price_cents":37000,"attributes":{"rozmer":"75x73x73 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"75x73x73 cm"}]'::jsonb,
  '[]'::jsonb,
  'https://www.plust.it/en/products/tambo/',
  'https://www.plust.it/en/products/tambo/',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'nabytok' LIMIT 1),
  'Kreslo Time out',
  'kreslo-time-out',
  'Serralunga',
  55000,
  NULL,
  'Kreslo Time Out, navrhnuté Rodolfo Dordonim pre Serralunga, patrí do kolekcie moderného nábytku určeného na dokonalé vychutnávanie života v exteriéri. Je vyrobené z rotačne tvarovaného polyetylénu a doplnené o konštrukciu z bielej ocele, čo zaručuje pevnosť, odolnosť a eleganciu zároveň. Kolekcia Time Out zahŕňa kreslo a stoličku, ktoré spoločne vytvárajú harmonickú súpravu pre moderné vonkajšie priestory.
Rozmer
75 x 65 x 64 cm
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/en/products/time-out-armchair?_pos=2&_psq=Time+out&_ss=e&_v=1.0)',
  'https://kochlik.netlify.app/images/kreslo-time-out/kreslo-time-out_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/kreslo-time-out/kreslo-time-out_1.jpg']::text[],
  '[{"name":"BIANCO","hex":null,"image_url":null,"family":"Biela"},{"name":"AZZURRO DI PROVENZA","hex":null,"image_url":null,"family":"Modrá"},{"name":"TORTORA DI TORINO","hex":null,"image_url":null,"family":"Hnedá"}]'::jsonb,
  ARRAY['Biela', 'Hnedá', 'Modrá']::text[],
  ARRAY['65 x 64 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/en/products/time-out-armchair?_pos=2&_psq=Time+out&_ss=e&_v=1.0',
  'https://serralunga.com/en/products/time-out-armchair?_pos=2&_psq=Time+out&_ss=e&_v=1.0',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  NULL,
  'Sedačka September',
  'sedacka-september',
  'Plust',
  97000,
  NULL,
  'Settembre je mesiac, ktorý sa lúči s letom, no stále si zachováva jeho vône, modrú oblohu a príjemné teploty, ktoré lákajú zostať vonku. Zaoblený tvar trojmiestnej pohovky a mäkký vzhľad zakrivených plôch sú navrhnuté tak, aby poskytovali maximálne pohodlie bez potreby dodatočného čalúnenia. Medzera medzi sedadlom a operadlom umožňuje odtok dažďovej vody, zatiaľ čo otvor na osvetlenie premieňa pohovku na skutočnú svetelnú sochu.
            

             Rozmer
             
             165 x 79 x 70
            




              Pre viac informácii navštívte stránku dodávateľa
              [tu](https://www.plust.it/en/products/settembre-sofa/)',
  'https://kochlik.netlify.app/images/sedacka-september/sedacka-september_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/sedacka-september/sedacka-september_1.jpg', 'https://kochlik.netlify.app/images/sedacka-september/sedacka-september_2.jpg', 'https://kochlik.netlify.app/images/sedacka-september/sedacka-september_3.jpg', 'https://kochlik.netlify.app/images/sedacka-september/sedacka-september_4.jpg', 'https://kochlik.netlify.app/images/sedacka-september/sedacka-september_5.jpg']::text[],
  '[{"name":"Pearl black","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_87_pearlblack.jpg","family":"Čierna"},{"name":"White C2","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_c2_whitec2.jpg","family":"Biela"},{"name":"Taupe","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_g9_taupe.jpg","family":"Hnedá"},{"name":"Sandy","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_m9_sandy.jpg","family":"Béžová"},{"name":"White light","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_u1_whitelight.jpg","family":"Biela"}]'::jsonb,
  ARRAY['Béžová', 'Biela', 'Čierna', 'Hnedá']::text[],
  ARRAY[]::text[],
  ARRAY[]::text[],
  '[]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb,
  'https://www.plust.it/en/products/settembre-sofa/',
  'https://www.plust.it/en/products/settembre-sofa/',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'dizajnove' LIMIT 1),
  'Kvetináč Eufronio',
  'kvetinac-eufronio',
  'Serralunga',
  70500,
  'Kvetináč Eufronio, navrhnutý Paolom Rizzattom pre značku Serralunga, je obojstranný kvetináč s dvoma možnosťami umiestnenia – dá sa položiť na dve rôzne základne rôznych veľkostí, čím vzniká buď rozšírený (flare), alebo zúžený (tapered) tvar. Je ideálny pre priestranné interiéry aj exteriéry.',
  'Eufronio je veľkoformátový kvetináč, ktorý predstavuje to najlepšie z talianskeho interiérového dizajnu, zaradený do kolekcie Serralunga pots. Jeho žliabkovaný povrch odkazuje na klasické stĺpy antickej architektúry, no zároveň má moderný tvar a funkciu. Pevne definovaný tvar kontrastuje s všestranným využitím, ktoré sa prispôsobuje aktuálnemu priestoru a potrebám.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/en/products/eufronio-planter?_pos=1&_psq=Eufronio&_ss=e&_v=1.0)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/kvetinac-eufronio/kvetinac-eufronio_1.webp',
  ARRAY['https://kochlik.netlify.app/images/kvetinac-eufronio/kvetinac-eufronio_1.webp']::text[],
  '[{"name":"ANTRACITE","hex":null,"image_url":null,"family":"Sivá"},{"name":"ROSSO","hex":null,"image_url":null,"family":"Červená"},{"name":"BIANCO","hex":null,"image_url":null,"family":"Biela"},{"name":"AZZURRO DI PROVENZA","hex":null,"image_url":null,"family":"Modrá"},{"name":"PIETRA DELLA DOLOMITI","hex":null,"image_url":null,"family":"Sivá"},{"name":"SALVIA DI SARDEGNA","hex":null,"image_url":null,"family":"Zelená"},{"name":"TERRACOTTA TOSCANA","hex":null,"image_url":null,"family":"Červená"},{"name":"TORTORA DI TORINO","hex":null,"image_url":null,"family":"Hnedá"},{"name":"GIALLO SAHARA","hex":null,"image_url":null,"family":"Žltá"},{"name":"VERDE BRITISH","hex":null,"image_url":null,"family":"Zelená"},{"name":"ROSSO POMPEIANO","hex":null,"image_url":null,"family":"Červená"}]'::jsonb,
  ARRAY['Biela', 'Červená', 'Hnedá', 'Modrá', 'Sivá', 'Zelená', 'Žltá']::text[],
  ARRAY['74x74x126 cm']::text[],
  ARRAY['101-150 cm']::text[],
  '[{"label":"74x74x126 cm","dimensions":"74x74x126 cm","price_cents":70500,"attributes":{"rozmer":"74x74x126 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"74x74x126 cm"}]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/en/products/eufronio-planter?_pos=1&_psq=Eufronio&_ss=e&_v=1.0',
  'https://serralunga.com/en/products/eufronio-planter?_pos=1&_psq=Eufronio&_ss=e&_v=1.0',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'klasicke-kvetinace' LIMIT 1),
  'Kvetináč Millerighe Parete',
  'kvetinac-millerighe-parete',
  'Serralunga',
  14600,
  NULL,
  'Kvetináč Millerighe Parete od Serralunga je večná klasika, ktorá spája tradičný dizajn s moderným farebným spracovaním. Práve farba dodáva tejto kolekcii jej charakter – jemné tón v tóne odtiene a chromatické prechody vytvárajú nečakané a harmonické kombinácie. Kvetináče Millerighe sú súčasťou línie Serralunga garden décor a predstavujú nadčasové riešenie pre elegantné záhrady a exteriéry.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/en/products/millerighe-parete-planter?_pos=1&_psq=Millerighe+Parete&_ss=e&_v=1.0)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/kvetinac-millerighe-parete/kvetinac-millerighe-parete_1.webp',
  ARRAY['https://kochlik.netlify.app/images/kvetinac-millerighe-parete/kvetinac-millerighe-parete_1.webp']::text[],
  '[{"name":"TORTORA DI TORINO","hex":null,"image_url":null,"family":"Hnedá"},{"name":"TERRACOTTA TOSCANA","hex":null,"image_url":null,"family":"Červená"},{"name":"GESSO DI BOLOGNA","hex":null,"image_url":null,"family":"Biela"},{"name":"AZZURRO DI PROVENZA","hex":null,"image_url":null,"family":"Modrá"},{"name":"SALVIA DI SARDEGNA","hex":null,"image_url":null,"family":"Zelená"},{"name":"TERRACOTTA SCURA","hex":null,"image_url":null,"family":"Červená"},{"name":"VERDE PAVONE","hex":null,"image_url":null,"family":"Zelená"},{"name":"ANTRACITE","hex":null,"image_url":null,"family":"Sivá"},{"name":"GIALLO SAHARA","hex":null,"image_url":null,"family":"Žltá"},{"name":"VERDE BRITISH","hex":null,"image_url":null,"family":"Zelená"},{"name":"ROSSO POMPEIANO","hex":null,"image_url":null,"family":"Červená"}]'::jsonb,
  ARRAY['Biela', 'Červená', 'Hnedá', 'Modrá', 'Sivá', 'Zelená', 'Žltá']::text[],
  ARRAY['61x35x54 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[{"label":"61x35x54 cm","dimensions":"61x35x54 cm","price_cents":14600,"attributes":{"rozmer":"61x35x54 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"61x35x54 cm"}]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/en/products/millerighe-parete-planter?_pos=1&_psq=Millerighe+Parete&_ss=e&_v=1.0',
  'https://serralunga.com/en/products/millerighe-parete-planter?_pos=1&_psq=Millerighe+Parete&_ss=e&_v=1.0',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'nabytok' LIMIT 1),
  'Kreslo Balzac',
  'kreslo-balzac',
  'Serralunga',
  55000,
  NULL,
  'Balzac predstavuje prvú spoluprácu medzi značkou Serralunga a dizajnérom Patrickom Norguetom, výsledkom ktorej je výrazná kolekcia spájajúca pevnosť, eleganciu a pohodlie. Dizajn sa vyznačuje mäkkými krivkami a kontrastnými líniami, ktoré pripomínajú štýl vonkajšieho nábytku z počiatku 20. storočia. Kreslo s rozpoznateľným a jednotným tvarom je vhodné na terasy, verandy či záhrady, ale aj do interiérových priestorov, ako sú hotelové lobby alebo relaxačné zóny. Balzac sa dokonale prispôsobí exteriéru aj interiéru, čím vytvára harmonické a nadčasové prostredie. Dostupné je s vankúšmi alebo bez nich.
Rozmer
96 x 86 x 85 cm
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/en/products/balzac-armchair?_pos=2&_psq=balzac&_ss=e&_v=1.0)',
  'https://kochlik.netlify.app/images/kreslo-balzac/kreslo-balzac_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/kreslo-balzac/kreslo-balzac_1.jpg', 'https://kochlik.netlify.app/images/kreslo-balzac/kreslo-balzac_2.jpg', 'https://kochlik.netlify.app/images/kreslo-balzac/kreslo-balzac_3.jpg']::text[],
  '[{"name":"RED CLAY without Cushion","hex":null,"image_url":null,"family":"Červená"},{"name":"RED CLAY with Red Clay Cushion","hex":null,"image_url":null,"family":"Červená"},{"name":"RED CLAY with Half Moon White Cushion","hex":null,"image_url":null,"family":"Biela"},{"name":"SALVIA DI SARDEGNA without Cushion","hex":null,"image_url":null,"family":"Zelená"},{"name":"SALVIA DI SARDEGNA with Half Moon White Cushion","hex":null,"image_url":null,"family":"Biela"},{"name":"TORTORA DI TORINO without Cushion","hex":null,"image_url":null,"family":"Hnedá"},{"name":"TORTORA DI TORINO with Half Moon White Cushion","hex":null,"image_url":null,"family":"Biela"},{"name":"PIETRA DI MATERA without Cushion","hex":null,"image_url":null,"family":"Sivá"},{"name":"PIETRA DI MATERA with Half Moon White Cushion","hex":null,"image_url":null,"family":"Biela"},{"name":"MORE DI ROVO without Cushion","hex":null,"image_url":null,"family":"Ružová"},{"name":"MORE DI ROVO with Half Moon White Cushion","hex":null,"image_url":null,"family":"Biela"}]'::jsonb,
  ARRAY['Biela', 'Červená', 'Hnedá', 'Ružová', 'Sivá', 'Zelená']::text[],
  ARRAY['86 x 85 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/en/products/balzac-armchair?_pos=2&_psq=balzac&_ss=e&_v=1.0',
  'https://serralunga.com/en/products/balzac-armchair?_pos=2&_psq=balzac&_ss=e&_v=1.0',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'nabytok' LIMIT 1),
  'Stolík Bold',
  'stolik-bold',
  'Plust',
  39000,
  NULL,
  'Konferenčný stolík dopĺňa a uzatvára kolekciu nábytku Bold. Doska je vyrobená z HPL materiálu v bielej alebo čiernej farbe a upevnená na základni z polyetylénu. Ideálny na vytvorenie útulnej spoločenskej zóny. Dostupný aj v svietiacej verzii.
Rozmer
73 x 73 x 37 cm
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.plust.it/en/products/bold-table-structure/)',
  'https://kochlik.netlify.app/images/stolik-bold/stolik-bold_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/stolik-bold/stolik-bold_1.jpg', 'https://kochlik.netlify.app/images/stolik-bold/stolik-bold_2.jpg', 'https://kochlik.netlify.app/images/stolik-bold/stolik-bold_3.jpg', 'https://kochlik.netlify.app/images/stolik-bold/stolik-bold_4.jpg', 'https://kochlik.netlify.app/images/stolik-bold/stolik-bold_5.jpg']::text[],
  '[{"name":"Sage green","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_34_sagegreen.jpg","family":"Zelená"},{"name":"White C2","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_c2_whitec2.jpg","family":"Biela"},{"name":"Taupe","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_g9_taupe.jpg","family":"Hnedá"},{"name":"Golden rust","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_n4_goldenrust.jpg","family":"Hnedá"},{"name":"Black","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_black_black.jpg","family":"Čierna"},{"name":"White","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_white_white.jpg","family":"Biela"},{"name":"White light","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_u1_whitelight.jpg","family":"Biela"}]'::jsonb,
  ARRAY['Biela', 'Čierna', 'Hnedá', 'Zelená']::text[],
  ARRAY['73 x 37 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb,
  'https://www.plust.it/en/products/bold-table-structure/',
  'https://www.plust.it/en/products/bold-table-structure/',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'dizajnove' LIMIT 1),
  'Nicole',
  'nicole',
  'Plust',
  34000,
  NULL,
  'Dvojkomorová váza, dostupná v dvoch veľkostiach, s jednoduchým a čistým tvarom, ktorý sa prispôsobí akémukoľvek interiéru či verejnému priestoru. Možno ju umiestniť v klasickej polohe alebo obrátene. Elegantné a štíhle línie vázy Nicole ju robia ideálnou pre klasické aj moderné prostredie, do interiéru aj exteriéru. Mimoriadne pôsobivo vynikne, keď je umiestnená v radoch pozdĺž záhradných chodníkov alebo v chodbách. Dostupná je aj v svietiacej verzii.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.plust.it/en/products/nicole/)',
  'https://kochlik.netlify.app/images/nicole/nicole_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/nicole/nicole_1.jpg', 'https://kochlik.netlify.app/images/nicole/nicole_2.jpg', 'https://kochlik.netlify.app/images/nicole/nicole_3.jpg']::text[],
  '[{"name":"White C2","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_c2_whitec2.jpg","family":"Biela"},{"name":"Granite","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_s4_granite.jpg","family":"Sivá"},{"name":"White light","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_u1_whitelight.jpg","family":"Biela"},{"name":"Stone","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_u4_stone.jpg","family":"Sivá"}]'::jsonb,
  ARRAY['Biela', 'Sivá']::text[],
  ARRAY['33x33x126 cm', '39x39x175 cm']::text[],
  ARRAY['101-150 cm', 'Nad 150 cm']::text[],
  '[{"label":"33x33x126 cm","dimensions":"33x33x126 cm","price_cents":34000,"attributes":{"rozmer":"33x33x126 cm"}},{"label":"39x39x175 cm","dimensions":"39x39x175 cm","price_cents":54000,"attributes":{"rozmer":"39x39x175 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"33x33x126 cm, 39x39x175 cm"}]'::jsonb,
  '[]'::jsonb,
  'https://www.plust.it/en/products/nicole/',
  'https://www.plust.it/en/products/nicole/',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'nabytok' LIMIT 1),
  'Pouf Lounge Cube',
  'pouf-lounge-cube',
  'Serralunga',
  14000,
  NULL,
  'Začínajúc najjednoduchším a najpresnejšie definovaným tvarom – kockou, vzniklo funkčné riešenie záhradného nábytku, ktorého cieľom je pretransformovať statický objekt na všestranný a praktický prvok. Navrhnutá špeciálne ako sedadlo, kocka spĺňa potrebu vysoko funkčného vonkajšieho nábytku. Jej mierne dovnútra zakrivené sedenie dodáva jemnosť inak prísnej a geometrickej forme. Táto verzia je dostupná aj v povrchovej úprave Moleskin, registrovaný dizajn, ktorá dodáva produktu teplo a hmatovú hĺbku, a taktiež v osvetlenej verzii pre vytvorenie jedinečnej atmosféry.
Rozmer
 
Pre viac informácii navštívte stránku dodávateľa tu',
  'https://kochlik.netlify.app/images/pouf-lounge-cube/pouf-lounge-cube_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/pouf-lounge-cube/pouf-lounge-cube_1.jpg']::text[],
  '[]'::jsonb,
  ARRAY[]::text[],
  ARRAY[]::text[],
  ARRAY[]::text[],
  '[]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb,
  'https://kochlik.sk/produkt/pouf-lounge-cube/',
  'https://kochlik.sk/produkt/pouf-lounge-cube/',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'nabytok' LIMIT 1),
  'Stôl Frozen',
  'stol-frozen',
  'Plust',
  25000,
  NULL,
  'Vysoký stôl s centrálnou podnožou, ktorý možno kombinovať s HPL doskami v rôznych veľkostiach a farbách podľa akýchkoľvek funkčných aj estetických požiadaviek.
Spojením viacerých stolov „Frozen Table“ so štvorcovou doskou môžete vytvoriť pôsobivé bufetové stoly a množstvo riešení, ktoré vyhovejú potrebám najbežnejších verejných priestorov. K dispozícii je aj svetelná (luminiscenčná) verzia.
Rozmer
45 x 45 x 99 cm
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.plust.it/en/products/frozen-table-structure/)',
  'https://kochlik.netlify.app/images/stol-frozen/stol-frozen_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/stol-frozen/stol-frozen_1.jpg', 'https://kochlik.netlify.app/images/stol-frozen/stol-frozen_2.jpg', 'https://kochlik.netlify.app/images/stol-frozen/stol-frozen_3.jpg', 'https://kochlik.netlify.app/images/stol-frozen/stol-frozen_4.jpg', 'https://kochlik.netlify.app/images/stol-frozen/stol-frozen_5.jpg']::text[],
  '[{"name":"Night blue","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_16_nightblue.jpg","family":"Modrá"},{"name":"Sage green","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_34_sagegreen.jpg","family":"Zelená"},{"name":"Pearl black","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_87_pearlblack.jpg","family":"Čierna"},{"name":"White C2","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_c2_whitec2.jpg","family":"Biela"},{"name":"Sandy","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_m9_sandy.jpg","family":"Béžová"},{"name":"Golden rust","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_n4_goldenrust.jpg","family":"Hnedá"},{"name":"Black","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_black_black.jpg","family":"Čierna"},{"name":"White","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_white_white.jpg","family":"Biela"},{"name":"Neutral","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_98_neutral.jpg","family":"Biela"},{"name":"White light","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_u1_whitelight.jpg","family":"Biela"}]'::jsonb,
  ARRAY['Béžová', 'Biela', 'Čierna', 'Hnedá', 'Modrá', 'Zelená']::text[],
  ARRAY['45 x 99 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb,
  'https://www.plust.it/en/products/frozen-table-structure/',
  'https://www.plust.it/en/products/frozen-table-structure/',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'klasicke-kvetinace' LIMIT 1),
  'Kvetináč TEMPIUM',
  'kvetinac-tempium',
  'Euro3plast',
  40700,
  NULL,
  'Kolekcia Style je elegantná a nadčasová: tieto kvetináče a dekorácie s klasickým šarmom dodajú záhradám a terasám sofistikovaný vzhľad a po prvom použití sa stanú nepostrádateľné. Dokonale dopĺňajú priestory, ktoré sa rady nechávajú obdivovať.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.euro3plast.com/gb/products/400-tempium.html)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/kvetinac-tempium/kvetinac-tempium_1.webp',
  ARRAY['https://kochlik.netlify.app/images/kvetinac-tempium/kvetinac-tempium_1.webp']::text[],
  '[{"name":"TERRA DI SIENA","hex":"#e3945b","image_url":null,"family":"Červená"}]'::jsonb,
  ARRAY['Červená']::text[],
  ARRAY['102x77 cm', '114x88 cm', '145x114 cm', '85x66 cm']::text[],
  ARRAY['51-100 cm', '101-150 cm']::text[],
  '[{"label":"102x77 cm","dimensions":"102x77 cm","price_cents":56900,"attributes":{"rozmer":"102x77 cm"}},{"label":"114x88 cm","dimensions":"114x88 cm","price_cents":60200,"attributes":{"rozmer":"114x88 cm"}},{"label":"145x114 cm","dimensions":"145x114 cm","price_cents":100200,"attributes":{"rozmer":"145x114 cm"}},{"label":"85x66 cm","dimensions":"85x66 cm","price_cents":40700,"attributes":{"rozmer":"85x66 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"102×77 cm, 114×88 cm, 145×114 cm, 85×66 cm"}]'::jsonb,
  '[{"label":"Technický dokument","url":"https://www.euro3plast.com/sheets/tempium_vaso.pdf"},{"label":"Informačný dokument","url":"https://www.euro3plast.com/sheets/tempium_pot_info_en.pdf"}]'::jsonb,
  'https://www.euro3plast.com/gb/products/400-tempium.html',
  'https://www.euro3plast.com/gb/products/400-tempium.html',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'nabytok' LIMIT 1),
  'Konferenčný stolík Milo',
  'konferencny-stolik-milo',
  'Serralunga',
  35000,
  NULL,
  'Konferenčný stolík Milo, navrhnutý štúdiom Aquilialberg pre Serralunga, má ako základný dizajnový prvok zakrivenú líniu. Aj rovné línie stolovej dosky sú jemne zaoblené, čím vyniká výrazná plasticita jeho oblého tvaru. Vonkajšie stolíky Milo pripomínajú krivkové črty a poetickú architektúru slávnej Casa Milà od Gaudího. Názov Milo je v skutočnosti poctou tomuto architektovi.
Prívetivý konkávny tvar stolíkov vás vyzýva na používanie, vychutnávanie a zdieľanie. Ide o neformálne stolíky do exteriéru aj interiéru, ideálne pre komerčné prevádzky, ale aj na použitie v domácnosti – ako bytový doplnok a pre život vonku. Jemné, oblúkové línie totiž dokonale splývajú s prírodnou krajinou aj s interiérovými priestormi: vo verejných priestoroch, showroomoch, obchodoch, čakárňach a spoločenských zónach aj v obytných priestoroch.
Rozmer
59.9 x 59.9 x 56 cm
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/products/milo-coffeetable?_pos=2&_psq=Milo&_ss=e&_v=1.0)',
  'https://kochlik.netlify.app/images/konferencny-stolik-milo/konferencny-stolik-milo_1.webp',
  ARRAY['https://kochlik.netlify.app/images/konferencny-stolik-milo/konferencny-stolik-milo_1.webp']::text[],
  '[{"name":"ANTRACITE","hex":null,"image_url":null,"family":"Sivá"},{"name":"BIANCO","hex":null,"image_url":null,"family":"Biela"},{"name":"AZZURRO DI PROVENZA","hex":null,"image_url":null,"family":"Modrá"},{"name":"ROSSO","hex":null,"image_url":null,"family":"Červená"},{"name":"SALVIA DI SARDEGNA","hex":null,"image_url":null,"family":"Zelená"},{"name":"TORTORA DI TORINO","hex":null,"image_url":null,"family":"Hnedá"},{"name":"VERDE PAVONE","hex":null,"image_url":null,"family":"Zelená"},{"name":"GIALLO SAHARA","hex":null,"image_url":null,"family":"Žltá"},{"name":"VERDE BRITISH","hex":null,"image_url":null,"family":"Zelená"},{"name":"ROSSO POMPEIANO","hex":null,"image_url":null,"family":"Červená"}]'::jsonb,
  ARRAY['Biela', 'Červená', 'Hnedá', 'Modrá', 'Sivá', 'Zelená', 'Žltá']::text[],
  ARRAY['9 x 56 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/products/milo-coffeetable?_pos=2&_psq=Milo&_ss=e&_v=1.0',
  'https://serralunga.com/products/milo-coffeetable?_pos=2&_psq=Milo&_ss=e&_v=1.0',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'moderne-kvetinace' LIMIT 1),
  'Kvetináč KUBE',
  'kvetinac-kube',
  'Euro3plast',
  3000,
  NULL,
  'Kube je robustný rastlinný box s textúrovaným povrchom. Esenciálne tvary a čisté línie z neho robia súčasť minimalistického dizajnu. Elegantná farebná paleta a praktické príslušenstvo z neho tvoria modernú rodinu kvetináčov – ideálnu pre interiér aj exteriér. (Pripravené na sadu vodnej rezervy – predáva sa samostatne.)
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.euro3plast.com/gb/-/324-3115-kube.html#/332-colour-white_c2/614-significant_measure-40)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/kvetinac-kube/kvetinac-kube_1.webp',
  ARRAY['https://kochlik.netlify.app/images/kvetinac-kube/kvetinac-kube_1.webp', 'https://kochlik.netlify.app/images/kvetinac-kube/kvetinac-kube_2.webp', 'https://kochlik.netlify.app/images/kvetinac-kube/kvetinac-kube_3.webp']::text[],
  '[{"name":"WHITE C2","hex":"#ffffff","image_url":null,"family":"Biela"},{"name":"RUST","hex":"#543920","image_url":null,"family":"Hnedá"},{"name":"TAUPE","hex":"#706961","image_url":null,"family":"Hnedá"},{"name":"CEMENT","hex":"#999390","image_url":null,"family":"Sivá"},{"name":"GRANITE","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/e3p_kvetinac-kube_granite.jpg","family":"Sivá"},{"name":"LAVA","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/e3p_kvetinac-kube_lava.jpg","family":"Sivá"},{"name":"STONE","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/e3p_kvetinac-kube_stone.jpg","family":"Sivá"},{"name":"CRETA","hex":"#786e69","image_url":null,"family":"Béžová"},{"name":"PEARL BLACK","hex":"#4a4a49","image_url":null,"family":"Čierna"}]'::jsonb,
  ARRAY['Béžová', 'Biela', 'Čierna', 'Hnedá', 'Sivá']::text[],
  ARRAY['30x30x30 cm', '20x20x20 cm', '40x40x40 cm', '50x50x50 cm']::text[],
  ARRAY['Do 50 cm']::text[],
  '[{"label":"30x30x30 cm","dimensions":"30x30x30 cm","price_cents":5100,"attributes":{"rozmer":"30x30x30 cm"}},{"label":"20x20x20 cm","dimensions":"20x20x20 cm","price_cents":3000,"attributes":{"rozmer":"20x20x20 cm"}},{"label":"40x40x40 cm","dimensions":"40x40x40 cm","price_cents":11400,"attributes":{"rozmer":"40x40x40 cm"}},{"label":"50x50x50 cm","dimensions":"50x50x50 cm","price_cents":14500,"attributes":{"rozmer":"50x50x50 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"20x20x20 cm, 30x30x30 cm, 40x40x40 cm, 50x50x50 cm"}]'::jsonb,
  '[{"label":"Technický dokument","url":"https://www.euro3plast.com/sheets/kube_vaso_con_doppia_parete.pdf"},{"label":"Informačný dokument","url":"https://www.euro3plast.com/sheets/kube_pot_with_double_wall_info_en.pdf"}]'::jsonb,
  'https://www.euro3plast.com/gb/-/324-3115-kube.html#/332-colour-white_c2/614-significant_measure-40',
  'https://www.euro3plast.com/gb/-/324-3115-kube.html#/332-colour-white_c2/614-significant_measure-40',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'klasicke-kvetinace' LIMIT 1),
  'Lavica POLOBLÚK',
  'lavica-polobluk',
  'Euro3plast',
  49600,
  NULL,
  'Kolekcia Style je elegantná a nadčasová: tieto nadčasové kvetináče a doplnky dodajú šarm záhradám, ktoré si zaslúžia obdiv. V duchu čisto talianskej tradície ponúka širokú škálu veľkostí a vkusne klasických dekorácií, ktoré sa po prvom vzhliadnutí stanú nepostrádateľnými.
Rozmer:
135 x 45 x 45 cm
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.euro3plast.com/gb/products/373-3515-semitonda.html#/534-colour-white/656-significant_measure-135)',
  'https://kochlik.netlify.app/images/lavica-polobluk/lavica-polobluk_1.webp',
  ARRAY['https://kochlik.netlify.app/images/lavica-polobluk/lavica-polobluk_1.webp']::text[],
  '[{"name":"WHITE","hex":"#ffffff","image_url":null,"family":"Biela"}]'::jsonb,
  ARRAY['Biela']::text[],
  ARRAY['45 x 45 cm']::text[],
  ARRAY['Do 50 cm']::text[],
  '[]'::jsonb,
  '[]'::jsonb,
  '[{"label":"Technický dokument","url":"https://www.euro3plast.com/sheets/semitonda_panca.pdf"},{"label":"Informačný dokument","url":"https://www.euro3plast.com/sheets/semitonda_bench_info_en.pdf"}]'::jsonb,
  'https://www.euro3plast.com/gb/products/373-3515-semitonda.html#/534-colour-white/656-significant_measure-135',
  'https://www.euro3plast.com/gb/products/373-3515-semitonda.html#/534-colour-white/656-significant_measure-135',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'moderne-kvetinace' LIMIT 1),
  'Kvetináč New Pot veľký',
  'kvetinac-new-pot-velky',
  'Serralunga',
  32000,
  NULL,
  'Kvetináč New Pot, ktorý navrhol Paolo Rizzatto pre Serralunga, vychádza z tradičného tvaru zrezaného kužeľa – archetypu kvetináča – a prináša moderný, sofistikovaný pohľad na klasický dizajn. Myšlienkou kolekcie New Pot je spojiť funkčnú dokonalosť s estetickou eleganciou, čím vzniká kvetináč, ktorý pôsobí jednoducho, no zároveň mimoriadne kultivovane. Model New Pot High predstavuje vyššiu verziu kolekcie, dostupnú v rôznych veľkostiach, ideálnu na vytváranie harmonických kompozícií. Dostupný je aj v prevedení s povrchovou úpravou Moleskin – registrovaný dizajn, ktorý dodáva produktu šarm, teplo a nadčasový charakter.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/en/products/new-pot-planter-large?_pos=3&_psq=new+pot&_ss=e&_v=1.0)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/kvetinac-new-pot-velky/kvetinac-new-pot-velky_1.webp',
  ARRAY['https://kochlik.netlify.app/images/kvetinac-new-pot-velky/kvetinac-new-pot-velky_1.webp', 'https://kochlik.netlify.app/images/kvetinac-new-pot-velky/kvetinac-new-pot-velky_2.webp', 'https://kochlik.netlify.app/images/kvetinac-new-pot-velky/kvetinac-new-pot-velky_3.webp']::text[],
  '[{"name":"BIANCO","hex":null,"image_url":null,"family":"Biela"},{"name":"ANTRACITE","hex":null,"image_url":null,"family":"Sivá"},{"name":"TORTORA DI TORINO","hex":null,"image_url":null,"family":"Hnedá"},{"name":"TERRACOTTA SCURA","hex":null,"image_url":null,"family":"Červená"},{"name":"VERDE PAVONE","hex":null,"image_url":null,"family":"Zelená"},{"name":"PIETRA DELLA DOLOMITI","hex":null,"image_url":null,"family":"Sivá"},{"name":"NEVE DI SAN CANDIDO","hex":null,"image_url":null,"family":"Biela"},{"name":"AZZURRO DI PROVENZA","hex":null,"image_url":null,"family":"Modrá"},{"name":"ROSSO","hex":null,"image_url":null,"family":"Červená"},{"name":"SALVIA DI SARDEGNA","hex":null,"image_url":null,"family":"Zelená"},{"name":"LACQUEROSSO BIANCO","hex":null,"image_url":null,"family":"Biela"},{"name":"TERRACOTTA TOSCANA","hex":null,"image_url":null,"family":"Červená"},{"name":"GIALLO SAHARA","hex":null,"image_url":null,"family":"Žltá"},{"name":"VERDE BRITISH","hex":null,"image_url":null,"family":"Zelená"},{"name":"ROSSO POMPEIANO","hex":null,"image_url":null,"family":"Červená"}]'::jsonb,
  ARRAY['Biela', 'Červená', 'Hnedá', 'Modrá', 'Sivá', 'Zelená', 'Žltá']::text[],
  ARRAY['70x70x70 cm', '90x90x90 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[{"label":"70x70x70 cm","dimensions":"70x70x70 cm","price_cents":32000,"attributes":{"rozmer":"70x70x70 cm"}},{"label":"90x90x90 cm","dimensions":"90x90x90 cm","price_cents":52600,"attributes":{"rozmer":"90x90x90 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"70x70x70 cm, 90x90x90 cm"}]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/en/products/new-pot-planter-large?_pos=3&_psq=new+pot&_ss=e&_v=1.0',
  'https://serralunga.com/en/products/new-pot-planter-large?_pos=3&_psq=new+pot&_ss=e&_v=1.0',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'nabytok' LIMIT 1),
  'Kreslo September',
  'kreslo-september',
  'Plust',
  46000,
  NULL,
  'Kreslo Settembre evokuje mesiac september so svojimi miernymi teplotami a jasnou oblohou. Jeho ladné a harmonické línie spájajú komfort s dizajnom, čím vytvárajú dokonalú rovnováhu medzi estetikou a pohodlím. Ideálne na zariadenie vonkajších priestorov v tradičnom aj modernom mestskom štýle.
Rozmer
81 x 78 x 70 cm
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.plust.it/en/products/settembre-armchair/)',
  'https://kochlik.netlify.app/images/kreslo-september/kreslo-september_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/kreslo-september/kreslo-september_1.jpg', 'https://kochlik.netlify.app/images/kreslo-september/kreslo-september_2.jpg', 'https://kochlik.netlify.app/images/kreslo-september/kreslo-september_3.jpg', 'https://kochlik.netlify.app/images/kreslo-september/kreslo-september_4.jpg']::text[],
  '[{"name":"Pearl black","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_87_pearlblack.jpg","family":"Čierna"},{"name":"White C2","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_c2_whitec2.jpg","family":"Biela"},{"name":"Taupe","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_g9_taupe.jpg","family":"Hnedá"},{"name":"Sandy","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_m9_sandy.jpg","family":"Béžová"},{"name":"White light","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_u1_whitelight.jpg","family":"Biela"}]'::jsonb,
  ARRAY['Béžová', 'Biela', 'Čierna', 'Hnedá']::text[],
  ARRAY['78 x 70 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb,
  'https://www.plust.it/en/products/settembre-armchair/',
  'https://www.plust.it/en/products/settembre-armchair/',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'klasicke-kvetinace' LIMIT 1),
  'Nádoba ULIVUM',
  'nadoba-ulivum',
  'Euro3plast',
  72300,
  NULL,
  'Kolekcia Style je elegantná a nadčasová: tieto kvetináče a dekorácie s klasickým šarmom dodajú záhradám a terasám sofistikovaný vzhľad a po prvom použití sa stanú nepostrádateľné. Dokonale dopĺňajú priestory, ktoré sa rady nechávajú obdivovať.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.euro3plast.com/gb/products/445-ulivum.html)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/nadoba-ulivum/nadoba-ulivum_1.webp',
  ARRAY['https://kochlik.netlify.app/images/nadoba-ulivum/nadoba-ulivum_1.webp']::text[],
  '[{"name":"TERRA DI SIENA","hex":"#e3945b","image_url":null,"family":"Červená"}]'::jsonb,
  ARRAY['Červená']::text[],
  ARRAY['115x81 cm']::text[],
  ARRAY['101-150 cm']::text[],
  '[{"label":"115x81 cm","dimensions":"115x81 cm","price_cents":72300,"attributes":{"rozmer":"115x81 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"115×81 cm"}]'::jsonb,
  '[{"label":"Technický dokument","url":"https://www.euro3plast.com/sheets/ulivum_conca.pdf"},{"label":"Informačný dokument","url":"https://www.euro3plast.com/sheets/ulivum_conch_info_en.pdf"}]'::jsonb,
  'https://www.euro3plast.com/gb/products/445-ulivum.html',
  'https://www.euro3plast.com/gb/products/445-ulivum.html',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'moderne-kvetinace' LIMIT 1),
  'ETRIA',
  'etria',
  'Euro3plast',
  3600,
  NULL,
  'Štýl je synonymom minimalizmu – dokonale zhrnutý v čistých a jednoduchých líniách našich kvetináčov a doplnkov. Skombinovali sme čisté profily s farebnou paletou pre každý vkus – od výraznej kyslej zelene a červenej po klasické odtiene – aby ste obohatili svoje obľúbené priestory harmóniou a eleganciou.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.euro3plast.com/gb/-/317-3046-etria.html#/332-colour-white_c2/632-significant_measure-34)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/etria/etria_1.webp',
  ARRAY['https://kochlik.netlify.app/images/etria/etria_1.webp']::text[],
  '[{"name":"WHITE C2","hex":"#ffffff","image_url":null,"family":"Biela"},{"name":"RUST","hex":"#543920","image_url":null,"family":"Hnedá"},{"name":"TAUPE","hex":"#706961","image_url":null,"family":"Hnedá"},{"name":"SANDY","hex":"#b8a999","image_url":null,"family":"Béžová"},{"name":"TERRA DI SIENA","hex":"#e3945b","image_url":null,"family":"Červená"},{"name":"PEARL BLACK","hex":"#4a4a49","image_url":null,"family":"Čierna"}]'::jsonb,
  ARRAY['Béžová', 'Biela', 'Červená', 'Čierna', 'Hnedá']::text[],
  ARRAY['24x20 cm', '34x28 cm', '44x36 cm', '54x44 cm', '64x52 cm', '74x61 cm']::text[],
  ARRAY['Do 50 cm', '51-100 cm']::text[],
  '[{"label":"24x20 cm","dimensions":"24x20 cm","price_cents":3600,"attributes":{"rozmer":"24x20 cm"}},{"label":"34x28 cm","dimensions":"34x28 cm","price_cents":4700,"attributes":{"rozmer":"34x28 cm"}},{"label":"44x36 cm","dimensions":"44x36 cm","price_cents":8100,"attributes":{"rozmer":"44x36 cm"}},{"label":"54x44 cm","dimensions":"54x44 cm","price_cents":13000,"attributes":{"rozmer":"54x44 cm"}},{"label":"64x52 cm","dimensions":"64x52 cm","price_cents":22700,"attributes":{"rozmer":"64x52 cm"}},{"label":"74x61 cm","dimensions":"74x61 cm","price_cents":32700,"attributes":{"rozmer":"74x61 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"24×20 cm, 34×28 cm, 44×36 cm, 54×44 cm, 64×52 cm, 74×61 cm"}]'::jsonb,
  '[{"label":"Technický dokument","url":"https://www.euro3plast.com/sheets/etria_vaso_con_doppia_parete.pdf"},{"label":"Informačný dokument","url":"https://www.euro3plast.com/sheets/etria_pot_with_double_wall_info_en.pdf"}]'::jsonb,
  'https://www.euro3plast.com/gb/-/317-3046-etria.html#/332-colour-white_c2/632-significant_measure-34',
  'https://www.euro3plast.com/gb/-/317-3046-etria.html#/332-colour-white_c2/632-significant_measure-34',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'svietiace-kvetinace' LIMIT 1),
  'PALOMA svietiaci',
  'paloma-svietiaci',
  'Serralunga',
  44500,
  NULL,
  'Paloma je dekoratívny objekt, ktorý vnáša do záhrady aj do nášho každodenného života štipku živosti a evokuje prvky, ktoré nás vracajú k prírode a detstvu.
Úlomky reality, metafyzické objekty, snové miesta – na zemi… keď sa vo vašom každodennom živote objaví surrealistický prvok záhradného nábytku. Dizajn: Eero Aarnio pre Serralunga.
Vďaka osvetľovaciemu systému vo vnútri nie je Paloma len dekoratívnym prvkom alebo neformálnym sedením, ale aj elegantnou formou exteriérového osvetlenia pre život vonku. Paloma je dostupná v rôznych štandardných farbách a možno ju ukotviť do zeme.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/products/paloma-with-light?_pos=1&_psq=paloma&_ss=e&_v=1.0)',
  'https://kochlik.netlify.app/images/paloma-svietiaci/paloma-svietiaci_1.webp',
  ARRAY['https://kochlik.netlify.app/images/paloma-svietiaci/paloma-svietiaci_1.webp', 'https://kochlik.netlify.app/images/paloma-svietiaci/paloma-svietiaci_2.webp']::text[],
  '[{"name":"Luce bianca con cavo","hex":null,"image_url":null,"family":"Biela"},{"name":"Luce RGB senza fili","hex":null,"image_url":null,"family":null},{"name":"Luce RGB con cavo","hex":null,"image_url":null,"family":null}]'::jsonb,
  ARRAY['Biela']::text[],
  ARRAY['130x37.5x52.5 cm']::text[],
  ARRAY['101-150 cm']::text[],
  '[{"label":"130x37.5x52.5 cm","dimensions":"130x37.5x52.5 cm","price_cents":48000,"attributes":{"typ-ziarovky":"LED","rozmer":"130x37.5x52.5 cm"}},{"label":"130x37.5x52.5 cm","dimensions":"130x37.5x52.5 cm","price_cents":44500,"attributes":{"typ-ziarovky":"RGB","rozmer":"130x37.5x52.5 cm"}}]'::jsonb,
  '[{"key":"Typ žiarovky","value":"LED, RGB"},{"key":"Rozmer","value":"130×37.5×52.5 cm"}]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/products/paloma-with-light?_pos=1&_psq=paloma&_ss=e&_v=1.0',
  'https://serralunga.com/products/paloma-with-light?_pos=1&_psq=paloma&_ss=e&_v=1.0',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'nabytok' LIMIT 1),
  'Jetlag',
  'jetlag',
  'Plust',
  84500,
  NULL,
  'Pevná, poveternostným vplyvom odolná modulárna lavica navrhnutá pre veľké interiérové aj exteriérové priestory. Drážkovaný povrch vytvára elegantnú textúru a zabezpečuje vizuálnu kontinuitu tvaru, pričom zakrýva spoje medzi jednotlivými modulmi. Kombináciou viacerých prvkov možno vytvoriť pohodlné pohovky alebo dynamické zostavy. Dostupná je aj svietiaca verzia s bielym alebo farebným LED osvetlením.
Rozmer
175 x 145 x 42 cm 
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.plust.it/en/products/jetlag/)',
  'https://kochlik.netlify.app/images/jetlag/jetlag_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/jetlag/jetlag_1.jpg', 'https://kochlik.netlify.app/images/jetlag/jetlag_2.jpg']::text[],
  '[{"name":"Acid green","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_86_acidgreen.jpg","family":"Zelená"},{"name":"Pearl black","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_87_pearlblack.jpg","family":"Čierna"},{"name":"White C2","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_c2_whitec2.jpg","family":"Biela"},{"name":"Golden rust","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_n4_goldenrust.jpg","family":"Hnedá"},{"name":"White light","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_u1_whitelight.jpg","family":"Biela"}]'::jsonb,
  ARRAY['Biela', 'Čierna', 'Hnedá', 'Zelená']::text[],
  ARRAY['145 x 42 cm']::text[],
  ARRAY['101-150 cm']::text[],
  '[]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb,
  'https://www.plust.it/en/products/jetlag/',
  'https://www.plust.it/en/products/jetlag/',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'dizajnove' LIMIT 1),
  'Moai',
  'moai',
  'Plust',
  26500,
  NULL,
  'Štíhla váza s plynulým tvarom, pripomínajúca monumentálne sochy z Veľkonočného ostrova. Archetypálna silueta je dostupná v dvoch veľkostiach – možno ich kombinovať do páru alebo použiť samostatne. Ideálna na menšie rastliny alebo dekorácie so zvislým tvarom. K dispozícii je aj stabilizačná základňa alebo verzia so základňou na ukotvenie do zeme.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.plust.it/en/products/moai/)',
  'https://kochlik.netlify.app/images/moai/moai_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/moai/moai_1.jpg']::text[],
  '[{"name":"White C2","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_c2_whitec2.jpg","family":"Biela"},{"name":"Granite","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_s4_granite.jpg","family":"Sivá"},{"name":"White light","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_u1_whitelight.jpg","family":"Biela"},{"name":"Stone","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_u4_stone.jpg","family":"Sivá"}]'::jsonb,
  ARRAY['Biela', 'Sivá']::text[],
  ARRAY['29x29x126 cm', '41x41x175 cm']::text[],
  ARRAY['101-150 cm', 'Nad 150 cm']::text[],
  '[{"label":"29x29x126 cm","dimensions":"29x29x126 cm","price_cents":26500,"attributes":{"rozmer":"29x29x126 cm"}},{"label":"41x41x175 cm","dimensions":"41x41x175 cm","price_cents":50900,"attributes":{"rozmer":"41x41x175 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"29x29x126 cm, 41x41x175 cm"}]'::jsonb,
  '[]'::jsonb,
  'https://www.plust.it/en/products/moai/',
  'https://www.plust.it/en/products/moai/',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'svietiace-kvetinace' LIMIT 1),
  'Visiaca lampa Bonheur',
  'visiaca-lampa-bonheur',
  'Serralunga',
  87000,
  NULL,
  'Bonheur je závesná lampa na použitie v interiéri aj exteriéri. Má difúzor z dvoch polyetylénových častí vyrobených rotačným tvarovaním a konštrukciu zo sivého lakovaného kovu. Biela matná plocha polyméru jemne rozptyľuje svetlo a vytvára kontrast s hlbokou sivou farbou konštrukcie. Táto závesná lampa, navrhnutá na vonkajšie použitie, je vyrobená z nárazuvzdorného polyetylénu a má širokú základňu pre vyššiu stabilitu. Lampa patrí do kategórie osvetlenia Serralunga a je dostupná aj ako stojacia lampa. Navrhol ju Michele De Lucchi a je krásnym príkladom talianskeho interiérového dizajnu.
Rozmer
56x 56 x 80 cm
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/products/bonheur-hanging-lamp?_pos=1&_psq=Bonheur&_ss=e&_v=1.0)',
  'https://kochlik.netlify.app/images/visiaca-lampa-bonheur/visiaca-lampa-bonheur_1.webp',
  ARRAY['https://kochlik.netlify.app/images/visiaca-lampa-bonheur/visiaca-lampa-bonheur_1.webp', 'https://kochlik.netlify.app/images/visiaca-lampa-bonheur/visiaca-lampa-bonheur_2.webp', 'https://kochlik.netlify.app/images/visiaca-lampa-bonheur/visiaca-lampa-bonheur_3.webp', 'https://kochlik.netlify.app/images/visiaca-lampa-bonheur/visiaca-lampa-bonheur_4.webp']::text[],
  '[{"name":"Luce RGB con cavo","hex":null,"image_url":null,"family":null},{"name":"luce bianca con cavo","hex":null,"image_url":null,"family":"Biela"}]'::jsonb,
  ARRAY['Biela']::text[],
  ARRAY['56 x 80 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/products/bonheur-hanging-lamp?_pos=1&_psq=Bonheur&_ss=e&_v=1.0',
  'https://serralunga.com/products/bonheur-hanging-lamp?_pos=1&_psq=Bonheur&_ss=e&_v=1.0',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'klasicke-kvetinace' LIMIT 1),
  'Hrantík hladký BALAUSTRA LISCIA',
  'hrantik-hladky-balaustra-liscia',
  'Euro3plast',
  6000,
  NULL,
  'Kolekcia Style je elegantná a nadčasová: tieto kvetináče a dekorácie s klasickým šarmom dodajú záhradám a terasám sofistikovaný vzhľad a po prvom použití sa stanú nepostrádateľné. Dokonale dopĺňajú priestory, ktoré sa rady nechávajú obdivovať.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.euro3plast.com/gb/products/409-balaustra-liscia.html)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/hrantik-hladky-balaustra-liscia/hrantik-hladky-balaustra-liscia_1.webp',
  ARRAY['https://kochlik.netlify.app/images/hrantik-hladky-balaustra-liscia/hrantik-hladky-balaustra-liscia_1.webp']::text[],
  '[{"name":"TERRA DI SIENA","hex":"#e3945b","image_url":null,"family":"Červená"}]'::jsonb,
  ARRAY['Červená']::text[],
  ARRAY['100x25x26 cm', '50x25x26 cm', '60x25x26 cm', '80x25x26 cm']::text[],
  ARRAY['Do 50 cm', '51-100 cm']::text[],
  '[{"label":"100x25x26 cm","dimensions":"100x25x26 cm","price_cents":18800,"attributes":{"rozmer":"100x25x26 cm"}},{"label":"50x25x26 cm","dimensions":"50x25x26 cm","price_cents":6000,"attributes":{"rozmer":"50x25x26 cm"}},{"label":"60x25x26 cm","dimensions":"60x25x26 cm","price_cents":9100,"attributes":{"rozmer":"60x25x26 cm"}},{"label":"80x25x26 cm","dimensions":"80x25x26 cm","price_cents":12800,"attributes":{"rozmer":"80x25x26 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"100x25x26 cm, 50x25x26 cm, 60x25x26 cm, 80x25x26 cm"}]'::jsonb,
  '[{"label":"Technický dokument","url":"https://www.euro3plast.com/sheets/balaustra_liscia_cassetta.pdf"},{"label":"Informačný dokument","url":"https://www.euro3plast.com/sheets/balaustra_liscia_plant_box_info_en.pdf"}]'::jsonb,
  'https://www.euro3plast.com/gb/products/409-balaustra-liscia.html',
  'https://www.euro3plast.com/gb/products/409-balaustra-liscia.html',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'nabytok' LIMIT 1),
  'Konferečný stolík Oasis',
  'konferencny-stolik-oasis',
  'Serralunga',
  66400,
  NULL,
  'Viacfarebná funkčnosť je hlavnou prednosťou taburetu Oasis, ktorý – rovnako ako skutočná oáza – spája vnútorný aj vonkajší charakter značky Serralunga. Ide o dokonalý doplnok interiérového dizajnu a zároveň mnohostranný prvok moderného nábytku. Vďaka jednoduchým proporciám, precíznemu spracovaniu a elegantným líniám je Oasis ideálnym riešením aj pre komerčné priestory a pohostinstvá. Predstavuje univerzálny a luxusný kus nábytku, ktorý prináša pohodlie aj štýl. Umelá tráva nie je súčasťou balenia.
Rozmer
115 x 115 x 45 cm
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/en/products/oasis-table?_pos=1&_psq=Oasis&_ss=e&_v=1.0)',
  'https://kochlik.netlify.app/images/konferencny-stolik-oasis/konferencny-stolik-oasis_1.webp',
  ARRAY['https://kochlik.netlify.app/images/konferencny-stolik-oasis/konferencny-stolik-oasis_1.webp', 'https://kochlik.netlify.app/images/konferencny-stolik-oasis/konferencny-stolik-oasis_2.webp']::text[],
  '[{"name":"BIANCO","hex":null,"image_url":null,"family":"Biela"},{"name":"VERDE PAVONE","hex":null,"image_url":null,"family":"Zelená"},{"name":"ANTRACITE","hex":null,"image_url":null,"family":"Sivá"},{"name":"AZZURRO DI PROVENZA","hex":null,"image_url":null,"family":"Modrá"},{"name":"SALVIA DI SARDEGNA","hex":null,"image_url":null,"family":"Zelená"},{"name":"TORTORA DI TORINO","hex":null,"image_url":null,"family":"Hnedá"},{"name":"VERDE OLIVE DI CERIGNOLA","hex":null,"image_url":null,"family":"Zelená"},{"name":"GIALLO SAHARA","hex":null,"image_url":null,"family":"Žltá"},{"name":"VERDE BRITISH","hex":null,"image_url":null,"family":"Zelená"},{"name":"ROSSO POMPEIANO","hex":null,"image_url":null,"family":"Červená"}]'::jsonb,
  ARRAY['Biela', 'Červená', 'Hnedá', 'Modrá', 'Sivá', 'Zelená', 'Žltá']::text[],
  ARRAY['115 x 45 cm']::text[],
  ARRAY['101-150 cm']::text[],
  '[]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/en/products/oasis-table?_pos=1&_psq=Oasis&_ss=e&_v=1.0',
  'https://serralunga.com/en/products/oasis-table?_pos=1&_psq=Oasis&_ss=e&_v=1.0',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'nabytok' LIMIT 1),
  'Modul Big Cut',
  'modul-big-cut',
  'Plust',
  101000,
  NULL,
  'Tento rohový prvok možno umiestniť na koniec modulárnej zostavy, čím umožňuje vytvárať nekonečné kombinácie vždy s ideálnym počtom miest na sedenie. Súčasťou je vankúš vhodný na použitie v interiéri aj exteriéri, ktorý možno podľa potreby umiestniť tak, aby vytvoril pravý alebo ľavý roh. Dostupné aj v svietiacej verzii.
Rozmer
60 x 81 x 73 cm
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.plust.it/en/products/big-cut-module/)',
  'https://kochlik.netlify.app/images/modul-big-cut/modul-big-cut_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/modul-big-cut/modul-big-cut_1.jpg', 'https://kochlik.netlify.app/images/modul-big-cut/modul-big-cut_2.jpg', 'https://kochlik.netlify.app/images/modul-big-cut/modul-big-cut_3.jpg', 'https://kochlik.netlify.app/images/modul-big-cut/modul-big-cut_4.jpg']::text[],
  '[{"name":"White-White","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_l6_white-white.jpg","family":"Biela"},{"name":"White-Orange","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_l7_white-orange.jpg","family":"Biela"},{"name":"White-Taupe","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_l8_white-taupe.jpg","family":"Biela"},{"name":"Taupe-White","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_m6_taupe-white.jpg","family":"Biela"},{"name":"Taupe-Orange","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_m7_taupe-orange.jpg","family":"Hnedá"},{"name":"Taupe-Taupe","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_m8_taupe-taupe.jpg","family":"Hnedá"},{"name":"White Light-White","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_v8_whitelight-white.jpg","family":"Biela"},{"name":"White Light-Orange","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_x3_whitelight-orange.jpg","family":"Biela"},{"name":"White Light-Tortora","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_x4_whitelight-tortora.jpg","family":"Biela"}]'::jsonb,
  ARRAY['Biela', 'Hnedá']::text[],
  ARRAY['81 x 73 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb,
  'https://www.plust.it/en/products/big-cut-module/',
  'https://www.plust.it/en/products/big-cut-module/',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'moderne-kvetinace' LIMIT 1),
  'Kvetináč Torre',
  'kvetinac-torre',
  'Serralunga',
  12700,
  NULL,
  'Kvetináč Torre od Serralunga dokazuje, že aj ten najjednoduchší kvetináč môže byť dekoratívnym prvkom priestoru. Stačí náznak farby a správne zvolená rastlina – hra kontrastov a harmónie tónov vytvára vyvážený vizuálny efekt. Kvetináče Torre patria do kolekcie Serralunga 1825, ktorá je súčasťou exteriérového nábytku a doplnkov. Ich minimalistický dizajn umožňuje univerzálne použitie – od interiérových priestorov až po terasové a záhradné aranžmány.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/en/products/torre-planter?_pos=1&_psq=Vaso+Torre&_ss=e&_v=1.0)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/kvetinac-torre/kvetinac-torre_1.webp',
  ARRAY['https://kochlik.netlify.app/images/kvetinac-torre/kvetinac-torre_1.webp']::text[],
  '[{"name":"ANTRACITE","hex":null,"image_url":null,"family":"Sivá"},{"name":"BIANCO","hex":null,"image_url":null,"family":"Biela"},{"name":"AZZURRO DI PROVENZA","hex":null,"image_url":null,"family":"Modrá"},{"name":"ROSSO","hex":null,"image_url":null,"family":"Červená"},{"name":"SALVIA DI SARDEGNA","hex":null,"image_url":null,"family":"Zelená"},{"name":"TERRACOTTA TOSCANA","hex":null,"image_url":null,"family":"Červená"},{"name":"TERRACOTTA SCURA","hex":null,"image_url":null,"family":"Červená"},{"name":"TORTORA DI TORINO","hex":null,"image_url":null,"family":"Hnedá"},{"name":"VERDE PAVONE","hex":null,"image_url":null,"family":"Zelená"},{"name":"VERDE BRITISH","hex":null,"image_url":null,"family":"Zelená"},{"name":"ROSSO POMPEIANO","hex":null,"image_url":null,"family":"Červená"}]'::jsonb,
  ARRAY['Biela', 'Červená', 'Hnedá', 'Modrá', 'Sivá', 'Zelená']::text[],
  ARRAY['38x38x70 cm', '42x42x90 cm', '45x45x50 cm', '55x55x100 cm']::text[],
  ARRAY['Do 50 cm', '51-100 cm']::text[],
  '[{"label":"38x38x70 cm","dimensions":"38x38x70 cm","price_cents":17100,"attributes":{"rozmer":"38x38x70 cm"}},{"label":"42x42x90 cm","dimensions":"42x42x90 cm","price_cents":21800,"attributes":{"rozmer":"42x42x90 cm"}},{"label":"45x45x50 cm","dimensions":"45x45x50 cm","price_cents":12700,"attributes":{"rozmer":"45x45x50 cm"}},{"label":"55x55x100 cm","dimensions":"55x55x100 cm","price_cents":28200,"attributes":{"rozmer":"55x55x100 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"38x38x70 cm, 42x42x90 cm, 45x45x50 cm, 55x55x100 cm"}]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/en/products/torre-planter?_pos=1&_psq=Vaso+Torre&_ss=e&_v=1.0',
  'https://serralunga.com/en/products/torre-planter?_pos=1&_psq=Vaso+Torre&_ss=e&_v=1.0',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  NULL,
  'Tumbler',
  'tumbler',
  'Teraitaly',
  NULL,
  NULL,
  'Tumbler a Ring nie sú len obyčajné kvetináče – sú to ostrovy spoločenskosti. Predstavujú dizajnové doplnky, ktoré podporujú interakciu a pohodu, spájajú funkčnosť a estetiku v jednom okrúhlom priestore vďaka integrovanej odkladacej poličke.',
  'https://kochlik.netlify.app/images/tumbler/tumbler_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/tumbler/tumbler_1.jpg']::text[],
  '[]'::jsonb,
  ARRAY[]::text[],
  ARRAY[]::text[],
  ARRAY[]::text[],
  '[]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb,
  'https://kochlik.sk/produkt/tumbler/',
  'https://kochlik.sk/produkt/tumbler/',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'moderne-kvetinace' LIMIT 1),
  'Kvetináč FENCE malý',
  'kvetinac-fence-maly',
  'Serralunga',
  38600,
  NULL,
  'Kvetináč Fence, navrhnutý Raffaellou Mangiarotti pre značku Serralunga, prináša nádych Provence v podobe tradičného tvaru dreveného plota, ktorý určuje jeho originálny dizajn. Tento kvetináč – pripomínajúci záhradnú debničku – predstavuje modernú interpretáciu klasického štýlu a zároveň vytvára pocit súkromia a útulnej atmosféry. Jeho ľahký, trojrozmerný povrch dodáva hĺbku a textúru, vďaka čomu sa ľahko kombinuje s rôznymi štýlmi a prostrediami. Model Fence je dostupný aj vo väčšej verzii, vhodnej pre rozsiahlejšie priestory či exteriéry.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/en/products/fence-planter-small?_pos=2&_psq=FENCE&_ss=e&_v=1.0)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/kvetinac-fence-maly/kvetinac-fence-maly_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/kvetinac-fence-maly/kvetinac-fence-maly_1.jpg']::text[],
  '[{"name":"PIETRA DELLA DOLOMITI","hex":null,"image_url":null,"family":"Sivá"},{"name":"SALVIA DI SARDEGNA","hex":null,"image_url":null,"family":"Zelená"},{"name":"TERRACOTTA TOSCANA","hex":null,"image_url":null,"family":"Červená"},{"name":"ANTRACITE","hex":null,"image_url":null,"family":"Sivá"},{"name":"AZZURRO DI PROVENZA","hex":null,"image_url":null,"family":"Modrá"},{"name":"TERRACOTTA SCURA","hex":null,"image_url":null,"family":"Červená"},{"name":"TORTORA DI TORINO","hex":null,"image_url":null,"family":"Hnedá"},{"name":"BIANCO","hex":null,"image_url":null,"family":"Biela"},{"name":"GIALLO SAHARA","hex":null,"image_url":null,"family":"Žltá"},{"name":"VERDE BRITISH","hex":null,"image_url":null,"family":"Zelená"},{"name":"ROSSO POMPEIANO","hex":null,"image_url":null,"family":"Červená"},{"name":"PIETRA DI MATERA","hex":null,"image_url":null,"family":"Sivá"}]'::jsonb,
  ARRAY['Biela', 'Červená', 'Hnedá', 'Modrá', 'Sivá', 'Zelená', 'Žltá']::text[],
  ARRAY['45x35x60 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[{"label":"45x35x60 cm","dimensions":"45x35x60 cm","price_cents":38600,"attributes":{"rozmer":"45x35x60 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"45x35x60 cm"}]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/en/products/fence-planter-small?_pos=2&_psq=FENCE&_ss=e&_v=1.0',
  'https://serralunga.com/en/products/fence-planter-small?_pos=2&_psq=FENCE&_ss=e&_v=1.0',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  NULL,
  'Hrantík AKAN',
  'hrantik-akan',
  'Euro3plast',
  11400,
  NULL,
  'Štýl je synonymom minimalizmu – dokonale zhrnutý v čistých a jednoduchých líniách našich kvetináčov a doplnkov. Skombinovali sme čisté profily s farebnou paletou pre každý vkus – od výraznej kyslej zelene a červenej po klasické odtiene – aby ste obohatili svoje obľúbené priestory harmóniou a eleganciou.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.euro3plast.com/gb/products/413-akan.html)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/hrantik-akan/hrantik-akan_1.webp',
  ARRAY['https://kochlik.netlify.app/images/hrantik-akan/hrantik-akan_1.webp']::text[],
  '[{"name":"RUST","hex":"#543920","image_url":null,"family":"Hnedá"},{"name":"PEARL BLACK","hex":"#4a4a49","image_url":null,"family":"Čierna"}]'::jsonb,
  ARRAY['Čierna', 'Hnedá']::text[],
  ARRAY['40x40x33 cm']::text[],
  ARRAY['Do 50 cm']::text[],
  '[{"label":"40x40x33 cm","dimensions":"40x40x33 cm","price_cents":11400,"attributes":{"rozmer":"40x40x33 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"40x40x33 cm"}]'::jsonb,
  '[{"label":"Technický dokument","url":"https://www.euro3plast.com/sheets/akan_vaso_quadro_con_doppia_parete.pdf"},{"label":"Informačný dokument","url":"https://www.euro3plast.com/sheets/akan_square_pot_with_double_wall_info_en.pdf"}]'::jsonb,
  'https://www.euro3plast.com/gb/products/413-akan.html',
  'https://www.euro3plast.com/gb/products/413-akan.html',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'klasicke-kvetinace' LIMIT 1),
  'Kvetináč Millerighe Quadrato –xxxxx',
  'kvetinac-millerighe-quadrato',
  'Serralunga',
  6600,
  NULL,
  'Kvetináč Millerighe Quadrato od Serralunga je večná klasika s čistými líniami a elegantným tvarom, ktorý nikdy nevyjde z módy. Jeho farebné spracovanie – od jemných tón v tóne odtieňov až po výrazné chromatické akcenty – prináša nečakané kombinácie a dodáva priestoru sofistikovaný vzhľad. Kvetináče Millerighe patria do kolekcie Serralunga garden décor a sú ideálne pre moderné aj klasické záhradné aranžmány.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/en/products/millerighe-quadrato-planter?_pos=1&_psq=Vaso+Millerighe+Quadrato&_ss=e&_v=1.0)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/kvetinac-millerighe-quadrato/kvetinac-millerighe-quadrato_1.webp',
  ARRAY['https://kochlik.netlify.app/images/kvetinac-millerighe-quadrato/kvetinac-millerighe-quadrato_1.webp']::text[],
  '[{"name":"TORTORA DI TORINO","hex":null,"image_url":null,"family":"Hnedá"},{"name":"TERRACOTTA TOSCANA","hex":null,"image_url":null,"family":"Červená"},{"name":"ANTRACITE","hex":null,"image_url":null,"family":"Sivá"},{"name":"AZZURRO DI PROVENZA","hex":null,"image_url":null,"family":"Modrá"},{"name":"PIETRA DELLE DOLOMITI","hex":null,"image_url":null,"family":"Sivá"},{"name":"SALVIA DI SARDEGNA","hex":null,"image_url":null,"family":"Zelená"},{"name":"TERRACOTTA SCURA","hex":null,"image_url":null,"family":"Červená"},{"name":"BIANCO","hex":null,"image_url":null,"family":"Biela"},{"name":"VERDE PAVONE","hex":null,"image_url":null,"family":"Zelená"},{"name":"ROSSO","hex":null,"image_url":null,"family":"Červená"},{"name":"IMPRUNETA CLASSICA","hex":null,"image_url":null,"family":"Hnedá"},{"name":"GIALLO SAHARA","hex":null,"image_url":null,"family":"Žltá"},{"name":"VERDE BRITISH","hex":null,"image_url":null,"family":"Zelená"},{"name":"ROSSO POMPEIANO","hex":null,"image_url":null,"family":"Červená"}]'::jsonb,
  ARRAY['Biela', 'Červená', 'Hnedá', 'Modrá', 'Sivá', 'Zelená', 'Žltá']::text[],
  ARRAY[]::text[],
  ARRAY[]::text[],
  '[]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/en/products/millerighe-quadrato-planter?_pos=1&_psq=Vaso+Millerighe+Quadrato&_ss=e&_v=1.0',
  'https://serralunga.com/en/products/millerighe-quadrato-planter?_pos=1&_psq=Vaso+Millerighe+Quadrato&_ss=e&_v=1.0',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  NULL,
  'Hrantík AKAN',
  'hrantik-akan-2',
  'Euro3plast',
  19100,
  NULL,
  'Štýl je synonymom minimalizmu – dokonale zhrnutý v čistých a jednoduchých líniách našich kvetináčov a doplnkov. Skombinovali sme čisté profily s farebnou paletou pre každý vkus – od výraznej kyslej zelene a červenej po klasické odtiene – aby ste obohatili svoje obľúbené priestory harmóniou a eleganciou.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.euro3plast.com/gb/products/412-akan.html)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/hrantik-akan-2/hrantik-akan-2_1.webp',
  ARRAY['https://kochlik.netlify.app/images/hrantik-akan-2/hrantik-akan-2_1.webp']::text[],
  '[{"name":"RUST","hex":"#543920","image_url":null,"family":"Hnedá"},{"name":"PEARL BLACK","hex":"#4a4a49","image_url":null,"family":"Čierna"}]'::jsonb,
  ARRAY['Čierna', 'Hnedá']::text[],
  ARRAY['80x40x33 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[{"label":"80x40x33 cm","dimensions":"80x40x33 cm","price_cents":19100,"attributes":{"rozmer":"80x40x33 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"80x40x33 cm"}]'::jsonb,
  '[{"label":"Technický dokument","url":"https://www.euro3plast.com/sheets/akan_cassetta_con_doppia_parete.pdf"},{"label":"Informačný dokument","url":"https://www.euro3plast.com/sheets/akan_plant_box_with_double_wall_info_en.pdf"}]'::jsonb,
  'https://www.euro3plast.com/gb/products/412-akan.html',
  'https://www.euro3plast.com/gb/products/412-akan.html',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'klasicke-kvetinace' LIMIT 1),
  'Misa CIOTOLA GIULIA',
  'misa-ciotola-giulia',
  'Serralunga',
  17700,
  NULL,
  'Kvetináč Ciotola Giulia od značky Serralunga je klasickým dizajnovým kúskom, ktorý v sebe spája atmosféru anglickej záhrady a talianskeho vidieka. Jeho vzhľad pôsobí harmonicky a elegantne, čím dodáva priestoru teplo a nadčasový šarm. Nová, prekvapivá povrchová úprava prináša čaro nečakaného a odhaľuje kryštalickú krásu starobylých kvetináčov, ktoré pripomínajú umenie minulosti v modernom prevedení.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/en/products/decorati-ciotola-giulia-planter?_pos=1&_psq=CIOTOLA+GIULIA&_ss=e&_v=1.0)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/misa-ciotola-giulia/misa-ciotola-giulia_1.webp',
  ARRAY['https://kochlik.netlify.app/images/misa-ciotola-giulia/misa-ciotola-giulia_1.webp']::text[],
  '[{"name":"TORTORA DI TORINO","hex":null,"image_url":null,"family":"Hnedá"},{"name":"TERRACOTTA TOSCANA","hex":null,"image_url":null,"family":"Červená"},{"name":"GESSO DI BOLOGNA","hex":null,"image_url":null,"family":"Biela"},{"name":"ANTRACITE","hex":null,"image_url":null,"family":"Sivá"},{"name":"AZZURRO DI PROVENZA","hex":null,"image_url":null,"family":"Modrá"},{"name":"SALVIA DI SARDEGNA","hex":null,"image_url":null,"family":"Zelená"},{"name":"TERRACOTTA SCURA","hex":null,"image_url":null,"family":"Červená"},{"name":"VERDE PAVONE","hex":null,"image_url":null,"family":"Zelená"},{"name":"PIETRA DELLA DOLOMITI","hex":null,"image_url":null,"family":"Sivá"},{"name":"BIANCO","hex":null,"image_url":null,"family":"Biela"},{"name":"GIALLO SAHARA","hex":null,"image_url":null,"family":"Žltá"},{"name":"VERDE BRITISH","hex":null,"image_url":null,"family":"Zelená"},{"name":"ROSSO POMPEIANO","hex":null,"image_url":null,"family":"Červená"}]'::jsonb,
  ARRAY['Biela', 'Červená', 'Hnedá', 'Modrá', 'Sivá', 'Zelená', 'Žltá']::text[],
  ARRAY['66x25 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[{"label":"66x25 cm","dimensions":"66x25 cm","price_cents":17700,"attributes":{"rozmer":"66x25 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"66×25 cm"}]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/en/products/decorati-ciotola-giulia-planter?_pos=1&_psq=CIOTOLA+GIULIA&_ss=e&_v=1.0',
  'https://serralunga.com/en/products/decorati-ciotola-giulia-planter?_pos=1&_psq=CIOTOLA+GIULIA&_ss=e&_v=1.0',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  NULL,
  'Kvetináč TULUM',
  'kvetinac-tulum',
  'Euro3plast',
  9500,
  NULL,
  'Štýl je synonymom minimalizmu – dokonale zhrnutý v čistých a jednoduchých líniách našich kvetináčov a doplnkov. Skombinovali sme čisté profily s farebnou paletou pre každý vkus – od výraznej kyslej zelene a červenej po klasické odtiene – aby ste obohatili svoje obľúbené priestory harmóniou a eleganciou.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.euro3plast.com/gb/products/517-tulum.html)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/kvetinac-tulum/kvetinac-tulum_1.webp',
  ARRAY['https://kochlik.netlify.app/images/kvetinac-tulum/kvetinac-tulum_1.webp']::text[],
  '[{"name":"PEARL BLACK","hex":"#4a4a49","image_url":null,"family":"Čierna"}]'::jsonb,
  ARRAY['Čierna']::text[],
  ARRAY['35x51 cm', '43x63 cm', '56x102 cm']::text[],
  ARRAY['51-100 cm', '101-150 cm']::text[],
  '[{"label":"35x51 cm","dimensions":"35x51 cm","price_cents":9500,"attributes":{"rozmer":"35x51 cm"}},{"label":"43x63 cm","dimensions":"43x63 cm","price_cents":12800,"attributes":{"rozmer":"43x63 cm"}},{"label":"56x102 cm","dimensions":"56x102 cm","price_cents":30600,"attributes":{"rozmer":"56x102 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"35×51 cm, 43×63 cm, 56×102 cm"}]'::jsonb,
  '[{"label":"Technický dokument","url":"https://www.euro3plast.com/sheets/tulum_vaso_con_doppia_parete.pdf"},{"label":"Informačný dokument","url":"https://www.euro3plast.com/sheets/tulum_pot_with_double_wall_info_en.pdf"}]'::jsonb,
  'https://www.euro3plast.com/gb/products/517-tulum.html',
  'https://www.euro3plast.com/gb/products/517-tulum.html',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'dizajnove' LIMIT 1),
  'Drop',
  'drop',
  'Plust',
  26000,
  NULL,
  'Váza Drop vyniká svojou univerzálnosťou a čistým, elegantným tvarom. Skvele sa kombinuje s kaktusmi alebo sušenými dekoratívnymi vetvami, ktoré zvýrazňujú kontrast medzi jednoduchosťou jej formy a výrazom prírody. Ideálna na rastliny alebo stredne veľké dekorácie. V svietiacej verzii sa hodí do rôznych prostredí – od moderných či klasických interiérov až po záhrady, terasy, verandy či otvorené priestory.
Rozmer:
69 x 69 x 73 cm
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.plust.it/en/products/drop/)',
  'https://kochlik.netlify.app/images/drop/drop_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/drop/drop_1.jpg', 'https://kochlik.netlify.app/images/drop/drop_2.jpg', 'https://kochlik.netlify.app/images/drop/drop_3.jpg']::text[],
  '[{"name":"White C2","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_c2_whitec2.jpg","family":"Biela"},{"name":"Granite","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_s4_granite.jpg","family":"Sivá"},{"name":"Stone","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_u4_stone.jpg","family":"Sivá"},{"name":"White light","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_u1_whitelight.jpg","family":"Biela"}]'::jsonb,
  ARRAY['Biela', 'Sivá']::text[],
  ARRAY['69 x 73 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb,
  'https://www.plust.it/en/products/drop/',
  'https://www.plust.it/en/products/drop/',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  NULL,
  'Kvetináč ILIE GLOSS',
  'kvetinac-ilie-gloss',
  'Euro3plast',
  8000,
  NULL,
  'Lesklé povrchy a žiarivé farby sú výrazným prvkom kolekcie Style Gloss – moderná línia s mladistvým, no výrazným charakterom. Kvetináče nie sú dodatočne glazované; vyrábajú sa priamo v lesklej farebnej verzii, pripravené ozdobiť každý priestor svojou jedinečnou osobitosťou.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.euro3plast.com/gb/-/323-ilie.html)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/kvetinac-ilie-gloss/kvetinac-ilie-gloss_1.webp',
  ARRAY['https://kochlik.netlify.app/images/kvetinac-ilie-gloss/kvetinac-ilie-gloss_1.webp']::text[],
  '[{"name":"WHITE C2","hex":"#ffffff","image_url":null,"family":"Biela"}]'::jsonb,
  ARRAY['Biela']::text[],
  ARRAY['32x67 cm', '37x75 cm', '47x98 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[{"label":"32x67 cm","dimensions":"32x67 cm","price_cents":8000,"attributes":{"rozmer":"32x67 cm"}},{"label":"37x75 cm","dimensions":"37x75 cm","price_cents":13100,"attributes":{"rozmer":"37x75 cm"}},{"label":"47x98 cm","dimensions":"47x98 cm","price_cents":23000,"attributes":{"rozmer":"47x98 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"32×67 cm, 37×75 cm, 47×98 cm"}]'::jsonb,
  '[{"label":"Technický dokument","url":"https://www.euro3plast.com/sheets/ilie_vaso_gloss_con_doppia_parete.pdf"},{"label":"Informačný dokument","url":"https://www.euro3plast.com/sheets/ilie_gloss_pot_with_double_wall_info_en.pdf"}]'::jsonb,
  'https://www.euro3plast.com/gb/-/323-ilie.html',
  'https://www.euro3plast.com/gb/-/323-ilie.html',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'moderne-kvetinace' LIMIT 1),
  'Kvetináč Cup veľký',
  'kvetinac-cup-velky',
  'Serralunga',
  35200,
  NULL,
  'Kolekcia Cup predstavuje sériu kvetináčov inšpirovaných nadčasovými tvarmi, ktoré pripomínajú precízne vyrezávané drevené misy. Vďaka čistým líniám a minimalistickému dizajnu vyžarujú klasickú eleganciu a harmonicky ladia s akýmkoľvek prostredím. Dizajn od Naota Fukasawu pre značku Serralunga robí z kolekcie Cup ideálny doplnok vonkajšieho nábytku a záhradnej architektúry. Model Cup Big Planter má priemer 70 cm a výšku 58 cm. Vyrobené z ľahkého, no odolného polyetylénu, tvarovaného technológiou rotačného liatia. Poskytuje UV ochranu, je 100 % recyklovateľné a farbené v hmote.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/en/products/cup-big-planter?pr_prod_strat=e5_desc&pr_rec_id=d06526bda&pr_rec_pid=7003990458505&pr_ref_pid=7003990392969&pr_seq=uniform)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/kvetinac-cup-velky/kvetinac-cup-velky_1.webp',
  ARRAY['https://kochlik.netlify.app/images/kvetinac-cup-velky/kvetinac-cup-velky_1.webp', 'https://kochlik.netlify.app/images/kvetinac-cup-velky/kvetinac-cup-velky_2.webp', 'https://kochlik.netlify.app/images/kvetinac-cup-velky/kvetinac-cup-velky_3.webp']::text[],
  '[{"name":"BIANCO","hex":null,"image_url":null,"family":"Biela"},{"name":"TORTORA DI TORINO","hex":null,"image_url":null,"family":"Hnedá"},{"name":"ANTRACITE","hex":null,"image_url":null,"family":"Sivá"},{"name":"AZZURRO DI PROVENZA","hex":null,"image_url":null,"family":"Modrá"},{"name":"ACQUA DELLA MADDALENA","hex":null,"image_url":null,"family":"Modrá"},{"name":"SALVIA DI SARDEGNA","hex":null,"image_url":null,"family":"Zelená"},{"name":"ROSSO","hex":null,"image_url":null,"family":"Červená"},{"name":"TERRACOTTA TOSCANA","hex":null,"image_url":null,"family":"Červená"},{"name":"TERRACOTTA SCURA","hex":null,"image_url":null,"family":"Červená"},{"name":"VERDE PAVONE","hex":null,"image_url":null,"family":"Zelená"},{"name":"NEVE DI SAN CANDIDO","hex":null,"image_url":null,"family":"Biela"},{"name":"LACQUERED BIANCO","hex":null,"image_url":null,"family":"Biela"},{"name":"GIALLO SAHARA","hex":null,"image_url":null,"family":"Žltá"},{"name":"VERDE BRITISH","hex":null,"image_url":null,"family":"Zelená"},{"name":"ROSSO POMPEIANO","hex":null,"image_url":null,"family":"Červená"},{"name":"MORE DI ROVO-NERO","hex":null,"image_url":null,"family":"Čierna"}]'::jsonb,
  ARRAY['Biela', 'Červená', 'Čierna', 'Hnedá', 'Modrá', 'Sivá', 'Zelená', 'Žltá']::text[],
  ARRAY['70x70x58 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[{"label":"70x70x58 cm","dimensions":"70x70x58 cm","price_cents":35200,"attributes":{"rozmer":"70x70x58 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"70x70x58 cm"}]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/en/products/cup-big-planter?pr_prod_strat=e5_desc&pr_rec_id=d06526bda&pr_rec_pid=7003990458505&pr_ref_pid=7003990392969&pr_seq=uniform',
  'https://serralunga.com/en/products/cup-big-planter?pr_prod_strat=e5_desc&pr_rec_id=d06526bda&pr_rec_pid=7003990458505&pr_ref_pid=7003990392969&pr_seq=uniform',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'nabytok' LIMIT 1),
  'Kreslo Boom',
  'kreslo-boom',
  'Plust',
  46000,
  NULL,
  'Kreslo Boom je novou ikonou značky Plust, ktorá spája geometrickú dokonalosť kruhu s vysokým komfortom sedenia. Boom je nadčasový kúsok s elegantným dizajnom, ktorý si zachováva svoju aktuálnosť v každom období.
Rozmer
98 x 95 x 69 cm
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.plust.it/en/products/boom-armchair/)',
  'https://kochlik.netlify.app/images/kreslo-boom/kreslo-boom_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/kreslo-boom/kreslo-boom_1.jpg', 'https://kochlik.netlify.app/images/kreslo-boom/kreslo-boom_2.gif', 'https://kochlik.netlify.app/images/kreslo-boom/kreslo-boom_3.gif', 'https://kochlik.netlify.app/images/kreslo-boom/kreslo-boom_4.gif', 'https://kochlik.netlify.app/images/kreslo-boom/kreslo-boom_5.gif']::text[],
  '[{"name":"White C2","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_c2_whitec2.jpg","family":"Biela"},{"name":"Mint","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_v5_mint.jpg","family":"Zelená"},{"name":"Tide","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_v6_tide.jpg","family":"Béžová"},{"name":"Creta","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_v7_creta.jpg","family":"Béžová"},{"name":"Decor","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_z3_decor.jpg","family":"Béžová"},{"name":"Grain","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_z6_grain.jpg","family":"Béžová"},{"name":"White light","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_u1_whitelight.jpg","family":"Biela"}]'::jsonb,
  ARRAY['Béžová', 'Biela', 'Zelená']::text[],
  ARRAY['95 x 69 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb,
  'https://www.plust.it/en/products/boom-armchair/',
  'https://www.plust.it/en/products/boom-armchair/',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'nabytok' LIMIT 1),
  'Sedačka Boom',
  'sedacka-boom',
  'Plust',
  106000,
  NULL,
  'Pohovka Boom je pozvánkou na oddych v maximálnom pohodlí, obklopená decentnou, modernou formou, ktorá ladí s ostatnými produktmi z kolekcie. Jej zaoblený tvar vyžaruje nadčasový šarm a dizajn, ktorý nikdy nevyjde z módy.
Rozmer
198 x 99 x 71 cm
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.plust.it/en/products/boom-sofa/)',
  'https://kochlik.netlify.app/images/sedacka-boom/sedacka-boom_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/sedacka-boom/sedacka-boom_1.jpg', 'https://kochlik.netlify.app/images/sedacka-boom/sedacka-boom_2.gif', 'https://kochlik.netlify.app/images/sedacka-boom/sedacka-boom_3.gif', 'https://kochlik.netlify.app/images/sedacka-boom/sedacka-boom_4.gif', 'https://kochlik.netlify.app/images/sedacka-boom/sedacka-boom_5.gif', 'https://kochlik.netlify.app/images/sedacka-boom/sedacka-boom_6.gif']::text[],
  '[{"name":"White C2","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_c2_whitec2.jpg","family":"Biela"},{"name":"Mint","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_v5_mint.jpg","family":"Zelená"},{"name":"Tide","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_v6_tide.jpg","family":"Béžová"},{"name":"Creta","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_v7_creta.jpg","family":"Béžová"},{"name":"Grain","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_z6_grain.jpg","family":"Béžová"},{"name":"White light","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_u1_whitelight.jpg","family":"Biela"}]'::jsonb,
  ARRAY['Béžová', 'Biela', 'Zelená']::text[],
  ARRAY['99 x 71 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb,
  'https://www.plust.it/en/products/boom-sofa/',
  'https://www.plust.it/en/products/boom-sofa/',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'svietiace-kvetinace' LIMIT 1),
  'Kvetináč Primavera svietiaci',
  'kvetinac-primavera-svietiaci',
  'Serralunga',
  136200,
  NULL,
  'Materiál: Vyrobené z LLDPE (lineárny nízkohustotný polyetylén) Farba: Neutrálna priesvitná Výrobný proces: Rotačné tvarovanie Vhodné na vonkajšie použitie – odolné voči všetkým poveternostným podmienkam. Poskytuje UV ochranu, je 100 % recyklovateľné a farbené v hmote. Má vysokú mechanickú pevnosť a odolnosť proti nárazom. Odoláva teplotám od -35 °C do +80 °C.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/en/products/primavera-planter-with-light?_pos=2&_psq=Primavera&_ss=e&_v=1.0)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom.',
  'https://kochlik.netlify.app/images/kvetinac-primavera-svietiaci/kvetinac-primavera-svietiaci_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/kvetinac-primavera-svietiaci/kvetinac-primavera-svietiaci_1.jpg']::text[],
  '[{"name":"White light with cable","hex":null,"image_url":null,"family":"Biela"},{"name":"RGB light with cable","hex":null,"image_url":null,"family":null}]'::jsonb,
  ARRAY['Biela']::text[],
  ARRAY['130x130x120 cm']::text[],
  ARRAY['101-150 cm']::text[],
  '[{"label":"130x130x120 cm","dimensions":"130x130x120 cm","price_cents":139700,"attributes":{"rozmer":"130x130x120 cm","typ-ziarovky":"LED"}},{"label":"130x130x120 cm","dimensions":"130x130x120 cm","price_cents":136200,"attributes":{"rozmer":"130x130x120 cm","typ-ziarovky":"RGB"}}]'::jsonb,
  '[{"key":"Rozmer","value":"130x130x120 cm"},{"key":"Typ žiarovky","value":"LED, RGB"}]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/en/products/primavera-planter-with-light?_pos=2&_psq=Primavera&_ss=e&_v=1.0',
  'https://serralunga.com/en/products/primavera-planter-with-light?_pos=2&_psq=Primavera&_ss=e&_v=1.0',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'doplnky' LIMIT 1),
  'Kuriatko',
  'kuriatko',
  'Serralunga',
  21000,
  NULL,
  'Pulcino je menšia verzia modelu Paloma, dekoratívny objekt, ktorý vnáša do záhrady aj do nášho každodenného života štipku živosti a evokuje prvky, ktoré nás vracajú k prírode a detstvu. Rovnako ako Paloma, aj Pulcino patrí do kategórií talianskeho nábytku a záhradného nábytku značky Serralunga.
Pulcino je možné ukotviť do zeme. Dizajnérom kolekcie záhradného nábytku Pulcino, Doggy a Paloma je Eero Aarnio.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/en/products/pulcino?_pos=1&_psq=pulcino&_ss=e&_v=1.0)',
  'https://kochlik.netlify.app/images/kuriatko/kuriatko_1.webp',
  ARRAY['https://kochlik.netlify.app/images/kuriatko/kuriatko_1.webp', 'https://kochlik.netlify.app/images/kuriatko/kuriatko_2.webp', 'https://kochlik.netlify.app/images/kuriatko/kuriatko_3.webp', 'https://kochlik.netlify.app/images/kuriatko/kuriatko_4.webp']::text[],
  '[{"name":"BIANCO","hex":null,"image_url":null,"family":"Biela"},{"name":"AZZURRO DI PROVENZA","hex":null,"image_url":null,"family":"Modrá"},{"name":"SALVIA DI SARDEGNA","hex":null,"image_url":null,"family":"Zelená"},{"name":"TORTORA DI TORINO","hex":null,"image_url":null,"family":"Hnedá"},{"name":"VERDE PAVONE","hex":null,"image_url":null,"family":"Zelená"},{"name":"ROSSO","hex":null,"image_url":null,"family":"Červená"},{"name":"LACQUERED GOLD","hex":null,"image_url":null,"family":"Žltá"},{"name":"ANTRACITE","hex":null,"image_url":null,"family":"Sivá"},{"name":"ACQUA DELLA MADDALENA","hex":null,"image_url":null,"family":"Modrá"},{"name":"GIALLO SAHARA","hex":null,"image_url":null,"family":"Žltá"},{"name":"VERDE BRITISH","hex":null,"image_url":null,"family":"Zelená"},{"name":"ROSSO POMPEIANO","hex":null,"image_url":null,"family":"Červená"}]'::jsonb,
  ARRAY['Biela', 'Červená', 'Hnedá', 'Modrá', 'Sivá', 'Zelená', 'Žltá']::text[],
  ARRAY['80x27x39 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[{"label":"80x27x39 cm","dimensions":"80x27x39 cm","price_cents":21000,"attributes":{"rozmer":"80x27x39 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"80x27x39 cm"}]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/en/products/pulcino?_pos=1&_psq=pulcino&_ss=e&_v=1.0',
  'https://serralunga.com/en/products/pulcino?_pos=1&_psq=pulcino&_ss=e&_v=1.0',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'klasicke-kvetinace' LIMIT 1),
  'Kvetináč KUBIS štvorcový',
  'kvetinac-kubis-stvorcovy',
  'Euro3plast',
  46900,
  NULL,
  'Kolekcia Style je elegantná a nadčasová: tieto kvetináče a dekorácie s klasickým šarmom dodajú záhradám a terasám sofistikovaný vzhľad a po prvom použití sa stanú nepostrádateľné. Dokonale dopĺňajú priestory, ktoré sa rady nechávajú obdivovať.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.euro3plast.com/gb/products/408-kubis.html)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/kvetinac-kubis-stvorcovy/kvetinac-kubis-stvorcovy_1.webp',
  ARRAY['https://kochlik.netlify.app/images/kvetinac-kubis-stvorcovy/kvetinac-kubis-stvorcovy_1.webp']::text[],
  '[{"name":"TERRA DI SIENA","hex":"#e3945b","image_url":null,"family":"Červená"}]'::jsonb,
  ARRAY['Červená']::text[],
  ARRAY['80x80x65 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[{"label":"80x80x65 cm","dimensions":"80x80x65 cm","price_cents":46900,"attributes":{"rozmer":"80x80x65 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"80x80x65 cm"}]'::jsonb,
  '[{"label":"Technický dokument","url":"https://www.euro3plast.com/sheets/kubis_vaso_quadro.pdf"},{"label":"Informačný dokument","url":"https://www.euro3plast.com/sheets/kubis_square_pot_info_en.pdf"}]'::jsonb,
  'https://www.euro3plast.com/gb/products/408-kubis.html',
  'https://www.euro3plast.com/gb/products/408-kubis.html',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'moderne-kvetinace' LIMIT 1),
  'Kvetináč Cup vysoký',
  'kvetinac-cup-vysoky',
  'Serralunga',
  17300,
  NULL,
  'Kolekcia Cup zahŕňa sériu kvetináčov inšpirovaných nadčasovými tvarmi, ktoré pripomínajú precízne vyrezávané drevené misy. Vďaka čistým líniám a minimalistickému dizajnu pôsobia klasicky elegantne a prinášajú harmonickú estetiku do každého priestoru. Dizajn od Naota Fukasawu pre značku Serralunga robí z kolekcie Cup ideálny doplnok vonkajšieho nábytku a moderného exteriéru. Vyrobené z ľahkého, no odolného polyetylénu, tvarovaného technológiou rotačného liatia. Poskytuje UV ochranu, je 100 % recyklovateľné a farbené v hmote. Model Cup High má priemer 48 cm a výšku 40 cm.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/en/products/cup-high-planter?pr_prod_strat=jac&pr_rec_id=55953ee42&pr_rec_pid=7003990392969&pr_ref_pid=7003990294665&pr_seq=uniform)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/kvetinac-cup-vysoky/kvetinac-cup-vysoky_1.webp',
  ARRAY['https://kochlik.netlify.app/images/kvetinac-cup-vysoky/kvetinac-cup-vysoky_1.webp', 'https://kochlik.netlify.app/images/kvetinac-cup-vysoky/kvetinac-cup-vysoky_2.webp', 'https://kochlik.netlify.app/images/kvetinac-cup-vysoky/kvetinac-cup-vysoky_3.webp']::text[],
  '[{"name":"BIANCO","hex":null,"image_url":null,"family":"Biela"},{"name":"TORTORA DI TORINO","hex":null,"image_url":null,"family":"Hnedá"},{"name":"ANTRACITE","hex":null,"image_url":null,"family":"Sivá"},{"name":"AZZURRO DI PROVENZA","hex":null,"image_url":null,"family":"Modrá"},{"name":"ACQUA DELLA MADDALENA","hex":null,"image_url":null,"family":"Modrá"},{"name":"SALVIA DI SARDEGNA","hex":null,"image_url":null,"family":"Zelená"},{"name":"ROSSO","hex":null,"image_url":null,"family":"Červená"},{"name":"TERRACOTTA TOSCANA","hex":null,"image_url":null,"family":"Červená"},{"name":"TERRACOTTA SCURA","hex":null,"image_url":null,"family":"Červená"},{"name":"VERDE PAVONE","hex":null,"image_url":null,"family":"Zelená"},{"name":"NEVE DI SAN CANDIDO","hex":null,"image_url":null,"family":"Biela"},{"name":"GIALLO SAHARA","hex":null,"image_url":null,"family":"Žltá"},{"name":"VERDE BRITISH","hex":null,"image_url":null,"family":"Zelená"},{"name":"ROSSO POMPEIANO","hex":null,"image_url":null,"family":"Červená"}]'::jsonb,
  ARRAY['Biela', 'Červená', 'Hnedá', 'Modrá', 'Sivá', 'Zelená', 'Žltá']::text[],
  ARRAY['48x48x40 cm']::text[],
  ARRAY['Do 50 cm']::text[],
  '[{"label":"48x48x40 cm","dimensions":"48x48x40 cm","price_cents":17300,"attributes":{"rozmer":"48x48x40 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"48x48x40 cm"}]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/en/products/cup-high-planter?pr_prod_strat=jac&pr_rec_id=55953ee42&pr_rec_pid=7003990392969&pr_ref_pid=7003990294665&pr_seq=uniform',
  'https://serralunga.com/en/products/cup-high-planter?pr_prod_strat=jac&pr_rec_id=55953ee42&pr_rec_pid=7003990392969&pr_ref_pid=7003990294665&pr_seq=uniform',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'doplnky' LIMIT 1),
  'Svietici paraván Fade',
  'svietiaci-paravan-fade',
  'Plust',
  74000,
  NULL,
  'Harmónia medzi funkčnosťou a umením Svietici paraván Fade je viac než len kus nábytku – je to vyjadrenie štýlu a inovácií, ktoré premieňajú priestor svojou pôsobivou prítomnosťou. Predstavuje manifest neustáleho výskumu značky Plust Collection, v ktorom sa spája funkčnosť a umenie v odvážnom dizajne. Socha: Každá krivka modelu Fade Shell rozpráva príbeh tvorivosti a štýlu. Jeho zakrivená forma vytvára sochársky objem, zatiaľ čo jemne vybrúsené pruhy na povrchu vytvárajú rafinovanú hru svetla a tieňov. Deliaci prvok: Vďaka svojmu jedinečnému tvaru a výraznej prítomnosti dokáže Fade Shell elegantne rozdeľovať priestory bez toho, aby ich izoloval. Vytvára vizuálnu, no nie emocionálnu hranicu – ideálne riešenie pre definovanie zón pri zachovaní plynulosti a kontinuity prostredia. Lampa: Zakrivená forma jemne presvitá mäkkým svetlom, ktoré rozžiari večernú atmosféru. Je to svietiace umelecké dielo, v ktorom sa stretáva krása a inovácia. Dekoratívne pozadie: Fade Shell možno jednoducho umiestniť a urobiť z neho dominantný prvok každého priestoru. Je to jedinečný dizajnový doplnok – symbol elegancie, precíznosti a moderného umeleckého prejavu. Produkty sú vyrobené z polyetylénu pomocou technológie rotačného tvarovania, čo zaručuje ich vysokú kvalitu, odolnosť a dlhú životnosť.
Rozmer
175 x 38 x 140 cm
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.plust.it/en/products/fade-shell/)',
  'https://kochlik.netlify.app/images/svietiaci-paravan-fade/svietiaci-paravan-fade_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/svietiaci-paravan-fade/svietiaci-paravan-fade_1.jpg', 'https://kochlik.netlify.app/images/svietiaci-paravan-fade/svietiaci-paravan-fade_2.gif', 'https://kochlik.netlify.app/images/svietiaci-paravan-fade/svietiaci-paravan-fade_3.gif', 'https://kochlik.netlify.app/images/svietiaci-paravan-fade/svietiaci-paravan-fade_4.jpg']::text[],
  '[{"name":"Granite","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_s4_granite.jpg","family":"Sivá"},{"name":"Lava","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_u0_lava.jpg","family":"Sivá"},{"name":"Stone","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_u4_stone.jpg","family":"Sivá"},{"name":"Mint","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_v5_mint.jpg","family":"Zelená"},{"name":"Tide","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_v6_tide.jpg","family":"Béžová"},{"name":"Creta","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_v7_creta.jpg","family":"Béžová"},{"name":"White light","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_u1_whitelight.jpg","family":"Biela"}]'::jsonb,
  ARRAY['Béžová', 'Biela', 'Sivá', 'Zelená']::text[],
  ARRAY['38 x 140 cm']::text[],
  ARRAY['101-150 cm']::text[],
  '[]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb,
  'https://www.plust.it/en/products/fade-shell/',
  'https://www.plust.it/en/products/fade-shell/',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'klasicke-kvetinace' LIMIT 1),
  'Busta FRANCÚZSKA ŽENA',
  'busta-francuzska-zena',
  'Euro3plast',
  21900,
  NULL,
  'Kolekcia Style je elegantná a nadčasová: tieto nadčasové kvetináče a doplnky dodajú šmrnc záhradám, ktoré chcú byť obdivované. Úplne talianska podľa tradície ponúka širokú škálu veľkostí a vkusne klasických dekorácií, ktoré sa po prvom vzhliadnutí stanú nepostrádateľnými.
Rozmer:
37 x 22 x 50 cm
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.euro3plast.com/gb/products/391-donna-francese.html)',
  'https://kochlik.netlify.app/images/busta-francuzska-zena/busta-francuzska-zena_1.webp',
  ARRAY['https://kochlik.netlify.app/images/busta-francuzska-zena/busta-francuzska-zena_1.webp']::text[],
  '[{"name":"WHITE","hex":"#ffffff","image_url":null,"family":"Biela"}]'::jsonb,
  ARRAY['Biela']::text[],
  ARRAY['22 x 50 cm']::text[],
  ARRAY['Do 50 cm']::text[],
  '[]'::jsonb,
  '[]'::jsonb,
  '[{"label":"Technický dokument","url":"https://www.euro3plast.com/sheets/donna_francese_busto.pdf"},{"label":"Informačný dokument","url":"https://www.euro3plast.com/sheets/donna_francese_bust_info_en.pdf"}]'::jsonb,
  'https://www.euro3plast.com/gb/products/391-donna-francese.html',
  'https://www.euro3plast.com/gb/products/391-donna-francese.html',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'svietiace-kvetinace' LIMIT 1),
  'Vaso Kabin Maxi con luce',
  'vaso-kabin-maxi-con-luce',
  'Serralunga',
  68000,
  NULL,
  'Materiál: Vyrobené z LLDPE (lineárny nízkohustotný polyetylén) Spôsob výroby: Rotačné tvarovanie Vhodnosť: Určené na vonkajšie použitie, odolné voči všetkým poveternostným podmienkam. Poskytuje UV ochranu, je 100 % recyklovateľné a farbené v hmote. Vyznačuje sa vysokou mechanickou pevnosťou a odolnosťou voči nárazom. Materiál odoláva teplotám od –35 °C do +80 °C.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/en/products/kabin-maxi-planter-with-light?_pos=1&_psq=Kabin+Maxi+con+luce&_ss=e&_v=1.0)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/vaso-kabin-maxi-con-luce/vaso-kabin-maxi-con-luce_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/vaso-kabin-maxi-con-luce/vaso-kabin-maxi-con-luce_1.jpg']::text[],
  '[{"name":"White light with cable","hex":null,"image_url":null,"family":"Biela"}]'::jsonb,
  ARRAY['Biela']::text[],
  ARRAY[]::text[],
  ARRAY[]::text[],
  '[]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/en/products/kabin-maxi-planter-with-light?_pos=1&_psq=Kabin+Maxi+con+luce&_ss=e&_v=1.0',
  'https://serralunga.com/en/products/kabin-maxi-planter-with-light?_pos=1&_psq=Kabin+Maxi+con+luce&_ss=e&_v=1.0',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'nabytok' LIMIT 1),
  'Stôl Fade',
  'stol-fade',
  'Plust',
  40000,
  NULL,
  'Stôl s vysokou stabilitou, ku ktorému je potrebné samostatne zvoliť dosku z HPL materiálu. Rebrovaný povrch vytvára jedinečnú hru svetla a tieňov, zatiaľ čo špeciálne povrchové úpravy pripomínajú prírodné materiály. V bielej svietiacej verzii je možné stôl vybaviť špeciálnou svetelnou sadou pre pôsobivé osvetlenie.
Rozmer
38 x 38 x 72 cm
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.plust.it/en/products/fade-dining-table-structure/)',
  'https://kochlik.netlify.app/images/stol-fade/stol-fade_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/stol-fade/stol-fade_1.jpg', 'https://kochlik.netlify.app/images/stol-fade/stol-fade_2.jpg', 'https://kochlik.netlify.app/images/stol-fade/stol-fade_3.gif', 'https://kochlik.netlify.app/images/stol-fade/stol-fade_4.gif']::text[],
  '[{"name":"Granite","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_s4_granite.jpg","family":"Sivá"},{"name":"Lava","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_u0_lava.jpg","family":"Sivá"},{"name":"Stone","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_u4_stone.jpg","family":"Sivá"},{"name":"Creta","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_v7_creta.jpg","family":"Béžová"},{"name":"Black","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_black_black.jpg","family":"Čierna"},{"name":"White","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_white_white.jpg","family":"Biela"},{"name":"White light","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_u1_whitelight.jpg","family":"Biela"}]'::jsonb,
  ARRAY['Béžová', 'Biela', 'Čierna', 'Sivá']::text[],
  ARRAY['38 x 72 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb,
  'https://www.plust.it/en/products/fade-dining-table-structure/',
  'https://www.plust.it/en/products/fade-dining-table-structure/',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'moderne-kvetinace' LIMIT 1),
  'Kvetináč vysoký KUBE',
  'kvetinac-vysoky-kube',
  'Euro3plast',
  14100,
  NULL,
  'Štýl je synonymom minimalizmu – dokonale zhrnutý v čistých a jednoduchých líniách našich kvetináčov a doplnkov. Skombinovali sme čisté profily s farebnou paletou pre každý vkus – od výraznej kyslej zelene a červenej po klasické odtiene – aby ste obohatili svoje obľúbené priestory harmóniou a eleganciou.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.euro3plast.com/gb/-/335-3262-kube-high.html#/332-colour-white_c2/612-significant_measure-30)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/kvetinac-vysoky-kube/kvetinac-vysoky-kube_1.webp',
  ARRAY['https://kochlik.netlify.app/images/kvetinac-vysoky-kube/kvetinac-vysoky-kube_1.webp']::text[],
  '[{"name":"WHITE C2","hex":"#ffffff","image_url":null,"family":"Biela"},{"name":"RUST","hex":"#543920","image_url":null,"family":"Hnedá"},{"name":"TAUPE","hex":"#706961","image_url":null,"family":"Hnedá"},{"name":"CEMENT","hex":"#999390","image_url":null,"family":"Sivá"},{"name":"GRANITE","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/e3p_kvetinac-vysoky-kube_granite.jpg","family":"Sivá"},{"name":"LAVA","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/e3p_kvetinac-vysoky-kube_lava.jpg","family":"Sivá"},{"name":"STONE","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/e3p_kvetinac-vysoky-kube_stone.jpg","family":"Sivá"},{"name":"CRETA","hex":"#786e69","image_url":null,"family":"Béžová"},{"name":"PEARL BLACK","hex":"#4a4a49","image_url":null,"family":"Čierna"}]'::jsonb,
  ARRAY['Béžová', 'Biela', 'Čierna', 'Hnedá', 'Sivá']::text[],
  ARRAY['30x30x70 cm', '40x40x70 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[{"label":"30x30x70 cm","dimensions":"30x30x70 cm","price_cents":14100,"attributes":{"rozmer":"30x30x70 cm"}},{"label":"40x40x70 cm","dimensions":"40x40x70 cm","price_cents":19000,"attributes":{"rozmer":"40x40x70 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"30x30x70 cm, 40x40x70 cm"}]'::jsonb,
  '[{"label":"Technický dokument","url":"https://www.euro3plast.com/sheets/kube_high_vaso_con_doppia_parete.pdf"},{"label":"Informačný dokument","url":"https://www.euro3plast.com/sheets/kube_high_pot_with_double_wall_info_en.pdf"}]'::jsonb,
  'https://www.euro3plast.com/gb/-/335-3262-kube-high.html#/332-colour-white_c2/612-significant_measure-30',
  'https://www.euro3plast.com/gb/-/335-3262-kube-high.html#/332-colour-white_c2/612-significant_measure-30',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'nabytok' LIMIT 1),
  'Barová stolička Fade',
  'barova-stolicka-fade',
  'Plust',
  17000,
  NULL,
  'Ľahká, no stabilná stolička s funkčným výrezom na opierku nôh a špeciálnymi povrchovými úpravami, ktoré pripomínajú prírodné materiály. V bielej svietiacej verzii je možné stoličku vybaviť špeciálnou svetelnou sadou pre jedinečný vizuálny efekt.
Rozmer
33 x 33 x 76 cm
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.plust.it/en/products/fade-stool/)',
  'https://kochlik.netlify.app/images/barova-stolicka-fade/barova-stolicka-fade_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/barova-stolicka-fade/barova-stolicka-fade_1.jpg', 'https://kochlik.netlify.app/images/barova-stolicka-fade/barova-stolicka-fade_2.jpg', 'https://kochlik.netlify.app/images/barova-stolicka-fade/barova-stolicka-fade_3.jpg']::text[],
  '[{"name":"Granite","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_s4_granite.jpg","family":"Sivá"},{"name":"Lava","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_u0_lava.jpg","family":"Sivá"},{"name":"Stone","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_u4_stone.jpg","family":"Sivá"},{"name":"Creta","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_v7_creta.jpg","family":"Béžová"},{"name":"White light","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_u1_whitelight.jpg","family":"Biela"}]'::jsonb,
  ARRAY['Béžová', 'Biela', 'Sivá']::text[],
  ARRAY['33 x 76 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb,
  'https://www.plust.it/en/products/fade-stool/',
  'https://www.plust.it/en/products/fade-stool/',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'klasicke-kvetinace' LIMIT 1),
  'Hrantík hladký CASSETTA LISCIA',
  'hrantik-hladky-cassetta-liscia',
  'Serralunga',
  16400,
  NULL,
  'Doprajte si eleganciu Talianska s kvetináčom Neoclassic Cassetta Liscia. Jeho tradičný taliansky dizajn a zemité tóny pozdvihnú váš exteriér a vytvoria vidiecku atmosféru pripomínajúcu bujné záhrady. Prijmite neočakávané a dodajte svojim rastlinám nádych sofistikovanosti. Zažite nadčasovú krásu.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/en/products/neoclassic-cassetta-liscia-planter?_pos=1&_psq=CASSETTA+LISCIA&_ss=e&_v=1.0)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/hrantik-hladky-cassetta-liscia/hrantik-hladky-cassetta-liscia_1.webp',
  ARRAY['https://kochlik.netlify.app/images/hrantik-hladky-cassetta-liscia/hrantik-hladky-cassetta-liscia_1.webp', 'https://kochlik.netlify.app/images/hrantik-hladky-cassetta-liscia/hrantik-hladky-cassetta-liscia_2.jpg', 'https://kochlik.netlify.app/images/hrantik-hladky-cassetta-liscia/hrantik-hladky-cassetta-liscia_3.webp']::text[],
  '[{"name":"BIANCO","hex":null,"image_url":null,"family":"Biela"},{"name":"ANTRACITE","hex":null,"image_url":null,"family":"Sivá"},{"name":"PIETRA DELLA DOLOMITI","hex":null,"image_url":null,"family":"Sivá"},{"name":"TERRACOTTA TOSCANA","hex":null,"image_url":null,"family":"Červená"},{"name":"TERRACOTTA SCURA","hex":null,"image_url":null,"family":"Červená"},{"name":"TORTORA DI TORINO","hex":null,"image_url":null,"family":"Hnedá"},{"name":"AZZURRO DI PROVENZA","hex":null,"image_url":null,"family":"Modrá"},{"name":"ROSSO","hex":null,"image_url":null,"family":"Červená"},{"name":"SALVIA DI SARDEGNA","hex":null,"image_url":null,"family":"Zelená"},{"name":"VERDE PAVONE","hex":null,"image_url":null,"family":"Zelená"},{"name":"GIALLO SAHARA","hex":null,"image_url":null,"family":"Žltá"},{"name":"VERDE BRITISH","hex":null,"image_url":null,"family":"Zelená"},{"name":"ROSSO POMPEIANO","hex":null,"image_url":null,"family":"Červená"},{"name":"CASTORO","hex":null,"image_url":null,"family":"Hnedá"},{"name":"PIETRA DI MATERA","hex":null,"image_url":null,"family":"Sivá"}]'::jsonb,
  ARRAY['Biela', 'Červená', 'Hnedá', 'Modrá', 'Sivá', 'Zelená', 'Žltá']::text[],
  ARRAY['100x47x42 cm', '80x35x35 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[{"label":"100x47x42 cm","dimensions":"100x47x42 cm","price_cents":20100,"attributes":{"rozmer":"100x47x42 cm"}},{"label":"80x35x35 cm","dimensions":"80x35x35 cm","price_cents":16400,"attributes":{"rozmer":"80x35x35 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"100x47x42 cm, 80x35x35 cm"}]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/en/products/neoclassic-cassetta-liscia-planter?_pos=1&_psq=CASSETTA+LISCIA&_ss=e&_v=1.0',
  'https://serralunga.com/en/products/neoclassic-cassetta-liscia-planter?_pos=1&_psq=CASSETTA+LISCIA&_ss=e&_v=1.0',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'nabytok' LIMIT 1),
  'Kreslo Jetlag',
  'kreslo-jetlag',
  'Plust',
  38000,
  NULL,
  'Priestranné modulárne kreslo určené na kombináciu s lavicou Jetlag. Spájaním viacerých kresiel možno vytvoriť dlhé pohovky, alebo vložením lavice medzi moduly dosiahnuť dynamické zostavy. V svietiacej verzii mení farby vďaka bielej alebo farebnej LED sade. Dostupný je aj kotviaci systém na podlahu.
Rozmer
70 x 62 x 72 cm
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.plust.it/en/products/jetlag-chair/)',
  'https://kochlik.netlify.app/images/kreslo-jetlag/kreslo-jetlag_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/kreslo-jetlag/kreslo-jetlag_1.jpg', 'https://kochlik.netlify.app/images/kreslo-jetlag/kreslo-jetlag_2.jpg', 'https://kochlik.netlify.app/images/kreslo-jetlag/kreslo-jetlag_3.jpg', 'https://kochlik.netlify.app/images/kreslo-jetlag/kreslo-jetlag_4.jpg']::text[],
  '[{"name":"Acid green","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_86_acidgreen.jpg","family":"Zelená"},{"name":"Pearl black","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_87_pearlblack.jpg","family":"Čierna"},{"name":"White C2","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_c2_whitec2.jpg","family":"Biela"},{"name":"Golden rust","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_n4_goldenrust.jpg","family":"Hnedá"},{"name":"White light","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_u1_whitelight.jpg","family":"Biela"}]'::jsonb,
  ARRAY['Biela', 'Čierna', 'Hnedá', 'Zelená']::text[],
  ARRAY['62 x 72 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb,
  'https://www.plust.it/en/products/jetlag-chair/',
  'https://www.plust.it/en/products/jetlag-chair/',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'nabytok' LIMIT 1),
  'Sedačka Pine Beach',
  'sedacka-pine-beach',
  'Serralunga',
  132000,
  NULL,
  'Pohovka Pine Beach, navrhnutá Christophe Pilletom pre Serralunga, je inšpirovaná morským pobrežím – jej dizajn sa vyznačuje mäkkými, zaoblenými tvarmi a harmonickými líniami, ktoré vytvárajú obopínajúci a pohodlný tvar kopírujúci ergonómiu ľudského tela. Vďaka integrovanému odtokovému systému s malým otvorom na odvod vody je možné na pohovke sedieť aj po daždi, čo ju robí ideálnou pre interiérové aj exteriérové použitie. Táto verzia je dostupná aj v povrchovej úprave Moleskin, registrovaný dizajn, ktorá dodáva výrobku teplo, štruktúru a eleganciu.
Rozmer
180 x 81 x 76 cm
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/en/products/pine-beach-sofa?_pos=1&_psq=Pine+Beach&_ss=e&_v=1.0)',
  'https://kochlik.netlify.app/images/sedacka-pine-beach/sedacka-pine-beach_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/sedacka-pine-beach/sedacka-pine-beach_1.jpg', 'https://kochlik.netlify.app/images/sedacka-pine-beach/sedacka-pine-beach_2.jpg']::text[],
  '[{"name":"BIANCO","hex":null,"image_url":null,"family":"Biela"},{"name":"ANTRACITE","hex":null,"image_url":null,"family":"Sivá"},{"name":"SALVIA DI SARDEGNA","hex":null,"image_url":null,"family":"Zelená"},{"name":"TERRACOTTA SCURA","hex":null,"image_url":null,"family":"Červená"},{"name":"TORTORA DI TORINO","hex":null,"image_url":null,"family":"Hnedá"},{"name":"VERDE OLIVE DI CERIGNOLA","hex":null,"image_url":null,"family":"Zelená"},{"name":"VERDE PAVONE","hex":null,"image_url":null,"family":"Zelená"},{"name":"ACQUA DELLA MADDALENA","hex":null,"image_url":null,"family":"Modrá"},{"name":"AZZURRO DI PROVENZA","hex":null,"image_url":null,"family":"Modrá"},{"name":"ROSSO","hex":null,"image_url":null,"family":"Červená"},{"name":"TERRACOTTA TOSCANA","hex":null,"image_url":null,"family":"Červená"},{"name":"CASTORO","hex":null,"image_url":null,"family":"Hnedá"},{"name":"GIALLO SAHARA","hex":null,"image_url":null,"family":"Žltá"},{"name":"VERDE BRITISH","hex":null,"image_url":null,"family":"Zelená"},{"name":"ROSSO POMPEIANO","hex":null,"image_url":null,"family":"Červená"},{"name":"CORTEN","hex":null,"image_url":null,"family":"Hnedá"}]'::jsonb,
  ARRAY['Biela', 'Červená', 'Hnedá', 'Modrá', 'Sivá', 'Zelená', 'Žltá']::text[],
  ARRAY['81 x 76 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/en/products/pine-beach-sofa?_pos=1&_psq=Pine+Beach&_ss=e&_v=1.0',
  'https://serralunga.com/en/products/pine-beach-sofa?_pos=1&_psq=Pine+Beach&_ss=e&_v=1.0',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'svietiace-kvetinace' LIMIT 1),
  'Vešiak Ramo',
  'vesiak-ramo',
  'Serralunga',
  33000,
  NULL,
  'Ramo, navrhnuté Emanuelle Jacques pre Serralunga. Vešiak, akýsi sochársky objekt určený na umiestnenie vonku, aby ste si naplno vychutnali život na čerstvom vzduchu. Opretý alebo pripevnený na stenu sa stáva praktickým vešiakom v záhrade a/alebo pri bazéne. Dizajnový doplnok s prírodným vzhľadom, ktorý možno začleniť do kontextu zariadenia.
Pred nákupom je povinné uviesť, či chcete RAMO používať ako samostatne stojaci (opretý) alebo pripevnený na stenu.
Rozmer
40 x 25 x 160 cm
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/products/ramo-coat-rack?_pos=1&_psq=Ramo&_ss=e&_v=1.0)',
  'https://kochlik.netlify.app/images/vesiak-ramo/vesiak-ramo_1.webp',
  ARRAY['https://kochlik.netlify.app/images/vesiak-ramo/vesiak-ramo_1.webp', 'https://kochlik.netlify.app/images/vesiak-ramo/vesiak-ramo_2.webp']::text[],
  '[{"name":"ANTRACITE","hex":null,"image_url":null,"family":"Sivá"},{"name":"AZZURRO DI PROVENZA","hex":null,"image_url":null,"family":"Modrá"},{"name":"BIANCO","hex":null,"image_url":null,"family":"Biela"},{"name":"VERDE OLIVA DI CERIGNOLA","hex":null,"image_url":null,"family":"Zelená"},{"name":"ROSSO","hex":null,"image_url":null,"family":"Červená"},{"name":"TORTORA DI TORINO","hex":null,"image_url":null,"family":"Hnedá"},{"name":"GIALLO SAHARA","hex":null,"image_url":null,"family":"Žltá"},{"name":"VERDE BRITISH","hex":null,"image_url":null,"family":"Zelená"},{"name":"ROSSO POMPEIANO","hex":null,"image_url":null,"family":"Červená"},{"name":"NEVE DI SAN CANDIDO","hex":null,"image_url":null,"family":"Biela"}]'::jsonb,
  ARRAY['Biela', 'Červená', 'Hnedá', 'Modrá', 'Sivá', 'Zelená', 'Žltá']::text[],
  ARRAY['25 x 160 cm']::text[],
  ARRAY['Nad 150 cm']::text[],
  '[]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/products/ramo-coat-rack?_pos=1&_psq=Ramo&_ss=e&_v=1.0',
  'https://serralunga.com/products/ramo-coat-rack?_pos=1&_psq=Ramo&_ss=e&_v=1.0',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'nabytok' LIMIT 1),
  'Kreslo PASHA',
  'kreslo-pasha',
  'Euro3plast',
  37700,
  NULL,
  'Kolekcia Style je elegantná a nadčasová: tieto kvetináče a dekorácie s klasickým šarmom dodajú záhradám a terasám sofistikovaný vzhľad a po prvom použití sa stanú nepostrádateľné. Dokonale dopĺňajú priestory, ktoré sa rady nechávajú obdivovať.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.euro3plast.com/gb/products/374-pasha.html)',
  'https://kochlik.netlify.app/images/kreslo-pasha/kreslo-pasha_1.webp',
  ARRAY['https://kochlik.netlify.app/images/kreslo-pasha/kreslo-pasha_1.webp']::text[],
  '[{"name":"WHITE","hex":"#ffffff","image_url":null,"family":"Biela"}]'::jsonb,
  ARRAY['Biela']::text[],
  ARRAY['78x70x77 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[{"label":"78x70x77 cm","dimensions":"78x70x77 cm","price_cents":37700,"attributes":{"rozmer":"78x70x77 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"78x70x77 cm"}]'::jsonb,
  '[{"label":"Technický dokument","url":"https://www.euro3plast.com/sheets/pash%C3%A0_poltroncina_&_tavolino.pdf"},{"label":"Informačný dokument","url":"https://www.euro3plast.com/sheets/pash%C3%A0_small_armchair_&_small_table_info_en.pdf"}]'::jsonb,
  'https://www.euro3plast.com/gb/products/374-pasha.html',
  'https://www.euro3plast.com/gb/products/374-pasha.html',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'klasicke-kvetinace' LIMIT 1),
  'Kvetináč TOSKÁNSKY štvor. s dvojitou stenou 50 cm',
  'kvetinac-toskansky-stvor-s-dvojitou-stenou-50-cm',
  'Euro3plast',
  21700,
  NULL,
  'Kolekcia Style je elegantná a nadčasová: tieto kvetináče a dekorácie s klasickým šarmom dodajú záhradám a terasám sofistikovaný vzhľad a po prvom použití sa stanú nepostrádateľné. Dokonale dopĺňajú priestory, ktoré sa rady nechávajú obdivovať.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.euro3plast.com/gb/products/360-toscana.html)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/kvetinac-toskansky-stvor-s-dvojitou-stenou-50-cm/kvetinac-toskansky-stvor-s-dvojitou-stenou-50-cm_1.webp',
  ARRAY['https://kochlik.netlify.app/images/kvetinac-toskansky-stvor-s-dvojitou-stenou-50-cm/kvetinac-toskansky-stvor-s-dvojitou-stenou-50-cm_1.webp']::text[],
  '[{"name":"TERRA DI SIENA","hex":"#e3945b","image_url":null,"family":"Červená"}]'::jsonb,
  ARRAY['Červená']::text[],
  ARRAY['67x67x62 cm', '47x47x47 cm']::text[],
  ARRAY['Do 50 cm', '51-100 cm']::text[],
  '[{"label":"67x67x62 cm","dimensions":"67x67x62 cm","price_cents":41500,"attributes":{"rozmer":"67x67x62 cm"}},{"label":"47x47x47 cm","dimensions":"47x47x47 cm","price_cents":21700,"attributes":{"rozmer":"47x47x47 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"47x47x47 cm, 67x67x62 cm"}]'::jsonb,
  '[{"label":"Technický dokument","url":"https://www.euro3plast.com/sheets/toscana_vaso_quadro_con_doppia_parete.pdf"},{"label":"Informačný dokument","url":"https://www.euro3plast.com/sheets/toscana_square_pot_with_double_wall_info_en.pdf"}]'::jsonb,
  'https://www.euro3plast.com/gb/products/360-toscana.html',
  'https://www.euro3plast.com/gb/products/360-toscana.html',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'klasicke-kvetinace' LIMIT 1),
  'Nádoba IMPERO',
  'nadoba-impero',
  'Euro3plast',
  14800,
  NULL,
  'Kolekcia Style je elegantná a nadčasová: tieto kvetináče a dekorácie s klasickým šarmom dodajú záhradám a terasám sofistikovaný vzhľad a po prvom použití sa stanú nepostrádateľné. Dokonale dopĺňajú priestory, ktoré sa rady nechávajú obdivovať.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.euro3plast.com/gb/products/364-impero.html)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/nadoba-impero/nadoba-impero_1.webp',
  ARRAY['https://kochlik.netlify.app/images/nadoba-impero/nadoba-impero_1.webp']::text[],
  '[{"name":"WHITE","hex":"#ffffff","image_url":null,"family":"Biela"}]'::jsonb,
  ARRAY['Biela']::text[],
  ARRAY['48x60 cm', '36x47 cm', '65x79 cm']::text[],
  ARRAY['Do 50 cm', '51-100 cm']::text[],
  '[{"label":"48x60 cm","dimensions":"48x60 cm","price_cents":23100,"attributes":{"rozmer":"48x60 cm"}},{"label":"36x47 cm","dimensions":"36x47 cm","price_cents":14800,"attributes":{"rozmer":"36x47 cm"}},{"label":"65x79 cm","dimensions":"65x79 cm","price_cents":37700,"attributes":{"rozmer":"65x79 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"36×47 cm, 48×60 cm, 65×79 cm"}]'::jsonb,
  '[{"label":"Technický dokument","url":"https://www.euro3plast.com/sheets/impero_fioriera.pdf"},{"label":"Informačný dokument","url":"https://www.euro3plast.com/sheets/impero_vase_info_en.pdf"}]'::jsonb,
  'https://www.euro3plast.com/gb/products/364-impero.html',
  'https://www.euro3plast.com/gb/products/364-impero.html',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'nabytok' LIMIT 1),
  'Kreslo Vela',
  'kreslo-vela',
  'Plust',
  44000,
  NULL,
  'Kreslo VELA, navrhnuté umeleckými riaditeľmi BrogliatoTraverso, vzniklo z poetického pozorovania plachiet napnutých vetrom a premieňa tento pohyb do obklopujúceho a harmonického tvaru. Jeho veľkorysý objem ponúka mimoriadne pohodlné sedenie, ktoré prirodzene zapadne do verejných aj súkromných priestorov. Praktické detaily, ako napríklad odtokový otvor na vodu, odhaľujú exteriérovú dušu kresla, ktorá zaručuje dlhú životnosť a odolnosť voči poveternostným vplyvom. Jedným z najvyspelejších dizajnových detailov kresla je vyvýšený šev, ktorý vedie pozdĺž okrajov a definuje kontúry celej konštrukcie. Tento spojovací prvok má lesklú povrchovú úpravu, ktorá kontrastuje s matným telom sedadla, čím zdôrazňuje presnosť spracovania a estetickú hodnotu dizajnu. Trojrozmerný efekt dodáva hĺbku a eleganciu, zatiaľ čo prešívanie odkazuje na remeselnú starostlivosť typickú pre talianske spracovanie. Kreslo VELA je dostupné v rôznych povrchových úpravách: Lava, Grain, Pietra a Creta. V bielej svietiacej verzii (White Light) môže byť kreslo vybavené svetelnou sadou, vďaka ktorej sa mení na svietiaci dizajnový objekt, vytvárajúci jedinečnú atmosféru počas večerných hodín. Jemné svetlo prenikajúce materiálom zvýrazňuje línie švu, ktoré sa stávajú grafickým prvkom podčiarkujúcim geometriu kresla aj zodpovedajúceho konferenčného stolíka.
Rozmer
102 x 88 x 82 cm
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.plust.it/en/products/vela-armchair/)',
  'https://kochlik.netlify.app/images/kreslo-vela/kreslo-vela_1.gif',
  ARRAY['https://kochlik.netlify.app/images/kreslo-vela/kreslo-vela_1.gif', 'https://kochlik.netlify.app/images/kreslo-vela/kreslo-vela_2.gif']::text[],
  '[{"name":"Lava","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_u0_lava.jpg","family":"Sivá"},{"name":"Stone","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_u4_stone.jpg","family":"Sivá"},{"name":"Creta","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_v7_creta.jpg","family":"Béžová"},{"name":"Grain","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_z6_grain.jpg","family":"Béžová"},{"name":"White light","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_u1_whitelight.jpg","family":"Biela"}]'::jsonb,
  ARRAY['Béžová', 'Biela', 'Sivá']::text[],
  ARRAY['88 x 82 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb,
  'https://www.plust.it/en/products/vela-armchair/',
  'https://www.plust.it/en/products/vela-armchair/',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'dizajnove' LIMIT 1),
  'Kvetináč Sevres',
  'vaso-sevres',
  'Serralunga',
  29000,
  NULL,
  'Kvetináč Sevres, navrhnutý Rodolfo Dordoni pre Serralunga, predstavuje nový prístup k dizajnu záhradných kvetináčov – spája jednoduchý, čistý tvar s originálnou kombináciou dvoch materiálov. Tento model je vyrobený z polyetylénu v kombinácii s druhým materiálom použitým na hornom okraji, čo mu dodáva nezameniteľný vzhľad a sofistikovaný charakter. Kvetináč Sevres opäť potvrdzuje pozíciu značky Serralunga ako inovátora a trendsettera v oblasti dizajnu exteriérových doplnkov – spája technologickú precíznosť s estetickou originalitou.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/en/products/sevres-planter?_pos=1&_psq=Sevres&_ss=e&_v=1.0)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/vaso-sevres/vaso-sevres_1.webp',
  ARRAY['https://kochlik.netlify.app/images/vaso-sevres/vaso-sevres_1.webp', 'https://kochlik.netlify.app/images/vaso-sevres/vaso-sevres_2.webp']::text[],
  '[{"name":"LACQUERED WHITE","hex":null,"image_url":null,"family":"Biela"},{"name":"MORE DI ROVO","hex":null,"image_url":null,"family":"Ružová"},{"name":"ROSSO","hex":null,"image_url":null,"family":"Červená"},{"name":"TORTORA DI TORINO","hex":null,"image_url":null,"family":"Hnedá"},{"name":"BIANCO","hex":null,"image_url":null,"family":"Biela"}]'::jsonb,
  ARRAY['Biela', 'Červená', 'Hnedá', 'Ružová']::text[],
  ARRAY['42.5x42.5x92 cm', '48.5x48.5x44 cm']::text[],
  ARRAY['Do 50 cm', '51-100 cm']::text[],
  '[{"label":"42.5x42.5x92 cm","dimensions":"42.5x42.5x92 cm","price_cents":29000,"attributes":{"rozmer":"42.5x42.5x92 cm"}},{"label":"48.5x48.5x44 cm","dimensions":"48.5x48.5x44 cm","price_cents":41000,"attributes":{"rozmer":"48.5x48.5x44 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"42.5×42.5×92 cm, 48.5×48.5×44 cm"}]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/en/products/sevres-planter?_pos=1&_psq=Sevres&_ss=e&_v=1.0',
  'https://serralunga.com/en/products/sevres-planter?_pos=1&_psq=Sevres&_ss=e&_v=1.0',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'nabytok' LIMIT 1),
  'Lavica Luba',
  'lavica-luba',
  'Serralunga',
  51000,
  NULL,
  'Luba je multifunkčná záhradná lavica, ktorú pre Serralunga navrhla Ionna Vautrin. Je vhodná na vonkajšie aj vnútorné použitie a dokonale sa hodí aj ako dekoratívny prvok do interiéru. Dizajn tejto lavice pôsobí priateľsky a pozývavo – jej tvar akoby vás chcel objať. Hoci je jednoduchá, nikdy nie je predvídateľná – svojím jemným a veľkorysým tvarom prináša teplo a eleganciu do každého priestoru. Jej stredne veľké proporcie zabezpečujú maximálne pohodlie, vďaka čomu je vhodná do komerčných priestorov aj záhrad. Luba je nenápadná, presná a harmonická, prirodzene sa prispôsobuje prostrediu, pričom si zachováva nezameniteľný rukopis svojej francúzskej autorky. Táto verzia je dostupná aj v povrchovej úprave Moleskin, registrovaný dizajn, ktorá dodáva produktu teplo, štruktúru a vizuálny šarm.
Rozmer
141 x 41.5 x 49 cm
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/en/products/luba-bench?_pos=1&_psq=Luba&_ss=e&_v=1.0)',
  'https://kochlik.netlify.app/images/lavica-luba/lavica-luba_1.webp',
  ARRAY['https://kochlik.netlify.app/images/lavica-luba/lavica-luba_1.webp', 'https://kochlik.netlify.app/images/lavica-luba/lavica-luba_2.webp', 'https://kochlik.netlify.app/images/lavica-luba/lavica-luba_3.webp', 'https://kochlik.netlify.app/images/lavica-luba/lavica-luba_4.webp']::text[],
  '[{"name":"BIANCO","hex":null,"image_url":null,"family":"Biela"},{"name":"AZZURRO DI PROVENZA","hex":null,"image_url":null,"family":"Modrá"},{"name":"ANTRACITE","hex":null,"image_url":null,"family":"Sivá"},{"name":"ROSSO","hex":null,"image_url":null,"family":"Červená"},{"name":"SALVIA DI SARDEGNA","hex":null,"image_url":null,"family":"Zelená"},{"name":"TORTORA DI TORINO","hex":null,"image_url":null,"family":"Hnedá"},{"name":"VERDE PAVONE","hex":null,"image_url":null,"family":"Zelená"},{"name":"GIALLO SAHARA","hex":null,"image_url":null,"family":"Žltá"},{"name":"VERDE BRITISH","hex":null,"image_url":null,"family":"Zelená"},{"name":"ROSSO POMPEIANO","hex":null,"image_url":null,"family":"Červená"},{"name":"CORTEN","hex":null,"image_url":null,"family":"Hnedá"}]'::jsonb,
  ARRAY['Biela', 'Červená', 'Hnedá', 'Modrá', 'Sivá', 'Zelená', 'Žltá']::text[],
  ARRAY['5 x 49 cm']::text[],
  ARRAY['Do 50 cm']::text[],
  '[]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/en/products/luba-bench?_pos=1&_psq=Luba&_ss=e&_v=1.0',
  'https://serralunga.com/en/products/luba-bench?_pos=1&_psq=Luba&_ss=e&_v=1.0',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'dizajnove' LIMIT 1),
  'Kvetináč RETTANGOLARE',
  'kvetinac-rettangolare',
  'Serralunga',
  28700,
  NULL,
  'Kvetináč RETTANGOLARE je dlhý a úzky kvetináč, ktorý dokáže vytvárať priestory a zároveň ich opticky oddeľovať. Predstavuje zelený predel – akoby dvere medzi interiérom a exteriérom. Tento moderný a funkčný prvok záhradnej dekorácie spája estetiku s praktickosťou, čím prináša do každého prostredia harmóniu, súkromie a eleganciu.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/en/products/vaso-rettangolare-o-e-planter?_pos=1&_psq=RETTANGOLARE&_ss=e&_v=1.0)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/kvetinac-rettangolare/kvetinac-rettangolare_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/kvetinac-rettangolare/kvetinac-rettangolare_1.jpg', 'https://kochlik.netlify.app/images/kvetinac-rettangolare/kvetinac-rettangolare_2.webp']::text[],
  '[{"name":"BIANCO","hex":null,"image_url":null,"family":"Biela"},{"name":"ANTRACITE","hex":null,"image_url":null,"family":"Sivá"},{"name":"PIETRA DELLA DOLOMITI","hex":null,"image_url":null,"family":"Sivá"},{"name":"TERRACOTTA TOSCANA","hex":null,"image_url":null,"family":"Červená"},{"name":"TERRACOTTA SCURA","hex":null,"image_url":null,"family":"Červená"},{"name":"TORTORA DI TORINO","hex":null,"image_url":null,"family":"Hnedá"},{"name":"ACQUA DELLA MADDALENA","hex":null,"image_url":null,"family":"Modrá"},{"name":"AZZURRO DI PROVENZA","hex":null,"image_url":null,"family":"Modrá"},{"name":"ROSSO","hex":null,"image_url":null,"family":"Červená"},{"name":"SALVIA DI SARDEGNA","hex":null,"image_url":null,"family":"Zelená"},{"name":"VERDE PAVONE","hex":null,"image_url":null,"family":"Zelená"},{"name":"GIALLO SAHARA","hex":null,"image_url":null,"family":"Žltá"},{"name":"VERDE BRITISH","hex":null,"image_url":null,"family":"Zelená"},{"name":"ROSSO POMPEIANO","hex":null,"image_url":null,"family":"Červená"},{"name":"PIETRA DI MATERA","hex":null,"image_url":null,"family":"Sivá"}]'::jsonb,
  ARRAY['Biela', 'Červená', 'Hnedá', 'Modrá', 'Sivá', 'Zelená', 'Žltá']::text[],
  ARRAY['93.5x26.5x70 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[{"label":"93.5x26.5x70 cm","dimensions":"93.5x26.5x70 cm","price_cents":28700,"attributes":{"rozmer":"93.5x26.5x70 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"93.5×26.5×70 cm"}]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/en/products/vaso-rettangolare-o-e-planter?_pos=1&_psq=RETTANGOLARE&_ss=e&_v=1.0',
  'https://serralunga.com/en/products/vaso-rettangolare-o-e-planter?_pos=1&_psq=RETTANGOLARE&_ss=e&_v=1.0',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'klasicke-kvetinace' LIMIT 1),
  'Kvetináč LIMONI',
  'kvetinac-limoni',
  'Serralunga',
  8400,
  NULL,
  'Kvetináč Decorati Limoni od značky Serralunga predstavuje modernú klasiku medzi vonkajšími kvetináčmi z kolekcie Serralunga 1825. Spája v sebe klasické, precízne línie s osviežujúcim pôvabom citrónovníka, čím vytvára jedinečný kontrast medzi eleganciou a prirodzenosťou. Jeho pevná konštrukcia zaručuje odolnosť voči poveternostným podmienkam, zatiaľ čo jemne zaoblené línie a bohatá textúra dodávajú dizajnu sofistikovanosť a štýl. Či už umiestnený na slnečnej terase alebo v zelenom kúsku záhrady, kvetináč Decorati Limoni sa stane výrazným prvkom každého exteriéru.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/en/products/decorati-limoni-planter?_pos=1&_psq=LIMONI&_ss=e&_v=1.0)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/kvetinac-limoni/kvetinac-limoni_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/kvetinac-limoni/kvetinac-limoni_1.jpg', 'https://kochlik.netlify.app/images/kvetinac-limoni/kvetinac-limoni_2.webp', 'https://kochlik.netlify.app/images/kvetinac-limoni/kvetinac-limoni_3.webp', 'https://kochlik.netlify.app/images/kvetinac-limoni/kvetinac-limoni_4.webp']::text[],
  '[{"name":"SALVIA DI SARDEGNA","hex":null,"image_url":null,"family":"Zelená"},{"name":"TORTORA DI TORINO","hex":null,"image_url":null,"family":"Hnedá"},{"name":"VERDE OLIVE DI CERIGNOLA","hex":null,"image_url":null,"family":"Zelená"},{"name":"PIETRA DI MATERA","hex":null,"image_url":null,"family":"Sivá"},{"name":"GIALLO SAHARA","hex":null,"image_url":null,"family":"Žltá"},{"name":"VERDE BRITISH","hex":null,"image_url":null,"family":"Zelená"},{"name":"ROSSO POMPEIANO","hex":null,"image_url":null,"family":"Červená"},{"name":"TERRACOTTA","hex":null,"image_url":null,"family":"Červená"},{"name":"PIETRA DELLE DOLOMITI","hex":null,"image_url":null,"family":"Sivá"}]'::jsonb,
  ARRAY['Červená', 'Hnedá', 'Sivá', 'Zelená', 'Žltá']::text[],
  ARRAY['42x32 cm', '52x38 cm', '59x43 cm']::text[],
  ARRAY['Do 50 cm', '51-100 cm']::text[],
  '[{"label":"42x32 cm","dimensions":"42x32 cm","price_cents":8400,"attributes":{"rozmer":"42x32 cm"}},{"label":"52x38 cm","dimensions":"52x38 cm","price_cents":11100,"attributes":{"rozmer":"52x38 cm"}},{"label":"59x43 cm","dimensions":"59x43 cm","price_cents":15500,"attributes":{"rozmer":"59x43 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"42×32 cm, 52×38 cm, 59×43 cm"}]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/en/products/decorati-limoni-planter?_pos=1&_psq=LIMONI&_ss=e&_v=1.0',
  'https://serralunga.com/en/products/decorati-limoni-planter?_pos=1&_psq=LIMONI&_ss=e&_v=1.0',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'moderne-kvetinace' LIMIT 1),
  'Hrantik KUBE',
  'hrantik-kube',
  'Euro3plast',
  18600,
  'Kube je robustný rastlinný box s textúrovaným povrchom. Esenciálne tvary a čisté línie z neho robia súčasť minimalistického dizajnu. Elegantná farebná paleta a praktické príslušenstvo z neho tvoria modernú rodinu kvetináčov – ideálnu pre interiér aj exteriér. (Pripravené na sadu vodnej rezervy – predáva sa samostatne.)',
  'Kube je robustný rastlinný box s textúrovaným povrchom. Esenciálne tvary a čisté línie z neho robia súčasť minimalistického dizajnu. Elegantná farebná paleta a praktické príslušenstvo z neho tvoria modernú rodinu kvetináčov – ideálnu pre interiér aj exteriér. (Pripravené na sadu vodnej rezervy – predáva sa samostatne.)
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.euro3plast.com/gb/-/327-3223-kube.html#/353-colour-rust/620-significant_measure-80)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/hrantik-kube/hrantik-kube_1.webp',
  ARRAY['https://kochlik.netlify.app/images/hrantik-kube/hrantik-kube_1.webp']::text[],
  '[{"name":"WHITE C2","hex":"#ffffff","image_url":null,"family":"Biela"},{"name":"RUST","hex":"#543920","image_url":null,"family":"Hnedá"},{"name":"TAUPE","hex":"#706961","image_url":null,"family":"Hnedá"},{"name":"CEMENT","hex":"#999390","image_url":null,"family":"Sivá"},{"name":"GRANITE","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/e3p_hrantik-kube_granite.jpg","family":"Sivá"},{"name":"LAVA","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/e3p_hrantik-kube_lava.jpg","family":"Sivá"},{"name":"STONE","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/e3p_hrantik-kube_stone.jpg","family":"Sivá"},{"name":"CRETA","hex":"#786e69","image_url":null,"family":"Béžová"},{"name":"PEARL BLACK","hex":"#4a4a49","image_url":null,"family":"Čierna"}]'::jsonb,
  ARRAY['Béžová', 'Biela', 'Čierna', 'Hnedá', 'Sivá']::text[],
  ARRAY['100x40x40 cm', '80x30x30 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[{"label":"100x40x40 cm","dimensions":"100x40x40 cm","price_cents":23800,"attributes":{"rozmer":"100x40x40 cm"}},{"label":"80x30x30 cm","dimensions":"80x30x30 cm","price_cents":18600,"attributes":{"rozmer":"80x30x30 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"100x40x40 cm, 80x30x30 cm"}]'::jsonb,
  '[{"label":"Technický dokument","url":"https://www.euro3plast.com/sheets/kube_cassetta_con_doppia_parete.pdf"},{"label":"Informačný dokument","url":"https://www.euro3plast.com/sheets/kube_plant_box_with_double_wall_info_en.pdf"}]'::jsonb,
  'https://www.euro3plast.com/gb/-/327-3223-kube.html#/353-colour-rust/620-significant_measure-80',
  'https://www.euro3plast.com/gb/-/327-3223-kube.html#/353-colour-rust/620-significant_measure-80',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'moderne-kvetinace' LIMIT 1),
  'Kvetináč Cassero Slim',
  'kvetinac-cassero-slim',
  'Serralunga',
  45000,
  NULL,
  'Kolekcia Cassero, ktorú pre značku Serralunga navrhla Patricia Urquiola, je inšpirovaná formami používanými v stavebníctve pri odlievaní betónu. Táto séria jednodielnych kvetináčov z polyetylénu zámerne napodobňuje betónový efekt, akoby boli odliate a následne vybraté z formy. S kolekciou Cassero sa architektka Urquiola rozhodla vytvoriť kvetináče, ktoré sú ideálne nielen pre exteriér, ale zároveň prinášajú zeleň aj do interiéru, čím sa stávajú plnohodnotnou súčasťou dekoru. Model Cassero Slim predstavuje štíhlu verziu tejto kolekcie.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/en/products/cassero-slim?_pos=1&_psq=Cassero+Slim&_ss=e&_v=1.0)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/kvetinac-cassero-slim/kvetinac-cassero-slim_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/kvetinac-cassero-slim/kvetinac-cassero-slim_1.jpg', 'https://kochlik.netlify.app/images/kvetinac-cassero-slim/kvetinac-cassero-slim_2.webp', 'https://kochlik.netlify.app/images/kvetinac-cassero-slim/kvetinac-cassero-slim_3.jpg']::text[],
  '[{"name":"GESSO DI BOLOGNA","hex":null,"image_url":null,"family":"Biela"},{"name":"SALVIA DI SARDEGNA","hex":null,"image_url":null,"family":"Zelená"},{"name":"TORTORA DI TORINO","hex":null,"image_url":null,"family":"Hnedá"},{"name":"TERRACOTTA SCURA","hex":null,"image_url":null,"family":"Červená"},{"name":"ORIGANO DI SARDEGNA","hex":null,"image_url":null,"family":"Zelená"},{"name":"TERRACOTTA TOSCANA","hex":null,"image_url":null,"family":"Červená"},{"name":"ANTRACITE","hex":null,"image_url":null,"family":"Sivá"},{"name":"AZZURRO DI PROVENZA","hex":null,"image_url":null,"family":"Modrá"},{"name":"PIETRA DI MATERA","hex":null,"image_url":null,"family":"Sivá"},{"name":"MORE DI ROVO","hex":null,"image_url":null,"family":"Ružová"},{"name":"IMPRUNETA","hex":null,"image_url":null,"family":"Hnedá"}]'::jsonb,
  ARRAY['Biela', 'Červená', 'Hnedá', 'Modrá', 'Ružová', 'Sivá', 'Zelená']::text[],
  ARRAY['83x30x72.5 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[{"label":"83x30x72.5 cm","dimensions":"83x30x72.5 cm","price_cents":45000,"attributes":{"rozmer":"83x30x72.5 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"83x30x72.5 cm"}]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/en/products/cassero-slim?_pos=1&_psq=Cassero+Slim&_ss=e&_v=1.0',
  'https://serralunga.com/en/products/cassero-slim?_pos=1&_psq=Cassero+Slim&_ss=e&_v=1.0',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'klasicke-kvetinace' LIMIT 1),
  'Fontána NEPTÚN',
  'fontana-neptun',
  'Euro3plast',
  60500,
  NULL,
  'Kolekcia Style je elegantná a nadčasová: tieto nadčasové kvetináče a doplnky dodajú šarm záhradám, ktoré si zaslúžia obdiv. V duchu čisto talianskej tradície ponúka širokú škálu veľkostí a vkusne klasických dekorácií, ktoré sa po prvom vzhliadnutí stanú nepostrádateľnými.
Rozmer:
59 x 54 x 123 cm
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.euro3plast.com/gb/products/380-nettuno.html)',
  'https://kochlik.netlify.app/images/fontana-neptun/fontana-neptun_1.webp',
  ARRAY['https://kochlik.netlify.app/images/fontana-neptun/fontana-neptun_1.webp']::text[],
  '[{"name":"ANTHRACITE 08","hex":"#4e4e4f","image_url":null,"family":"Sivá"}]'::jsonb,
  ARRAY['Sivá']::text[],
  ARRAY['54 x 123 cm']::text[],
  ARRAY['101-150 cm']::text[],
  '[]'::jsonb,
  '[]'::jsonb,
  '[{"label":"Technický dokument","url":"https://www.euro3plast.com/sheets/nettuno_fontana.pdf"},{"label":"Informačný dokument","url":"https://www.euro3plast.com/sheets/nettuno_fountain_info_en.pdf"}]'::jsonb,
  'https://www.euro3plast.com/gb/products/380-nettuno.html',
  'https://www.euro3plast.com/gb/products/380-nettuno.html',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'dizajnove' LIMIT 1),
  'Vaso Flow Large',
  'vaso-flow-large',
  'Serralunga',
  957,
  NULL,
  'Zdá sa, že Zaha Hadid čerpala inšpiráciu z tvarov sochárskeho a futuristického dizajnu, keď vytvorila kvetináč – sochu Flow. Tento výnimočný kúsok doslova berie dych, najmä vďaka svojej výške 2 metre a dynamickým, elegantne zakriveným líniám, ktoré sa neustále menia podľa uhla pohľadu. Flow je skutočným umeleckým dielom a stelesnením ikonického štýlu Zahy Hadid, ktorá je právom považovaná za „matku“ dizajnu Serralunga Flow.',
  'https://kochlik.netlify.app/images/vaso-flow-large/vaso-flow-large_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/vaso-flow-large/vaso-flow-large_1.jpg']::text[],
  '[]'::jsonb,
  ARRAY[]::text[],
  ARRAY[]::text[],
  ARRAY[]::text[],
  '[]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb,
  'https://kochlik.sk/produkt/vaso-flow-large/',
  'https://kochlik.sk/produkt/vaso-flow-large/',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'dizajnove' LIMIT 1),
  'Kvetináč Holly All',
  'kvetinac-holly-all',
  'Serralunga',
  210000,
  NULL,
  'Veľký kvetináč Holly All, navrhnutý Philippom Starckom pre značku Serralunga, nie je len obyčajný kvetináč – môže slúžiť aj ako stolička alebo jedinečná socha, čím sa radí medzi vonkajší dizajnový nábytok. Otvor na povrchu, pripomínajúci lodné okienko (porthole), dodáva celému objektu ľahkosť a plynulosť, narúša jeho kompaktný tvar a vytvára dynamický dizajn, ktorý možno vychutnať z rôznych uhlov pohľadu. Model Serralunga Holly All je dostupný ako veľkoformátový kvetináč aj v osvetlenej verzii, ktorá umocňuje jeho sochársky a elegantný charakter.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/en/products/holly-all-planter?_pos=1&_psq=Holly+All&_ss=e&_v=1.0)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/kvetinac-holly-all/kvetinac-holly-all_1.webp',
  ARRAY['https://kochlik.netlify.app/images/kvetinac-holly-all/kvetinac-holly-all_1.webp', 'https://kochlik.netlify.app/images/kvetinac-holly-all/kvetinac-holly-all_2.webp', 'https://kochlik.netlify.app/images/kvetinac-holly-all/kvetinac-holly-all_3.webp']::text[],
  '[{"name":"ANTRACITE","hex":null,"image_url":null,"family":"Sivá"},{"name":"ROSSO","hex":null,"image_url":null,"family":"Červená"},{"name":"SALVIA DI SARDEGNA","hex":null,"image_url":null,"family":"Zelená"},{"name":"TERRACOTTA SCURA","hex":null,"image_url":null,"family":"Červená"},{"name":"TORTORA DI TORINO","hex":null,"image_url":null,"family":"Hnedá"},{"name":"BIANCO","hex":null,"image_url":null,"family":"Biela"},{"name":"VERDE PAVONE","hex":null,"image_url":null,"family":"Zelená"},{"name":"LACQUEROSSO BIANCO","hex":null,"image_url":null,"family":"Biela"}]'::jsonb,
  ARRAY['Biela', 'Červená', 'Hnedá', 'Sivá', 'Zelená']::text[],
  ARRAY['92x89x200 cm']::text[],
  ARRAY['Nad 150 cm']::text[],
  '[{"label":"92x89x200 cm","dimensions":"92x89x200 cm","price_cents":210000,"attributes":{"rozmer":"92x89x200 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"92x89x200 cm"}]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/en/products/holly-all-planter?_pos=1&_psq=Holly+All&_ss=e&_v=1.0',
  'https://serralunga.com/en/products/holly-all-planter?_pos=1&_psq=Holly+All&_ss=e&_v=1.0',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'nabytok' LIMIT 1),
  'Sedačka Gumball',
  'sedacka-gumball',
  'Plust',
  101200,
  NULL,
  'Dvojmiestna pohovka s mäkkým a obklopujúcim dizajnom, dokonale zapadajúca do kolekcie, ktorá zahŕňa kreslo, stolík/úložný kontajner a ležadlo. Dostupná aj v svietiacej verzii, ktorá vďaka jemnému rozptýlenému svetlu vytvára teplú a príjemnú atmosféru, ideálnu najmä pre verejné a komerčné priestory.
Rozmer
165 x 88 x 66 cm
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.plust.it/en/products/gumball-sofa/)',
  'https://kochlik.netlify.app/images/sedacka-gumball/sedacka-gumball_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/sedacka-gumball/sedacka-gumball_1.jpg', 'https://kochlik.netlify.app/images/sedacka-gumball/sedacka-gumball_2.jpg', 'https://kochlik.netlify.app/images/sedacka-gumball/sedacka-gumball_3.jpg']::text[],
  '[{"name":"Pearl black","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_87_pearlblack.jpg","family":"Čierna"},{"name":"White C2","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_c2_whitec2.jpg","family":"Biela"},{"name":"Taupe","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_g9_taupe.jpg","family":"Hnedá"},{"name":"Sandy","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_m9_sandy.jpg","family":"Béžová"},{"name":"Golden rust","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_n4_goldenrust.jpg","family":"Hnedá"},{"name":"Aquamarina","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_s8_aquamarina.jpg","family":"Modrá"},{"name":"Lava","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_u0_lava.jpg","family":"Sivá"},{"name":"Ochre","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_u3_ochre.jpg","family":"Žltá"},{"name":"Neutral","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_98_neutral.jpg","family":"Biela"},{"name":"White light","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/plust_u1_whitelight.jpg","family":"Biela"}]'::jsonb,
  ARRAY['Béžová', 'Biela', 'Čierna', 'Hnedá', 'Modrá', 'Sivá', 'Žltá']::text[],
  ARRAY['88 x 66 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb,
  'https://www.plust.it/en/products/gumball-sofa/',
  'https://www.plust.it/en/products/gumball-sofa/',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'moderne-kvetinace' LIMIT 1),
  'Kvetináč Cassero Small',
  'kvetinac-cassero-small',
  'Serralunga',
  20700,
  NULL,
  'Kolekcia Cassero, ktorú pre značku Serralunga navrhla Patricia Urquiola, je inšpirovaná formami používanými v stavebníctve pri odlievaní betónu. Táto séria jednodielnych kvetináčov z polyetylénu zámerne vytvára betónový efekt, akoby boli odliate a následne vybraté z formy. S kolekciou Cassero sa architektka Urquiola rozhodla vytvoriť kvetináče, ktoré sú vhodné nielen do exteriéru, ale aj na oživenie interiéru, čím ich začlenila do sveta moderného dekoru. Model Cassero Small predstavuje menšiu verziu modelu Cassero 60 a je navrhnutý tak, aby sa mohol vložiť do väčšieho kvetináča a tým zjednodušiť prepravu.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/en/products/cassero-small?_pos=1&_psq=Cassero+Small&_ss=e&_v=1.0)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/kvetinac-cassero-small/kvetinac-cassero-small_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/kvetinac-cassero-small/kvetinac-cassero-small_1.jpg', 'https://kochlik.netlify.app/images/kvetinac-cassero-small/kvetinac-cassero-small_2.jpg', 'https://kochlik.netlify.app/images/kvetinac-cassero-small/kvetinac-cassero-small_3.jpg']::text[],
  '[{"name":"SALVIA DI SARDEGNA","hex":null,"image_url":null,"family":"Zelená"},{"name":"TORTORA DI TORINO","hex":null,"image_url":null,"family":"Hnedá"},{"name":"TERRACOTTA TOSCANA","hex":null,"image_url":null,"family":"Červená"},{"name":"ANTRACITE","hex":null,"image_url":null,"family":"Sivá"},{"name":"BIANCO","hex":null,"image_url":null,"family":"Biela"}]'::jsonb,
  ARRAY['Biela', 'Červená', 'Hnedá', 'Sivá', 'Zelená']::text[],
  ARRAY['44x44x51 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[{"label":"44x44x51 cm","dimensions":"44x44x51 cm","price_cents":20700,"attributes":{"rozmer":"44x44x51 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"44x44x51 cm"}]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/en/products/cassero-small?_pos=1&_psq=Cassero+Small&_ss=e&_v=1.0',
  'https://serralunga.com/en/products/cassero-small?_pos=1&_psq=Cassero+Small&_ss=e&_v=1.0',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'nabytok' LIMIT 1),
  'Russel Chair Cushion',
  'russel-chair-cushion',
  'Serralunga',
  36500,
  NULL,
  'Dizajn od Vico Magistretti pre Serralunga Stolička Russel je reinterpretáciou klasickej záhradnej stoličky – kombinuje tradičný štýl s modernou technológiou, vďaka čomu je nadčasová, odolná a elegantná. Predstavuje súčasný nábytok, ideálny pre vonkajšie priestory aj interiér, pričom zvýrazňuje význam komfortu a estetického dizajnu v bývaní. Pre ešte väčšie pohodlie a štýl skombinujte stoličku Russel s vankúšom v odtieni Terracotta, ktorý zvýrazní jej eleganciu a teplý charakter.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/en/products/russel-chair-cushion?_pos=1&_psq=Russel+Chair+Cushion&_ss=e&_v=1.0)',
  'https://kochlik.netlify.app/images/russel-chair-cushion/russel-chair-cushion_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/russel-chair-cushion/russel-chair-cushion_1.jpg']::text[],
  '[]'::jsonb,
  ARRAY[]::text[],
  ARRAY[]::text[],
  ARRAY[]::text[],
  '[]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/en/products/russel-chair-cushion?_pos=1&_psq=Russel+Chair+Cushion&_ss=e&_v=1.0',
  'https://serralunga.com/en/products/russel-chair-cushion?_pos=1&_psq=Russel+Chair+Cushion&_ss=e&_v=1.0',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'svietiace-kvetinace' LIMIT 1),
  'Kvetináč Bordato Liscio svietiaci',
  'kvetinac-bordato-liscio-svietiaci',
  'Serralunga',
  23100,
  NULL,
  'Materiál: Vyrobené z LLDPE (lineárny nízkohustotný polyetylén) Farba: Neutrálna – priesvitná Spôsob výroby: Rotačné tvarovanie Vhodné na vonkajšie použitie, odolné voči všetkým poveternostným podmienkam. Poskytuje UV ochranu, je 100 % recyklovateľné a farbené v hmote. Vyznačuje sa vysokou mechanickou pevnosťou a odolnosťou voči nárazom. Materiál je tepelne odolný, znáša teploty od –35 °C do +80 °C.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/en/products/bordato-liscio-planter-with-light?_pos=2&_psq=Bordato+Liscio&_ss=e&_v=1.0)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/kvetinac-bordato-liscio-svietiaci/kvetinac-bordato-liscio-svietiaci_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/kvetinac-bordato-liscio-svietiaci/kvetinac-bordato-liscio-svietiaci_1.jpg', 'https://kochlik.netlify.app/images/kvetinac-bordato-liscio-svietiaci/kvetinac-bordato-liscio-svietiaci_2.webp']::text[],
  '[]'::jsonb,
  ARRAY[]::text[],
  ARRAY['110x110x100 cm', '58x58x50 cm', '68x68x60 cm', '78x78x70 cm']::text[],
  ARRAY['51-100 cm', '101-150 cm']::text[],
  '[{"label":"110x110x100 cm","dimensions":"110x110x100 cm","price_cents":71400,"attributes":{"rozmer":"110x110x100 cm","typ-ziarovky":"LED"}},{"label":"110x110x100 cm","dimensions":"110x110x100 cm","price_cents":74300,"attributes":{"rozmer":"110x110x100 cm","typ-ziarovky":"RGB"}},{"label":"58x58x50 cm","dimensions":"58x58x50 cm","price_cents":26100,"attributes":{"rozmer":"58x58x50 cm","typ-ziarovky":"LED"}},{"label":"58x58x50 cm","dimensions":"58x58x50 cm","price_cents":23100,"attributes":{"rozmer":"58x58x50 cm","typ-ziarovky":"RGB"}},{"label":"68x68x60 cm","dimensions":"68x68x60 cm","price_cents":29100,"attributes":{"rozmer":"68x68x60 cm","typ-ziarovky":"LED"}},{"label":"68x68x60 cm","dimensions":"68x68x60 cm","price_cents":34500,"attributes":{"rozmer":"68x68x60 cm","typ-ziarovky":"RGB"}},{"label":"78x78x70 cm","dimensions":"78x78x70 cm","price_cents":32000,"attributes":{"rozmer":"78x78x70 cm","typ-ziarovky":"LED"}},{"label":"78x78x70 cm","dimensions":"78x78x70 cm","price_cents":34700,"attributes":{"rozmer":"78x78x70 cm","typ-ziarovky":"RGB"}}]'::jsonb,
  '[{"key":"Rozmer","value":"110x110x100 cm, 58x58x50 cm, 68x68x60 cm, 78x78x70 cm"},{"key":"Typ žiarovky","value":"LED, RGB"}]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/en/products/bordato-liscio-planter-with-light?_pos=2&_psq=Bordato+Liscio&_ss=e&_v=1.0',
  'https://serralunga.com/en/products/bordato-liscio-planter-with-light?_pos=2&_psq=Bordato+Liscio&_ss=e&_v=1.0',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'moderne-kvetinace' LIMIT 1),
  'Kvetináč KUBE HIGH SLIM CM.80',
  'kvetinac-kube-high-slim-2',
  'Euro3plast',
  22500,
  NULL,
  'Štýl je synonymom minimalizmu – dokonale zhrnutý v čistých a jednoduchých líniách našich kvetináčov a doplnkov. Skombinovali sme čisté profily s farebnou paletou pre každý vkus – od výraznej kyslej zelene a červenej po klasické odtiene – aby ste obohatili svoje obľúbené priestory harmóniou a eleganciou.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.euro3plast.com/gb/-/345-3329-kube-high-slim.html#/332-colour-white_c2/620-significant_measure-80)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/kvetinac-kube-high-slim-2/kvetinac-kube-high-slim-2_1.webp',
  ARRAY['https://kochlik.netlify.app/images/kvetinac-kube-high-slim-2/kvetinac-kube-high-slim-2_1.webp']::text[],
  '[{"name":"WHITE C2","hex":"#ffffff","image_url":null,"family":"Biela"},{"name":"RUST","hex":"#543920","image_url":null,"family":"Hnedá"},{"name":"TAUPE","hex":"#706961","image_url":null,"family":"Hnedá"},{"name":"CEMENT","hex":"#999390","image_url":null,"family":"Sivá"},{"name":"GRANITE","hex":null,"image_url":"https://kochlik.netlify.app/images/swatches/e3p_kvetinac-kube-high-slim-2_granite.jpg","family":"Sivá"},{"name":"PEARL BLACK","hex":"#4a4a49","image_url":null,"family":"Čierna"}]'::jsonb,
  ARRAY['Biela', 'Čierna', 'Hnedá', 'Sivá']::text[],
  ARRAY['80x25x70 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[{"label":"80x25x70 cm","dimensions":"80x25x70 cm","price_cents":22500,"attributes":{"rozmer":"80x25x70 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"80x25x70 cm"}]'::jsonb,
  '[{"label":"Technický dokument","url":"https://www.euro3plast.com/sheets/kube_high_slim_cassetta_con_doppia_parete.pdf"},{"label":"Informačný dokument","url":"https://www.euro3plast.com/sheets/kube_high_slim_plant_box_with_double_wall_info_en.pdf"}]'::jsonb,
  'https://www.euro3plast.com/gb/-/345-3329-kube-high-slim.html#/332-colour-white_c2/620-significant_measure-80',
  'https://www.euro3plast.com/gb/-/345-3329-kube-high-slim.html#/332-colour-white_c2/620-significant_measure-80',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'moderne-kvetinace' LIMIT 1),
  'Kvetináč SIEPI štvorcový',
  'kvetinac-siepi-stvorcovy',
  'Euro3plast',
  11400,
  NULL,
  'Kolekcia Style je elegantná a nadčasová: tieto nestarnúce kvetináče a doplnky dodajú záhradám, ktoré túžia po obdive, štýlový nádych. V duchu čistej talianskej tradície ponúka široký výber veľkostí a vkusne klasických dekorácií, ktoré sa po prvom vzhliadnutí stanú nepostrádateľnými.
Pre viac informácii navštívte stránku dodávateľa [tu](https://www.euro3plast.com/gb/products/313-siepi.html)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/kvetinac-siepi-stvorcovy/kvetinac-siepi-stvorcovy_1.webp',
  ARRAY['https://kochlik.netlify.app/images/kvetinac-siepi-stvorcovy/kvetinac-siepi-stvorcovy_1.webp', 'https://kochlik.netlify.app/images/kvetinac-siepi-stvorcovy/kvetinac-siepi-stvorcovy_2.png']::text[],
  '[{"name":"WHITE C2","hex":"#ffffff","image_url":null,"family":"Biela"},{"name":"TAUPE","hex":"#706961","image_url":null,"family":"Hnedá"},{"name":"TERRA DI SIENA","hex":"#e3945b","image_url":null,"family":"Červená"},{"name":"PEARL BLACK","hex":"#4a4a49","image_url":null,"family":"Čierna"}]'::jsonb,
  ARRAY['Biela', 'Červená', 'Čierna', 'Hnedá']::text[],
  ARRAY['39x39x35 cm', '47x47x41 cm']::text[],
  ARRAY['Do 50 cm']::text[],
  '[{"label":"39x39x35 cm","dimensions":"39x39x35 cm","price_cents":11400,"attributes":{"rozmer":"39x39x35 cm"}},{"label":"47x47x41 cm","dimensions":"47x47x41 cm","price_cents":12900,"attributes":{"rozmer":"47x47x41 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"39x39x35 cm, 47x47x41 cm"}]'::jsonb,
  '[{"label":"Technický dokument","url":"https://www.euro3plast.com/sheets/siepi_vaso_quadro.pdf"},{"label":"Informačný dokument","url":"https://www.euro3plast.com/sheets/siepi_square_pot_info_en.pdf"}]'::jsonb,
  'https://www.euro3plast.com/gb/products/313-siepi.html',
  'https://www.euro3plast.com/gb/products/313-siepi.html',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'moderne-kvetinace' LIMIT 1),
  'Kvetináč KABIN EXTRA',
  'kvetinac-kabin-extra',
  'Serralunga',
  93700,
  NULL,
  'Kvetináč Kabin Extra, ktorý pre značku Serralunga navrhla Luisa Bocchietto, je archetypálnym dizajnovým objektom, ktorý spája klasické geometrické tvary s jemne brúseným povrchom vo vznešenom a harmonickom prevedení. Presnosť línií a rohov sa tu stretáva s mäkkosťou zamatového dojmu a čistotou zenového minimalizmu. Model Kabin Extra predstavuje veľkoformátový kvetináč, ktorý sa stáva dominantným prvkom každého dizajnového priestoru – ikonou elegancie, rovnováhy a nadčasového štýlu.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/en/products/kabin-extra-planter?_pos=1&_psq=KABIN+EXTRA&_ss=e&_v=1.0)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/kvetinac-kabin-extra/kvetinac-kabin-extra_1.webp',
  ARRAY['https://kochlik.netlify.app/images/kvetinac-kabin-extra/kvetinac-kabin-extra_1.webp', 'https://kochlik.netlify.app/images/kvetinac-kabin-extra/kvetinac-kabin-extra_2.webp', 'https://kochlik.netlify.app/images/kvetinac-kabin-extra/kvetinac-kabin-extra_3.webp', 'https://kochlik.netlify.app/images/kvetinac-kabin-extra/kvetinac-kabin-extra_4.webp']::text[],
  '[{"name":"ANTRACITE","hex":null,"image_url":null,"family":"Sivá"},{"name":"AZZURRO DI PROVENZA","hex":null,"image_url":null,"family":"Modrá"},{"name":"ROSSO","hex":null,"image_url":null,"family":"Červená"},{"name":"SALVIA DI SARDEGNA","hex":null,"image_url":null,"family":"Zelená"},{"name":"TERRACOTTA SCURA","hex":null,"image_url":null,"family":"Červená"},{"name":"TORTORA DI TORINO","hex":null,"image_url":null,"family":"Hnedá"},{"name":"VERDE PAVONE","hex":null,"image_url":null,"family":"Zelená"},{"name":"BIANCO","hex":null,"image_url":null,"family":"Biela"},{"name":"TERRACOTTA TOSCANA","hex":null,"image_url":null,"family":"Červená"},{"name":"GIALLO SAHARA","hex":null,"image_url":null,"family":"Žltá"},{"name":"VERDE BRITISH","hex":null,"image_url":null,"family":"Zelená"},{"name":"ROSSO POMPEIANO","hex":null,"image_url":null,"family":"Červená"}]'::jsonb,
  ARRAY['Biela', 'Červená', 'Hnedá', 'Modrá', 'Sivá', 'Zelená', 'Žltá']::text[],
  ARRAY['75x75x150cm']::text[],
  ARRAY['101-150 cm']::text[],
  '[{"label":"75x75x150cm","dimensions":"75x75x150cm","price_cents":93700,"attributes":{"rozmer":"75x75x150cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"75x75x150cm"}]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/en/products/kabin-extra-planter?_pos=1&_psq=KABIN+EXTRA&_ss=e&_v=1.0',
  'https://serralunga.com/en/products/kabin-extra-planter?_pos=1&_psq=KABIN+EXTRA&_ss=e&_v=1.0',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'nabytok' LIMIT 1),
  'Lehátko Lazy Sunbed',
  'lehatko-lettino-sunbed',
  'Serralunga',
  160000,
  NULL,
  'Lehátko Lazy Lettino je súčasťou kolekcie Lazy, ktorú navrhol belgický dizajnér Michel Boucquillon pre Serralunga. Jeho konštrukcia je vyrobená z eloxovaného hliníka, čo zaručuje vysokú odolnosť voči poveternostným podmienkam, ideálnu pre vonkajšie použitie. Sedacia plocha z materiálu Batyline® je vodoodolná, pohodlná a prináša pocit ľahkosti a funkčnej elegancie bez kompromisov. Svojím striktne minimalistickým tvarom sa Lazy Lettino hodí do akéhokoľvek typu exteriéru, od moderných terás až po súkromné pláže či bazénové priestory. Táto kolekcia predstavuje moderný nábytok navrhnutý aj pre námorný sektor, kde sa spája odolnosť, estetika a komfort.
Rozmer
72 x 172 x 23 cm
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/en/products/lazy-lettino-sunbed?_pos=1&_psq=Lazy+Sunbed&_ss=e&_v=1.0)',
  'https://kochlik.netlify.app/images/lehatko-lettino-sunbed/lehatko-lettino-sunbed_1.webp',
  ARRAY['https://kochlik.netlify.app/images/lehatko-lettino-sunbed/lehatko-lettino-sunbed_1.webp', 'https://kochlik.netlify.app/images/lehatko-lettino-sunbed/lehatko-lettino-sunbed_2.webp', 'https://kochlik.netlify.app/images/lehatko-lettino-sunbed/lehatko-lettino-sunbed_3.webp']::text[],
  '[{"name":"TORTORA","hex":null,"image_url":null,"family":"Hnedá"},{"name":"BIANCO","hex":null,"image_url":null,"family":"Biela"}]'::jsonb,
  ARRAY['Biela', 'Hnedá']::text[],
  ARRAY['172 x 23 cm']::text[],
  ARRAY['Nad 150 cm']::text[],
  '[]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/en/products/lazy-lettino-sunbed?_pos=1&_psq=Lazy+Sunbed&_ss=e&_v=1.0',
  'https://serralunga.com/en/products/lazy-lettino-sunbed?_pos=1&_psq=Lazy+Sunbed&_ss=e&_v=1.0',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();

INSERT INTO public.kochlik_products (
  owner_id, category_id, name, slug, brand, price_cents, short_description, description, main_image_url, gallery_images, color_options, color_families, dimensions, dimension_groups, variations, specifications, download_files, supplier_url, source_url, is_active, sort_order
) VALUES (
  'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
  (SELECT id FROM public.kochlik_categories WHERE owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid AND slug = 'moderne-kvetinace' LIMIT 1),
  'Kvetináč Cassero 60',
  'kvetinac-cassero-60',
  'Serralunga',
  37000,
  NULL,
  'Kolekcia Cassero, ktorú pre značku Serralunga navrhla Patricia Urquiola, je inšpirovaná formami používanými v stavebníctve pri odlievaní betónu. Táto séria jednodielnych kvetináčov z polyetylénu zámerne napodobňuje betónový efekt, akoby boli odliate a následne vybraté z formy. S kolekciou Cassero sa architektka Urquiola rozhodla vytvoriť kvetináče, ktoré sú ideálne nielen do exteriéru, ale zároveň umožňujú preniesť zeleň aj do interiéru, čím ich začlenila do sveta moderného interiérového dizajnu. Model Cassero 60 predstavuje okrúhlu verziu tejto kolekcie.
 
Pre viac informácii navštívte stránku dodávateľa [tu](https://serralunga.com/en/products/cassero-60?pr_prod_strat=e5_desc&pr_rec_id=d9e2e364a&pr_rec_pid=7003991670921&pr_ref_pid=7003991736457&pr_seq=uniform)
K niektorým kvetináčom je možné objednať aj podmisku v rovnakej farbe (pozrite si tabuľku v popise produktu) a na cenu sa informujte mailom',
  'https://kochlik.netlify.app/images/kvetinac-cassero-60/kvetinac-cassero-60_1.jpg',
  ARRAY['https://kochlik.netlify.app/images/kvetinac-cassero-60/kvetinac-cassero-60_1.jpg']::text[],
  '[{"name":"GESSO DI BOLOGNA","hex":null,"image_url":null,"family":"Biela"},{"name":"SALVIA DI SARDEGNA","hex":null,"image_url":null,"family":"Zelená"},{"name":"TORTORA DI TORINO","hex":null,"image_url":null,"family":"Hnedá"},{"name":"TERRACOTTA SCURA","hex":null,"image_url":null,"family":"Červená"},{"name":"ORIGANO DI SARDEGNA","hex":null,"image_url":null,"family":"Zelená"},{"name":"TERRACOTTA TOSCANA","hex":null,"image_url":null,"family":"Červená"},{"name":"ANTRACITE","hex":null,"image_url":null,"family":"Sivá"},{"name":"AZZURRO DI PROVENZA","hex":null,"image_url":null,"family":"Modrá"},{"name":"PIETRA DI MATERA","hex":null,"image_url":null,"family":"Sivá"},{"name":"MORE DI ROVO","hex":null,"image_url":null,"family":"Ružová"},{"name":"IMPRUNETA","hex":null,"image_url":null,"family":"Hnedá"}]'::jsonb,
  ARRAY['Biela', 'Červená', 'Hnedá', 'Modrá', 'Ružová', 'Sivá', 'Zelená']::text[],
  ARRAY['60x60x70 cm']::text[],
  ARRAY['51-100 cm']::text[],
  '[{"label":"60x60x70 cm","dimensions":"60x60x70 cm","price_cents":37000,"attributes":{"rozmer":"60x60x70 cm"}}]'::jsonb,
  '[{"key":"Rozmer","value":"60x60x70 cm"}]'::jsonb,
  '[]'::jsonb,
  'https://serralunga.com/en/products/cassero-60?pr_prod_strat=e5_desc&pr_rec_id=d9e2e364a&pr_rec_pid=7003991670921&pr_ref_pid=7003991736457&pr_seq=uniform',
  'https://serralunga.com/en/products/cassero-60?pr_prod_strat=e5_desc&pr_rec_id=d9e2e364a&pr_rec_pid=7003991670921&pr_ref_pid=7003991736457&pr_seq=uniform',
  TRUE,
  0
) ON CONFLICT (owner_id, slug) DO UPDATE SET
  category_id = EXCLUDED.category_id,
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  price_cents = EXCLUDED.price_cents,
  short_description = EXCLUDED.short_description,
  description = EXCLUDED.description,
  main_image_url = EXCLUDED.main_image_url,
  gallery_images = EXCLUDED.gallery_images,
  color_options = EXCLUDED.color_options,
  color_families = EXCLUDED.color_families,
  dimensions = EXCLUDED.dimensions,
  dimension_groups = EXCLUDED.dimension_groups,
  variations = EXCLUDED.variations,
  specifications = EXCLUDED.specifications,
  download_files = EXCLUDED.download_files,
  supplier_url = EXCLUDED.supplier_url,
  source_url = EXCLUDED.source_url,
  is_active = EXCLUDED.is_active,
  updated_at = now();
COMMIT;
