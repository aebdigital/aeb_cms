-- Creates the blog posts table used by the espron blog builder in aeb_cms.
-- Run this in the Supabase SQL Editor of the aeb_cms project
-- (project ref: ngifengeshwvyzhqvprn).

create table if not exists public.espron_blog_posts (
  id uuid primary key default gen_random_uuid(),
  slug text unique not null,
  title text not null default 'Nový článok',
  excerpt text not null default '',
  category text not null default 'Blog',
  reading_time text not null default '5 min',
  cover_image text,
  content_html text not null default '<p><br></p>',
  is_published boolean not null default false,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

alter table public.espron_blog_posts enable row level security;

drop policy if exists "espron_blog_posts read" on public.espron_blog_posts;
create policy "espron_blog_posts read"
  on public.espron_blog_posts for select
  to authenticated, anon
  using (true);

drop policy if exists "espron_blog_posts write" on public.espron_blog_posts;
create policy "espron_blog_posts write"
  on public.espron_blog_posts for all
  to authenticated
  using (true)
  with check (true);

create or replace function public.espron_blog_posts_set_updated_at()
returns trigger language plpgsql as $$
begin
  new.updated_at := now();
  return new;
end;
$$;

drop trigger if exists espron_blog_posts_updated_at on public.espron_blog_posts;
create trigger espron_blog_posts_updated_at
  before update on public.espron_blog_posts
  for each row execute function public.espron_blog_posts_set_updated_at();
