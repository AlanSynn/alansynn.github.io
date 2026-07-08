// data.ts — single access point for all structured content. YAML lives in
// content/ (sole user-edit zone); papers.bib parsed at build by papers.ts.
// Every YAML is parsed through a strict Zod schema (content-schema.ts), so a
// typo or unknown key fails loudly at build. enforcePaperIntegrity runs at
// module init (featured-without-selected throws).

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

const cv = cvSchema.parse(cvRaw);

// entry-visible mirror of lib.typ at default target "". Web = untargeted view:
// `only:` entries hidden (target-specific), `except:` shown, neither shown.
// Exported so the homepage applies the same rule to honors groups.
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
// Validation-only parse: CV reads references.yaml directly, web never renders
// it. Validating here means web-only CI catches a bad file before a bad PDF.
referencesSchema.parse(referencesData);

const venues = venuesSchema.parse(venuesRaw);
const coauthors = coauthorsSchema.parse(coauthorsRaw);

// Validation-only: targets.yaml is PDF-side config (web never renders it).
// Parse so a typo fails web CI before a bad PDF is generated locally.
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

export interface NewsItem {
  date: Date;
  link?: string;
  highlight?: boolean;
  body: string;
}

export const newsItems: NewsItem[] = z.array(newsItemSchema).parse(newsRaw);

// Cross-ref integrity (abbr ∈ venues, featured/selected). Throws on
// featured-without-selected; warns on missing venue key. Fires once at init.
enforcePaperIntegrity(getPapers(), venues as unknown as Record<string, VenueInfo>);

export function venueInfo(abbr: string | null): VenueInfo | null {
  if (!abbr) return null;
  return (venues as Record<string, VenueInfo>)[abbr] ?? null;
}

// Coauthor URL lookup by family name (hyperlinks authors in pub lists).
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

// Lookup a paper by its bib citekey. Academic project pages DRY-link their
// hero/citation/BibTeX to the papers.bib source via a `paper:` frontmatter
// field; this resolves it. Linear scan over the cached list (tiny). Returns
// null if not found — the caller in [slug].astro getStaticPaths throws on miss.
export function getPaperByKey(key: string): Paper | null {
  return getPapers().find((p) => p.key === key) ?? null;
}

// Site origin without trailing slash, for same-origin link detection.
const ORIGIN = (site.url as string).replace(/\/$/, '');

// True for URLs that point at a route ON THIS SITE (root-relative paths or
// same-origin absolute). Such links must navigate client-side (same tab) so
// Astro's ClientRouter view-transitions fire — opening them in a new tab or as
// a full load to the production origin defeats both transitions and local dev.
export function isInternalHref(u: string | null | undefined): boolean {
  if (!u) return false;
  if (u.startsWith('/')) return !u.startsWith('//'); // root-relative (not protocol-relative)
  return u.startsWith(ORIGIN + '/') || u === ORIGIN;
}

// Normalize a same-origin absolute URL to a root-relative path (keeps
// client-side navigation working); leaves external URLs untouched. e.g.
// "https://alansynn.com/projects/x" → "/projects/x".
export function webPath(u: string | null | undefined): string | null {
  if (!u) return null;
  if (u.startsWith(ORIGIN + '/')) return u.slice(ORIGIN.length);
  if (u === ORIGIN) return '/';
  return u;
}
