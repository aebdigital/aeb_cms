-- Creates the table used by the drag-and-drop builder in aeb_cms.
-- Run this in the Supabase SQL Editor of the aeb_cms project
-- (project ref: ngifengeshwvyzhqvprn).

create table if not exists public.espron_visual_pages (
  id uuid primary key default gen_random_uuid(),
  site text not null default 'sk' check (site in ('sk', 'cz')),
  slug text not null,
  title text not null default 'Nová stránka',
  elements jsonb not null default '[]'::jsonb,
  is_published boolean not null default false,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique (site, slug)
);

alter table public.espron_visual_pages enable row level security;

drop policy if exists "espron_visual_pages read" on public.espron_visual_pages;
create policy "espron_visual_pages read"
  on public.espron_visual_pages for select
  to authenticated, anon
  using (true);

drop policy if exists "espron_visual_pages write" on public.espron_visual_pages;
create policy "espron_visual_pages write"
  on public.espron_visual_pages for all
  to authenticated
  using (true)
  with check (true);

create or replace function public.espron_visual_pages_set_updated_at()
returns trigger language plpgsql as $$
begin
  new.updated_at := now();
  return new;
end;
$$;

drop trigger if exists espron_visual_pages_updated_at on public.espron_visual_pages;
create trigger espron_visual_pages_updated_at
  before update on public.espron_visual_pages
  for each row execute function public.espron_visual_pages_set_updated_at();
