-- Raving CMS project migration.
-- Creates the Raving account/site surface used by aeb_cms and exposes
-- published project references to the static Raving website.

create extension if not exists pgcrypto;

create table if not exists public.sites (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  slug text not null unique,
  domain text,
  owner_id uuid references auth.users(id) on delete set null,
  settings jsonb not null default '{}'::jsonb,
  lang text not null default 'sk',
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.site_memberships (
  site_id uuid not null references public.sites(id) on delete cascade,
  user_id uuid not null references auth.users(id) on delete cascade,
  role text not null default 'editor',
  created_at timestamptz not null default now(),
  primary key (site_id, user_id)
);

create table if not exists public.pages (
  id uuid primary key default gen_random_uuid(),
  site_id uuid not null references public.sites(id) on delete cascade,
  slug text not null,
  title text not null,
  is_public boolean not null default true,
  show_in_nav boolean not null default true,
  nav_label text,
  nav_order integer not null default 0,
  status text not null default 'published',
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique (site_id, slug)
);

create table if not exists public.raving_projects (
  id uuid primary key default gen_random_uuid(),
  site_id uuid references public.sites(id) on delete set null,
  owner_email text not null default 'petras@raving.sk',
  title text not null,
  description text not null default '',
  slug text not null unique,
  category text not null default 'ostatne' check (category in ('priemyselne', 'rodinne', 'administrativne', 'ostatne')),
  cover_image_url text not null default '',
  gallery_images text[] not null default '{}',
  legacy_folder text,
  legacy_first_image text,
  sort_order integer not null default 0,
  is_published boolean not null default true,
  seo_title text,
  seo_description text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create index if not exists raving_projects_published_order_idx
  on public.raving_projects (is_published, sort_order, created_at desc);

create or replace function public.raving_set_updated_at()
returns trigger
language plpgsql
as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

drop trigger if exists raving_projects_updated_at on public.raving_projects;
create trigger raving_projects_updated_at
  before update on public.raving_projects
  for each row execute function public.raving_set_updated_at();

alter table public.sites enable row level security;
alter table public.site_memberships enable row level security;
alter table public.pages enable row level security;
alter table public.raving_projects enable row level security;

drop policy if exists "Users can read their site memberships" on public.site_memberships;
create policy "Users can read their site memberships"
on public.site_memberships
for select
to authenticated
using (user_id = auth.uid());

drop policy if exists "Users can read their sites" on public.sites;
create policy "Users can read their sites"
on public.sites
for select
to authenticated
using (
  owner_id = auth.uid()
  or exists (
    select 1 from public.site_memberships
    where site_memberships.site_id = sites.id
      and site_memberships.user_id = auth.uid()
  )
);

drop policy if exists "Users can read pages for their sites" on public.pages;
create policy "Users can read pages for their sites"
on public.pages
for select
to authenticated
using (
  exists (
    select 1 from public.site_memberships
    where site_memberships.site_id = pages.site_id
      and site_memberships.user_id = auth.uid()
  )
);

drop policy if exists "Public can read published Raving projects" on public.raving_projects;
create policy "Public can read published Raving projects"
on public.raving_projects
for select
to anon, authenticated
using (is_published = true);

drop policy if exists "Raving editors can manage projects" on public.raving_projects;
create policy "Raving editors can manage projects"
on public.raving_projects
for all
to authenticated
using (
  lower(coalesce(auth.jwt() ->> 'email', '')) in ('petras@raving.sk', 'alexander.hidveghy@gmail.com')
  or exists (
    select 1 from public.site_memberships
    where site_memberships.site_id = raving_projects.site_id
      and site_memberships.user_id = auth.uid()
      and site_memberships.role in ('admin', 'editor')
  )
)
with check (
  lower(coalesce(auth.jwt() ->> 'email', '')) in ('petras@raving.sk', 'alexander.hidveghy@gmail.com')
  or exists (
    select 1 from public.site_memberships
    where site_memberships.site_id = raving_projects.site_id
      and site_memberships.user_id = auth.uid()
      and site_memberships.role in ('admin', 'editor')
  )
);

insert into public.sites (name, slug, domain, lang)
values ('Raving', 'raving', 'raving.sk', 'sk')
on conflict (slug) do update set
  name = excluded.name,
  domain = excluded.domain,
  lang = excluded.lang;

insert into public.pages (site_id, slug, title, is_public, show_in_nav, nav_label, nav_order, status)
select sites.id, 'raving-projects', 'Raving referencie', true, false, 'Referencie', 10, 'published'
from public.sites
where sites.slug = 'raving'
on conflict (site_id, slug) do update set
  title = excluded.title,
  is_public = excluded.is_public,
  show_in_nav = excluded.show_in_nav,
  nav_label = excluded.nav_label,
  nav_order = excluded.nav_order,
  status = excluded.status;

-- Petra exists in Supabase Auth. This profile insert is schema-aware because
-- different AEB CMS projects have different public.profiles columns.
do $profile$
declare
  insert_columns text := 'id';
  select_values text := 'users.id';
  update_values text := '';
begin
  if exists (
    select 1 from information_schema.columns
    where table_schema = 'public' and table_name = 'profiles' and column_name = 'email'
  ) then
    insert_columns := insert_columns || ', email';
    select_values := select_values || ', users.email';
    update_values := update_values || 'email = excluded.email';
  end if;

  if exists (
    select 1 from information_schema.columns
    where table_schema = 'public' and table_name = 'profiles' and column_name = 'full_name'
  ) then
    insert_columns := insert_columns || ', full_name';
    select_values := select_values || ', coalesce(users.raw_user_meta_data ->> ''full_name'', ''Raving'')';
    update_values := update_values
      || case when update_values = '' then '' else ', ' end
      || 'full_name = coalesce(public.profiles.full_name, excluded.full_name)';
  end if;

  if exists (
    select 1 from information_schema.columns
    where table_schema = 'public' and table_name = 'profiles' and column_name = 'lang'
  ) then
    insert_columns := insert_columns || ', lang';
    select_values := select_values || ', ''sk''';
    update_values := update_values
      || case when update_values = '' then '' else ', ' end
      || 'lang = excluded.lang';
  end if;

  execute format(
    'insert into public.profiles (%s)
     select %s
     from auth.users users
     where lower(users.email) = %L
     on conflict (id) do %s',
    insert_columns,
    select_values,
    'petras@raving.sk',
    case when update_values = '' then 'nothing' else 'update set ' || update_values end
  );
end
$profile$;

insert into public.site_memberships (site_id, user_id, role)
select sites.id, users.id, 'admin'
from public.sites
cross join auth.users
where sites.slug = 'raving'
  and lower(users.email) in ('petras@raving.sk', 'alexander.hidveghy@gmail.com')
on conflict (site_id, user_id) do update set role = excluded.role;

insert into public.raving_projects
  (site_id, title, description, slug, category, cover_image_url, legacy_folder, legacy_first_image, sort_order, is_published)
select sites.id, seed.title, seed.description, seed.slug, seed.category, seed.cover_image_url, seed.legacy_folder, seed.legacy_first_image, seed.sort_order, seed.is_published
from public.sites
cross join (
  values
    ('Modernizácia farmy PD Dolná Krupá', 'Modernizácia farmy dojníc', 'modernizacia-farmy-pd-dolna-krupa', 'priemyselne', '/sources/referencie/Modernizacia farmy dojnic PD Dolna Krupa/RD-TT-bazen-3.jpg', 'Modernizacia farmy dojnic PD Dolna Krupa', 'RD-TT-bazen-3.jpg', 0, true),
    ('Parkovisko', 'Novostavba a rekonštrukcia parkoviska', 'parkovisko', 'ostatne', '/sources/referencie/Novostavba parkoviska, rekonstrukcia jestvujuceho parkoviska/DJI_20250331133341_0059_D-2000x1200.jpg', 'Novostavba parkoviska, rekonstrukcia jestvujuceho parkoviska', 'DJI_20250331133341_0059_D-2000x1200.jpg', 1, true),
    ('Agrocoop Imeľ, Novostavba maštale K250', 'Novostavba maštale pre 250 ks dobytka', 'agrocoop-imeli-novstavba-mastale-k250', 'priemyselne', '/sources/referencie/Agrocoop Imel, Novostavba mastale K250/DJI_20250917100542_0160_D-2000x1200.jpg', 'Agrocoop Imel, Novostavba mastale K250', 'DJI_20250917100542_0160_D-2000x1200.jpg', 2, true),
    ('Vrbovská cesta', 'Rekonštrukcia polyfunkčnej budovy', 'vrbovska-cesta', 'administrativne', '/sources/referencie/Rekonstrukcia polyfunkcnej budovy, vlastne sidlo spolocnosti/Vrbovska-2000x1200.jpg', 'Rekonstrukcia polyfunkcnej budovy, vlastne sidlo spolocnosti', 'Vrbovska-2000x1200.jpg', 3, true),
    ('PD Radošinka', 'Maštal + robotizovaná kruhová dojáreň', 'pd-radosinka', 'priemyselne', '/sources/referencie/PD Radosinka, mastal + robotizovana kruhova dojaren/dji_fly_20250129_151246_0037_1738330513623_photo-2000x1200.jpg', 'PD Radosinka, mastal + robotizovana kruhova dojaren', 'dji_fly_20250129_151246_0037_1738330513623_photo-2000x1200.jpg', 4, true),
    ('JFK INOVEC 9.000m2', 'Výrobná hala 9.000m2', 'jfk-inovec-9000m2', 'priemyselne', '/sources/referencie/Novostavba vyrobnej haly 9.000m2, JFK INOVEC sro/Stakotra-dron-05-2024-1536x864.jpg', 'Novostavba vyrobnej haly 9.000m2, JFK INOVEC sro', 'Stakotra-dron-05-2024-1536x864.jpg', 5, true),
    ('PD Okoč - Silážný žlab', 'Novostavba silážneho žlabu', 'pd-okoc-silazny-zlab', 'administrativne', '/sources/referencie/PD Okoc - novostavba silazneho zlabu/IMG-20231013-WA0004-1.jpg', 'PD Okoc - novostavba silazneho zlabu', 'IMG-20231013-WA0004-1.jpg', 6, true),
    ('Penzión Anna Vila', 'Rekonštrukcia penziónu, Piešťany', 'penzion-anna-vila', 'administrativne', '/sources/referencie/Rekonstrukcia penzionu Anna Vila, Sad A. Kmeta, Piestany/IMG_2364-1-rotated.jpg', 'Rekonstrukcia penzionu Anna Vila, Sad A. Kmeta, Piestany', 'IMG_2364-1-rotated.jpg', 7, true),
    ('PORSCHE Slovakia', 'Monolitické základy haly', 'porsche-slovakia', 'priemyselne', '/sources/referencie/Monoliticke zaklady haly - PORSCHE Slovakia/IMG-20230126-WA0009-2000x1200.jpg', 'Monoliticke zaklady haly - PORSCHE Slovakia', 'IMG-20230126-WA0009-2000x1200.jpg', 8, true),
    ('Agropodnik Trnava - ČOV', 'Úprava retencie dažďových vôd a nová ČOV', 'agropodnik-trnava-cov', 'priemyselne', '/sources/referencie/Uprava retencie dazdovych vod a nova COV - areal Agropodnik Trnava/IMG-20221010-WA0009-2000x1200.jpg', 'Uprava retencie dazdovych vod a nova COV - areal Agropodnik Trnava', 'IMG-20221010-WA0009-2000x1200.jpg', 9, true),
    ('JFK Inovec 3.000m2', 'Výrobná hala 3.000m2, areál Stakotra', 'jfk-inovec-3000m2', 'priemyselne', '/sources/referencie/Novostavba vyrobnej haly, JFK Inovec, 3.000m2, areal Stakotra Piestany/dji_fly_20250131_095952_0089_1738327373468_photo-1536x864.jpg', 'Novostavba vyrobnej haly, JFK Inovec, 3.000m2, areal Stakotra Piestany', 'dji_fly_20250131_095952_0089_1738327373468_photo-1536x864.jpg', 10, true),
    ('Apartmánový dom Pínia', 'Zakladanie stavby apartmánového domu', 'apartmanovy-dom-pinia', 'rodinne', '/sources/referencie/Apartmanovy dom Pinia - zakladanie stavby/PINIA-zaklady.jpg', 'Apartmanovy dom Pinia - zakladanie stavby', 'PINIA-zaklady.jpg', 11, true),
    ('Prístrešok na palety', 'Prístrešok a spevnené plochy 2.500m2', 'pristresok-na-palety', 'priemyselne', '/sources/referencie/Pristresok na palety a spevnene plochy 2.500m2/20210809_082108-2000x1200.jpg', 'Pristresok na palety a spevnene plochy 2.500m2', '20210809_082108-2000x1200.jpg', 12, true),
    ('PVOD Drahovce', 'Rekonštrukcia a prístavba maštale', 'pvod-drahovce', 'priemyselne', '/sources/referencie/Rekonstrukcia a pristavba mastale PVOD Drahovce/dji_fly_20250205_120750_0148_1738756593552_photo-2000x1200.jpg', 'Rekonstrukcia a pristavba mastale PVOD Drahovce', 'dji_fly_20250205_120750_0148_1738756593552_photo-2000x1200.jpg', 13, true),
    ('Apartmánový dom Tília', 'Výstavba apartmánového domu Tília', 'apartmanovy-dom-tilia', 'rodinne', '/sources/referencie/Apartmanovy dom Tilia/DJI_20250203131255_0129_D-1536x864.jpg', 'Apartmanovy dom Tilia', 'DJI_20250203131255_0129_D-1536x864.jpg', 14, true),
    ('Maštal PD Okoč', 'Novostavba maštale 4.250m2', 'mastal-pd-okoc', 'priemyselne', '/sources/referencie/Novostavba mastale PD Okoc, 4.250m2/PD-Okoc-OK-1024x768.jpg', 'Novostavba mastale PD Okoc, 4.250m2', 'PD-Okoc-OK-1024x768.jpg', 15, true),
    ('Kúpele Piešťany - Bazén', 'Rekonštrukcia trakčného bazéna', 'kupele-piestany-bazen', 'ostatne', '/sources/referencie/Rekonstrukcia trakcneho bazena Kupele Piestany/20200706_150802-2000x1200.jpg', 'Rekonstrukcia trakcneho bazena Kupele Piestany', '20200706_150802-2000x1200.jpg', 16, true),
    ('Odchovná mladého dobytka', 'Novostavba odchovne - stavebná časť', 'odchovna-mladeho-dobytka', 'priemyselne', '/sources/referencie/Novostavba odchovne mladeho dobytka - stavebna cast/20200630_095039-1024x768.jpg', 'Novostavba odchovne mladeho dobytka - stavebna cast', '20200630_095039-1024x768.jpg', 17, true),
    ('Agrocoop Imeľ, Kravín K250', 'Novostavba maštale pre 250ks dojníc', 'agrocoop-imel-kravin-k250', 'priemyselne', '/sources/referencie/Agrocoop Imel Kravin K250/HLAVNA.jpg', 'Agrocoop Imel Kravin K250', 'HLAVNA.jpg', 18, true),
    ('PD Dobrá Niva - Odchovná', 'Odchovná mladého dobytka', 'pd-dobra-niva-odchovna', 'priemyselne', '/sources/referencie/Odchovna mladeho dobytka PD Dobra Niva/dji_fly_20250131_142932_0118_1738330434446_photo-2000x1200.jpg', 'Odchovna mladeho dobytka PD Dobra Niva', 'dji_fly_20250131_142932_0118_1738330434446_photo-2000x1200.jpg', 19, true),
    ('Rybárova farma Šurany', 'Výkrm býkov', 'rybarova-farma-surany', 'priemyselne', '/sources/referencie/Vykrm bykov Rybarova farma Surany/20200127_104648-2000x1200.jpg', 'Vykrm bykov Rybarova farma Surany', '20200127_104648-2000x1200.jpg', 20, true),
    ('PD Dobrá Niva', 'Poľnohospodárske družstvo', 'pd-dobra-niva', 'priemyselne', '/sources/referencie/Polnohospodarsky druzstvo Dobra Niva/PD-Dobra-Niva-Sasa4.jpg', 'Polnohospodarsky druzstvo Dobra Niva', 'PD-Dobra-Niva-Sasa4.jpg', 21, true),
    ('Výrobná hala Stakotra', 'Novostavba výrobnej haly', 'vyrobna-hala-stakotra', 'priemyselne', '/sources/referencie/Novostavba vyrobnej haly/Stakotra3.jpg', 'Novostavba vyrobnej haly', 'Stakotra3.jpg', 22, true),
    ('Tenisová akadémia Empire', 'Tenisová akadémia Trnava', 'tenisova-akademia-empire', 'ostatne', '/sources/referencie/Tenisova akademia Empire Trnava/Tenisova-akademia-Trnava1.jpg', 'Tenisova akademia Empire Trnava', 'Tenisova-akademia-Trnava1.jpg', 23, true),
    ('ON Semiconductor', 'Priemyselný komplex Piešťany', 'on-semiconductor', 'priemyselne', '/sources/referencie/ON Semiconductor Piestany/OnSemiconductor2.jpg', 'ON Semiconductor Piestany', 'OnSemiconductor2.jpg', 24, true),
    ('Obchodný dom Domoss', 'Obchodný dom Piešťany', 'obchodny-dom-domoss', 'administrativne', '/sources/referencie/Obchodny dom Domoss Piestany/domoss-letak.jpg', 'Obchodny dom Domoss Piestany', 'domoss-letak.jpg', 25, true),
    ('Vacuumschmelze - Administratíva', 'Výstavba administratívnej budovy', 'vacuumschmelze-administrativa', 'administrativne', '/sources/referencie/Vystavba administrativnej budovy/20170614_101352.jpg', 'Vystavba administrativnej budovy', '20170614_101352.jpg', 26, true),
    ('Hella Slovakia - Jedáleň', 'Prístavba jedálne', 'hella-slovakia-jedalen', 'ostatne', '/sources/referencie/Pristavba jedalne Hella Slovakia/Hella-Slovakia-Front-Lighting1.jpg', 'Pristavba jedalne Hella Slovakia', 'Hella-Slovakia-Front-Lighting1.jpg', 27, true),
    ('RD Považany', 'Prestavba rodinného domu', 'rd-povazany', 'rodinne', '/sources/referencie/Prestavba rodinneho domu/Rodinny-dom-Povazany-2000x1200.jpg', 'Prestavba rodinneho domu', 'Rodinny-dom-Povazany-2000x1200.jpg', 28, true),
    ('Rozšírenie parkoviska HELLA Slovakia', 'Rozšírenie parkoviska pre HELLA Slovakia Front-Lightning s.r.o.', 'rozsirenie-parkoviska-hella-slovakia', 'ostatne', '/sources/referencie/Rozšírenie parkoviska HELLA Slovakia /HLAVNA.jpg', 'Rozšírenie parkoviska HELLA Slovakia ', 'HLAVNA.jpg', 29, true),
    ('Sklad hnojaček Senica', 'Sklad kvapalných hnojív DAM', 'sklad-hnojaciek-senica', 'priemyselne', '/sources/referencie/Sklad kvapalnych hnojiv DAM Senica/Agropodnik-Trnava-2000x1200.jpg', 'Sklad kvapalnych hnojiv DAM Senica', 'Agropodnik-Trnava-2000x1200.jpg', 30, true),
    ('Bytový dom Bernolákova', 'Nadstavba a rekonštrukcia', 'bytovy-dom-bernolakova', 'rodinne', '/sources/referencie/Nadstavba a rekonstrukcia bytoveho domu/Benolakova5.jpeg', 'Nadstavba a rekonstrukcia bytoveho domu', 'Benolakova5.jpeg', 31, true),
    ('Kúpalisko EVA', 'Rekonštrukcia vonkajších bazénov', 'kupalisko-eva', 'ostatne', '/sources/referencie/Rekonstrukcia vonkajsich bazenov kupaliska EVA/kupalisko-EVA-2000x1200.jpg', 'Rekonstrukcia vonkajsich bazenov kupaliska EVA', 'kupalisko-EVA-2000x1200.jpg', 32, true),
    ('Zvýšenie prestrešenia príjmového koša', 'Zvýšenie prestrešenia príjmového koša, Agropodnik a.s. Trnava', 'zvysenie-prestresenia-prijmoveho-kosa', 'priemyselne', '/sources/referencie/Zvysenie prestresenia prijmoveho kosa/HLAVNA.jpg', 'Zvysenie prestresenia prijmoveho kosa', 'HLAVNA.jpg', 33, true),
    ('Vacuumschmelze - Sklady', 'Prístavba skladu KB a haly', 'vacuumschmelze-sklady', 'priemyselne', '/sources/referencie/Pristavba skladu KB a haly/Vacuumschmelze-sklad1.jpg', 'Pristavba skladu KB a haly', 'Vacuumschmelze-sklad1.jpg', 34, true),
    ('PD Ostrov', 'Poľnohospodárske družstvo Ostrov', 'pd-ostrov', 'priemyselne', '/sources/referencie/Polnohospodarsky druzstvo Ostrov/Ostrov-PD11.jpg', 'Polnohospodarsky druzstvo Ostrov', 'Ostrov-PD11.jpg', 35, true),
    ('Bioplynová stanica RPD Zuberec', 'Výstavba bioplynovéj stanice', 'bioplynova-stanica-rpd-zuberec', 'priemyselne', '/sources/referencie/Bioplynova stanica RPD Zuberec/Bioplynova-stanica-RPD-Zuberec6.jpg', 'Bioplynova stanica RPD Zuberec', 'Bioplynova-stanica-RPD-Zuberec6.jpg', 36, true),
    ('RD s bazénom Piešťany', 'Rodinný dom s bazénom', 'rd-s-bazenom-piestany', 'rodinne', '/sources/referencie/Rodinny dom s bazenom Piestany/Rodinny-dom-Piestany.jpg', 'Rodinny dom s bazenom Piestany', 'Rodinny-dom-Piestany.jpg', 37, true),
    ('PVOD Kočín', 'Poľnohospodársky vodohospodársky objekt', 'pvod-kocin', 'priemyselne', '/sources/referencie/PVOD Kocin/PVOD-Kocin-Sterusy-2000x1200.jpg', 'PVOD Kocin', 'PVOD-Kocin-Sterusy-2000x1200.jpg', 38, true),
    ('Administratívna budova', 'Nadstavba administratívnej budovy', 'administrativna-budova', 'administrativne', '/sources/referencie/Nadstavba administrativnej budovy/Vacuumschmelze-nadstavba1.jpg', 'Nadstavba administrativnej budovy', 'Vacuumschmelze-nadstavba1.jpg', 39, true),
    ('Kotolňa Brezová', 'Rekonštrukcia kotolne na biomasu', 'kotolna-brezova', 'priemyselne', '/sources/referencie/Rekonstrukcia kotolne na biomasu/Kotolna-Brezova12.jpg', 'Rekonstrukcia kotolne na biomasu', 'Kotolna-Brezova12.jpg', 40, true),
    ('PD Ostrov - Osivová kukurica', 'Výstavba prevádzok na produkciu osivovej kukurice', 'pd-ostrov-osivova-kukurica', 'priemyselne', '/sources/referencie/Vystavba prevadzok na produkciu osivovej kukurice/PD-Ostrov-nasypny-kos-2000x1200.jpg', 'Vystavba prevadzok na produkciu osivovej kukurice', 'PD-Ostrov-nasypny-kos-2000x1200.jpg', 41, true),
    ('Bytový dom Bernolákova 2', 'Nadstavba a rekonštrukcia časť 2', 'bytovy-dom-bernolakova-2', 'rodinne', '/sources/referencie/Nadstavba a rekonstrukcia bytoveho domu 2/Bernolakova-5_3.jpg', 'Nadstavba a rekonstrukcia bytoveho domu 2', 'Bernolakova-5_3.jpg', 42, true),
    ('Oxymat Vadovce', 'Prestavba haly firmy', 'oxymat-vadovce', 'priemyselne', '/sources/referencie/Prestavba haly firmy Oxymat/Oxymat-Vadovce.png', 'Prestavba haly firmy Oxymat', 'Oxymat-Vadovce.png', 43, true),
    ('Administratívna budova Ekom', 'Nadstavba budovy Ekom', 'administrativna-budova-ekom', 'administrativne', '/sources/referencie/Nadstavba administrativnej budovy Ekom/Ekom-stavba2.jpg', 'Nadstavba administrativnej budovy Ekom', 'Ekom-stavba2.jpg', 44, true),
    ('Meroco Leopoldov', 'Priemyselný komplex', 'meroco-leopoldov', 'administrativne', '/sources/referencie/Meroco Leopoldov/Meroco5.jpg', 'Meroco Leopoldov', 'Meroco5.jpg', 45, true),
    ('Rekonštrukcia polyfunkčného objektu', 'Rekonštrukcia polyfunkčného objektu Royova Piešťany', 'rekonstrukcia-polyfunkcneho-objektu', 'administrativne', '/sources/referencie/Rekonstrukcia polyfunkcneho objektu/HLAVNA.jpg', 'Rekonstrukcia polyfunkcneho objektu', 'HLAVNA.jpg', 46, true),
    ('Kúpelný dom Irma', 'Stavebné úpravy kúpelného domu', 'kupelny-dom-irma', 'ostatne', '/sources/referencie/Kupelny dom Irma stavebne upravy/Irma1.jpeg', 'Kupelny dom Irma stavebne upravy', 'Irma1.jpeg', 47, true),
    ('Kúpele Piešťany a.s.', 'Slovenské liečebné kúpele', 'kupele-piestany-as', 'administrativne', '/sources/referencie/Slovenske liecebne kupele Piestany, a.s./Riaditelstvo-kupelov6 (1).jpeg', 'Slovenske liecebne kupele Piestany, a.s.', 'Riaditelstvo-kupelov6 (1).jpeg', 48, true),
    ('Balnea Palace', 'Rekonštrukcia kúpelného hotela', 'balnea-palace', 'ostatne', '/sources/referencie/Rekonstrukcia kupelneho hotela/Balnea-Palace5.jpeg', 'Rekonstrukcia kupelneho hotela', 'Balnea-Palace5.jpeg', 49, true),
    ('RD Piešťany', 'Výstavba rodinného domu', 'rd-piestany', 'rodinne', '/sources/referencie/Vystavba rodinneho domu Piestany/dom-Piestany4.png', 'Vystavba rodinneho domu Piestany', 'dom-Piestany4.png', 50, true),
    ('Cafe Mon Bijou', 'Rekonštrukcia budovy', 'cafe-mon-bijou', 'ostatne', '/sources/referencie/Cafe Mon Bijou rekonstrukcia budovy/IMG_6556.jpg', 'Cafe Mon Bijou rekonstrukcia budovy', 'IMG_6556.jpg', 51, true),
    ('Gymnázium', 'Prístavba tried a výstavba telocvične', 'gymnazium', 'ostatne', '/sources/referencie/Pristavba tried a vystavba telocvicne Gymnazia/Gymnazium-pristavba.jpeg', 'Pristavba tried a vystavba telocvicne Gymnazia', 'Gymnazium-pristavba.jpeg', 52, true)
) as seed(title, description, slug, category, cover_image_url, legacy_folder, legacy_first_image, sort_order, is_published)
where sites.slug = 'raving'
on conflict (slug) do update set
  site_id = excluded.site_id,
  title = excluded.title,
  description = excluded.description,
  category = excluded.category,
  cover_image_url = excluded.cover_image_url,
  legacy_folder = excluded.legacy_folder,
  legacy_first_image = excluded.legacy_first_image,
  sort_order = excluded.sort_order,
  is_published = excluded.is_published;

insert into storage.buckets (id, name, public)
values ('site-uploads', 'site-uploads', true)
on conflict (id) do update set public = true;

drop policy if exists "Public can read site uploads" on storage.objects;
create policy "Public can read site uploads"
on storage.objects
for select
to anon, authenticated
using (bucket_id = 'site-uploads');

drop policy if exists "Raving editors can upload project media" on storage.objects;
create policy "Raving editors can upload project media"
on storage.objects
for insert
to authenticated
with check (
  bucket_id = 'site-uploads'
  and name like 'raving/projects/%'
  and lower(coalesce(auth.jwt() ->> 'email', '')) in ('petras@raving.sk', 'alexander.hidveghy@gmail.com')
);

drop policy if exists "Raving editors can update project media" on storage.objects;
create policy "Raving editors can update project media"
on storage.objects
for update
to authenticated
using (
  bucket_id = 'site-uploads'
  and name like 'raving/projects/%'
  and lower(coalesce(auth.jwt() ->> 'email', '')) in ('petras@raving.sk', 'alexander.hidveghy@gmail.com')
)
with check (
  bucket_id = 'site-uploads'
  and name like 'raving/projects/%'
  and lower(coalesce(auth.jwt() ->> 'email', '')) in ('petras@raving.sk', 'alexander.hidveghy@gmail.com')
);

drop policy if exists "Raving editors can delete project media" on storage.objects;
create policy "Raving editors can delete project media"
on storage.objects
for delete
to authenticated
using (
  bucket_id = 'site-uploads'
  and name like 'raving/projects/%'
  and lower(coalesce(auth.jwt() ->> 'email', '')) in ('petras@raving.sk', 'alexander.hidveghy@gmail.com')
);
