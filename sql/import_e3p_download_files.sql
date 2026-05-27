-- Import Euro3plast PDF download files into Kochlik CMS.
-- Safe to run after add_kochlik_download_files.sql.
-- Only fills products whose download_files array is currently empty.
-- Source: data/e3p_downloads_supabase.json

BEGIN;

update public.kochlik_products
set download_files = '[{"label":"Technický dokument","url":"https://ngifengeshwvyzhqvprn.supabase.co/storage/v1/object/public/site-uploads/kochlik/products/d6a6289c-1331-4179-ae43-6726103969fd/downloads/balustrada-1-balaustra-balaustra.pdf"},{"label":"Informačný dokument","url":"https://ngifengeshwvyzhqvprn.supabase.co/storage/v1/object/public/site-uploads/kochlik/products/d6a6289c-1331-4179-ae43-6726103969fd/downloads/balustrada-2-balaustra-balustrade-info-en.pdf"}]'::jsonb,
    updated_at = now()
where owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid
  and slug = 'balustrada'
  and jsonb_array_length(download_files) = 0;

update public.kochlik_products
set download_files = '[{"label":"Technický dokument","url":"https://ngifengeshwvyzhqvprn.supabase.co/storage/v1/object/public/site-uploads/kochlik/products/ee5f700e-20d4-433b-a23a-4fa35bca73cc/downloads/busta-francuzska-zena-1-donna-francese-busto.pdf"},{"label":"Informačný dokument","url":"https://ngifengeshwvyzhqvprn.supabase.co/storage/v1/object/public/site-uploads/kochlik/products/ee5f700e-20d4-433b-a23a-4fa35bca73cc/downloads/busta-francuzska-zena-2-donna-francese-bust-info-en.pdf"}]'::jsonb,
    updated_at = now()
where owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid
  and slug = 'busta-francuzska-zena'
  and jsonb_array_length(download_files) = 0;

update public.kochlik_products
set download_files = '[{"label":"Technický dokument","url":"https://ngifengeshwvyzhqvprn.supabase.co/storage/v1/object/public/site-uploads/kochlik/products/7b9376bc-b01c-438d-9efa-9f2f9093aa30/downloads/etria-1-etria-vaso-con-doppia-parete.pdf"},{"label":"Informačný dokument","url":"https://ngifengeshwvyzhqvprn.supabase.co/storage/v1/object/public/site-uploads/kochlik/products/7b9376bc-b01c-438d-9efa-9f2f9093aa30/downloads/etria-2-etria-pot-with-double-wall-info-en.pdf"}]'::jsonb,
    updated_at = now()
where owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid
  and slug = 'etria'
  and jsonb_array_length(download_files) = 0;

update public.kochlik_products
set download_files = '[{"label":"Technický dokument","url":"https://ngifengeshwvyzhqvprn.supabase.co/storage/v1/object/public/site-uploads/kochlik/products/a967aaee-d0f5-491b-b5e9-d443a6ec65be/downloads/etria-uno-1-etria-uno-vaso.pdf"},{"label":"Informačný dokument","url":"https://ngifengeshwvyzhqvprn.supabase.co/storage/v1/object/public/site-uploads/kochlik/products/a967aaee-d0f5-491b-b5e9-d443a6ec65be/downloads/etria-uno-2-etria-uno-pot-info-en.pdf"}]'::jsonb,
    updated_at = now()
where owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid
  and slug = 'etria-uno'
  and jsonb_array_length(download_files) = 0;

update public.kochlik_products
set download_files = '[{"label":"Technický dokument","url":"https://ngifengeshwvyzhqvprn.supabase.co/storage/v1/object/public/site-uploads/kochlik/products/2b36a6f5-cf19-4519-8656-c5ac9c8ec757/downloads/festonato-1-festonato-vaso.pdf"},{"label":"Informačný dokument","url":"https://ngifengeshwvyzhqvprn.supabase.co/storage/v1/object/public/site-uploads/kochlik/products/2b36a6f5-cf19-4519-8656-c5ac9c8ec757/downloads/festonato-2-festonato-pot-info-en.pdf"}]'::jsonb,
    updated_at = now()
where owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid
  and slug = 'festonato'
  and jsonb_array_length(download_files) = 0;

update public.kochlik_products
set download_files = '[{"label":"Technický dokument","url":"https://ngifengeshwvyzhqvprn.supabase.co/storage/v1/object/public/site-uploads/kochlik/products/9f4c1d54-7ca6-42c6-a049-af9e76416df0/downloads/fontana-musla-conchiglia-1-conchiglia-fontana.pdf"},{"label":"Informačný dokument","url":"https://ngifengeshwvyzhqvprn.supabase.co/storage/v1/object/public/site-uploads/kochlik/products/9f4c1d54-7ca6-42c6-a049-af9e76416df0/downloads/fontana-musla-conchiglia-2-conchiglia-fountain-info-en.pdf"}]'::jsonb,
    updated_at = now()
where owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid
  and slug = 'fontana-musla-conchiglia'
  and jsonb_array_length(download_files) = 0;

update public.kochlik_products
set download_files = '[{"label":"Technický dokument","url":"https://ngifengeshwvyzhqvprn.supabase.co/storage/v1/object/public/site-uploads/kochlik/products/272573a8-3f77-45a8-b20c-333c27d5d672/downloads/fontana-neptun-1-nettuno-fontana.pdf"},{"label":"Informačný dokument","url":"https://ngifengeshwvyzhqvprn.supabase.co/storage/v1/object/public/site-uploads/kochlik/products/272573a8-3f77-45a8-b20c-333c27d5d672/downloads/fontana-neptun-2-nettuno-fountain-info-en.pdf"}]'::jsonb,
    updated_at = now()
where owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid
  and slug = 'fontana-neptun'
  and jsonb_array_length(download_files) = 0;

