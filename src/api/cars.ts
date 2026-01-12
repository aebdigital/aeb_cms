import { supabase } from '../lib/supabaseClient'
import { Car, CarRow, mapCarRow, mapCarToRow } from '../types/car'

export interface CarFilterOptions {
  featuredOnly?: boolean
  minPrice?: number | null
  maxPrice?: number | null
  fuel?: string | null
  transmission?: string | null
  brand?: string | null
  bodyType?: string | null
  minYear?: number | null
  maxYear?: number | null
  limit?: number
  offset?: number
  search?: string
}

export async function getCarsForSite(siteId: string, opts?: CarFilterOptions): Promise<Car[]> {
  let query = supabase
    .from('cars')
    .select('*')
    .eq('site_id', siteId)
    .is('deleted_at', null) // Only get non-deleted cars

  if (opts?.featuredOnly) {
    query = query.eq('show_on_homepage', true)
  }
  if (opts?.minPrice != null) {
    query = query.gte('price', opts.minPrice)
  }
  if (opts?.maxPrice != null) {
    query = query.lte('price', opts.maxPrice)
  }
  if (opts?.fuel) {
    query = query.eq('fuel', opts.fuel)
  }
  if (opts?.transmission) {
    query = query.eq('transmission', opts.transmission)
  }
  if (opts?.brand) {
    query = query.eq('brand', opts.brand)
  }
  if (opts?.bodyType) {
    query = query.eq('body_type', opts.bodyType)
  }
  if (opts?.minYear != null) {
    query = query.gte('year', opts.minYear)
  }
  if (opts?.maxYear != null) {
    query = query.lte('year', opts.maxYear)
  }
  if (opts?.search) {
    const s = `%${opts.search}%`
    query = query.or(`brand.ilike.${s},model.ilike.${s},description.ilike.${s}`)
  }
  if (opts?.offset) {
    query = query.range(opts.offset, opts.offset + (opts.limit || 50) - 1)
  } else if (opts?.limit) {
    query = query.limit(opts.limit)
  }

  query = query.order('created_at', { ascending: false })

  const { data, error } = await query
  if (error) throw error
  return (data as CarRow[]).map(mapCarRow)
}

export async function getCar(carId: string): Promise<Car> {
  const { data, error } = await supabase
    .from('cars')
    .select('*')
    .eq('id', carId)
    .single()

  if (error) throw error
  return mapCarRow(data as CarRow)
}

export async function createCar(siteId: string, car: Partial<Car>): Promise<Car> {
  const row = mapCarToRow(car, siteId)
  // Ensure image has a default value for NOT NULL constraint
  if (!row.image) {
    row.image = ''
  }
  const { data, error } = await supabase
    .from('cars')
    .insert(row)
    .select()
    .single()

  if (error) throw error
  return mapCarRow(data as CarRow)
}

export async function updateCar(carId: string, updates: Partial<Car>, siteId: string): Promise<Car> {
  const row = mapCarToRow(updates, siteId)
  // Remove site_id from update (shouldn't change)
  delete row.site_id

  const { data, error } = await supabase
    .from('cars')
    .update(row)
    .eq('id', carId)
    .select()
    .single()

  if (error) throw error
  return mapCarRow(data as CarRow)
}

export async function deleteCar(carId: string): Promise<void> {
  // Soft delete - set deleted_at timestamp
  const { error } = await supabase
    .from('cars')
    .update({ deleted_at: new Date().toISOString() })
    .eq('id', carId)

  if (error) throw error
}

// Permanently delete a car (hard delete)
export async function permanentlyDeleteCar(carId: string): Promise<void> {
  const { error } = await supabase
    .from('cars')
    .delete()
    .eq('id', carId)

  if (error) throw error
}

// Restore a soft-deleted car
export async function restoreCar(carId: string): Promise<Car> {
  const { data, error } = await supabase
    .from('cars')
    .update({ deleted_at: null })
    .eq('id', carId)
    .select()
    .single()

  if (error) throw error
  return mapCarRow(data as CarRow)
}

// Get all cars including deleted ones (for archive)
export async function getAllCarsForSite(siteId: string, includeDeleted: boolean = true): Promise<Car[]> {
  let query = supabase
    .from('cars')
    .select('*')
    .eq('site_id', siteId)

  if (!includeDeleted) {
    query = query.is('deleted_at', null)
  }

  query = query.order('deleted_at', { ascending: true, nullsFirst: true })
    .order('created_at', { ascending: false })

  const { data, error } = await query
  if (error) throw error
  return (data as CarRow[]).map(mapCarRow)
}

export async function toggleCarFeatured(carId: string, isFeatured: boolean, siteId: string): Promise<Car> {
  return updateCar(carId, { showOnHomepage: isFeatured }, siteId)
}

export async function getCarCount(siteId: string): Promise<number> {
  const { count, error } = await supabase
    .from('cars')
    .select('*', { count: 'exact', head: true })
    .eq('site_id', siteId)

  if (error) throw error
  return count || 0
}

export async function getUniqueBrands(siteId: string): Promise<string[]> {
  const { data, error } = await supabase
    .from('cars')
    .select('brand')
    .eq('site_id', siteId)

  if (error) throw error

  const uniqueBrands = [...new Set(data.map(c => c.brand))].sort()
  return uniqueBrands
}

export async function getUniqueFuelTypes(siteId: string): Promise<string[]> {
  const { data, error } = await supabase
    .from('cars')
    .select('fuel')
    .eq('site_id', siteId)

  if (error) throw error

  const uniqueFuels = [...new Set(data.map(c => c.fuel))].sort()
  return uniqueFuels
}
