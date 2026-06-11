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
