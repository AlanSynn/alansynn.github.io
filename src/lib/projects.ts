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

// Canonical sort/group year for a project. For a work project this is its MOST
// RECENT activity — the END of the period range — so newest-first ordering
// matches #publications (a pub's year is its "of record"/end event). An explicit
// frontmatter `date` overrides the period-string parse as a deterministic
// escape hatch for odd ranges. Returns null only if neither yields a 4-digit
// year; getWorkProjects() treats that as a build error.
export function projectYear(p: CollectionEntry<'projects'>): number | null {
  const d = p.data;
  if (d.date instanceof Date) return d.date.getUTCFullYear();
  if (typeof d.period === 'string') {
    const years = d.period.match(/\d{4}/g);
    if (years && years.length > 0) return Number(years[years.length - 1]);
  }
  return null;
}

// Homepage #projects = work/engineering only, newest year first (end-of-range),
// mirroring #publications. `order` is now just an in-year tiebreaker (higher =
// earlier within the same year) — no global manual rank, so adding a project
// never requires renumbering. Throws if a work project has no parseable year
// (no 4-digit year in `period` and no `date`), matching the repo's fail-loud
// convention so a future entry can't silently misorder.
export async function getWorkProjects(): Promise<CollectionEntry<'projects'>[]> {
  const all = await getCollection('projects');
  const work = all.filter((p) => p.data.category !== 'research');
  for (const p of work) {
    if (projectYear(p) === null) {
      throw new Error(
        `[content] work project "${p.id}" has no parseable year — give its ` +
          `frontmatter a \`period\` with a 4-digit year (e.g. "2024") or an ` +
          `explicit \`date\`. The homepage sorts projects by year.`,
      );
    }
  }
  return work.sort((a, b) => {
    const ya = projectYear(a) ?? 0;
    const yb = projectYear(b) ?? 0;
    if (yb !== ya) return yb - ya; // year DESC (primary)
    return (b.data.order ?? 0) - (a.data.order ?? 0); // order DESC (in-year tiebreaker)
  });
}
