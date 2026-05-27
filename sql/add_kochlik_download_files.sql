alter table public.kochlik_products
  add column if not exists download_files jsonb not null default '[]'::jsonb;

do $$
begin
  if not exists (
    select 1
    from pg_constraint
    where conname = 'kochlik_products_download_files_array'
      and conrelid = 'public.kochlik_products'::regclass
  ) then
    alter table public.kochlik_products
      add constraint kochlik_products_download_files_array
      check (jsonb_typeof(download_files) = 'array');
  end if;
end $$;
