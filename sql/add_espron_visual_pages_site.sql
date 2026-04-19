-- Adds SK/CZ targeting to drag-and-drop builder pages.
-- Run this in the Supabase SQL Editor after create_espron_visual_pages.sql
-- if the table already exists without the site column.

alter table public.espron_visual_pages
  add column if not exists site text not null default 'sk';

alter table public.espron_visual_pages
  drop constraint if exists espron_visual_pages_slug_key;

do $$
begin
  if not exists (
    select 1
    from pg_constraint
    where conname = 'espron_visual_pages_site_check'
      and conrelid = 'public.espron_visual_pages'::regclass
  ) then
    alter table public.espron_visual_pages
      add constraint espron_visual_pages_site_check
      check (site in ('sk', 'cz'));
  end if;
end $$;

create unique index if not exists espron_visual_pages_site_slug_idx
  on public.espron_visual_pages (site, slug);

create index if not exists espron_visual_pages_site_updated_idx
  on public.espron_visual_pages (site, updated_at desc);
