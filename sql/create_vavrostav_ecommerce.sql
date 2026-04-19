CREATE EXTENSION IF NOT EXISTS pgcrypto;

CREATE TABLE IF NOT EXISTS public.ecommerce_products (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  owner_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  name TEXT NOT NULL,
  slug TEXT NOT NULL,
  sku TEXT,
  description TEXT,
  image_url TEXT,
  price_cents INTEGER NOT NULL DEFAULT 0 CHECK (price_cents >= 0),
  currency TEXT NOT NULL DEFAULT 'EUR',
  stock_quantity INTEGER NOT NULL DEFAULT 0 CHECK (stock_quantity >= 0),
  is_active BOOLEAN NOT NULL DEFAULT true,
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
  UNIQUE(owner_id, slug)
);

CREATE TABLE IF NOT EXISTS public.ecommerce_orders (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  owner_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  customer_name TEXT NOT NULL,
  customer_email TEXT NOT NULL,
  customer_phone TEXT,
  customer_address TEXT,
  notes TEXT,
  status TEXT NOT NULL DEFAULT 'new' CHECK (status IN ('new', 'confirmed', 'in_progress', 'completed', 'cancelled')),
  payment_status TEXT NOT NULL DEFAULT 'unpaid' CHECK (payment_status IN ('unpaid', 'paid', 'refunded')),
  total_cents INTEGER NOT NULL DEFAULT 0 CHECK (total_cents >= 0),
  currency TEXT NOT NULL DEFAULT 'EUR',
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS public.ecommerce_order_items (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  order_id UUID NOT NULL REFERENCES public.ecommerce_orders(id) ON DELETE CASCADE,
  product_id UUID REFERENCES public.ecommerce_products(id) ON DELETE SET NULL,
  product_name TEXT NOT NULL,
  unit_price_cents INTEGER NOT NULL CHECK (unit_price_cents >= 0),
  quantity INTEGER NOT NULL CHECK (quantity > 0),
  line_total_cents INTEGER NOT NULL CHECK (line_total_cents >= 0),
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS ecommerce_products_owner_active_idx
ON public.ecommerce_products (owner_id, is_active, created_at DESC);

CREATE INDEX IF NOT EXISTS ecommerce_orders_owner_created_idx
ON public.ecommerce_orders (owner_id, created_at DESC);

CREATE INDEX IF NOT EXISTS ecommerce_order_items_order_idx
ON public.ecommerce_order_items (order_id);

ALTER TABLE public.ecommerce_products ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.ecommerce_orders ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.ecommerce_order_items ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Vavrostav owner can manage products" ON public.ecommerce_products;
CREATE POLICY "Vavrostav owner can manage products"
ON public.ecommerce_products
FOR ALL
TO authenticated
USING (owner_id = auth.uid())
WITH CHECK (owner_id = auth.uid());

DROP POLICY IF EXISTS "Public can view active Vavrostav products" ON public.ecommerce_products;
CREATE POLICY "Public can view active Vavrostav products"
ON public.ecommerce_products
FOR SELECT
TO anon
USING (
  owner_id = '9083c583-0fcf-483d-b3f1-ba435287ec04'::uuid
  AND is_active = true
);

DROP POLICY IF EXISTS "Vavrostav owner can manage orders" ON public.ecommerce_orders;
CREATE POLICY "Vavrostav owner can manage orders"
ON public.ecommerce_orders
FOR ALL
TO authenticated
USING (owner_id = auth.uid())
WITH CHECK (owner_id = auth.uid());

DROP POLICY IF EXISTS "Public can create Vavrostav orders" ON public.ecommerce_orders;
CREATE POLICY "Public can create Vavrostav orders"
ON public.ecommerce_orders
FOR INSERT
TO anon
WITH CHECK (
  owner_id = '9083c583-0fcf-483d-b3f1-ba435287ec04'::uuid
  AND status = 'new'
  AND payment_status = 'unpaid'
);

DROP POLICY IF EXISTS "Vavrostav owner can view order items" ON public.ecommerce_order_items;
CREATE POLICY "Vavrostav owner can view order items"
ON public.ecommerce_order_items
FOR SELECT
TO authenticated
USING (
  EXISTS (
    SELECT 1
    FROM public.ecommerce_orders
    WHERE ecommerce_orders.id = ecommerce_order_items.order_id
      AND ecommerce_orders.owner_id = auth.uid()
  )
);

DROP POLICY IF EXISTS "Public can create Vavrostav order items" ON public.ecommerce_order_items;
CREATE POLICY "Public can create Vavrostav order items"
ON public.ecommerce_order_items
FOR INSERT
TO anon
WITH CHECK (
  product_id IS NULL
  OR EXISTS (
    SELECT 1
    FROM public.ecommerce_products
    WHERE ecommerce_products.id = ecommerce_order_items.product_id
      AND ecommerce_products.owner_id = '9083c583-0fcf-483d-b3f1-ba435287ec04'::uuid
      AND ecommerce_products.is_active = true
  )
);
