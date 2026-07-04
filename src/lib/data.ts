// ============================================================================
// data.ts — single access point for all structured content. YAML files live
// in src/data/ (human-edited); papers.bib is parsed at build by papers.ts.
// Import from here in any .astro frontmatter.
// ============================================================================

import site from '@/data/site.yaml';
import education from '@/data/education.yaml';
import experience from '@/data/experience.yaml';
import honors from '@/data/honors.yaml';
import teaching from '@/data/teaching.yaml';
import activities from '@/data/activities.yaml';
import referencesData from '@/data/references.yaml';
import skills from '@/data/skills.yaml';
import researchInterests from '@/data/research-interests.yaml';
import venues from '@/data/venues.yaml';
import coauthors from '@/data/coauthors.yaml';
import { getPapers, formatAuthors, type Paper, type Author } from './papers';

export {
  site, education, experience, honors, teaching, activities,
  researchInterests, venues, coauthors, getPapers, formatAuthors, skills,
};
export type { Paper, Author };

export const references = referencesData;

// "Me" — used to bold + disambiguate the owner in author lists.
export const me = {
  family: site.last_name,
  givenFirst: [site.first_name, site.nick_name, 'D.'],
};

export interface VenueInfo { url?: string; color?: string }

export function venueInfo(abbr: string | null): VenueInfo | null {
  if (!abbr) return null;
  return (venues as Record<string, VenueInfo>)[abbr] ?? null;
}

// Coauthor URL lookup by family name (for hyperlinking authors in pub lists).
export function coauthorUrl(family: string, given: string): string | null {
  const entry = (coauthors as Record<string, Array<{ firstname: string[]; url: string }>>)[family];
  if (!entry) return null;
  const g = given.toLowerCase();
  const hit = entry.find((e) =>
    e.firstname.some((f) => {
      const fl = f.toLowerCase().replace(/\.$/, '');
      return g === fl || g.startsWith(fl) || fl.startsWith(g);
    })
  );
  return (hit ?? entry[0])?.url ?? null;
}
