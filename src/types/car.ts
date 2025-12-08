export interface Car {
  id: string;
  brand: string;
  model: string;
  year: number;
  price: number;
  mileage: number;
  fuel: string;
  transmission: string;
  image: string;
  images?: string[];
  features?: string[];
  engine?: string;
  power?: string;
  bodyType?: string;
  drivetrain?: string;
  vin?: string;
  description?: string;
  source?: 'xml' | 'admin';
  reservedUntil?: string;
  showOnHomepage?: boolean;
}

// Database row type (snake_case from Supabase)
export interface CarRow {
  id: string;
  site_id: string;
  brand: string;
  model: string;
  year: number | null;
  price: number | null;
  mileage: number | null;
  fuel: string | null;
  transmission: string | null;
  image: string;
  images: string[] | null;
  features: string[] | null;
  engine: string | null;
  power: string | null;
  body_type: string | null;
  drivetrain: string | null;
  vin: string | null;
  description: string | null;
  source: 'xml' | 'admin' | null;
  reserved_until: string | null;
  show_on_homepage: boolean;
  created_at: string;
  updated_at: string;
}

// Map DB row to frontend Car interface
export function mapCarRow(row: CarRow): Car {
  return {
    id: row.id,
    brand: row.brand,
    model: row.model,
    year: row.year ?? 0,
    price: row.price ?? 0,
    mileage: row.mileage ?? 0,
    fuel: row.fuel ?? '',
    transmission: row.transmission ?? '',
    image: row.image,
    images: row.images ?? [],
    features: row.features ?? [],
    engine: row.engine ?? '',
    power: row.power ?? '',
    bodyType: row.body_type ?? '',
    drivetrain: row.drivetrain ?? '',
    vin: row.vin ?? '',
    description: row.description ?? '',
    source: row.source ?? undefined,
    reservedUntil: row.reserved_until ?? undefined,
    showOnHomepage: row.show_on_homepage,
  };
}

// Map frontend Car to DB row for insert/update
export function mapCarToRow(car: Partial<Car>, siteId: string): Partial<CarRow> {
  const row: Partial<CarRow> = {
    site_id: siteId,
    brand: car.brand,
    model: car.model,
    year: car.year,
    price: car.price,
    mileage: car.mileage,
    fuel: car.fuel,
    transmission: car.transmission,
    images: car.images,
    features: car.features,
    engine: car.engine,
    power: car.power,
    body_type: car.bodyType,
    drivetrain: car.drivetrain,
    vin: car.vin,
    description: car.description,
    source: car.source,
    reserved_until: car.reservedUntil,
    show_on_homepage: car.showOnHomepage ?? false,
  };

  // Only include image if it's defined (to avoid NOT NULL constraint issues)
  // Use empty string as default for new cars without images
  if (car.image !== undefined) {
    row.image = car.image || '';
  }

  return row;
}
