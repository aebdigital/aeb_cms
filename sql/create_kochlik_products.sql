-- Kochlik product CMS.
-- Run this in the Supabase SQL Editor for project ngifengeshwvyzhqvprn.

create extension if not exists pgcrypto;

create table if not exists public.kochlik_categories (
  id uuid primary key default gen_random_uuid(),
  owner_id uuid not null references auth.users(id) on delete cascade,
  name text not null,
  slug text not null,
  description text,
  sort_order integer not null default 0,
  is_active boolean not null default true,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique (owner_id, slug)
);

create table if not exists public.kochlik_products (
  id uuid primary key default gen_random_uuid(),
  owner_id uuid not null references auth.users(id) on delete cascade,
  category_id uuid references public.kochlik_categories(id) on delete set null,
  name text not null,
  slug text not null,
  sku text,
  brand text,
  price_text text,
  price_cents integer check (price_cents is null or price_cents >= 0),
  currency text not null default 'EUR',
  short_description text,
  description text,
  main_image_url text,
  gallery_images text[] not null default '{}',
  color_options jsonb not null default '[]'::jsonb,
  color_families text[] not null default '{}',
  dimensions text[] not null default '{}',
  dimension_groups text[] not null default '{}',
  variations jsonb not null default '[]'::jsonb,
  specifications jsonb not null default '[]'::jsonb,
  download_files jsonb not null default '[]'::jsonb,
  supplier_url text,
  source_url text,
  is_featured boolean not null default false,
  is_active boolean not null default true,
  sort_order integer not null default 0,
  seo_title text,
  seo_description text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique (owner_id, slug),
  constraint kochlik_products_color_options_array check (jsonb_typeof(color_options) = 'array'),
  constraint kochlik_products_variations_array check (jsonb_typeof(variations) = 'array'),
  constraint kochlik_products_specifications_array check (jsonb_typeof(specifications) = 'array'),
  constraint kochlik_products_download_files_array check (jsonb_typeof(download_files) = 'array')
);

create index if not exists kochlik_categories_owner_active_idx
  on public.kochlik_categories (owner_id, is_active, sort_order, name);

create index if not exists kochlik_products_owner_active_idx
  on public.kochlik_products (owner_id, is_active, sort_order, updated_at desc);

create index if not exists kochlik_products_category_idx
  on public.kochlik_products (category_id);

create or replace function public.kochlik_set_updated_at()
returns trigger
language plpgsql
as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

drop trigger if exists kochlik_categories_updated_at on public.kochlik_categories;
create trigger kochlik_categories_updated_at
  before update on public.kochlik_categories
  for each row execute function public.kochlik_set_updated_at();

drop trigger if exists kochlik_products_updated_at on public.kochlik_products;
create trigger kochlik_products_updated_at
  before update on public.kochlik_products
  for each row execute function public.kochlik_set_updated_at();

alter table public.kochlik_categories enable row level security;
alter table public.kochlik_products enable row level security;

drop policy if exists "Kochlik owner can manage categories" on public.kochlik_categories;
create policy "Kochlik owner can manage categories"
on public.kochlik_categories
for all
to authenticated
using (
  owner_id = auth.uid()
  or exists (
    select 1 from public.profiles
    where profiles.id = auth.uid()
      and profiles.is_super_admin = true
  )
)
with check (
  owner_id = auth.uid()
  or exists (
    select 1 from public.profiles
    where profiles.id = auth.uid()
      and profiles.is_super_admin = true
  )
);

drop policy if exists "Public can view active Kochlik categories" on public.kochlik_categories;
create policy "Public can view active Kochlik categories"
on public.kochlik_categories
for select
to anon
using (
  owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid
  and is_active = true
);

drop policy if exists "Kochlik owner can manage products" on public.kochlik_products;
create policy "Kochlik owner can manage products"
on public.kochlik_products
for all
to authenticated
using (
  owner_id = auth.uid()
  or exists (
    select 1 from public.profiles
    where profiles.id = auth.uid()
      and profiles.is_super_admin = true
  )
)
with check (
  owner_id = auth.uid()
  or exists (
    select 1 from public.profiles
    where profiles.id = auth.uid()
      and profiles.is_super_admin = true
  )
);

drop policy if exists "Public can view active Kochlik products" on public.kochlik_products;
create policy "Public can view active Kochlik products"
on public.kochlik_products
for select
to anon
using (
  owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid
  and is_active = true
);

insert into public.kochlik_categories
  (owner_id, name, slug, description, sort_order, is_active)
values
  ('c28707c3-2289-48b9-bbd3-08a441fd02fc', 'Dizajnové kvetináče', 'dizajnove', 'Dizajnové kvetináče a výrazné talianske solitéry.', 10, true),
  ('c28707c3-2289-48b9-bbd3-08a441fd02fc', 'Moderné kvetináče', 'moderne-kvetinace', 'Moderné kvetináče pre interiér, exteriér a reprezentatívne priestory.', 20, true),
  ('c28707c3-2289-48b9-bbd3-08a441fd02fc', 'Klasické kvetináče', 'klasicke-kvetinace', 'Klasické a nadčasové tvary pre záhrady a terasy.', 30, true),
  ('c28707c3-2289-48b9-bbd3-08a441fd02fc', 'Svietiace kvetináče', 'svietiace-kvetinace', 'Svietiace kvetináče a svetelné varianty.', 40, true),
  ('c28707c3-2289-48b9-bbd3-08a441fd02fc', 'Nábytok', 'nabytok', 'Exteriérový a interiérový dizajnový nábytok.', 50, true),
  ('c28707c3-2289-48b9-bbd3-08a441fd02fc', 'Doplnky', 'doplnky', 'Doplnky pre záhrady, terasy a interiéry.', 60, true)
on conflict (owner_id, slug) do update set
  name = excluded.name,
  description = excluded.description,
  sort_order = excluded.sort_order,
  is_active = excluded.is_active;

insert into public.sites
  (name, slug, domain, owner_id, settings, lang)
values
  ('Kochlik', 'kochlik', 'kochlik.sk', 'c28707c3-2289-48b9-bbd3-08a441fd02fc', '{}'::jsonb, 'sk')
on conflict (slug) do update set
  name = excluded.name,
  domain = excluded.domain,
  owner_id = excluded.owner_id,
  lang = excluded.lang;

insert into public.site_memberships
  (site_id, user_id, role)
select sites.id, 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid, 'admin'
from public.sites
where sites.slug = 'kochlik'
on conflict do nothing;

insert into public.pages
  (site_id, slug, title, is_public, show_in_nav, nav_label, nav_order, status)
select sites.id, page_data.slug, page_data.title, true, false, page_data.nav_label, page_data.nav_order, 'published'
from public.sites
cross join (
  values
    ('kochlik-produkty', 'Kochlik produkty', 'Produkty', 10),
    ('kochlik-kategorie', 'Kochlik kategórie', 'Kategórie', 20)
) as page_data(slug, title, nav_label, nav_order)
where sites.slug = 'kochlik'
  and not exists (
    select 1
    from public.pages
    where pages.site_id = sites.id
      and pages.slug = page_data.slug
  );

update public.pages
set show_in_nav = false
where slug in ('kochlik-produkty', 'kochlik-kategorie')
  and site_id = (
    select id from public.sites where slug = 'kochlik' limit 1
  );

insert into public.profiles
  (id, full_name, lang)
values
  ('c28707c3-2289-48b9-bbd3-08a441fd02fc', 'Kochlik', 'sk')
on conflict (id) do update set
  full_name = coalesce(public.profiles.full_name, excluded.full_name),
  lang = excluded.lang;
