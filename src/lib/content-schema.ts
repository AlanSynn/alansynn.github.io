// content-schema.ts — strict Zod schemas for every structured YAML in content/.
// .strict(): an unknown key (typo / dead field) fails the build loudly, not
// silently — the failure mode that once left tagline/skills.yaml/bibtex_show
// edited-but-ignored. Three cross-ref rules at the bottom (all THROW):
// abbr∈venues, featured→selected, and only/except target ids ∈ targets.yaml.

import { z } from 'astro/zod';

// only:/except: on any CV entry — string or list (mirrors lib.typ entry-visible).
const targetList = z.union([z.string(), z.array(z.string())]);

// Shared timeline entry for all 4 cv.yaml sections. body/location optional.
export const timelineEntry = z
  .object({
    period: z.string(),
    title: z.string(),
    location: z.string().optional(),
    body: z.string().optional(),
    // CV/web-only detail the resume omits (a 2nd experience bullet, an advisor
    // line, military service). lib.typ cv-entry renders `more` only when
    // doc != "resume"; the web Timeline concatenates body+more (web mirrors the
    // full CV, never the compact resume).
    more: z.string().optional(),
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
    // Invited Talks & Outreach — CV-only section (plan §5.8). Same entry model.
    // Not rendered on the web homepage (only the Typst CV consumes it), but
    // validated here so a typo fails the web build before a bad PDF.
    outreach: z.array(timelineEntry),
  })
  .strict();

export const siteSchema = z
  .object({
    name: z.string(),
    short_name: z.string(),
    first_name: z.string(),
    nick_name: z.string(),
    last_name: z.string(),
    title: z.string(),
    browser_title: z.string().optional(),
    affiliation: z.string(),
    affiliation_url: z.url(),
    department: z.string().optional(),
    department_url: z.url().optional(),
    email: z.string(),
    email_obfuscated: z.string(),
    url: z.url(),
    domain: z.string().optional(),
    description: z.string(),
    keywords: z.array(z.string()).default([]),
    advisors: z.array(z.object({ name: z.string(), url: z.url() }).strict()).default([]),
    socials: z
      .array(z.object({ label: z.string(), url: z.string(), icon: z.string() }).strict())
      .default([]),
  })
  .strict();

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

export const referencesSchema = z.array(
  z
    .object({
      name: z.string(),
      role: z.string().optional(),
      affiliation: z.string().optional(),
      department: z.string().optional(),
      email: z.string().optional(),
      url: z.url().optional(),
    })
    .strict(),
);

export const researchInterestsSchema = z
  .object({
    statements: z.array(z.string()),
    focus_areas: z.array(z.string()),
  })
  .strict();

// news: coerce date + validate link so a bad entry fails the build, not NewsList.
export const newsItemSchema = z
  .object({
    date: z.coerce.date(),
    link: z.url().optional(),
    highlight: z.boolean().default(false),
    body: z.string(),
  })
  .strict();

// `type` drives CV pub grouping (journal/conference/preprint); lib.typ heuristics
// only when absent. `color` retired when labels unified to accent — not re-added.
export const venueSchema = z
  .object({
    name: z.string(),
    url: z.url(),
    type: z.enum(['journal', 'conference', 'preprint']).optional(),
  })
  .strict();
export const venuesSchema = z.record(z.string(), venueSchema);

export const coauthorSchema = z
  .object({
    firstname: z.array(z.string()),
    url: z.url(),
  })
  .strict();
export const coauthorsSchema = z.record(z.string(), z.array(coauthorSchema));

// target id → { blurb, keywords } for targeted PDF variants. Web ignores it.
export const targetSchema = z
  .object({
    blurb: z.string(),
    keywords: z.array(z.string()),
  })
  .strict();
export const targetsSchema = z.record(z.string(), targetSchema);

// Cross-reference integrity (build-time). Mirrors src/lib/papers.ts Paper subset.
interface PaperLike {
  key: string;
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

// Both THROW. Each is always an oversight with a 1-line fix, and symmetry beats
// a cosmetic-vs-structural split: when missing-venue was only a warn it lingered
// unfixed, buried in build noise (a bare-text badge shipped). Now both fail the
// build, naming the exact key to add.
//   abbr ∉ venues.yaml → venue badge would render as bare text; add the key.
//   featured without selected → homepage surfaces a paper the CV omits.
export function enforcePaperIntegrity(
  papers: PaperLike[],
  venues: Record<string, VenueLike>,
): void {
  const missingVenues = papers.filter((p) => p.abbr && !(p.abbr in venues));
  if (missingVenues.length > 0) {
    throw new Error(
      `[content] ${missingVenues.length} paper(s) have an abbr with no matching key in content/venues.yaml (the venue badge would render as bare, unlinked text). Add a key for each abbr:\n  ` +
        missingVenues.map((p) => `- ${p.abbr} (${p.key}: ${p.title.slice(0, 60)})`).join('\n  '),
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

// only:/except: on cv.yaml timeline entries + honors.yaml groups must reference
// real target ids (keys in targets.yaml). A typo like `only: [graphcs]` HIDES
// the entry everywhere — web (only is defined → entry hidden as target-specific)
// AND every PDF target (no target matches the typo) — a silent vanish with no
// build signal. Throws naming each offender + the known target ids.
export function enforceTargetFlags(
  entries: { only?: string | string[]; except?: string | string[] }[],
  targetIds: string[],
  source: string,
): void {
  const known = new Set(targetIds);
  const bad: string[] = [];
  for (const e of entries) {
    for (const fld of ['only', 'except'] as const) {
      const v = e[fld];
      if (v === undefined) continue;
      const ids = Array.isArray(v) ? v : [v];
      // An empty list (only: [] / except: []) is defined-but-empty → the entry
      // is hidden on web (entry-visible returns false) AND every PDF target,
      // with no build signal — the same silent-vanish class as a typo'd id.
      if (ids.length === 0) {
        bad.push(`${source} → ${fld}: [] (empty list hides the entry everywhere)`);
        continue;
      }
      for (const id of ids) if (!known.has(id)) bad.push(`${source} → ${fld}: ${id}`);
    }
  }
  if (bad.length > 0) {
    throw new Error(
      `[content] ${bad.length} only:/except: value(s) are not target ids in content/targets.yaml ` +
        `(a typo here hides the entry on web AND every PDF target — silent vanish). ` +
        `Known target ids: [${targetIds.join(', ') || '(none defined)'}]. Offenders:\n  ` +
        bad.join('\n  '),
    );
  }
}
