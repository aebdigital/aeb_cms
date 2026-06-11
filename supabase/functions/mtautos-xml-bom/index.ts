import { serve } from "https://deno.land/std@0.224.0/http/server.ts";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

const SUPABASE_URL = Deno.env.get("SUPABASE_URL")!;
const SUPABASE_SERVICE_ROLE_KEY = Deno.env.get("SERVICE_ROLE_KEY")!;
const MTAUTOS_SITE_ID = Deno.env.get("MTAUTOS_SITE_ID")!;
const PUBLIC_SITE_BASE_URL = Deno.env.get("PUBLIC_SITE_BASE_URL") || "https://mtautos.sk";
const STORAGE_BUCKET = Deno.env.get("STORAGE_BUCKET") || "site-uploads";

const supabase = createClient(SUPABASE_URL, SUPABASE_SERVICE_ROLE_KEY);

interface CarRow {
  id: string;
  site_id: string;
  brand: string | null;
  model: string | null;
  year: number | null;
  price: number | null;
  mileage: number | null;
  fuel: string | null;
  transmission: string | null;
  image: string | null;
  images: string[] | null;
  engine: string | null;
  power: string | null;
  body_type: string | null;
  drivetrain: string | null;
  vin: string | null;
  seats: number | null;
  description: string | null;
  features: string[] | null;
  reserved_until: string | null;
  show_on_homepage: boolean | null;
  created_at: string | null;
  updated_at: string | null;
  slug?: string | null;
  deleted_at: string | null;
}

function escapeCdata(value: string | null | undefined): string {
  if (!value) return "";
  return value.replaceAll("]]>", "]]]]><![CDATA[>");
}

function buildImageUrl(path: string): string {
  return `${SUPABASE_URL}/storage/v1/object/public/${STORAGE_BUCKET}/${path}`;
}

