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
