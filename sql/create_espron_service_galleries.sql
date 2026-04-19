-- Service realizácie (gallery) for the Espron site.
-- Each row is one photo (or video poster) attached to a service slug
-- like "zateplenie-fasady", "cistenie-fasady", "interierovy-dizajn", etc.
-- The frontend renders a Realizácie + lightbox section when at least
-- one published row exists for that slug, and hides the section otherwise.
--
-- Run this in the Supabase SQL Editor of the aeb_cms project
-- (project ref: ngifengeshwvyzhqvprn).

create table if not exists public.espron_service_galleries (
  id uuid primary key default gen_random_uuid(),
  service_slug text not null,
  site text not null default 'sk',          -- 'sk' or 'cz'
  image_url text not null,                   -- public URL (storage or remote)
  alt text not null default '',
  caption text not null default '',
  kind text not null default 'image',        -- 'image' | 'video'
  sort_order integer not null default 0,
  is_published boolean not null default true,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create index if not exists espron_service_galleries_slug_idx
  on public.espron_service_galleries (site, service_slug, sort_order);

alter table public.espron_service_galleries enable row level security;

drop policy if exists "espron_service_galleries read" on public.espron_service_galleries;
create policy "espron_service_galleries read"
  on public.espron_service_galleries for select
  to authenticated, anon
  using (true);

drop policy if exists "espron_service_galleries write" on public.espron_service_galleries;
create policy "espron_service_galleries write"
  on public.espron_service_galleries for all
  to authenticated
  using (true)
  with check (true);

create or replace function public.espron_service_galleries_set_updated_at()
returns trigger language plpgsql as $$
begin
  new.updated_at := now();
  return new;
end;
$$;

drop trigger if exists espron_service_galleries_updated_at on public.espron_service_galleries;
create trigger espron_service_galleries_updated_at
  before update on public.espron_service_galleries
  for each row execute function public.espron_service_galleries_set_updated_at();