update public.kochlik_products
set download_files = '[{"label":"Technický dokument","url":"https://ngifengeshwvyzhqvprn.supabase.co/storage/v1/object/public/site-uploads/kochlik/products/9275b365-1165-4d47-8f7c-794a331748dc/downloads/gula-atmosfera-so-svetlom-1-sfera-lampada.pdf"},{"label":"Informačný dokument","url":"https://ngifengeshwvyzhqvprn.supabase.co/storage/v1/object/public/site-uploads/kochlik/products/9275b365-1165-4d47-8f7c-794a331748dc/downloads/gula-atmosfera-so-svetlom-2-sfera-light-info-en.pdf"}]'::jsonb,
    updated_at = now()
where owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid
  and slug = 'gula-atmosfera-so-svetlom'
  and jsonb_array_length(download_files) = 0;

update public.kochlik_products
set download_files = '[{"label":"Technický dokument","url":"https://ngifengeshwvyzhqvprn.supabase.co/storage/v1/object/public/site-uploads/kochlik/products/243f2c10-6b18-4ec4-a6eb-8454ee193da1/downloads/hrantik-akan-1-akan-vaso-quadro-con-doppia-parete.pdf"},{"label":"Informačný dokument","url":"https://ngifengeshwvyzhqvprn.supabase.co/storage/v1/object/public/site-uploads/kochlik/products/243f2c10-6b18-4ec4-a6eb-8454ee193da1/downloads/hrantik-akan-2-akan-square-pot-with-double-wall-info-en.pdf"}]'::jsonb,
    updated_at = now()
where owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid
  and slug = 'hrantik-akan'
  and jsonb_array_length(download_files) = 0;

update public.kochlik_products
set download_files = '[{"label":"Technický dokument","url":"https://ngifengeshwvyzhqvprn.supabase.co/storage/v1/object/public/site-uploads/kochlik/products/ed6091e4-2f32-4793-91ec-5e2702a8164d/downloads/hrantik-akan-2-1-akan-cassetta-con-doppia-parete.pdf"},{"label":"Informačný dokument","url":"https://ngifengeshwvyzhqvprn.supabase.co/storage/v1/object/public/site-uploads/kochlik/products/ed6091e4-2f32-4793-91ec-5e2702a8164d/downloads/hrantik-akan-2-2-akan-plant-box-with-double-wall-info-en.pdf"}]'::jsonb,
    updated_at = now()
where owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid
  and slug = 'hrantik-akan-2'
  and jsonb_array_length(download_files) = 0;

update public.kochlik_products
set download_files = '[{"label":"Technický dokument","url":"https://ngifengeshwvyzhqvprn.supabase.co/storage/v1/object/public/site-uploads/kochlik/products/94111f39-678c-47bc-92cf-39f306f6a5b9/downloads/hrantik-hladky-balaustra-liscia-1-balaustra-liscia-cassetta.pdf"},{"label":"Informačný dokument","url":"https://ngifengeshwvyzhqvprn.supabase.co/storage/v1/object/public/site-uploads/kochlik/products/94111f39-678c-47bc-92cf-39f306f6a5b9/downloads/hrantik-hladky-balaustra-liscia-2-balaustra-liscia-plant-box-info-en.pdf"}]'::jsonb,
    updated_at = now()
where owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid
  and slug = 'hrantik-hladky-balaustra-liscia'
  and jsonb_array_length(download_files) = 0;

update public.kochlik_products
set download_files = '[{"label":"Technický dokument","url":"https://ngifengeshwvyzhqvprn.supabase.co/storage/v1/object/public/site-uploads/kochlik/products/615c2e63-acda-4b17-9354-5a5282d22b61/downloads/hrantik-kube-1-kube-cassetta-con-doppia-parete.pdf"},{"label":"Informačný dokument","url":"https://ngifengeshwvyzhqvprn.supabase.co/storage/v1/object/public/site-uploads/kochlik/products/615c2e63-acda-4b17-9354-5a5282d22b61/downloads/hrantik-kube-2-kube-plant-box-with-double-wall-info-en.pdf"}]'::jsonb,
    updated_at = now()
where owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid
  and slug = 'hrantik-kube'
  and jsonb_array_length(download_files) = 0;

update public.kochlik_products
set download_files = '[{"label":"Technický dokument","url":"https://ngifengeshwvyzhqvprn.supabase.co/storage/v1/object/public/site-uploads/kochlik/products/56fd0ed3-8036-4e83-a185-6df8f6834d41/downloads/hrantik-kube-s-kolieskami-1-kube-cassetta-con-doppia-parete-ruote.pdf"},{"label":"Informačný dokument","url":"https://ngifengeshwvyzhqvprn.supabase.co/storage/v1/object/public/site-uploads/kochlik/products/56fd0ed3-8036-4e83-a185-6df8f6834d41/downloads/hrantik-kube-s-kolieskami-2-kube-plant-box-with-double-wall-castors-info-en.pdf"}]'::jsonb,
    updated_at = now()
where owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid
  and slug = 'hrantik-kube-s-kolieskami'
  and jsonb_array_length(download_files) = 0;

update public.kochlik_products
set download_files = '[{"label":"Technický dokument","url":"https://ngifengeshwvyzhqvprn.supabase.co/storage/v1/object/public/site-uploads/kochlik/products/0a2609df-8d5b-4d72-96ec-16622f6f4c01/downloads/hrantik-siepi-hladky-1-siepi-cassetta.pdf"},{"label":"Informačný dokument","url":"https://ngifengeshwvyzhqvprn.supabase.co/storage/v1/object/public/site-uploads/kochlik/products/0a2609df-8d5b-4d72-96ec-16622f6f4c01/downloads/hrantik-siepi-hladky-2-siepi-plant-box-info-en.pdf"}]'::jsonb,
    updated_at = now()
where owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid
  and slug = 'hrantik-siepi-hladky'
  and jsonb_array_length(download_files) = 0;

