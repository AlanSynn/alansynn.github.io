// ============================================================================
// data.ts - single access point for all structured content. YAML files live
// in content/ (the sole user-edit zone); papers.bib is parsed at build by
// papers.ts. Import from here in any .astro frontmatter.
//
// Every structured YAML is parsed through a Zod schema in content-schema.ts
// (incl. news) so a typo (bad key / wrong type / missing required field) fails
// loudly at build time with a located error instead of rendering wrong or
// throwing deep in a component. Paper cross-references (abbr ∈ venues,
// featured/selected asymmetry) are warned at build via warnPaperIntegrity.
// ============================================================================

import siteRaw from '@content/site.yaml';
import cvRaw from '@content/cv.yaml';
import honorsRaw from '@content/honors.yaml';
import referencesData from '@content/references.yaml';
import skillsRaw from '@content/skills.yaml';
import researchInterestsRaw from '@content/research-interests.yaml';
import venues from '@content/venues.yaml';
import coauthors from '@content/coauthors.yaml';
import newsRaw from '@content/news.yaml';
import { z } from 'astro:content';
import { getPapers, type Paper, type Author } from './papers';
import {
  cvSchema,
  siteSchema,
  honorsSchema,
  referencesSchema,
  skillsSchema,
  researchInterestsSchema,
  newsItemSchema,
  warnPaperIntegrity,
} from './content-schema';

// ---- Parse structured YAML through schemas --------------------------------
const cv = cvSchema.parse(cvRaw);

// Per-entry targeting (only:/except:) — mirrors resume/typst/lib.typ's
// entry-visible at the default target "". The web is the untargeted view
// (paired with the default CV), so an `only:`-tagged entry is target-specific
// and hidden here; an `except:`-tagged entry is shown (the web is never the
// excluded PDF target). Entries with neither flag show. Keeps web + default
// CV in sync so an `only:`/`except:` edit can't silently diverge them.
const entryVisible = (e: {
  only?: string | string[];
  except?: string | string[];
}): boolean => e.only === undefined;

const education = cv.education.filter(entryVisible);
const experience = cv.experience.filter(entryVisible);
const teaching = cv.teaching.filter(entryVisible);
const activities = cv.activities.filter(entryVisible);

const site = siteSchema.parse(siteRaw);
const honors = honorsSchema.parse(honorsRaw);
const skills = skillsSchema.parse(skillsRaw);
const researchInterests = researchInterestsSchema.parse(researchInterestsRaw);
const references = referencesSchema.parse(referencesData);

export {
  site, education, experience, honors, teaching, activities,
  researchInterests, venues, coauthors, getPapers, skills,
};
export type { Paper, Author };

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

export const newsItems: NewsItem[] = z.array(newsItemSchema).parse(newsRaw);

// Cross-reference integrity (abbr ∈ venues, featured/selected asymmetry).
// Warns only — does not block the add-paper workflow (bib first, venue/flag
// added next). Fires once per build at module init.
warnPaperIntegrity(getPapers(), venues as Record<string, VenueInfo>);

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
