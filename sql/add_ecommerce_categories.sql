-- Ecommerce categories for Vavrostav shop
CREATE TABLE IF NOT EXISTS public.ecommerce_categories (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  owner_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  name TEXT NOT NULL,
  slug TEXT NOT NULL,
  description TEXT,
  sort_order INTEGER NOT NULL DEFAULT 0,
  is_active BOOLEAN NOT NULL DEFAULT true,
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
  UNIQUE(owner_id, slug)
);

-- Add category_id to products
ALTER TABLE public.ecommerce_products
ADD COLUMN IF NOT EXISTS category_id UUID REFERENCES public.ecommerce_categories(id) ON DELETE SET NULL;

-- Index for category lookup
CREATE INDEX IF NOT EXISTS ecommerce_categories_owner_active_idx
ON public.ecommerce_categories (owner_id, is_active, sort_order ASC);

CREATE INDEX IF NOT EXISTS ecommerce_products_category_idx
ON public.ecommerce_products (category_id);

-- RLS for categories
ALTER TABLE public.ecommerce_categories ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Owner can manage categories" ON public.ecommerce_categories;
CREATE POLICY "Owner can manage categories"
ON public.ecommerce_categories
FOR ALL
TO authenticated
USING (owner_id = auth.uid())
WITH CHECK (owner_id = auth.uid());

DROP POLICY IF EXISTS "Public can view active categories" ON public.ecommerce_categories;
CREATE POLICY "Public can view active categories"
ON public.ecommerce_categories
FOR SELECT
TO anon
USING (
  owner_id = '9083c583-0fcf-483d-b3f1-ba435287ec04'::uuid
  AND is_active = true
);
