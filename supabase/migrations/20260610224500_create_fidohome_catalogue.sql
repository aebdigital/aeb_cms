-- Fidohome catalogue tables and initial data from /Documents/fidohome/lib/products.ts
create extension if not exists pgcrypto;

create table if not exists public.fidohome_categories (
  id uuid primary key default gen_random_uuid(),
  slug text not null unique,
  label text not null,
  description text,
  image_url text,
  sort_order integer not null default 0,
  is_active boolean not null default true,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.fidohome_products (
  id uuid primary key default gen_random_uuid(),
  category_id uuid references public.fidohome_categories(id) on delete set null,
  slug text not null unique,
  name text not null,
  subcategory text,
  price_cents integer not null default 0,
  original_price_cents integer,
  currency text not null default 'EUR',
  lead text,
  description text,
  specs jsonb not null default '[]'::jsonb,
  preview_url text,
  detail_url text,
  gallery_images jsonb not null default '[]'::jsonb,
  is_featured boolean not null default false,
  is_active boolean not null default true,
  sort_order integer not null default 0,
  seo_title text,
  seo_description text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  constraint fidohome_products_specs_array check (jsonb_typeof(specs) = 'array'),
  constraint fidohome_products_gallery_array check (jsonb_typeof(gallery_images) = 'array')
);

create index if not exists fidohome_categories_active_sort_idx
  on public.fidohome_categories (is_active, sort_order, label);

create index if not exists fidohome_products_category_idx
  on public.fidohome_products (category_id);

create index if not exists fidohome_products_active_sort_idx
  on public.fidohome_products (is_active, sort_order, name);

create or replace function public.set_fidohome_updated_at()
returns trigger as $$
begin
  new.updated_at = now();
  return new;
end;
$$ language plpgsql;

drop trigger if exists fidohome_categories_updated_at on public.fidohome_categories;
create trigger fidohome_categories_updated_at
  before update on public.fidohome_categories
  for each row execute function public.set_fidohome_updated_at();

drop trigger if exists fidohome_products_updated_at on public.fidohome_products;
create trigger fidohome_products_updated_at
  before update on public.fidohome_products
  for each row execute function public.set_fidohome_updated_at();

alter table public.fidohome_categories enable row level security;
alter table public.fidohome_products enable row level security;

drop policy if exists "Fidohome owner can manage categories" on public.fidohome_categories;
create policy "Fidohome owner can manage categories"
on public.fidohome_categories
for all
to authenticated
using (lower(coalesce(auth.jwt() ->> 'email', '')) in ('info@fidohome.sk', 'alexander.hidveghy@gmail.com'))
with check (lower(coalesce(auth.jwt() ->> 'email', '')) in ('info@fidohome.sk', 'alexander.hidveghy@gmail.com'));

drop policy if exists "Public can view active Fidohome categories" on public.fidohome_categories;
create policy "Public can view active Fidohome categories"
on public.fidohome_categories
for select
to anon, authenticated
using (is_active = true);

drop policy if exists "Fidohome owner can manage products" on public.fidohome_products;
create policy "Fidohome owner can manage products"
on public.fidohome_products
for all
to authenticated
using (lower(coalesce(auth.jwt() ->> 'email', '')) in ('info@fidohome.sk', 'alexander.hidveghy@gmail.com'))
with check (lower(coalesce(auth.jwt() ->> 'email', '')) in ('info@fidohome.sk', 'alexander.hidveghy@gmail.com'));

drop policy if exists "Public can view active Fidohome products" on public.fidohome_products;
create policy "Public can view active Fidohome products"
on public.fidohome_products
for select
to anon, authenticated
using (is_active = true);

with seed_categories as (
  select item.id, item.label, item.ordinality
  from jsonb_to_recordset('[{"id":"kuchynske-linky","label":"Kuchynské linky"},{"id":"vstavane-skrine","label":"Vstavané skrine"},{"id":"konferencne-stoliky","label":"Konferenčné stolíky"},{"id":"regaly","label":"Nástenné regály"},{"id":"postele","label":"Postele"},{"id":"vypinace","label":"Vypínače"},{"id":"kvetinace","label":"Kvetináče"},{"id":"obrazy","label":"Obrazy"},{"id":"realizacie","label":"Realizácie"}]'::jsonb) with ordinality as item(id text, label text, ordinality bigint)
)
insert into public.fidohome_categories (slug, label, sort_order, is_active)
select id, label, ordinality::int * 10, true
from seed_categories
on conflict (slug) do update set
  label = excluded.label,
  sort_order = excluded.sort_order,
  is_active = true;

with seed_products as (
  select item.*
  from jsonb_to_recordset('[{"slug":"konferencny-stolik-linia","name":"Konferenčný stolík Variant 9","category":"konferencne-stoliky","subcategory":"svetle","price":390,"lead":"Moderný konferenčný stolík s dubovým dekorom a subtílnou čiernou konštrukciou.","description":"Nízky stolík do obývačky s veľkou odkladacou plochou, ostrou siluetou a materiálmi, ktoré pôsobia pokojne a trvácne.","specs":["Dubový dekor","Čierna kovová konštrukcia","Nízky obývačkový formát","Vhodný k sedacím súpravám"],"preview":"/products/konferencny-stolik-linia/preview.jpg","detail":"/products/konferencny-stolik-linia/detail.jpg"},{"slug":"konferencny-stolik-kriz","name":"Konferenčný stolík Variant 3","category":"konferencne-stoliky","subcategory":"drevene","price":460,"lead":"Dubový konferenčný stolík s výraznou stredovou podnožou.","description":"Robustnejší model so silným detailom podnože. Hodí sa tam, kde má byť stolík vizuálnou dominantou obývačky.","specs":["Výrazná kovová podnož","Dubová vrchná doska","Výrazný stredový detail","Pevná obývačková konštrukcia"],"preview":"/products/konferencny-stolik-kriz/preview.jpg","detail":"/products/konferencny-stolik-kriz/detail.jpg"},{"slug":"konferencny-stolik-nox","name":"Konferenčný stolík Variant 15","category":"konferencne-stoliky","subcategory":"tmave","price":420,"originalPrice":540,"lead":"Tmavý hranatý stolík pre interiéry s pokojným, grafickým výrazom.","description":"Čistá čierna línia, nízky profil a praktická odkladacia plocha vytvárajú produkt, ktorý dobre sedí k modernému sedeniu.","specs":["Tmavý dekor","Nízky profil","Hranatá silueta","Praktická odkladacia časť"],"preview":"/products/konferencny-stolik-nox/preview.jpg","detail":"/products/konferencny-stolik-nox/detail.jpg"},{"slug":"konferencny-stolik-alba","name":"Konferenčný stolík Variant 20","category":"konferencne-stoliky","subcategory":"svetle","price":430,"lead":"Svetlejší stolík s jemnejšou podnožou a veľkou odkladacou plochou.","description":"Variant pre neutrálne, svetlé obývačky. Kombinuje drevený vrch s odľahčenou konštrukciou a pôsobí veľmi vzdušne.","specs":["Svetlá podnož","Dubový vrch","Odkladacia plocha","Vhodný do svetlých interiérov"],"preview":"/products/konferencny-stolik-alba/preview.jpg","detail":"/products/konferencny-stolik-alba/detail.jpg"},{"slug":"nastenny-regal-silva","name":"Nástenný regál Silva","category":"regaly","subcategory":"kovove-drevene","price":280,"originalPrice":350,"lead":"Nástenný regál s kovovým rámom a drevenými policami.","description":"Otvorený regál na knihy, keramiku a dekorácie. Drevené police zjemňujú čierny kov a držia vizuál v prirodzenej neutralite.","specs":["Kovový rám","Drevené police","Montáž na stenu","Vhodný do obývačky, pracovne aj chodby"],"preview":"/products/nastenny-regal-silva/preview.jpg","detail":"/products/nastenny-regal-silva/detail.jpg"},{"slug":"postel-dub-line","name":"Posteľ Dub Line","category":"postele","subcategory":"drevene","price":890,"lead":"Posteľ s dreveným čelom, kovovou konštrukciou a pokojným hotelovým výrazom.","description":"Masívnejší rám s dreveným akcentom v čele postele. Vhodná do spálne, kde má nábytok pôsobiť pevne, ale nie ťažko.","specs":["Drevené čelo","Kovový rám","Minimálna silueta","Možnosť doladenia rozmerov"],"preview":"/products/postel-dub-line/preview.jpg","detail":"/products/postel-dub-line/detail.jpg"},{"slug":"postel-industrial","name":"Posteľ Industrial","category":"postele","subcategory":"kovove","price":990,"originalPrice":1290,"lead":"Kovovo-drevená posteľ s výraznejším remeselným detailom.","description":"Model s charakterom pre interiéry, ktoré znesú silnejšiu konštrukciu, čierny kov a prirodzenú kresbu dreva.","specs":["Kovová konštrukcia","Drevené akcenty","Výrazné čelo","Stabilná konštrukcia"],"preview":"/products/postel-industrial/preview.jpg","detail":"/products/postel-industrial/detail.jpg"},{"slug":"dizajnove-vypinace-a-zasuvky","name":"Dizajnové vypínače a zásuvky","category":"vypinace","subcategory":"dizajnove","price":49,"lead":"Detailné prvky do interiérov s drevom, kovom a čiernym akcentom.","description":"Malé prvky, ktoré v katalógu dobre dopĺňajú nábytok na mieru. Vhodné pre projekty, kde má byť zladený aj technický detail.","specs":["Čierne a farebné varianty","Vhodné k drevu a kovu","Detail do interiéru","Cena podľa konfigurácie"],"preview":"/products/dizajnove-vypinace-a-zasuvky/preview.jpg","detail":"/products/dizajnove-vypinace-a-zasuvky/detail.jpg"},{"slug":"interier-na-mieru","name":"Interiér na mieru","category":"realizacie","subcategory":"kuchyne","price":1200,"lead":"Kuchyne, skrine, detaily a realizácie spracované ako kompletné zadanie.","description":"Sekcia pre väčšie zadania a referencie FIDO HOME. Zahŕňa návrh, výrobu, montáž a zladenie detailov do jedného celku.","specs":["Kuchyne","Skrine","Montáž","Kompletné interiérové zadania"],"preview":"/products/interier-na-mieru/preview.jpg","detail":"/products/interier-na-mieru/detail.jpg"},{"slug":"kuchynska-linka-variant-1","name":"Kuchynská linka Variant 1","category":"kuchynske-linky","price":3400,"lead":"Moderná kuchynská linka na mieru s čistým detailom.","description":"Individuálne riešenie kuchynskej linky prispôsobené priestoru s kvalitným kovaním a odolnými materiálmi.","specs":["Výroba na mieru","Kvalitné kovania","Individuálny dizajn","Dodanie vrátane montáže"],"preview":"/fido-new/kuchynske-linky/a1d3fe80-088c-482a-be2a-68b73b2d8735.JPG","detail":"/fido-new/kuchynske-linky/a1d3fe80-088c-482a-be2a-68b73b2d8735.JPG"},{"slug":"kuchynska-linka-variant-2","name":"Kuchynská linka Variant 2","category":"kuchynske-linky","price":3900,"lead":"Moderná kuchynská linka na mieru s čistým detailom.","description":"Individuálne riešenie kuchynskej linky prispôsobené priestoru s kvalitným kovaním a odolnými materiálmi.","specs":["Výroba na mieru","Kvalitné kovania","Individuálny dizajn","Dodanie vrátane montáže"],"preview":"/fido-new/kuchynske-linky/843d519e-1bca-4f92-b8cb-75e461362f3a.JPG","detail":"/fido-new/kuchynske-linky/843d519e-1bca-4f92-b8cb-75e461362f3a.JPG"},{"slug":"kuchynska-linka-variant-3","name":"Kuchynská linka Variant 3","category":"kuchynske-linky","price":4200,"lead":"Moderná kuchynská linka na mieru s čistým detailom.","description":"Individuálne riešenie kuchynskej linky prispôsobené priestoru s kvalitným kovaním a odolnými materiálmi.","specs":["Výroba na mieru","Kvalitné kovania","Individuálny dizajn","Dodanie vrátane montáže"],"preview":"/fido-new/kuchynske-linky/135a70da-c4a3-4482-94b8-4d9ac5a0a047.JPG","detail":"/fido-new/kuchynske-linky/135a70da-c4a3-4482-94b8-4d9ac5a0a047.JPG"},{"slug":"kuchynska-linka-variant-4","name":"Kuchynská linka Variant 4","category":"kuchynske-linky","price":3600,"lead":"Moderná kuchynská linka na mieru s čistým detailom.","description":"Individuálne riešenie kuchynskej linky prispôsobené priestoru s kvalitným kovaním a odolnými materiálmi.","specs":["Výroba na mieru","Kvalitné kovania","Individuálny dizajn","Dodanie vrátane montáže"],"preview":"/fido-new/kuchynske-linky/c62faaeb-30b7-4e6e-9e30-0c53bcf26a20.JPG","detail":"/fido-new/kuchynske-linky/c62faaeb-30b7-4e6e-9e30-0c53bcf26a20.JPG"},{"slug":"kuchynska-linka-variant-5","name":"Kuchynská linka Variant 5","category":"kuchynske-linky","price":4500,"lead":"Moderná kuchynská linka na mieru s čistým detailom.","description":"Individuálne riešenie kuchynskej linky prispôsobené priestoru s kvalitným kovaním a odolnými materiálmi.","specs":["Výroba na mieru","Kvalitné kovania","Individuálny dizajn","Dodanie vrátane montáže"],"preview":"/fido-new/kuchynske-linky/9eae0988-b200-48f7-b0fc-5bc7b904aa51.JPG","detail":"/fido-new/kuchynske-linky/9eae0988-b200-48f7-b0fc-5bc7b904aa51.JPG"},{"slug":"vstavana-skrina-variant-1","name":"Vstavaná skriňa Variant 1","category":"vstavane-skrine","price":1200,"lead":"Vstavaná skriňa na mieru s posuvnými alebo otváravými dverami.","description":"Praktický a elegantný úložný priestor na mieru pre spálne, chodby a šatníky.","specs":["Individuálne vnútorné usporiadanie","Kvalitný posuvný systém","Výber dekorov a materiálov","Montáž v cene"],"preview":"/fido-new/vstavane-skrine/1db43031-73ac-4039-b01f-a7d2cd3dc6ea.JPG","detail":"/fido-new/vstavane-skrine/1db43031-73ac-4039-b01f-a7d2cd3dc6ea.JPG"},{"slug":"vstavana-skrina-variant-2","name":"Vstavaná skriňa Variant 2","category":"vstavane-skrine","price":1400,"lead":"Vstavaná skriňa na mieru s posuvnými alebo otváravými dverami.","description":"Praktický a elegantný úložný priestor na mieru pre spálne, chodby a šatníky.","specs":["Individuálne vnútorne usporiadanie","Kvalitný posuvný systém","Výber dekorov a materiálov","Montáž v cene"],"preview":"/fido-new/vstavane-skrine/c5170402-0c70-4f20-9f01-98119e6899c4.JPG","detail":"/fido-new/vstavane-skrine/c5170402-0c70-4f20-9f01-98119e6899c4.JPG"},{"slug":"vstavana-skrina-variant-3","name":"Vstavaná skriňa Variant 3","category":"vstavane-skrine","price":1600,"lead":"Vstavaná skriňa na mieru s posuvnými alebo otváravými dverami.","description":"Praktický a elegantný úložný priestor na mieru pre spálne, chodby a šatníky.","specs":["Individuálne vnútorné usporiadanie","Kvalitný posuvný systém","Výber dekorov a materiálov","Montáž v cene"],"preview":"/fido-new/vstavane-skrine/f28f878f-b3ba-443d-a71f-7ab2edef7140.JPG","detail":"/fido-new/vstavane-skrine/f28f878f-b3ba-443d-a71f-7ab2edef7140.JPG"},{"slug":"vstavana-skrina-variant-4","name":"Vstavaná skriňa Variant 4","category":"vstavane-skrine","price":1350,"lead":"Vstavaná skriňa na mieru s posuvnými alebo otváravými dverami.","description":"Praktický a elegantný úložný priestor na mieru pre spálne, chodby a šatníky.","specs":["Individuálne vnútorné usporiadanie","Kvalitný posuvný systém","Výber dekorov a materiálov","Montáž v cene"],"preview":"/fido-new/vstavane-skrine/e4b3bd91-18f7-4dd1-9c89-26dd22b13890.JPG","detail":"/fido-new/vstavane-skrine/e4b3bd91-18f7-4dd1-9c89-26dd22b13890.JPG"},{"slug":"vstavana-skrina-variant-5","name":"Vstavaná skriňa Variant 5","category":"vstavane-skrine","price":1500,"lead":"Vstavaná skriňa na mieru s posuvnými alebo otváravými dverami.","description":"Praktický a elegantný úložný priestor na mieru pre spálne, chodby a šatníky.","specs":["Individuálne vnútorné usporiadanie","Kvalitný posuvný systém","Výber dekorov a materiálov","Montáž v cene"],"preview":"/fido-new/vstavane-skrine/4dc45ddb-5603-4d49-b3bd-0f20ad4b36cb.JPG","detail":"/fido-new/vstavane-skrine/4dc45ddb-5603-4d49-b3bd-0f20ad4b36cb.JPG"},{"slug":"vstavana-skrina-variant-6","name":"Vstavaná skriňa Variant 6","category":"vstavane-skrine","price":1700,"lead":"Vstavaná skriňa na mieru s posuvnými alebo otváravými dverami.","description":"Praktický a elegantný úložný priestor na mieru pre spálne, chodby a šatníky.","specs":["Individuálne vnútorné usporiadanie","Kvalitný posuvný systém","Výber dekorov a materiálov","Montáž v cene"],"preview":"/fido-new/vstavane-skrine/2c48a29a-a383-4ae8-ab09-bbd6c4947773.JPG","detail":"/fido-new/vstavane-skrine/2c48a29a-a383-4ae8-ab09-bbd6c4947773.JPG"},{"slug":"vstavana-skrina-variant-7","name":"Vstavaná skriňa Variant 7","category":"vstavane-skrine","price":1450,"lead":"Vstavaná skriňa na mieru s posuvnými alebo otváravými dverami.","description":"Praktický a elegantný úložný priestor na mieru pre spálne, chodby a šatníky.","specs":["Individuálne vnútorné usporiadanie","Kvalitný posuvný systém","Výber dekorov a materiálov","Montáž v cene"],"preview":"/fido-new/vstavane-skrine/690eb425-ab78-4580-b23c-cedc57aea175.JPG","detail":"/fido-new/vstavane-skrine/690eb425-ab78-4580-b23c-cedc57aea175.JPG"},{"slug":"dizajnovy-kvetinac-variant-1","name":"Dizajnový kvetináč Variant 1","category":"kvetinace","price":120,"lead":"Moderný kvetináč na mieru s kovovou konštrukciou a drevenými prvkami.","description":"Ideálny interiérový doplnok spájajúci prírodné drevo a čiernu oceľ.","specs":["Kovová konštrukcia","Drevené detaily","Vhodný do moderného interiéru","Výroba podľa rozmeru"],"preview":"/fido-new/kvetinace/3613e79b-8474-4e0c-911b-f5c509e881ac.JPG","detail":"/fido-new/kvetinace/3613e79b-8474-4e0c-911b-f5c509e881ac.JPG"},{"slug":"dizajnovy-kvetinac-variant-2","name":"Dizajnový kvetináč Variant 2","category":"kvetinace","price":150,"lead":"Moderný kvetináč na mieru s kovovou konštrukciou a drevenými prvkami.","description":"Ideálny interiérový doplnok spájajúci prírodné drevo a čiernu oceľ.","specs":["Kovová konštrukcia","Drevené detaily","Vhodný do moderného interiéru","Výroba podľa rozmeru"],"preview":"/fido-new/kvetinace/6f845d2e-ce1b-43fd-b933-ee8fdcd13d64.JPG","detail":"/fido-new/kvetinace/6f845d2e-ce1b-43fd-b933-ee8fdcd13d64.JPG"},{"slug":"dizajnovy-kvetinac-variant-3","name":"Dizajnový kvetináč Variant 3","category":"kvetinace","price":180,"lead":"Moderný kvetináč na mieru s kovovou konštrukciou a drevenými prvkami.","description":"Ideálny interiérový doplnok spájajúci prírodné drevo a čiernu oceľ.","specs":["Kovová konštrukcia","Drevené detaily","Vhodný do moderného interiéru","Výroba podľa rozmeru"],"preview":"/fido-new/kvetinace/6b5b396f-8eed-4213-8eee-3d3be3741d3c.JPG","detail":"/fido-new/kvetinace/6b5b396f-8eed-4213-8eee-3d3be3741d3c.JPG"},{"slug":"dizajnovy-obraz-variant-1","name":"Dizajnový obraz Variant 1","category":"obrazy","price":80,"lead":"Umelecké dielo a dizajnový obraz pre dotvorenie atmosféry priestoru.","description":"Štýlový interiérový obraz s dôrazom na minimalizmus a moderný grafický detail.","specs":["Kvalitný rám","Originálny dizajn","Rôzne formáty","Pripravené na zavesenie"],"preview":"/fido-new/obrazy/8e320d58-4dcf-4414-ba3d-0e252a734f1c.JPG","detail":"/fido-new/obrazy/8e320d58-4dcf-4414-ba3d-0e252a734f1c.JPG"},{"slug":"dizajnovy-obraz-variant-2","name":"Dizajnový obraz Variant 2","category":"obrazy","price":95,"lead":"Umelecké dielo a dizajnový obraz pre dotvorenie atmosféry priestoru.","description":"Štýlový interiérový obraz s dôrazom na minimalizmus a moderný grafický detail.","specs":["Kvalitný rám","Originálny dizajn","Rôzne formáty","Pripravené na zavesenie"],"preview":"/fido-new/obrazy/25598ce2-3373-48aa-9250-cbd4b37b6419.JPG","detail":"/fido-new/obrazy/25598ce2-3373-48aa-9250-cbd4b37b6419.JPG"},{"slug":"dizajnovy-obraz-variant-3","name":"Dizajnový obraz Variant 3","category":"obrazy","price":110,"lead":"Umelecké dielo a dizajnový obraz pre dotvorenie atmosféry priestoru.","description":"Štýlový interiérový obraz s dôrazom na minimalizmus a moderný grafický detail.","specs":["Kvalitný rám","Originálny dizajn","Rôzne formáty","Pripravené na zavesenie"],"preview":"/fido-new/obrazy/34e8415b-6efd-4ae6-88d9-c8bb70b51e3c.JPG","detail":"/fido-new/obrazy/34e8415b-6efd-4ae6-88d9-c8bb70b51e3c.JPG"},{"slug":"dizajnovy-obraz-variant-4","name":"Dizajnový obraz Variant 4","category":"obrazy","price":85,"lead":"Umelecké dielo a dizajnový obraz pre dotvorenie atmosféry priestoru.","description":"Štýlový interiérový obraz s dôrazom na minimalizmus a moderný grafický detail.","specs":["Kvalitný rám","Originálny dizajn","Rôzne formáty","Pripravené na zavesenie"],"preview":"/fido-new/obrazy/13b9ca46-816b-4499-b369-f69ae522297b.JPG","detail":"/fido-new/obrazy/13b9ca46-816b-4499-b369-f69ae522297b.JPG"},{"slug":"dizajnovy-obraz-variant-5","name":"Dizajnový obraz Variant 5","category":"obrazy","price":120,"lead":"Umelecké dielo a dizajnový obraz pre dotvorenie atmosféry priestoru.","description":"Štýlový interiérový obraz s dôrazom na minimalizmus a moderný grafický detail.","specs":["Kvalitný rám","Originálny dizajn","Rôzne formáty","Pripravené na zavesenie"],"preview":"/fido-new/obrazy/1a14dd77-4b1b-4809-8e6d-b3e7e1bcf423.JPG","detail":"/fido-new/obrazy/1a14dd77-4b1b-4809-8e6d-b3e7e1bcf423.JPG"},{"slug":"dizajnovy-obraz-variant-6","name":"Dizajnový obraz Variant 6","category":"obrazy","price":130,"lead":"Umelecké dielo a dizajnový obraz pre dotvorenie atmosféry priestoru.","description":"Štýlový interiérový obraz s dôrazom na minimalizmus a moderný grafický detail.","specs":["Kvalitný rám","Originálny dizajn","Rôzne formáty","Pripravené na zavesenie"],"preview":"/fido-new/obrazy/0c34e039-1ba3-42a3-8211-0132ecfec24b.JPG","detail":"/fido-new/obrazy/0c34e039-1ba3-42a3-8211-0132ecfec24b.JPG"},{"slug":"dizajnovy-obraz-variant-7","name":"Dizajnový obraz Variant 7","category":"obrazy","price":90,"lead":"Umelecké dielo a dizajnový obraz pre dotvorenie atmosféry priestoru.","description":"Štýlový interiérový obraz s dôrazom na minimalizmus a moderný grafický detail.","specs":["Kvalitný rám","Originálny dizajn","Rôzne formáty","Pripravené na zavesenie"],"preview":"/fido-new/obrazy/22a1e846-4b6c-493d-b545-c89f77e3087b.JPG","detail":"/fido-new/obrazy/22a1e846-4b6c-493d-b545-c89f77e3087b.JPG"},{"slug":"dizajnovy-obraz-variant-8","name":"Dizajnový obraz Variant 8","category":"obrazy","price":105,"lead":"Umelecké dielo a dizajnový obraz pre dotvorenie atmosféry priestoru.","description":"Štýlový interiérový obraz s dôrazom na minimalizmus a moderný grafický detail.","specs":["Kvalitný rám","Originálny dizajn","Rôzne formáty","Pripravené na zavesenie"],"preview":"/fido-new/obrazy/e9a9d18f-f0ed-44b7-836f-29e79f110467.JPG","detail":"/fido-new/obrazy/e9a9d18f-f0ed-44b7-836f-29e79f110467.JPG"},{"slug":"dizajnovy-obraz-variant-9","name":"Dizajnový obraz Variant 9","category":"obrazy","price":115,"lead":"Umelecké dielo a dizajnový obraz pre dotvorenie atmosféry priestoru.","description":"Štýlový interiérový obraz s dôrazom na minimalizmus a moderný grafický detail.","specs":["Kvalitný rám","Originálny dizajn","Rôzne formáty","Pripravené na zavesenie"],"preview":"/fido-new/obrazy/b88ffc8f-4a85-4fd2-a217-7fcb444cb356.JPG","detail":"/fido-new/obrazy/b88ffc8f-4a85-4fd2-a217-7fcb444cb356.JPG"},{"slug":"dizajnovy-obraz-variant-10","name":"Dizajnový obraz Variant 10","category":"obrazy","price":100,"lead":"Umelecké dielo a dizajnový obraz pre dotvorenie atmosféry priestoru.","description":"Štýlový interiérový obraz s dôrazom na minimalizmus a moderný grafický detail.","specs":["Kvalitný rám","Originálny dizajn","Rôzne formáty","Pripravené na zavesenie"],"preview":"/fido-new/obrazy/92002221-e4b1-4408-9f24-13f03e0a3eee.JPG","detail":"/fido-new/obrazy/92002221-e4b1-4408-9f24-13f03e0a3eee.JPG"},{"slug":"dizajnovy-obraz-variant-11","name":"Dizajnový obraz Variant 11","category":"obrazy","price":125,"lead":"Umelecké dielo a dizajnový obraz pre dotvorenie atmosféry priestoru.","description":"Štýlový interiérový obraz s dôrazom na minimalizmus a moderný grafický detail.","specs":["Kvalitný rám","Originálny dizajn","Rôzne formáty","Pripravené na zavesenie"],"preview":"/fido-new/obrazy/7814e09c-55eb-4cf7-bb2b-417ea4abed19.JPG","detail":"/fido-new/obrazy/7814e09c-55eb-4cf7-bb2b-417ea4abed19.JPG"}]'::jsonb) with ordinality as item(
    slug text,
    name text,
    category text,
    subcategory text,
    price numeric,
    "originalPrice" numeric,
    lead text,
    description text,
    specs jsonb,
    preview text,
    detail text,
    ordinality bigint
  )
)
insert into public.fidohome_products (
  category_id, slug, name, subcategory, price_cents, original_price_cents, currency, lead, description,
  specs, preview_url, detail_url, gallery_images, sort_order, is_active
)
select
  c.id,
  p.slug,
  p.name,
  nullif(p.subcategory, ''),
  round(coalesce(p.price, 0) * 100)::int,
  case when p."originalPrice" is null then null else round(p."originalPrice" * 100)::int end,
  'EUR',
  p.lead,
  p.description,
  coalesce(p.specs, '[]'::jsonb),
  p.preview,
  p.detail,
  case when p.detail is not null and p.detail <> p.preview then jsonb_build_array(p.preview, p.detail) else jsonb_build_array(p.preview) end,
  p.ordinality::int * 10,
  true
from seed_products p
left join public.fidohome_categories c on c.slug = p.category
on conflict (slug) do update set
  category_id = excluded.category_id,
  name = excluded.name,
  subcategory = excluded.subcategory,
  price_cents = excluded.price_cents,
  original_price_cents = excluded.original_price_cents,
  currency = excluded.currency,
  lead = excluded.lead,
  description = excluded.description,
  specs = excluded.specs,
  preview_url = excluded.preview_url,
  detail_url = excluded.detail_url,
  gallery_images = excluded.gallery_images,
  sort_order = excluded.sort_order,
  is_active = true;
