// ============================================================================
// data.ts - single access point for all structured content. YAML files live
// in content/ (the sole user-edit zone); papers.bib is parsed at build by
// papers.ts. Import from here in any .astro frontmatter.
//
// Every structured YAML is parsed through a STRICT Zod schema in
// content-schema.ts, so a typo (bad key / wrong type / missing required field)
// OR an unknown field (a dead key with no consumer) fails loudly at build time
// with a located error. Paper cross-references (abbr ∈ venues,
// featured/selected asymmetry) are enforced at build via
// enforcePaperIntegrity (featured-without-selected throws).
// ============================================================================

import siteRaw from '@content/site.yaml';
import cvRaw from '@content/cv.yaml';
import honorsRaw from '@content/honors.yaml';
import referencesData from '@content/references.yaml';
import researchInterestsRaw from '@content/research-interests.yaml';
import venuesRaw from '@content/venues.yaml';
import coauthorsRaw from '@content/coauthors.yaml';
import targetsRaw from '@content/targets.yaml';
import newsRaw from '@content/news.yaml';
import { z } from 'astro/zod';
import { getPapers, type Paper, type Author } from './papers';
import {
  cvSchema,
  siteSchema,
  honorsSchema,
  referencesSchema,
  researchInterestsSchema,
  venuesSchema,
  coauthorsSchema,
  targetsSchema,
  newsItemSchema,
  enforcePaperIntegrity,
} from './content-schema';

// ---- Parse structured YAML through schemas --------------------------------
const cv = cvSchema.parse(cvRaw);

// Per-entry targeting (only:/except:) — mirrors resume/typst/lib.typ's
// entry-visible at the default target "". The web is the untargeted view
// (paired with the default CV), so an `only:`-tagged entry is target-specific
// and hidden here; an `except:`-tagged entry is shown (the web is never the
// excluded PDF target). Entries with neither flag show. Exported so the
// homepage can apply the same rule to the honors groups.
export const entryVisible = (e: {
  only?: string | string[];
  except?: string | string[];
}): boolean => e.only === undefined;

const education = cv.education.filter(entryVisible);
const experience = cv.experience.filter(entryVisible);
const teaching = cv.teaching.filter(entryVisible);
const activities = cv.activities.filter(entryVisible);

const site = siteSchema.parse(siteRaw);
const honors = honorsSchema.parse(honorsRaw);
const researchInterests = researchInterestsSchema.parse(researchInterestsRaw);
// Parsed purely for validation — the CV (Typst) reads references.yaml directly;
// the web never renders it. Validating here means CI (web-only) catches a
// malformed references.yaml before a bad PDF is generated locally.
referencesSchema.parse(referencesData);

// Lookup files (venue badges + coauthor links) — now schema-validated, so a
// malformed entry fails the build instead of casting silently.
const venues = venuesSchema.parse(venuesRaw);
const coauthors = coauthorsSchema.parse(coauthorsRaw);

// targets.yaml is PDF-side config (targeted resume/CV variants); the web is the
// default/untargeted view and never renders it. Parse purely to validate — a
// typo in a target's blurb/keywords fails the web build too, so CI (web-only)
// catches it before a bad PDF is generated locally.
targetsSchema.parse(targetsRaw);

export {
  site,
  education,
  experience,
  honors,
  teaching,
  activities,
  researchInterests,
  venues,
  getPapers,
};
export type { Paper, Author };

// "Me" - used to bold + disambiguate the owner in author lists.
export const me = {
  family: site.last_name,
  givenFirst: [site.first_name, site.nick_name, 'D.'],
};

export interface VenueInfo {
  url?: string;
  name?: string;
  type?: 'journal' | 'conference' | 'preprint';
}

// News item shape (sourced from content/news.yaml).
export interface NewsItem {
  date: Date;
  link?: string;
  highlight?: boolean;
  body: string;
}

export const newsItems: NewsItem[] = z.array(newsItemSchema).parse(newsRaw);

// Cross-reference integrity (abbr ∈ venues, featured/selected asymmetry).
// Throws on featured-without-selected (always an oversight); warns on a paper
// whose abbr has no venues.yaml key (cosmetic, workflow-tolerant). Fires once
// per build at module init.
enforcePaperIntegrity(getPapers(), venues as unknown as Record<string, VenueInfo>);

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
    }),
  );
  return (hit ?? entry[0])?.url ?? null;
}
