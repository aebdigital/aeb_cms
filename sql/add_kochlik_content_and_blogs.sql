-- Kochlik homepage banners and blog CMS.
-- Run this in the Supabase SQL Editor for project ngifengeshwvyzhqvprn.

create extension if not exists pgcrypto;

create or replace function public.kochlik_set_updated_at()
returns trigger
language plpgsql
as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

create table if not exists public.kochlik_home_banners (
  id uuid primary key default gen_random_uuid(),
  owner_id uuid not null references auth.users(id) on delete cascade,
  title text not null,
  text text,
  image_url text,
  href text not null default '/produkt-kategoria/dizajnove',
  button_label text not null default 'Pozrieť',
  sort_order integer not null default 0,
  is_active boolean not null default true,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.kochlik_blog_posts (
  id uuid primary key default gen_random_uuid(),
  owner_id uuid not null references auth.users(id) on delete cascade,
  slug text not null,
  title text not null,
  excerpt text,
  category text not null default 'Blog',
  reading_time text not null default '5 min',
  cover_image text,
  content_html text not null default '',
  seo_title text,
  seo_description text,
  is_published boolean not null default false,
  published_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique (owner_id, slug)
);

create index if not exists kochlik_home_banners_owner_active_idx
  on public.kochlik_home_banners (owner_id, is_active, sort_order, updated_at desc);

create index if not exists kochlik_blog_posts_owner_publish_idx
  on public.kochlik_blog_posts (owner_id, is_published, published_at desc, updated_at desc);

drop trigger if exists kochlik_home_banners_updated_at on public.kochlik_home_banners;
create trigger kochlik_home_banners_updated_at
  before update on public.kochlik_home_banners
  for each row execute function public.kochlik_set_updated_at();

drop trigger if exists kochlik_blog_posts_updated_at on public.kochlik_blog_posts;
create trigger kochlik_blog_posts_updated_at
  before update on public.kochlik_blog_posts
  for each row execute function public.kochlik_set_updated_at();

alter table public.kochlik_home_banners enable row level security;
alter table public.kochlik_blog_posts enable row level security;

drop policy if exists "Kochlik owner can manage home banners" on public.kochlik_home_banners;
create policy "Kochlik owner can manage home banners"
on public.kochlik_home_banners
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

drop policy if exists "Public can view active Kochlik home banners" on public.kochlik_home_banners;
create policy "Public can view active Kochlik home banners"
on public.kochlik_home_banners
for select
to anon
using (
  owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid
  and is_active = true
);

drop policy if exists "Kochlik owner can manage blog posts" on public.kochlik_blog_posts;
create policy "Kochlik owner can manage blog posts"
on public.kochlik_blog_posts
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

drop policy if exists "Public can view published Kochlik blog posts" on public.kochlik_blog_posts;
create policy "Public can view published Kochlik blog posts"
on public.kochlik_blog_posts
for select
to anon
using (
  owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid
  and is_published = true
);

insert into public.kochlik_home_banners
  (owner_id, title, text, image_url, href, button_label, sort_order, is_active)
select *
from (
  values
    (
      'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
      'Dizajnové kvetináče',
      'Vášmu domovu, záhrade alebo firme dodajú osobitný charakter a ich nezvyčajné tvary pôsobia výnimočne a v každom návštevníkovi zanechajú silný dojem.',
      '/legacy/pot1.jpg',
      '/produkt-kategoria/dizajnove',
      'Pozrieť',
      10,
      true
    ),
    (
      'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
      'Moderné kvetináče',
      'Vášmu domovu, záhrade alebo firme dodajú osobitný charakter a ich nezvyčajné tvary pôsobia výnimočne a v každom návštevníkovi zanechajú silný dojem.',
      '/legacy/pot22.jpg',
      '/produkt-kategoria/moderne-kvetinace',
      'Pozrieť',
      20,
      true
    ),
    (
      'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid,
      'Klasické kvetináče',
      'Vášmu domovu, záhrade alebo firme dodajú osobitný charakter a ich nezvyčajné tvary pôsobia výnimočne a v každom návštevníkovi zanechajú silný dojem.',
      '/legacy/pot32.jpg',
      '/produkt-kategoria/klasicke-kvetinace',
      'Pozrieť',
      30,
      true
    )
) as seed(owner_id, title, text, image_url, href, button_label, sort_order, is_active)
where not exists (
  select 1
  from public.kochlik_home_banners
  where owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid
);

insert into public.pages
  (site_id, slug, title, is_public, show_in_nav, nav_label, nav_order, status)
select sites.id, page_data.slug, page_data.title, true, false, page_data.nav_label, page_data.nav_order, 'published'
from public.sites
cross join (
  values
    ('kochlik-obsah', 'Kochlik obsah', 'Obsah', 30),
    ('kochlik-blog', 'Kochlik blog', 'Blog', 40)
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
where slug in ('kochlik-obsah', 'kochlik-blog')
  and site_id = (
    select id from public.sites where slug = 'kochlik' limit 1
  );
