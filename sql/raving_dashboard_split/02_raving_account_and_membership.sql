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