update public.kochlik_products
set download_files = '[{"label":"Technický dokument","url":"https://ngifengeshwvyzhqvprn.supabase.co/storage/v1/object/public/site-uploads/kochlik/products/4b8e9147-53a4-4bdd-817a-b31506f06c96/downloads/hrantik-siepi-s-dvojitou-stenou-1-siepi-cassetta-con-doppia-parete.pdf"},{"label":"Informačný dokument","url":"https://ngifengeshwvyzhqvprn.supabase.co/storage/v1/object/public/site-uploads/kochlik/products/4b8e9147-53a4-4bdd-817a-b31506f06c96/downloads/hrantik-siepi-s-dvojitou-stenou-2-siepi-plant-box-with-double-wall-info-en.pdf"}]'::jsonb,
    updated_at = now()
where owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid
  and slug = 'hrantik-siepi-s-dvojitou-stenou'
  and jsonb_array_length(download_files) = 0;

update public.kochlik_products
set download_files = '[{"label":"Technický dokument","url":"https://ngifengeshwvyzhqvprn.supabase.co/storage/v1/object/public/site-uploads/kochlik/products/4bcc9d60-40eb-46f3-98c5-3ed5cf0d458b/downloads/hrantik-toskansky-s-dvojitou-stenou-1-toscana-cassetta-con-doppia-parete.pdf"},{"label":"Informačný dokument","url":"https://ngifengeshwvyzhqvprn.supabase.co/storage/v1/object/public/site-uploads/kochlik/products/4bcc9d60-40eb-46f3-98c5-3ed5cf0d458b/downloads/hrantik-toskansky-s-dvojitou-stenou-2-toscana-plant-box-with-double-wall-info-en.pdf"}]'::jsonb,
    updated_at = now()
where owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid
  and slug = 'hrantik-toskansky-s-dvojitou-stenou'
  and jsonb_array_length(download_files) = 0;

update public.kochlik_products
set download_files = '[{"label":"Technický dokument","url":"https://ngifengeshwvyzhqvprn.supabase.co/storage/v1/object/public/site-uploads/kochlik/products/593ad66d-e56b-4ed9-be20-8e0890820ff9/downloads/hrantik-vysoky-kube-1-kube-high-vaso-con-doppia-parete-ruote.pdf"},{"label":"Informačný dokument","url":"https://ngifengeshwvyzhqvprn.supabase.co/storage/v1/object/public/site-uploads/kochlik/products/593ad66d-e56b-4ed9-be20-8e0890820ff9/downloads/hrantik-vysoky-kube-2-kube-high-pot-with-double-wall-castors-info-en.pdf"}]'::jsonb,
    updated_at = now()
where owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid
  and slug = 'hrantik-vysoky-kube'
  and jsonb_array_length(download_files) = 0;

update public.kochlik_products
set download_files = '[{"label":"Technický dokument","url":"https://ngifengeshwvyzhqvprn.supabase.co/storage/v1/object/public/site-uploads/kochlik/products/4209f0e6-8f57-495f-a56f-ed17c3fcfa1d/downloads/hrantik-vysoky-kube-s-kolieskami-1-kube-high-cassetta-con-doppia-parete-ruote.pdf"},{"label":"Informačný dokument","url":"https://ngifengeshwvyzhqvprn.supabase.co/storage/v1/object/public/site-uploads/kochlik/products/4209f0e6-8f57-495f-a56f-ed17c3fcfa1d/downloads/hrantik-vysoky-kube-s-kolieskami-2-kube-high-plant-box-with-double-wall-castors-info-en.pdf"}]'::jsonb,
    updated_at = now()
where owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid
  and slug = 'hrantik-vysoky-kube-s-kolieskami'
  and jsonb_array_length(download_files) = 0;

update public.kochlik_products
set download_files = '[{"label":"Technický dokument","url":"https://ngifengeshwvyzhqvprn.supabase.co/storage/v1/object/public/site-uploads/kochlik/products/42a88d8f-7efd-4e66-bd31-d0c9731149dc/downloads/ikon-pot-1-ikon-vaso.pdf"},{"label":"Informačný dokument","url":"https://ngifengeshwvyzhqvprn.supabase.co/storage/v1/object/public/site-uploads/kochlik/products/42a88d8f-7efd-4e66-bd31-d0c9731149dc/downloads/ikon-pot-2-ikon-pot-info-en.pdf"}]'::jsonb,
    updated_at = now()
where owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid
  and slug = 'ikon-pot'
  and jsonb_array_length(download_files) = 0;

update public.kochlik_products
set download_files = '[{"label":"Technický dokument","url":"https://ngifengeshwvyzhqvprn.supabase.co/storage/v1/object/public/site-uploads/kochlik/products/e6189edd-f702-4257-a7ef-9169c2f8d40e/downloads/kreslo-pasha-1-pasha-poltroncina-tavolino.pdf"},{"label":"Informačný dokument","url":"https://ngifengeshwvyzhqvprn.supabase.co/storage/v1/object/public/site-uploads/kochlik/products/e6189edd-f702-4257-a7ef-9169c2f8d40e/downloads/kreslo-pasha-2-pasha-small-armchair-small-table-info-en.pdf"}]'::jsonb,
    updated_at = now()
where owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid
  and slug = 'kreslo-pasha'
  and jsonb_array_length(download_files) = 0;

update public.kochlik_products
set download_files = '[{"label":"Technický dokument","url":"https://ngifengeshwvyzhqvprn.supabase.co/storage/v1/object/public/site-uploads/kochlik/products/041d593f-997e-4260-813b-455f99f5f64b/downloads/kube-lavicka-1-kube-panca.pdf"},{"label":"Informačný dokument","url":"https://ngifengeshwvyzhqvprn.supabase.co/storage/v1/object/public/site-uploads/kochlik/products/041d593f-997e-4260-813b-455f99f5f64b/downloads/kube-lavicka-2-kube-bench-info-en.pdf"}]'::jsonb,
    updated_at = now()
where owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid
  and slug = 'kube-lavicka'
  and jsonb_array_length(download_files) = 0;

update public.kochlik_products
set download_files = '[{"label":"Technický dokument","url":"https://ngifengeshwvyzhqvprn.supabase.co/storage/v1/object/public/site-uploads/kochlik/products/646cc996-3f65-4db1-943f-d488fb828803/downloads/kube-mini-kvetinac-stvorcovy-1-kube-aromatika-vaso-con-doppia-parete.pdf"}]'::jsonb,
    updated_at = now()
where owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid
  and slug = 'kube-mini-kvetinac-stvorcovy'
  and jsonb_array_length(download_files) = 0;

update public.kochlik_products
set download_files = '[{"label":"Technický dokument","url":"https://ngifengeshwvyzhqvprn.supabase.co/storage/v1/object/public/site-uploads/kochlik/products/b43ab5cd-b5a7-4811-86cd-a0418dee000f/downloads/kube-stolicka-1-kube-sgabello.pdf"},{"label":"Informačný dokument","url":"https://ngifengeshwvyzhqvprn.supabase.co/storage/v1/object/public/site-uploads/kochlik/products/b43ab5cd-b5a7-4811-86cd-a0418dee000f/downloads/kube-stolicka-2-kube-stool-info-en.pdf"}]'::jsonb,
    updated_at = now()
where owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid
  and slug = 'kube-stolicka'
  and jsonb_array_length(download_files) = 0;

update public.kochlik_products
set download_files = '[{"label":"Technický dokument","url":"https://ngifengeshwvyzhqvprn.supabase.co/storage/v1/object/public/site-uploads/kochlik/products/564cce08-64f6-4b81-b227-15fcb9c7aed6/downloads/kube-tower-1-kube-tower-cassetta-con-doppia-parete.pdf"},{"label":"Informačný dokument","url":"https://ngifengeshwvyzhqvprn.supabase.co/storage/v1/object/public/site-uploads/kochlik/products/564cce08-64f6-4b81-b227-15fcb9c7aed6/downloads/kube-tower-2-kube-tower-plant-box-with-double-wall-info-en.pdf"}]'::jsonb,
    updated_at = now()
where owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid
  and slug = 'kube-tower'
  and jsonb_array_length(download_files) = 0;

update public.kochlik_products
set download_files = '[{"label":"Technický dokument","url":"https://ngifengeshwvyzhqvprn.supabase.co/storage/v1/object/public/site-uploads/kochlik/products/aa916d64-39df-4eb9-8590-dbd44fd5ee2e/downloads/kube-tower-vysoky-1-kube-tower-vaso-con-doppia-parete.pdf"},{"label":"Informačný dokument","url":"https://ngifengeshwvyzhqvprn.supabase.co/storage/v1/object/public/site-uploads/kochlik/products/aa916d64-39df-4eb9-8590-dbd44fd5ee2e/downloads/kube-tower-vysoky-2-kube-tower-pot-with-double-wall-info-en.pdf"}]'::jsonb,
    updated_at = now()
where owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid
  and slug = 'kube-tower-vysoky'
  and jsonb_array_length(download_files) = 0;

update public.kochlik_products
set download_files = '[{"label":"Technický dokument","url":"https://ngifengeshwvyzhqvprn.supabase.co/storage/v1/object/public/site-uploads/kochlik/products/0ad1dda9-ad53-4dff-9d92-0c9e44c90141/downloads/kvetina-ilie-1-ilie-vaso-con-doppia-parete.pdf"},{"label":"Informačný dokument","url":"https://ngifengeshwvyzhqvprn.supabase.co/storage/v1/object/public/site-uploads/kochlik/products/0ad1dda9-ad53-4dff-9d92-0c9e44c90141/downloads/kvetina-ilie-2-ilie-pot-with-double-wall-info-en.pdf"}]'::jsonb,
    updated_at = now()
where owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid
  and slug = 'kvetina-ilie'
  and jsonb_array_length(download_files) = 0;

update public.kochlik_products
set download_files = '[{"label":"Technický dokument","url":"https://ngifengeshwvyzhqvprn.supabase.co/storage/v1/object/public/site-uploads/kochlik/products/399dd7a9-1692-4868-9b0f-3ce1753af3ae/downloads/kvetinac-anjeli-1-angeli-vaso.pdf"},{"label":"Informačný dokument","url":"https://ngifengeshwvyzhqvprn.supabase.co/storage/v1/object/public/site-uploads/kochlik/products/399dd7a9-1692-4868-9b0f-3ce1753af3ae/downloads/kvetinac-anjeli-2-angeli-pot-info-en.pdf"}]'::jsonb,
    updated_at = now()
where owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid
  and slug = 'kvetinac-anjeli'
  and jsonb_array_length(download_files) = 0;

update public.kochlik_products
set download_files = '[{"label":"Technický dokument","url":"https://ngifengeshwvyzhqvprn.supabase.co/storage/v1/object/public/site-uploads/kochlik/products/425326d1-d52e-4d4d-8065-50d4fc5ac01e/downloads/kvetinac-cilinder-1-cilindro-rot-vaso.pdf"},{"label":"Informačný dokument","url":"https://ngifengeshwvyzhqvprn.supabase.co/storage/v1/object/public/site-uploads/kochlik/products/425326d1-d52e-4d4d-8065-50d4fc5ac01e/downloads/kvetinac-cilinder-2-cilindro-rot-pot-info-en.pdf"}]'::jsonb,
    updated_at = now()
where owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid
  and slug = 'kvetinac-cilinder'
  and jsonb_array_length(download_files) = 0;

update public.kochlik_products
set download_files = '[{"label":"Technický dokument","url":"https://ngifengeshwvyzhqvprn.supabase.co/storage/v1/object/public/site-uploads/kochlik/products/ea3be5fd-3c29-4b4d-a72f-7ab8cf735ba4/downloads/kvetinac-doppio-bordo-e3p-1-doppio-bordo-vaso.pdf"},{"label":"Informačný dokument","url":"https://ngifengeshwvyzhqvprn.supabase.co/storage/v1/object/public/site-uploads/kochlik/products/ea3be5fd-3c29-4b4d-a72f-7ab8cf735ba4/downloads/kvetinac-doppio-bordo-e3p-2-doppio-bordo-pot-info-en.pdf"}]'::jsonb,
    updated_at = now()
where owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid
  and slug = 'kvetinac-doppio-bordo-e3p'
  and jsonb_array_length(download_files) = 0;

update public.kochlik_products
set download_files = '[{"label":"Technický dokument","url":"https://ngifengeshwvyzhqvprn.supabase.co/storage/v1/object/public/site-uploads/kochlik/products/2f42f957-c497-45c7-abc0-428686b9f4a1/downloads/kvetinac-ikon-mini-1-ikon-aromatika-vaso.pdf"}]'::jsonb,
    updated_at = now()
where owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid
  and slug = 'kvetinac-ikon-mini'
  and jsonb_array_length(download_files) = 0;

update public.kochlik_products
set download_files = '[{"label":"Technický dokument","url":"https://ngifengeshwvyzhqvprn.supabase.co/storage/v1/object/public/site-uploads/kochlik/products/10099bec-8442-4068-a5c3-70a077b577d6/downloads/kvetinac-ikon-xxl-1-ikon-vaso-xxl.pdf"},{"label":"Informačný dokument","url":"https://ngifengeshwvyzhqvprn.supabase.co/storage/v1/object/public/site-uploads/kochlik/products/10099bec-8442-4068-a5c3-70a077b577d6/downloads/kvetinac-ikon-xxl-2-ikon-pot-xxl-info-en.pdf"}]'::jsonb,
    updated_at = now()
where owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid
  and slug = 'kvetinac-ikon-xxl'
  and jsonb_array_length(download_files) = 0;

update public.kochlik_products
set download_files = '[{"label":"Technický dokument","url":"https://ngifengeshwvyzhqvprn.supabase.co/storage/v1/object/public/site-uploads/kochlik/products/703e09a4-49fb-4117-84ac-99ec1aa61f94/downloads/kvetinac-ikon-xxl-zatvoreny-s-dierkami-1-ikon-vaso-xxl.pdf"},{"label":"Informačný dokument","url":"https://ngifengeshwvyzhqvprn.supabase.co/storage/v1/object/public/site-uploads/kochlik/products/703e09a4-49fb-4117-84ac-99ec1aa61f94/downloads/kvetinac-ikon-xxl-zatvoreny-s-dierkami-2-ikon-pot-xxl-info-en.pdf"}]'::jsonb,
    updated_at = now()
where owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid
  and slug = 'kvetinac-ikon-xxl-zatvoreny-s-dierkami'
  and jsonb_array_length(download_files) = 0;

update public.kochlik_products
set download_files = '[{"label":"Technický dokument","url":"https://ngifengeshwvyzhqvprn.supabase.co/storage/v1/object/public/site-uploads/kochlik/products/45b053d8-b0a9-401a-91ef-ffd20bfd5d2a/downloads/kvetinac-ilie-gloss-1-ilie-vaso-gloss-con-doppia-parete.pdf"},{"label":"Informačný dokument","url":"https://ngifengeshwvyzhqvprn.supabase.co/storage/v1/object/public/site-uploads/kochlik/products/45b053d8-b0a9-401a-91ef-ffd20bfd5d2a/downloads/kvetinac-ilie-gloss-2-ilie-gloss-pot-with-double-wall-info-en.pdf"}]'::jsonb,
    updated_at = now()
where owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid
  and slug = 'kvetinac-ilie-gloss'
  and jsonb_array_length(download_files) = 0;

update public.kochlik_products
set download_files = '[{"label":"Technický dokument","url":"https://ngifengeshwvyzhqvprn.supabase.co/storage/v1/object/public/site-uploads/kochlik/products/4b1ce93a-6bc0-40a2-966b-4b32cc07c112/downloads/kvetinac-kiam-1-kiam-vaso-quadro-con-doppia-parete.pdf"},{"label":"Informačný dokument","url":"https://ngifengeshwvyzhqvprn.supabase.co/storage/v1/object/public/site-uploads/kochlik/products/4b1ce93a-6bc0-40a2-966b-4b32cc07c112/downloads/kvetinac-kiam-2-kiam-square-pot-with-double-wall-info-en.pdf"}]'::jsonb,
    updated_at = now()
where owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid
  and slug = 'kvetinac-kiam'
  and jsonb_array_length(download_files) = 0;

update public.kochlik_products
set download_files = '[{"label":"Technický dokument","url":"https://ngifengeshwvyzhqvprn.supabase.co/storage/v1/object/public/site-uploads/kochlik/products/c8f343ad-2850-4dce-a67c-33cb0e1ed99c/downloads/kvetinac-kiam-gloss-1-kiam-vaso-gloss-quadro-con-doppia-parete.pdf"},{"label":"Informačný dokument","url":"https://ngifengeshwvyzhqvprn.supabase.co/storage/v1/object/public/site-uploads/kochlik/products/c8f343ad-2850-4dce-a67c-33cb0e1ed99c/downloads/kvetinac-kiam-gloss-2-kiam-gloss-square-pot-with-double-wall-info-en.pdf"}]'::jsonb,
    updated_at = now()
where owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid
  and slug = 'kvetinac-kiam-gloss'
  and jsonb_array_length(download_files) = 0;

update public.kochlik_products
set download_files = '[{"label":"Technický dokument","url":"https://ngifengeshwvyzhqvprn.supabase.co/storage/v1/object/public/site-uploads/kochlik/products/e693ba66-ee9f-4699-8c0c-2c8310e7ee59/downloads/kvetinac-kube-1-kube-vaso-con-doppia-parete.pdf"},{"label":"Informačný dokument","url":"https://ngifengeshwvyzhqvprn.supabase.co/storage/v1/object/public/site-uploads/kochlik/products/e693ba66-ee9f-4699-8c0c-2c8310e7ee59/downloads/kvetinac-kube-2-kube-pot-with-double-wall-info-en.pdf"}]'::jsonb,
    updated_at = now()
where owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid
  and slug = 'kvetinac-kube'
  and jsonb_array_length(download_files) = 0;

