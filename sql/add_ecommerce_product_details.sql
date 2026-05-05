ALTER TABLE public.ecommerce_products
ADD COLUMN IF NOT EXISTS gallery_images TEXT[] DEFAULT '{}',
ADD COLUMN IF NOT EXISTS specifications JSONB DEFAULT '[]'::jsonb;
