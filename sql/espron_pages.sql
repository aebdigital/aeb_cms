-- Migration: Create espron_pages table for the Espron page builder in the CMS
-- Run this in Supabase SQL editor

CREATE TABLE IF NOT EXISTS espron_pages (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

  -- URL path for the page, e.g. /nova-sluzba
  path TEXT NOT NULL UNIQUE,

  -- Display fields
  label TEXT NOT NULL,                             -- Page title shown in nav
  eyebrow TEXT NOT NULL DEFAULT 'ESPRON',          -- Small text above hero heading
  family TEXT NOT NULL DEFAULT 'service',          -- Page category/family

  -- SEO
  title TEXT NOT NULL,                             -- <title> tag
  meta_title TEXT NOT NULL,                        -- SEO meta title
  description TEXT NOT NULL DEFAULT '',            -- Meta description

  -- Media
  hero_image TEXT DEFAULT NULL,                    -- URL of hero image

  -- JSON arrays
  gallery_images JSONB NOT NULL DEFAULT '[]',      -- Array of image URL strings
  highlights JSONB NOT NULL DEFAULT '[]',          -- Array of highlight strings
  blocks JSONB NOT NULL DEFAULT '[]',              -- Array of ContentBlock objects
  related JSONB NOT NULL DEFAULT '[]',             -- Array of {href, label} objects

  -- Metadata
  lastmod TEXT DEFAULT NULL,                       -- ISO date string, e.g. 2025-04-10
  is_published BOOLEAN NOT NULL DEFAULT FALSE,

  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- RLS: enable row-level security (adjust policies to your existing setup)
ALTER TABLE espron_pages ENABLE ROW LEVEL SECURITY;

-- Allow authenticated users to read/write all rows
-- (tighten this to your admin user if needed)
CREATE POLICY "Authenticated users can manage espron_pages"
  ON espron_pages
  FOR ALL
  TO authenticated
  USING (true)
  WITH CHECK (true);

-- Auto-update updated_at
CREATE OR REPLACE FUNCTION update_espron_pages_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER espron_pages_updated_at
  BEFORE UPDATE ON espron_pages
  FOR EACH ROW EXECUTE FUNCTION update_espron_pages_updated_at();
