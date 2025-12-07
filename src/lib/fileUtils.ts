export function getFileExtension(file: File): string {
  const parts = file.name.split('.')
  return parts.length > 1 ? parts.pop()!.toLowerCase() : 'jpg'
}

export function generateUUID(): string {
  return crypto.randomUUID()
}
