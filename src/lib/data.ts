// ============================================================================
// data.ts - single access point for all structured content. YAML files live
// in content/ (the sole user-edit zone); papers.bib is parsed at build by
// papers.ts. Import from here in any .astro frontmatter.
// ============================================================================

import site from '@content/site.yaml';
import education from '@content/education.yaml';
import experience from '@content/experience.yaml';
import honors from '@content/honors.yaml';
import teaching from '@content/teaching.yaml';
import activities from '@content/activities.yaml';
import referencesData from '@content/references.yaml';
import skills from '@content/skills.yaml';
import researchInterests from '@content/research-interests.yaml';
import venues from '@content/venues.yaml';
import coauthors from '@content/coauthors.yaml';
import newsRaw from '@content/news.yaml';
import { z } from 'astro:content';
import { getPapers, formatAuthors, type Paper, type Author } from './papers';

export {
  site, education, experience, honors, teaching, activities,
  researchInterests, venues, coauthors, getPapers, formatAuthors, skills,
};
export type { Paper, Author };

export const references = referencesData;

// "Me" - used to bold + disambiguate the owner in author lists.
export const me = {
  family: site.last_name,
  givenFirst: [site.first_name, site.nick_name, 'D.'],
};

export interface VenueInfo { url?: string; color?: string; name?: string }

// News item shape (sourced from content/news.yaml).
export interface NewsItem {
  date: Date;
  link?: string;
  highlight?: boolean;
  body: string;
}

// Validate content/news.yaml at build time so a typo in the single most-edited
// file (bad date, malformed link, missing body) fails loudly instead of
// rendering wrong or throwing deep in the formatter. Mirrors the schema the old
// per-item Astro collection enforced.
const newsItemSchema = z.object({
  date: z.coerce.date(),
  link: z.string().url().optional(),
  highlight: z.boolean().default(false),
  body: z.string(),
});

export const newsItems: NewsItem[] = z.array(newsItemSchema).parse(newsRaw);

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
