// ============================================================================
// content-schema.ts — single source of truth for the SHAPE of every structured
// YAML in content/. Mirrors and generalizes the newsItemSchema pattern already
// used in data.ts.
//
// Why this exists (independent of file count): the 11 structured YAMLs were
// imported as untyped `as Record<...>` objects, so a typo (bad key, wrong
// type, missing required field) rendered wrong or threw deep in a component
// with zero signal. Parsing through Zod here turns those into loud, located
// build errors. This is the actual fix for the "management cost" pain —
// schema coverage is orthogonal to how many files hold the data.
//
// Two cross-reference rules that were previously only documented (CLAUDE.md)
// are enforced here as build-time warnings:
//   1. every paper's `abbr` should have a matching key in venues.yaml
//      (else the venue badge renders as bare text);
//   2. a paper flagged `featured` (web-top) without an explicit `selected`
//      (PDF) is usually an oversight — flag the asymmetry, don't force a value.
// Both warn rather than throw so the add-paper workflow (bib first, venue/
// flag second) is not blocked mid-edit.
// ============================================================================

import { z } from 'astro:content';

// ---- Per-entry targeting (only: / except: on any CV timeline entry) --------
// Accepts a single target string or a list. Mirrors lib.typ's entry-visible.
const targetList = z.union([z.string(), z.array(z.string())]);

// ---- Timeline entry: { period, title, location?, body?, only?/except? } -----
// Shared by every section of content/cv.yaml (education / experience /
// teaching / activities). `body` is optional because a future title-only
// entry is valid; `location` is optional (teaching/activities often omit it).
export const timelineEntry = z.object({
  period: z.string(),
  title: z.string(),
  location: z.string().optional(),
  body: z.string().optional(),
  only: targetList.optional(),
  except: targetList.optional(),
});

export const cvSchema = z.object({
  education: z.array(timelineEntry),
  experience: z.array(timelineEntry),
  teaching: z.array(timelineEntry),
  activities: z.array(timelineEntry),
});

// ---- site.yaml — identity / contact / socials / SEO ------------------------
export const siteSchema = z.object({
  name: z.string(),
  short_name: z.string(),
  first_name: z.string(),
  nick_name: z.string(),
  last_name: z.string(),
  title: z.string(),
  affiliation: z.string(),
  department: z.string().optional(),
  location: z.string().optional(),
  email: z.string(),
  email_obfuscated: z.string(),
  phone: z.string().optional(),
  url: z.string().url(),
  domain: z.string().optional(),
  description: z.string(),
  keywords: z.array(z.string()).default([]),
  tagline: z.string(),
  socials: z
    .array(
      z.object({
        label: z.string(),
        url: z.string(),
        icon: z.string(),
      }),
    )
    .default([]),
});

// ---- honors.yaml — { group, items: [markdown] } ----------------------------
export const honorsSchema = z.array(
  z.object({
    group: z.string(),
    items: z.array(z.string()),
    only: targetList.optional(),
    except: targetList.optional(),
  }),
);

// ---- references.yaml — CV reference contacts -------------------------------
export const referencesSchema = z.array(
  z.object({
    name: z.string(),
    role: z.string().optional(),
    affiliation: z.string().optional(),
    department: z.string().optional(),
    email: z.string().optional(),
    url: z.string().url().optional(),
  }),
);

// ---- skills.yaml — { category, items[] } -----------------------------------
export const skillsSchema = z.array(
  z.object({
    category: z.string(),
    items: z.array(z.string()),
  }),
);

// ---- research-interests.yaml — { statements[], focus_areas[] } -------------
export const researchInterestsSchema = z.object({
  statements: z.array(z.string()),
  focus_areas: z.array(z.string()),
});

// ---- news.yaml — { date, link?, highlight?, body } -------------------------
// The single most-edited file; coerce date + URL-validate the link so a bad
// entry fails loudly at build instead of rendering wrong or throwing deep in
// NewsList. Mirrors the schema the old per-item Astro collection enforced.
export const newsItemSchema = z.object({
  date: z.coerce.date(),
  link: z.string().url().optional(),
  highlight: z.boolean().default(false),
  body: z.string(),
});

// ---- Cross-reference integrity (build-time warnings) -----------------------
// Paper shape mirrors the relevant subset of src/lib/papers.ts Paper.
interface PaperLike {
  title: string;
  abbr: string | null;
  selected: boolean;
  featured: boolean;
}

interface VenueLike {
  name?: string;
  url?: string;
  color?: string;
}

/**
 * Warn (not throw) on two documented-but-unenforced rules:
 *   - abbr with no matching venues.yaml key → badge renders bare.
 *   - featured without explicit selected → homepage-top paper missing from PDF.
 * Surfaces every violation as a single console line so the build log lists
 * them all without stopping at the first.
 */
export function warnPaperIntegrity(
  papers: PaperLike[],
  venues: Record<string, VenueLike>,
): void {
  const missingVenues = papers.filter(
    (p) => p.abbr && !(p.abbr in venues),
  );
  if (missingVenues.length > 0) {
    console.warn(
      `[content] ${missingVenues.length} paper(s) have an abbr with no matching key in content/venues.yaml (badge will render as bare text):`,
      missingVenues.map((p) => `${p.abbr} (${p.title.slice(0, 50)})`).join(' | '),
    );
  }

  const asymmetric = papers.filter((p) => p.featured && !p.selected);
  if (asymmetric.length > 0) {
    console.warn(
      `[content] ${asymmetric.length} paper(s) are featured (web-top) but not selected (PDF) — usually an oversight:`,
      asymmetric.map((p) => p.title.slice(0, 50)).join(' | '),
    );
  }
}
