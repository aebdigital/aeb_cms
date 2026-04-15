ALTER TABLE public.projects
ADD COLUMN IF NOT EXISTS display_order INTEGER;

WITH ordered_projects AS (
  SELECT
    id,
    ROW_NUMBER() OVER (
      PARTITION BY site_id
      ORDER BY created_at DESC, id DESC
    ) - 1 AS new_display_order
  FROM public.projects
)
UPDATE public.projects AS projects
SET display_order = ordered_projects.new_display_order
FROM ordered_projects
WHERE projects.id = ordered_projects.id
  AND projects.display_order IS NULL;

CREATE INDEX IF NOT EXISTS projects_site_id_display_order_idx
ON public.projects (site_id, display_order);