serve(async (_req) => {
  // Exclude archived cars where deleted_at is not null
  const { data: cars, error } = await supabase
    .from("cars")
    .select("*")
    .eq("site_id", MTAUTOS_SITE_ID)
    .is("deleted_at", null);

  if (error) {
    console.error("Error loading cars:", error);
    return new Response("Error loading cars", { status: 500 });
  }

  const xmlParts: string[] = [];
  xmlParts.push(`<?xml version="1.0" encoding="UTF-8"?>`);
  xmlParts.push(`<advertisements>`);

  for (const car of (cars ?? []) as CarRow[]) {
    const brand = car.brand ?? "";
    const model = car.model ?? "";
    const title = `${brand} ${model}`.trim();
    const carSlug = car.slug && car.slug.length > 0 ? car.slug : car.id;
    const detailUrl = `${PUBLIC_SITE_BASE_URL}/auta/${carSlug}`;

    const imagePaths: string[] = [];
    if (car.image) imagePaths.push(car.image);
    if (car.images && Array.isArray(car.images)) {
      imagePaths.push(...car.images);
    }

    const isReserved = !!car.reserved_until;
    const cena = car.price != null ? String(car.price) : "";
    const rok = car.year != null ? String(car.year) : "";
    const najazdeneKm = car.mileage != null ? String(car.mileage) : "";

    xmlParts.push(`<advertisement>`);
    xmlParts.push(`<idAdvertisement>${car.id}</idAdvertisement>`);
    xmlParts.push(`<idMainCategory>1</idMainCategory>`);
    xmlParts.push(`<idCategory>101549</idCategory>`);
    xmlParts.push(`<brand><![CDATA[${escapeCdata(brand)}]]></brand>`);
    xmlParts.push(`<model><![CDATA[${escapeCdata(model)}]]></model>`);
    xmlParts.push(`<categoryTitle><![CDATA[${escapeCdata(title)}]]></categoryTitle>`);
    xmlParts.push(`<title><![CDATA[${escapeCdata(title)}]]></title>`);
    xmlParts.push(`<content><![CDATA[]]></content>`);
    xmlParts.push(`<contentExtend><![CDATA[${escapeCdata(car.description)}]]></contentExtend>`);

    const optionsParts: string[] = [];
    if (car.features && car.features.length > 0) {
      optionsParts.push(`Vybava: ${car.features.join(", ")}`);
    }
    if (car.mileage != null) optionsParts.push(`Najazdene km: ${car.mileage}`);
    if (car.fuel) optionsParts.push(`Palivo: ${car.fuel}`);
    if (car.transmission) optionsParts.push(`Prevodovka: ${car.transmission}`);
    if (car.engine) optionsParts.push(`Motor: ${car.engine}`);
    if (car.power) optionsParts.push(`Vykon: ${car.power}`);
    if (car.body_type) optionsParts.push(`Karoseria: ${car.body_type}`);
    if (car.drivetrain) optionsParts.push(`Pohon: ${car.drivetrain}`);
    if (car.seats != null) optionsParts.push(`Počet miest: ${car.seats}`);

    xmlParts.push(`<contentOptions><![CDATA[${escapeCdata(optionsParts.join(" | "))}]]></contentOptions>`);
    xmlParts.push(`<timeCreated>${car.created_at ?? ""}</timeCreated>`);
    xmlParts.push(`<timeChanged>${car.updated_at ?? car.created_at ?? ""}</timeChanged>`);
    xmlParts.push(`<link><![CDATA[${escapeCdata(detailUrl)}]]></link>`);
    xmlParts.push(`<sourceId>0</sourceId>`);
    xmlParts.push(`<isReserved><![CDATA[${isReserved ? "true" : "false"}]]></isReserved>`);

    xmlParts.push(`<params>`);
    xmlParts.push(`<cena><![CDATA[${cena}]]></cena>`);
    xmlParts.push(`<rok><![CDATA[${rok}]]></rok>`);
    xmlParts.push(`<vin><![CDATA[${escapeCdata(car.vin)}]]></vin>`);
    xmlParts.push(`<najazdene-km><![CDATA[${najazdeneKm}]]></najazdene-km>`);
    xmlParts.push(`<palivo_value><![CDATA[${escapeCdata(car.fuel)}]]></palivo_value>`);
    xmlParts.push(`<karoseria_value><![CDATA[${escapeCdata(car.body_type)}]]></karoseria_value>`);
    xmlParts.push(`<prevodovka_value><![CDATA[${escapeCdata(car.transmission)}]]></prevodovka_value>`);
    xmlParts.push(`<pohon_value><![CDATA[${escapeCdata(car.drivetrain)}]]></pohon_value>`);
    xmlParts.push(`<vykon-motora><![CDATA[${escapeCdata(car.power)}]]></vykon-motora>`);
    xmlParts.push(`<objem-motora><![CDATA[${escapeCdata(car.engine)}]]></objem-motora>`);
    xmlParts.push(`<miest-na-sedenie_value><![CDATA[${car.seats != null ? String(car.seats) : ""}]]></miest-na-sedenie_value>`);
    xmlParts.push(`</params>`);

    xmlParts.push(`<photos>`);
    for (const path of imagePaths) {
      if (!path) continue;
      xmlParts.push(`<photo><![CDATA[${escapeCdata(buildImageUrl(path))}]]></photo>`);
    }
    xmlParts.push(`</photos>`);
    xmlParts.push(`</advertisement>`);
  }

  xmlParts.push(`</advertisements>`);

  const xmlContent = xmlParts.join("\n");
  
  // Encode as UTF-8 bytes and prepend the BOM bytes (0xEF, 0xBB, 0xBF)
  const bom = new Uint8Array([0xEF, 0xBB, 0xBF]);
  const xmlBytes = new TextEncoder().encode(xmlContent);
  const responseBody = new Uint8Array(bom.length + xmlBytes.length);
  responseBody.set(bom, 0);
  responseBody.set(xmlBytes, bom.length);

  return new Response(responseBody, {
    status: 200,
    headers: {
      "Content-Type": "text/xml; charset=utf-8",
      "Cache-Control": "public, max-age=300",
    },
  });
});
