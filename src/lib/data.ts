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
  enforceTargetFlags,
} from './content-schema';

// Parse through a schema; on failure rethrow with the source filename so the
// error names the YAML. Zod gives a field path but NOT the file — a bare
// "education[0].title: Required" becomes "[content/cv.yaml] education[0].title".
function parseFile<T>(schema: z.ZodType<T>, data: unknown, file: string): T {
  try {
    return schema.parse(data);
  } catch (err) {
    if (err instanceof z.ZodError) {
      const paths = err.issues.map((i) => (i.path.length ? i.path.join('.') : '<root>')).join('; ');
      throw new Error(
        `[content/${file}] validation failed at: ${paths}\n  ${err.issues.map((i) => i.message).join('\n  ')}`,
      );
    }
    throw err;
  }
}

const cv = parseFile(cvSchema, cvRaw, 'cv.yaml');

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

const site = parseFile(siteSchema, siteRaw, 'site.yaml');
const honors = parseFile(honorsSchema, honorsRaw, 'honors.yaml');
const researchInterests = parseFile(
  researchInterestsSchema,
  researchInterestsRaw,
  'research-interests.yaml',
);
// Validation-only parse: CV reads references.yaml directly, web never renders
// it. Validating here means web-only CI catches a bad file before a bad PDF.
parseFile(referencesSchema, referencesData, 'references.yaml');

const venues = parseFile(venuesSchema, venuesRaw, 'venues.yaml');
const coauthors = parseFile(coauthorsSchema, coauthorsRaw, 'coauthors.yaml');

// Validation-only: targets.yaml is PDF-side config (web never renders it).
// Parse so a typo fails web CI before a bad PDF is generated locally. Keys are
// reused below to cross-check only:/except: ids on cv + honors entries.
const targetIds = Object.keys(parseFile(targetsSchema, targetsRaw, 'targets.yaml'));

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

export const newsItems: NewsItem[] = parseFile(z.array(newsItemSchema), newsRaw, 'news.yaml');

// Cross-ref integrity. All THROW, fire once at init:
//  - only:/except: ids on cv/honors entries must be real target ids (a typo
//    otherwise hides the entry on web AND every PDF target — silent vanish).
//  - paper abbr ∈ venues.yaml; featured → selected.
enforceTargetFlags(
  [...cv.education, ...cv.experience, ...cv.teaching, ...cv.activities],
  targetIds,
  'cv.yaml',
);
enforceTargetFlags(
  honors as unknown as { only?: string | string[]; except?: string | string[] }[],
  targetIds,
  'honors.yaml',
);
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
