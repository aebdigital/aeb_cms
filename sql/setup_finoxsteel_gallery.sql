-- 1. Create Finoxsteel site if not exists
INSERT INTO sites (name, slug)
VALUES ('Finoxsteel', 'finoxsteel')
ON CONFLICT (slug) DO NOTHING;

-- 2. Link User info@finoxsteel.com as owner
DO $$
DECLARE
    v_site_id UUID;
    v_user_id UUID := '6376ca37-b6da-492b-80f7-3c8344c52138';
BEGIN
    SELECT id INTO v_site_id FROM sites WHERE slug = 'finoxsteel';
    
    IF v_site_id IS NOT NULL THEN
        INSERT INTO site_memberships (site_id, user_id, role)
        VALUES (v_site_id, v_user_id, 'owner')
        ON CONFLICT (site_id, user_id) DO NOTHING;
    END IF;
END $$;

-- 3. Clear existing migrated images for finoxsteel (including old local paths)
DELETE FROM gallery_images 
WHERE site_id = (SELECT id FROM sites WHERE slug = 'finoxsteel');

-- 4. Bulk insert hardcoded images pointing to the newly uploaded Supabase Storage paths
DO $$
DECLARE
    v_site_id UUID;
BEGIN
    SELECT id INTO v_site_id FROM sites WHERE slug = 'finoxsteel';
    
    IF v_site_id IS NOT NULL THEN
        INSERT INTO gallery_images (site_id, category, image_path, display_order)
        VALUES 
            (v_site_id, 'brany', 'finoxsteel/gallery/brany/255020066_4643795265643850_3352048480199650790_n.jpg', 0),
            (v_site_id, 'brany', 'finoxsteel/gallery/brany/260839579_4686508461372530_2505623606432666679_n.jpg', 1),
            (v_site_id, 'brany', 'finoxsteel/gallery/brany/290161775_5337746472915389_8790292686262939797_n.jpg', 2),
            (v_site_id, 'brany', 'finoxsteel/gallery/brany/4.jpg', 3),
            (v_site_id, 'brany', 'finoxsteel/gallery/brany/479315987_596883256490575_8014104618849694477_n.jpg', 4),
            (v_site_id, 'brany', 'finoxsteel/gallery/brany/486422956_624113283767572_7579823688339688467_n.jpg', 5),
            (v_site_id, 'brany', 'finoxsteel/gallery/brany/76.jpg', 6),
            (v_site_id, 'brany', 'finoxsteel/gallery/brany/77.jpg', 7),
            (v_site_id, 'brany', 'finoxsteel/gallery/brany/IMG_3840.jpg', 8),
            (v_site_id, 'brany', 'finoxsteel/gallery/brany/IMG_4844.jpg', 9),
            (v_site_id, 'brany', 'finoxsteel/gallery/brany/IMG_4904 copy.jpg', 10),
            (v_site_id, 'brany', 'finoxsteel/gallery/brany/IMG_4906 copy.jpg', 11),
            (v_site_id, 'brany', 'finoxsteel/gallery/brany/IMG_6886.jpg', 12),
            (v_site_id, 'brany', 'finoxsteel/gallery/brany/IMG_6968.jpg', 13),
            (v_site_id, 'brany', 'finoxsteel/gallery/brany/IMG_7156.jpg', 14),
            (v_site_id, 'brany', 'finoxsteel/gallery/brany/IMG_7341.jpg', 15),
            (v_site_id, 'brany', 'finoxsteel/gallery/brany/IMG_7523.jpg', 16),
            (v_site_id, 'brany', 'finoxsteel/gallery/brany/IMG_7715.jpg', 17),
            (v_site_id, 'brany', 'finoxsteel/gallery/brany/Screenshot 2025-10-04 at 01.02.22.jpg', 18),
            (v_site_id, 'brany', 'finoxsteel/gallery/brany/Screenshot 2025-10-04 at 01.03.01.jpg', 19),
            (v_site_id, 'brany', 'finoxsteel/gallery/brany/Screenshot 2025-10-04 at 01.03.15.jpg', 20),
            (v_site_id, 'brany', 'finoxsteel/gallery/brany/service-brana.jpg', 21),
            (v_site_id, 'brany', 'finoxsteel/gallery/brany/hero1.jpg', 22),
            
            (v_site_id, 'pergoly', 'finoxsteel/gallery/pergoly/IMG_6212.jpg', 23),
            (v_site_id, 'pergoly', 'finoxsteel/gallery/pergoly/IMG_7318.jpg', 24),
            (v_site_id, 'pergoly', 'finoxsteel/gallery/pergoly/IMG_7321_jpg.jpg', 25),
            (v_site_id, 'pergoly', 'finoxsteel/gallery/pergoly/Screenshot 2025-10-04 at 01.07.22.png', 26),
            (v_site_id, 'pergoly', 'finoxsteel/gallery/pergoly/Screenshot 2025-10-04 at 01.07.28.png', 27),
            (v_site_id, 'pergoly', 'finoxsteel/gallery/pergoly/Screenshot 2025-10-04 at 01.07.39.png', 28),
            (v_site_id, 'pergoly', 'finoxsteel/gallery/pergoly/Screenshot 2025-10-04 at 01.07.51.png', 29),
            (v_site_id, 'pergoly', 'finoxsteel/gallery/pergoly/pergola.jpg', 30),
            (v_site_id, 'pergoly', 'finoxsteel/gallery/pergoly/hero2.jpg', 31),
            (v_site_id, 'pergoly', 'finoxsteel/gallery/pergoly/hero2.png', 32),
            
            (v_site_id, 'schody-zabradlia', 'finoxsteel/gallery/schody-zabradlia/1.jpg', 33),
            (v_site_id, 'schody-zabradlia', 'finoxsteel/gallery/schody-zabradlia/121.jpg', 34),
            (v_site_id, 'schody-zabradlia', 'finoxsteel/gallery/schody-zabradlia/432314200_376685958510307_4362093780546380355_n.jpg', 35),
            (v_site_id, 'schody-zabradlia', 'finoxsteel/gallery/schody-zabradlia/IMG_5401-scaled.jpg', 36),
            (v_site_id, 'schody-zabradlia', 'finoxsteel/gallery/schody-zabradlia/IMG_5420.jpg', 37),
            (v_site_id, 'schody-zabradlia', 'finoxsteel/gallery/schody-zabradlia/IMG_7495.jpg', 38),
            (v_site_id, 'schody-zabradlia', 'finoxsteel/gallery/schody-zabradlia/schody.jpg', 39),
            (v_site_id, 'schody-zabradlia', 'finoxsteel/gallery/schody-zabradlia/hero3.JPG', 40),
            
            (v_site_id, 'konstrukcie', 'finoxsteel/gallery/konstrukcie/konstrukcia.jpg', 41);
    END IF;
END $$;