update public.kochlik_products
set download_files = '[{"label":"Technický dokument","url":"https://ngifengeshwvyzhqvprn.supabase.co/storage/v1/object/public/site-uploads/kochlik/products/934e0c4c-5951-4a65-8c0f-865f601a910a/downloads/kvetinac-kube-high-slim-1-kube-high-slim-vaso-con-doppia-parete.pdf"},{"label":"Informačný dokument","url":"https://ngifengeshwvyzhqvprn.supabase.co/storage/v1/object/public/site-uploads/kochlik/products/934e0c4c-5951-4a65-8c0f-865f601a910a/downloads/kvetinac-kube-high-slim-2-kube-high-slim-pot-with-double-wall-info-en.pdf"}]'::jsonb,
    updated_at = now()
where owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid
  and slug = 'kvetinac-kube-high-slim'
  and jsonb_array_length(download_files) = 0;

update public.kochlik_products
set download_files = '[{"label":"Technický dokument","url":"https://ngifengeshwvyzhqvprn.supabase.co/storage/v1/object/public/site-uploads/kochlik/products/5fd038fb-3ce1-4f9c-be82-cc57f41b7814/downloads/kvetinac-kube-high-slim-2-1-kube-high-slim-cassetta-con-doppia-parete.pdf"},{"label":"Informačný dokument","url":"https://ngifengeshwvyzhqvprn.supabase.co/storage/v1/object/public/site-uploads/kochlik/products/5fd038fb-3ce1-4f9c-be82-cc57f41b7814/downloads/kvetinac-kube-high-slim-2-2-kube-high-slim-plant-box-with-double-wall-info-en.pdf"}]'::jsonb,
    updated_at = now()
where owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid
  and slug = 'kvetinac-kube-high-slim-2'
  and jsonb_array_length(download_files) = 0;

update public.kochlik_products
set download_files = '[{"label":"Technický dokument","url":"https://ngifengeshwvyzhqvprn.supabase.co/storage/v1/object/public/site-uploads/kochlik/products/bbc3d435-4d29-4ab5-998f-c3dfb4359826/downloads/kvetinac-kube-s-kolieskami-1-kube-vaso-con-doppia-parete-ruote.pdf"},{"label":"Informačný dokument","url":"https://ngifengeshwvyzhqvprn.supabase.co/storage/v1/object/public/site-uploads/kochlik/products/bbc3d435-4d29-4ab5-998f-c3dfb4359826/downloads/kvetinac-kube-s-kolieskami-2-kube-pot-with-double-wall-castors-info-en.pdf"}]'::jsonb,
    updated_at = now()
where owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid
  and slug = 'kvetinac-kube-s-kolieskami'
  and jsonb_array_length(download_files) = 0;

update public.kochlik_products
set download_files = '[{"label":"Technický dokument","url":"https://ngifengeshwvyzhqvprn.supabase.co/storage/v1/object/public/site-uploads/kochlik/products/020adeaa-3e33-4eb0-8bdd-a6416f84de58/downloads/kvetinac-kubis-stvorcovy-1-kubis-vaso-quadro.pdf"},{"label":"Informačný dokument","url":"https://ngifengeshwvyzhqvprn.supabase.co/storage/v1/object/public/site-uploads/kochlik/products/020adeaa-3e33-4eb0-8bdd-a6416f84de58/downloads/kvetinac-kubis-stvorcovy-2-kubis-square-pot-info-en.pdf"}]'::jsonb,
    updated_at = now()
where owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid
  and slug = 'kvetinac-kubis-stvorcovy'
  and jsonb_array_length(download_files) = 0;

update public.kochlik_products
set download_files = '[{"label":"Technický dokument","url":"https://ngifengeshwvyzhqvprn.supabase.co/storage/v1/object/public/site-uploads/kochlik/products/fb298e8c-0040-48fc-bb47-27cb9752e88e/downloads/kvetinac-ornamentovy-1-ornato-vaso.pdf"},{"label":"Informačný dokument","url":"https://ngifengeshwvyzhqvprn.supabase.co/storage/v1/object/public/site-uploads/kochlik/products/fb298e8c-0040-48fc-bb47-27cb9752e88e/downloads/kvetinac-ornamentovy-2-ornato-pot-info-en.pdf"}]'::jsonb,
    updated_at = now()
where owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid
  and slug = 'kvetinac-ornamentovy'
  and jsonb_array_length(download_files) = 0;

update public.kochlik_products
set download_files = '[{"label":"Technický dokument","url":"https://ngifengeshwvyzhqvprn.supabase.co/storage/v1/object/public/site-uploads/kochlik/products/c67c5237-90a4-4d54-9c82-23ddcc27a462/downloads/kvetinac-siepi-1-siepi-vaso.pdf"},{"label":"Informačný dokument","url":"https://ngifengeshwvyzhqvprn.supabase.co/storage/v1/object/public/site-uploads/kochlik/products/c67c5237-90a4-4d54-9c82-23ddcc27a462/downloads/kvetinac-siepi-2-siepi-pot-info-en.pdf"}]'::jsonb,
    updated_at = now()
where owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid
  and slug = 'kvetinac-siepi'
  and jsonb_array_length(download_files) = 0;

update public.kochlik_products
set download_files = '[{"label":"Technický dokument","url":"https://ngifengeshwvyzhqvprn.supabase.co/storage/v1/object/public/site-uploads/kochlik/products/a13521c1-ce1f-4a26-9880-349a7ed94be8/downloads/kvetinac-siepi-k-stene-1-siepi-vaso-a-muro.pdf"},{"label":"Informačný dokument","url":"https://ngifengeshwvyzhqvprn.supabase.co/storage/v1/object/public/site-uploads/kochlik/products/a13521c1-ce1f-4a26-9880-349a7ed94be8/downloads/kvetinac-siepi-k-stene-2-siepi-wall-pot-info-en.pdf"}]'::jsonb,
    updated_at = now()
where owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid
  and slug = 'kvetinac-siepi-k-stene'
  and jsonb_array_length(download_files) = 0;

