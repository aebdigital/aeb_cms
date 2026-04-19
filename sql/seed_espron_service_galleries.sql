-- Seeds the espron_service_galleries table with the existing legacy
-- realizácie photos for "zateplenie-fasady" and "cistenie-fasady" so
-- they appear in the admin Espron Realizácie panel and can be edited
-- or reordered there.
--
-- Safe to re-run: deletes only previously seeded rows (matched by URL)
-- before re-inserting them. Custom rows added via the admin UI are
-- preserved.
--
-- Run after create_espron_service_galleries.sql in the aeb_cms project
-- (project ref: ngifengeshwvyzhqvprn).

delete from public.espron_service_galleries
where site = 'sk'
  and service_slug in ('zateplenie-fasady', 'cistenie-fasady')
  and image_url like 'https://static.wixstatic.com/media/%';

insert into public.espron_service_galleries
  (service_slug, site, image_url, alt, caption, kind, sort_order, is_published)
values
  -- Čistenie fasády
  ('cistenie-fasady', 'sk', 'https://static.wixstatic.com/media/b0408c_b96f69eb425a4910a52117677cbbff9c~mv2.webp', 'Čistenie fasády v Tatranskej Lomnici', 'Tatranská Lomnica', 'image', 10, true),
  ('cistenie-fasady', 'sk', 'https://static.wixstatic.com/media/b0408c_a530abe8b0ab454e96deb068434dfa28~mv2.webp', 'Čistenie fasády v Tatranskej Lomnici', 'Tatranská Lomnica', 'image', 20, true),
  ('cistenie-fasady', 'sk', 'https://static.wixstatic.com/media/b0408c_6d9c71472d424d0189271eac4316e329~mv2.webp', 'Čistenie fasády v Tatranskej Lomnici', 'Tatranská Lomnica', 'image', 30, true),
  ('cistenie-fasady', 'sk', 'https://static.wixstatic.com/media/b0408c_482349b13c3146f6bae142d3e55061c8~mv2.webp', 'Čistenie fasády v Tatranskej Lomnici', 'Tatranská Lomnica', 'image', 40, true),
  ('cistenie-fasady', 'sk', 'https://static.wixstatic.com/media/b0408c_b2755552b3f243c08b73111a25637e21~mv2.webp', 'Čistenie fasády v Prakovciach', 'Prakovce', 'image', 50, true),
  ('cistenie-fasady', 'sk', 'https://static.wixstatic.com/media/b0408c_99408a9c06de4d9eb913bf1ea86bc15d~mv2.webp', 'Čistenie fasády v Prakovciach', 'Prakovce', 'image', 60, true),

  -- Zateplenie fasády
  ('zateplenie-fasady', 'sk', 'https://static.wixstatic.com/media/b0408c_367500351723442cad2942dc54dc2f5a~mv2.webp', 'Zateplenie fasády domu v Hlohovci', 'Hlohovec - SK', 'image', 10, true),
  ('zateplenie-fasady', 'sk', 'https://static.wixstatic.com/media/b0408c_fdbfe48c629c4b9ca41b1651bc21cf79~mv2.webp', 'Zateplenie fasády domu v Hlohovci', 'Hlohovec - SK', 'image', 20, true),
  ('zateplenie-fasady', 'sk', 'https://static.wixstatic.com/media/b0408c_94f20bec0ce4428a9d3f7c7cdee546d6~mv2.webp', 'Zateplenie fasády domu v Trnave', 'Trnava - SK', 'image', 30, true),
  ('zateplenie-fasady', 'sk', 'https://static.wixstatic.com/media/b0408c_0ab96dc3302e4b68b020fa7511c4a782~mv2.webp', 'Zateplenie fasády domu v Trnave', 'Trnava - SK', 'image', 40, true),
  ('zateplenie-fasady', 'sk', 'https://static.wixstatic.com/media/b0408c_4674ae04a22b459e9cbc880d5934070f~mv2.webp', 'Zateplenie fasády domu v Trnave', 'Trnava - SK', 'image', 50, true),
  ('zateplenie-fasady', 'sk', 'https://static.wixstatic.com/media/b0408c_a0e6ddc0956f4bef9e75ac8897362c01~mv2.webp', 'Zateplenie fasády domu v Trnave', 'Trnava - SK', 'image', 60, true),
  ('zateplenie-fasady', 'sk', 'https://static.wixstatic.com/media/b0408c_c2b7955b566d44399ad07aefb2069cce~mv2.webp', 'Zateplenie fasády domu v Banskej Bystrici', 'Banská Bystrica - SK', 'image', 70, true),
  ('zateplenie-fasady', 'sk', 'https://static.wixstatic.com/media/b0408c_b78ac503a95a4eb18adbba15b2466ea4~mv2.webp', 'Zateplenie fasády domu v Banskej Bystrici', 'Banská Bystrica - SK', 'image', 80, true),
  ('zateplenie-fasady', 'sk', 'https://static.wixstatic.com/media/b0408c_d172f4f834f34590bd70b4e46f25a19f~mv2.webp', 'Zateplenie fasády domu v Banskej Bystrici', 'Banská Bystrica - SK', 'image', 90, true),
  ('zateplenie-fasady', 'sk', 'https://static.wixstatic.com/media/b0408c_6286d292c3a04dc387007eb2a86a84cbf000.jpg', 'Video realizácie zateplenia v Banskej Bystrici', 'Banská Bystrica - SK', 'video', 100, true),
  ('zateplenie-fasady', 'sk', 'https://static.wixstatic.com/media/b0408c_2883303b07a4489798740af9878cc2db~mv2.webp', 'Zateplenie fasády domu v Banskej Bystrici', 'Banská Bystrica - SK', 'image', 110, true),
  ('zateplenie-fasady', 'sk', 'https://static.wixstatic.com/media/b0408c_ee9a889da2ac4dfaa47c0450cb7f1078~mv2.webp', 'Zateplenie fasády domu v Brezne', 'Brezno - SK', 'image', 120, true),
  ('zateplenie-fasady', 'sk', 'https://static.wixstatic.com/media/b0408c_d07a7667488340fca0d16bbb0aa3a3b3~mv2.webp', 'Zateplenie fasády domu v Brezne', 'Brezno - SK', 'image', 130, true),
  ('zateplenie-fasady', 'sk', 'https://static.wixstatic.com/media/b0408c_b5707254d4df4e26afa5d562c42991fe~mv2.webp', 'Zateplenie fasády domu v Brezne', 'Brezno - SK', 'image', 140, true),
  ('zateplenie-fasady', 'sk', 'https://static.wixstatic.com/media/b0408c_a2d739c0c1944d7f8ba8c1c0f0e9f9e8~mv2.webp', 'Zateplenie fasády domu v Brezne', 'Brezno - SK', 'image', 150, true),
  ('zateplenie-fasady', 'sk', 'https://static.wixstatic.com/media/b0408c_58ac0a882c1049d39a8a690416063504~mv2.webp', 'Zateplenie fasády domu v Brezne', 'Brezno - SK', 'image', 160, true);
