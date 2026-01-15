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
  // New fields
  doors?: string;
  color?: string;
  countryOfOrigin?: string;
  reserved?: boolean;
  month?: number;
  vatDeductible?: boolean;
  priceWithoutVat?: number;
  transmissionType?: string; // 'manual' | 'automatic'
  transmissionGears?: string;
  airbagCount?: number;
  radioCd?: boolean;
  radioCdMp3?: boolean;
  androidAuto?: boolean;
  acType?: string; // 'manual' | 'automatic'
  acZones?: string; // 'single' | 'dual' | 'triple' | 'quad'
  parkingSensors?: string; // 'front' | 'rear' | 'front_rear'
  electricWindows?: string; // '0' | '2' | '4'
  heatedSeats?: string; // 'front' | 'rear' | 'front_rear'
  deletedAt?: string; // Soft delete timestamp
  // PDF documents
  serviceBookPdf?: string; // Path to service book PDF
  cebiaProtocolPdf?: string; // Path to Cebia protocol PDF
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
  // New fields
  doors: string | null;
  color: string | null;
  country_of_origin: string | null;
  reserved: boolean | null;
  month: number | null;
  vat_deductible: boolean | null;
  price_without_vat: number | null;
  transmission_type: string | null;
  transmission_gears: string | null;
  airbag_count: number | null;
  radio_cd: boolean | null;
  radio_cd_mp3: boolean | null;
  android_auto: boolean | null;
  ac_type: string | null;
  ac_zones: string | null;
  parking_sensors: string | null;
  electric_windows: string | null;
  heated_seats: string | null;
  deleted_at: string | null;
  // PDF documents
  service_book_pdf: string | null;
  cebia_protocol_pdf: string | null;
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
    // New fields
    doors: row.doors ?? undefined,
    color: row.color ?? undefined,
    countryOfOrigin: row.country_of_origin ?? undefined,
    reserved: row.reserved ?? false,
    month: row.month ?? undefined,
    vatDeductible: row.vat_deductible ?? false,
    priceWithoutVat: row.price_without_vat ?? undefined,
    transmissionType: row.transmission_type ?? undefined,
    transmissionGears: row.transmission_gears ?? undefined,
    airbagCount: row.airbag_count ?? undefined,
    radioCd: row.radio_cd ?? false,
    radioCdMp3: row.radio_cd_mp3 ?? false,
    androidAuto: row.android_auto ?? false,
    acType: row.ac_type ?? undefined,
    acZones: row.ac_zones ?? undefined,
    parkingSensors: row.parking_sensors ?? undefined,
    electricWindows: row.electric_windows ?? undefined,
    heatedSeats: row.heated_seats ?? undefined,
    deletedAt: row.deleted_at ?? undefined,
    // PDF documents
    serviceBookPdf: row.service_book_pdf ?? undefined,
    cebiaProtocolPdf: row.cebia_protocol_pdf ?? undefined,
  };
}

// Map frontend Car to DB row for insert/update
export function mapCarToRow(car: Partial<Car>, siteId: string): Partial<CarRow> {
  const row: Partial<CarRow> = {
    site_id: siteId,
  };

  // Only include fields that are explicitly provided (not undefined)
  // This prevents partial updates from overwriting existing values with defaults
  if (car.brand !== undefined) row.brand = car.brand;
  if (car.model !== undefined) row.model = car.model;
  if (car.year !== undefined) row.year = car.year;
  if (car.price !== undefined) row.price = car.price;
  if (car.mileage !== undefined) row.mileage = car.mileage;
  if (car.fuel !== undefined) row.fuel = car.fuel;
  if (car.transmission !== undefined) row.transmission = car.transmission;
  if (car.images !== undefined) row.images = car.images;
  if (car.features !== undefined) row.features = car.features;
  if (car.engine !== undefined) row.engine = car.engine;
  if (car.power !== undefined) row.power = car.power;
  if (car.bodyType !== undefined) row.body_type = car.bodyType;
  if (car.drivetrain !== undefined) row.drivetrain = car.drivetrain;
  if (car.vin !== undefined) row.vin = car.vin;
  if (car.description !== undefined) row.description = car.description;
  if (car.source !== undefined) row.source = car.source;
  if (car.reservedUntil !== undefined) row.reserved_until = car.reservedUntil;
  if (car.showOnHomepage !== undefined) row.show_on_homepage = car.showOnHomepage;
  // New fields
  if (car.doors !== undefined) row.doors = car.doors;
  if (car.color !== undefined) row.color = car.color;
  if (car.countryOfOrigin !== undefined) row.country_of_origin = car.countryOfOrigin;
  if (car.reserved !== undefined) row.reserved = car.reserved;
  if (car.month !== undefined) row.month = car.month;
  if (car.vatDeductible !== undefined) row.vat_deductible = car.vatDeductible;
  if (car.priceWithoutVat !== undefined) row.price_without_vat = car.priceWithoutVat;
  if (car.transmissionType !== undefined) row.transmission_type = car.transmissionType;
  if (car.transmissionGears !== undefined) row.transmission_gears = car.transmissionGears;
  if (car.airbagCount !== undefined) row.airbag_count = car.airbagCount;
  if (car.radioCd !== undefined) row.radio_cd = car.radioCd;
  if (car.radioCdMp3 !== undefined) row.radio_cd_mp3 = car.radioCdMp3;
  if (car.androidAuto !== undefined) row.android_auto = car.androidAuto;
  if (car.acType !== undefined) row.ac_type = car.acType;
  if (car.acZones !== undefined) row.ac_zones = car.acZones;
  if (car.parkingSensors !== undefined) row.parking_sensors = car.parkingSensors;
  if (car.electricWindows !== undefined) row.electric_windows = car.electricWindows;
  if (car.heatedSeats !== undefined) row.heated_seats = car.heatedSeats;
  // PDF documents
  if (car.serviceBookPdf !== undefined) row.service_book_pdf = car.serviceBookPdf;
  if (car.cebiaProtocolPdf !== undefined) row.cebia_protocol_pdf = car.cebiaProtocolPdf;

  // Only include image if it's defined (to avoid NOT NULL constraint issues)
  // Use empty string as default for new cars without images
  if (car.image !== undefined) {
    row.image = car.image || '';
  }

  return row;
}