update public.kochlik_products
set download_files = '[{"label":"Technický dokument","url":"https://ngifengeshwvyzhqvprn.supabase.co/storage/v1/object/public/site-uploads/kochlik/products/869af742-1ae3-453d-8167-c0cfc7987e9f/downloads/kvetinac-siepi-stvorcovy-1-siepi-vaso-quadro.pdf"},{"label":"Informačný dokument","url":"https://ngifengeshwvyzhqvprn.supabase.co/storage/v1/object/public/site-uploads/kochlik/products/869af742-1ae3-453d-8167-c0cfc7987e9f/downloads/kvetinac-siepi-stvorcovy-2-siepi-square-pot-info-en.pdf"}]'::jsonb,
    updated_at = now()
where owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid
  and slug = 'kvetinac-siepi-stvorcovy'
  and jsonb_array_length(download_files) = 0;

update public.kochlik_products
set download_files = '[{"label":"Technický dokument","url":"https://ngifengeshwvyzhqvprn.supabase.co/storage/v1/object/public/site-uploads/kochlik/products/2a055268-10d7-4cef-9762-a04076fd2f97/downloads/kvetinac-siepi-stvorcovy-s-dvojitou-stenou-1-siepi-vaso-quadro-con-doppia-parete.pdf"},{"label":"Informačný dokument","url":"https://ngifengeshwvyzhqvprn.supabase.co/storage/v1/object/public/site-uploads/kochlik/products/2a055268-10d7-4cef-9762-a04076fd2f97/downloads/kvetinac-siepi-stvorcovy-s-dvojitou-stenou-2-siepi-square-pot-with-double-wall-info-en.pdf"}]'::jsonb,
    updated_at = now()
where owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid
  and slug = 'kvetinac-siepi-stvorcovy-s-dvojitou-stenou'
  and jsonb_array_length(download_files) = 0;

update public.kochlik_products
set download_files = '[{"label":"Technický dokument","url":"https://ngifengeshwvyzhqvprn.supabase.co/storage/v1/object/public/site-uploads/kochlik/products/e2d4183b-6f9b-4c52-9ee4-575c3e601238/downloads/kvetinac-tempium-1-tempium-vaso.pdf"},{"label":"Informačný dokument","url":"https://ngifengeshwvyzhqvprn.supabase.co/storage/v1/object/public/site-uploads/kochlik/products/e2d4183b-6f9b-4c52-9ee4-575c3e601238/downloads/kvetinac-tempium-2-tempium-pot-info-en.pdf"}]'::jsonb,
    updated_at = now()
where owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid
  and slug = 'kvetinac-tempium'
  and jsonb_array_length(download_files) = 0;

update public.kochlik_products
set download_files = '[{"label":"Technický dokument","url":"https://ngifengeshwvyzhqvprn.supabase.co/storage/v1/object/public/site-uploads/kochlik/products/e5d9264b-fd1b-48d2-b5d2-23f604b7e795/downloads/kvetinac-tisicriadkovy-stvorec-1-millerighe-vaso-quadro.pdf"},{"label":"Informačný dokument","url":"https://ngifengeshwvyzhqvprn.supabase.co/storage/v1/object/public/site-uploads/kochlik/products/e5d9264b-fd1b-48d2-b5d2-23f604b7e795/downloads/kvetinac-tisicriadkovy-stvorec-2-millerighe-square-pot-info-en.pdf"}]'::jsonb,
    updated_at = now()
where owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid
  and slug = 'kvetinac-tisicriadkovy-stvorec'
  and jsonb_array_length(download_files) = 0;

update public.kochlik_products
set download_files = '[{"label":"Technický dokument","url":"https://ngifengeshwvyzhqvprn.supabase.co/storage/v1/object/public/site-uploads/kochlik/products/c3ec1da5-0c92-4370-b872-c564fe58c529/downloads/kvetinac-toskansky-stvor-s-dvojitou-stenou-50-cm-1-toscana-vaso-quadro-con-doppia-parete.pdf"},{"label":"Informačný dokument","url":"https://ngifengeshwvyzhqvprn.supabase.co/storage/v1/object/public/site-uploads/kochlik/products/c3ec1da5-0c92-4370-b872-c564fe58c529/downloads/kvetinac-toskansky-stvor-s-dvojitou-stenou-50-cm-2-toscana-square-pot-with-double-wall-info-en.pdf"}]'::jsonb,
    updated_at = now()
where owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid
  and slug = 'kvetinac-toskansky-stvor-s-dvojitou-stenou-50-cm'
  and jsonb_array_length(download_files) = 0;

update public.kochlik_products
set download_files = '[{"label":"Technický dokument","url":"https://ngifengeshwvyzhqvprn.supabase.co/storage/v1/object/public/site-uploads/kochlik/products/e4ca86f0-31d2-4a80-b820-ff145f1bbb7f/downloads/kvetinac-tulum-1-tulum-vaso-con-doppia-parete.pdf"},{"label":"Informačný dokument","url":"https://ngifengeshwvyzhqvprn.supabase.co/storage/v1/object/public/site-uploads/kochlik/products/e4ca86f0-31d2-4a80-b820-ff145f1bbb7f/downloads/kvetinac-tulum-2-tulum-pot-with-double-wall-info-en.pdf"}]'::jsonb,
    updated_at = now()
where owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid
  and slug = 'kvetinac-tulum'
  and jsonb_array_length(download_files) = 0;

update public.kochlik_products
set download_files = '[{"label":"Technický dokument","url":"https://ngifengeshwvyzhqvprn.supabase.co/storage/v1/object/public/site-uploads/kochlik/products/7461edde-c986-409b-85a7-8ce30545621b/downloads/kvetinac-vysoky-kube-1-kube-high-vaso-con-doppia-parete.pdf"},{"label":"Informačný dokument","url":"https://ngifengeshwvyzhqvprn.supabase.co/storage/v1/object/public/site-uploads/kochlik/products/7461edde-c986-409b-85a7-8ce30545621b/downloads/kvetinac-vysoky-kube-2-kube-high-pot-with-double-wall-info-en.pdf"}]'::jsonb,
    updated_at = now()
where owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid
  and slug = 'kvetinac-vysoky-kube'
  and jsonb_array_length(download_files) = 0;

update public.kochlik_products
set download_files = '[{"label":"Technický dokument","url":"https://ngifengeshwvyzhqvprn.supabase.co/storage/v1/object/public/site-uploads/kochlik/products/88bdcb47-3d11-43f9-bdd8-c255d50c8d51/downloads/kvetinac-vysoky-kube-s-kolieskami-1-kube-high-vaso-con-doppia-parete-ruote.pdf"},{"label":"Informačný dokument","url":"https://ngifengeshwvyzhqvprn.supabase.co/storage/v1/object/public/site-uploads/kochlik/products/88bdcb47-3d11-43f9-bdd8-c255d50c8d51/downloads/kvetinac-vysoky-kube-s-kolieskami-2-kube-high-pot-with-double-wall-castors-info-en.pdf"}]'::jsonb,
    updated_at = now()
where owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid
  and slug = 'kvetinac-vysoky-kube-s-kolieskami'
  and jsonb_array_length(download_files) = 0;

update public.kochlik_products
set download_files = '[{"label":"Technický dokument","url":"https://ngifengeshwvyzhqvprn.supabase.co/storage/v1/object/public/site-uploads/kochlik/products/cc85c9e4-0946-46f0-87c5-c6833acdebe6/downloads/lavica-polobluk-1-semitonda-panca.pdf"},{"label":"Informačný dokument","url":"https://ngifengeshwvyzhqvprn.supabase.co/storage/v1/object/public/site-uploads/kochlik/products/cc85c9e4-0946-46f0-87c5-c6833acdebe6/downloads/lavica-polobluk-2-semitonda-bench-info-en.pdf"}]'::jsonb,
    updated_at = now()
where owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid
  and slug = 'lavica-polobluk'
  and jsonb_array_length(download_files) = 0;

update public.kochlik_products
set download_files = '[{"label":"Technický dokument","url":"https://ngifengeshwvyzhqvprn.supabase.co/storage/v1/object/public/site-uploads/kochlik/products/b7cf953a-d07b-4647-8af8-d4cd4778c39c/downloads/nadoba-etrusca-1-etrusca-fioriera.pdf"},{"label":"Informačný dokument","url":"https://ngifengeshwvyzhqvprn.supabase.co/storage/v1/object/public/site-uploads/kochlik/products/b7cf953a-d07b-4647-8af8-d4cd4778c39c/downloads/nadoba-etrusca-2-etrusca-vase-info-en.pdf"}]'::jsonb,
    updated_at = now()
where owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid
  and slug = 'nadoba-etrusca'
  and jsonb_array_length(download_files) = 0;

update public.kochlik_products
set download_files = '[{"label":"Technický dokument","url":"https://ngifengeshwvyzhqvprn.supabase.co/storage/v1/object/public/site-uploads/kochlik/products/e1d3049a-4f88-4f77-bf3c-aa4d139ac402/downloads/nadoba-impero-1-impero-fioriera.pdf"},{"label":"Informačný dokument","url":"https://ngifengeshwvyzhqvprn.supabase.co/storage/v1/object/public/site-uploads/kochlik/products/e1d3049a-4f88-4f77-bf3c-aa4d139ac402/downloads/nadoba-impero-2-impero-vase-info-en.pdf"}]'::jsonb,
    updated_at = now()
where owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid
  and slug = 'nadoba-impero'
  and jsonb_array_length(download_files) = 0;

update public.kochlik_products
set download_files = '[{"label":"Technický dokument","url":"https://ngifengeshwvyzhqvprn.supabase.co/storage/v1/object/public/site-uploads/kochlik/products/44bcfbd2-56ae-480d-93df-dc28b9a8ebf6/downloads/nadoba-ulivum-1-ulivum-conca.pdf"},{"label":"Informačný dokument","url":"https://ngifengeshwvyzhqvprn.supabase.co/storage/v1/object/public/site-uploads/kochlik/products/44bcfbd2-56ae-480d-93df-dc28b9a8ebf6/downloads/nadoba-ulivum-2-ulivum-conch-info-en.pdf"}]'::jsonb,
    updated_at = now()
where owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid
  and slug = 'nadoba-ulivum'
  and jsonb_array_length(download_files) = 0;

update public.kochlik_products
set download_files = '[{"label":"Technický dokument","url":"https://ngifengeshwvyzhqvprn.supabase.co/storage/v1/object/public/site-uploads/kochlik/products/99b6ed91-0e2e-4c26-a630-43c88ba5471c/downloads/quadrum-1-quadrum-vaso-quadro-con-doppia-parete.pdf"},{"label":"Informačný dokument","url":"https://ngifengeshwvyzhqvprn.supabase.co/storage/v1/object/public/site-uploads/kochlik/products/99b6ed91-0e2e-4c26-a630-43c88ba5471c/downloads/quadrum-2-quadrum-square-pot-with-double-wall-info-en.pdf"}]'::jsonb,
    updated_at = now()
where owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid
  and slug = 'quadrum'
  and jsonb_array_length(download_files) = 0;

update public.kochlik_products
set download_files = '[{"label":"Technický dokument","url":"https://ngifengeshwvyzhqvprn.supabase.co/storage/v1/object/public/site-uploads/kochlik/products/2fe63657-b84b-4f86-ad41-2a03a36bb2bc/downloads/stolik-oasi-1-oasi-poltroncina-tavolino.pdf"},{"label":"Informačný dokument","url":"https://ngifengeshwvyzhqvprn.supabase.co/storage/v1/object/public/site-uploads/kochlik/products/2fe63657-b84b-4f86-ad41-2a03a36bb2bc/downloads/stolik-oasi-2-oasi-small-armchair-small-table-info-en.pdf"}]'::jsonb,
    updated_at = now()
where owner_id = 'c28707c3-2289-48b9-bbd3-08a441fd02fc'::uuid
  and slug = 'stolik-oasi'
  and jsonb_array_length(download_files) = 0;

COMMIT;
