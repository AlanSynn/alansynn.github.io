// ============================================================================
// content-schema.ts — single source of truth for the SHAPE of every structured
// YAML in content/. Mirrors and generalizes the newsItemSchema pattern already
// used in data.ts.
//
// Why this exists (independent of file count): the structured YAMLs were
// imported as untyped `as Record<...>` objects, so a typo (bad key, wrong
// type, missing required field) rendered wrong or threw deep in a component
// with zero signal. Parsing through Zod here turns those into loud, located
// build errors. This is the actual fix for the "management cost" pain —
// schema coverage is orthogonal to how many files hold the data.
//
// Every object schema is `.strict()`: an UNKNOWN key (a typo, or a field that
// has no consumer) fails the build loudly instead of being silently stripped.
// This is what makes "edit content/ and you're done" trustworthy — a dead
// field can never again hide as a no-op (the failure mode that left tagline /
// skills.yaml / bibtex_show silently ignored for months).
//
// Two cross-reference rules are enforced here at build time:
//   1. every paper's `abbr` should have a matching key in venues.yaml
//      (else the venue badge renders as bare text) → WARN (cosmetic; the
//      add-paper workflow adds the bib entry before the venue key).
//   2. a paper flagged `featured` (web-top) without `selected` (PDF) is
//      ALWAYS an oversight — the homepage would surface a paper the CV omits.
//      → THROW (fail the build; the fix is one line in papers.bib).
// ============================================================================

import { z } from 'astro/zod';

// ---- Per-entry targeting (only: / except: on any CV timeline entry) --------
// Accepts a single target string or a list. Mirrors lib.typ's entry-visible.
const targetList = z.union([z.string(), z.array(z.string())]);

// ---- Timeline entry: { period, title, location?, body?, only?/except? } -----
// Shared by every section of content/cv.yaml (education / experience /
// teaching / activities). `body` is optional because a future title-only
// entry is valid; `location` is optional (teaching/activities often omit it).
export const timelineEntry = z
  .object({
    period: z.string(),
    title: z.string(),
    location: z.string().optional(),
    body: z.string().optional(),
    only: targetList.optional(),
    except: targetList.optional(),
  })
  .strict();

export const cvSchema = z
  .object({
    education: z.array(timelineEntry),
    experience: z.array(timelineEntry),
    teaching: z.array(timelineEntry),
    activities: z.array(timelineEntry),
  })
  .strict();

// ---- site.yaml — identity / contact / socials / SEO ------------------------
export const siteSchema = z
  .object({
    name: z.string(),
    short_name: z.string(),
    first_name: z.string(),
    nick_name: z.string(),
    last_name: z.string(),
    title: z.string(),
    affiliation: z.string(),
    affiliation_url: z.string().url(),
    department: z.string().optional(),
    department_url: z.string().url().optional(),
    location: z.string().optional(),
    email: z.string(),
    email_obfuscated: z.string(),
    phone: z.string().optional(),
    url: z.string().url(),
    domain: z.string().optional(),
    description: z.string(),
    keywords: z.array(z.string()).default([]),
    // PhD advisors — rendered on the hero + CV/resume title block.
    advisors: z.array(z.object({ name: z.string(), url: z.string().url() }).strict()).default([]),
    socials: z
      .array(z.object({ label: z.string(), url: z.string(), icon: z.string() }).strict())
      .default([]),
  })
  .strict();

// ---- honors.yaml — { group, items: [markdown], only?/except? } -------------
export const honorsSchema = z.array(
  z
    .object({
      group: z.string(),
      items: z.array(z.string()),
      only: targetList.optional(),
      except: targetList.optional(),
    })
    .strict(),
);

// ---- references.yaml — CV reference contacts -------------------------------
export const referencesSchema = z.array(
  z
    .object({
      name: z.string(),
      role: z.string().optional(),
      affiliation: z.string().optional(),
      department: z.string().optional(),
      email: z.string().optional(),
      url: z.string().url().optional(),
    })
    .strict(),
);

// ---- research-interests.yaml — { statements[], focus_areas[] } -------------
export const researchInterestsSchema = z
  .object({
    statements: z.array(z.string()),
    focus_areas: z.array(z.string()),
  })
  .strict();

// ---- news.yaml — { date, link?, highlight?, body } -------------------------
// The single most-edited file; coerce date + URL-validate the link so a bad
// entry fails loudly at build instead of rendering wrong or throwing deep in
// NewsList. Mirrors the schema the old per-item Astro collection enforced.
export const newsItemSchema = z
  .object({
    date: z.coerce.date(),
    link: z.string().url().optional(),
    highlight: z.boolean().default(false),
    body: z.string(),
  })
  .strict();

// ---- venues.yaml — abbr → { name, url, type? } -----------------------------
// `type` drives the CV publication grouping (journal/conference/preprint);
// lib.typ falls back to a heuristic only when it is absent. (Per-venue `color`
// was retired when publication labels were unified to the accent color; not
// re-added here to avoid reviving a field with no consumer.)
export const venueSchema = z
  .object({
    name: z.string(),
    url: z.string().url(),
    type: z.enum(['journal', 'conference', 'preprint']).optional(),
  })
  .strict();
export const venuesSchema = z.record(z.string(), venueSchema);

// ---- coauthors.yaml — lastname → [{ firstname[], url }] --------------------
export const coauthorSchema = z
  .object({
    firstname: z.array(z.string()),
    url: z.string().url(),
  })
  .strict();
export const coauthorsSchema = z.record(z.string(), z.array(coauthorSchema));

// ---- targets.yaml — target id → { blurb, keywords[] } ----------------------
// Targeted PDF variants (graphics / ml-systems). Web ignores this file.
export const targetSchema = z
  .object({
    blurb: z.string(),
    keywords: z.array(z.string()),
  })
  .strict();
export const targetsSchema = z.record(z.string(), targetSchema);

// ---- Cross-reference integrity (build-time) --------------------------------
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
  type?: 'journal' | 'conference' | 'preprint';
}

/**
 * Enforce two documented cross-reference rules:
 *   - abbr with no matching venues.yaml key → badge renders bare. WARN only
 *     (cosmetic, and the add-paper workflow adds the bib entry first).
 *   - featured without selected → homepage surfaces a paper the CV omits.
 *     THROW — this is always an oversight and the fix is one line in papers.bib.
 */
export function enforcePaperIntegrity(
  papers: PaperLike[],
  venues: Record<string, VenueLike>,
): void {
  const missingVenues = papers.filter((p) => p.abbr && !(p.abbr in venues));
  if (missingVenues.length > 0) {
    console.warn(
      `[content] ${missingVenues.length} paper(s) have an abbr with no matching key in content/venues.yaml (badge will render as bare text):`,
      missingVenues.map((p) => `${p.abbr} (${p.title.slice(0, 50)})`).join(' | '),
    );
  }

  const asymmetric = papers.filter((p) => p.featured && !p.selected);
  if (asymmetric.length > 0) {
    throw new Error(
      `[content] ${asymmetric.length} paper(s) are featured (web-top) but not selected (PDF) — ` +
        `a featured paper must also appear in the CV/resume. Set selected={true} (or featured={false}) in content/papers.bib for:\n  ` +
        asymmetric.map((p) => `- ${p.title.slice(0, 80)}`).join('\n  '),
    );
  }
}
