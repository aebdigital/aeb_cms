-- Add new fields to cars table
-- Run this in Supabase SQL Editor

-- Basic fields
ALTER TABLE cars ADD COLUMN IF NOT EXISTS doors text;
ALTER TABLE cars ADD COLUMN IF NOT EXISTS color text;
ALTER TABLE cars ADD COLUMN IF NOT EXISTS reserved boolean DEFAULT false;
ALTER TABLE cars ADD COLUMN IF NOT EXISTS month integer;

-- VAT deduction fields
ALTER TABLE cars ADD COLUMN IF NOT EXISTS vat_deductible boolean DEFAULT false;
ALTER TABLE cars ADD COLUMN IF NOT EXISTS price_without_vat numeric;

-- Transmission details (extends existing transmission field)
ALTER TABLE cars ADD COLUMN IF NOT EXISTS transmission_type text; -- 'manual' or 'automatic'
ALTER TABLE cars ADD COLUMN IF NOT EXISTS transmission_gears text;

-- Airbags
ALTER TABLE cars ADD COLUMN IF NOT EXISTS airbag_count integer;

-- Audio/Entertainment
ALTER TABLE cars ADD COLUMN IF NOT EXISTS radio_cd boolean DEFAULT false;
ALTER TABLE cars ADD COLUMN IF NOT EXISTS radio_cd_mp3 boolean DEFAULT false;
ALTER TABLE cars ADD COLUMN IF NOT EXISTS android_auto boolean DEFAULT false;

-- Climate control
-- ac_type options: 'manual', 'automatic'
-- ac_zones options: 'single', 'dual', 'triple', 'quad' (only when ac_type is 'automatic')
ALTER TABLE cars ADD COLUMN IF NOT EXISTS ac_type text;
ALTER TABLE cars ADD COLUMN IF NOT EXISTS ac_zones text;

-- Parking sensors
-- Options: 'front', 'rear', 'front_rear'
ALTER TABLE cars ADD COLUMN IF NOT EXISTS parking_sensors text;

-- Electric windows
-- Options: '0', '2', '4'
ALTER TABLE cars ADD COLUMN IF NOT EXISTS electric_windows text;

-- Heated seats
-- Options: 'front', 'rear', 'front_rear'
ALTER TABLE cars ADD COLUMN IF NOT EXISTS heated_seats text;

-- Create index for commonly filtered fields
CREATE INDEX IF NOT EXISTS idx_cars_reserved ON cars(reserved);
CREATE INDEX IF NOT EXISTS idx_cars_vat_deductible ON cars(vat_deductible);
CREATE INDEX IF NOT EXISTS idx_cars_color ON cars(color);

-- Update RLS policies if needed (existing policies should cover these new columns)
