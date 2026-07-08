// Project-collection helpers shared by the project routes.
import { getCollection, type CollectionEntry } from 'astro:content';

// Fetch a single project by its slug (the filename stem under content/projects/).
// Used by the per-work-project static route files (see src/pages/projects/*.astro
// for the 3 work projects) — academic/paper projects are served by [slug].astro.
export async function getProjectBySlug(slug: string): Promise<CollectionEntry<'projects'>> {
  const all = await getCollection('projects');
  const project = all.find((p) => p.id === slug);
  if (!project) {
    throw new Error(
      `[content] project "${slug}" not found in content/projects/. ` +
        `Check the filename matches the route.`,
    );
  }
  return project;
}
