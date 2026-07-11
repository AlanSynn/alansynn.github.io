// papers.ts — dependency-free BibTeX parser for the al-folio flavour in
// content/papers.bib. Build-time only (Node fs). Handles @string macros,
// nested braces, {}/""/bare values, author split, month names; preserves raw
// entry text for BibTeX export.

import { existsSync, readFileSync } from 'node:fs';
import { resolve } from 'node:path';

export interface Author {
  raw: string; // "Synn, DoangJoo" or "DoangJoo Synn"
  given: string; // "DoangJoo"
  family: string; // "Synn"
}

export interface Paper {
  key: string;
  type: string; // inproceedings | article | ...
  fields: Record<string, string>;
  raw: string; // original entry text for BibTeX export
  year: number;
  month: number | null;
  authors: Author[];
  selected: boolean;
  featured: boolean; // homepage #publications highlight (web-only)
  title: string;
  venue: string; // booktitle | journal
  abbr: string | null; // venue badge label
  doi: string | null;
  url: string | null;
  pdf: string | null;
  code: string | null;
  website: string | null; // project page
  video: string | null;
  abstract: string | null;
  preview: string | null; // thumbnail image path
}

const MONTHS: Record<string, number> = {
  jan: 1,
  feb: 2,
  mar: 3,
  apr: 4,
  may: 5,
  jun: 6,
  jul: 7,
  aug: 8,
  sep: 9,
  oct: 10,
  nov: 11,
  dec: 12,
};

function findClose(src: string, open: number): number {
  // open points at '{' or '('. Returns index of matching close.
  const openCh = src[open];
  const closeCh = openCh === '{' ? '}' : ')';
  let depth = 0;
  for (let i = open; i < src.length; i++) {
    const c = src[i];
    if (c === openCh) depth++;
    else if (c === closeCh) {
      depth--;
      if (depth === 0) return i;
    }
  }
  return src.length - 1;
}

function stripComments(src: string): string {
  // Remove % line-comments that occur outside a value. Simple + safe for our .bib.
  let out = '';
  let depth = 0;
  for (let i = 0; i < src.length; i++) {
    const c = src[i];
    if (c === '{') depth++;
    else if (c === '}') depth = Math.max(0, depth - 1);
    if (c === '%' && depth === 0) {
      while (i < src.length && src[i] !== '\n') i++;
    } else {
      out += c;
    }
  }
  return out;
}

function parseValue(token: string, strings: Record<string, string>): string {
  const t = token.trim();
  if (!t) return '';
  // Quoted or braced - strip outermost delimiters, keep inner braces as content.
  if ((t[0] === '{' && t[t.length - 1] === '}') || (t[0] === '"' && t[t.length - 1] === '"')) {
    return t.slice(1, -1).trim();
  }
  // Bare word - could be a @string macro or a number.
  if (Object.prototype.hasOwnProperty.call(strings, t)) return strings[t];
  // Concatenation with # - e.g., acm # " Inc."
  if (t.includes('#')) {
    return t
      .split('#')
      .map((p) => parseValue(p, strings))
      .join('');
  }
  return t;
}

function parseBody(
  body: string,
  strings: Record<string, string>,
): { key: string; fields: Record<string, string> } {
  // First token up to ',' is the cite key.
  const keyMatch = body.match(/^([^,]+),/);
  const key = keyMatch ? keyMatch[1].trim() : (body.match(/^([^\s,]+)/)?.[1] ?? '');
  let rest = keyMatch ? body.slice(keyMatch[0].length) : body;

  const fields: Record<string, string> = {};
  // Walk field = value pairs, respecting brace depth.
  while (rest.length) {
    const eq = rest.indexOf('=');
    if (eq === -1) break;
    const name = rest.slice(0, eq).trim().toLowerCase();
    if (!/^[a-z_][\w-]*$/.test(name)) {
      rest = rest.slice(eq + 1);
      continue;
    }
    let i = eq + 1;
    while (i < rest.length && /\s/.test(rest[i])) i++;
    // value spans until a top-level comma
    let val = '';
    let depth = 0;
    let inStr: string | null = null;
    for (; i < rest.length; i++) {
      const c = rest[i];
      if (inStr) {
        val += c;
        if (c === inStr) inStr = null;
      } else if (c === '{') {
        depth++;
        val += c;
      } else if (c === '}') {
        depth--;
        val += c;
      } else if (c === '"') {
        inStr = '"';
        val += c;
      } else if (c === ',' && depth === 0) {
        break;
      } else {
        val += c;
      }
    }
    fields[name] = parseValue(val, strings);
    rest = rest.slice(i);
    if (rest[0] === ',') rest = rest.slice(1);
  }
  return { key, fields };
}

function splitAuthors(raw: string): Author[] {
  return raw.split(/\s+and\s+/i).map((a) => {
    const seg = a.trim().replace(/[{}]/g, '');
    if (seg.includes(',')) {
      const [family, given] = seg.split(',').map((s) => s.trim());
      return { raw: seg, family, given };
    }
    const parts = seg.split(/\s+/);
    const family = parts.length > 1 ? parts[parts.length - 1] : seg;
    const given = parts.length > 1 ? parts.slice(0, -1).join(' ') : '';
    return { raw: seg, family, given };
  });
}

export function parseBibtex(src: string): Paper[] {
  const clean = stripComments(src);
  const strings: Record<string, string> = {};
  const rawEntries: { type: string; body: string; full: string }[] = [];

  let i = 0;
  while (i < clean.length) {
    const at = clean.indexOf('@', i);
    if (at === -1) break;
    let j = at + 1;
    while (j < clean.length && /[A-Za-z]/.test(clean[j])) j++;
    const type = clean.slice(at + 1, j).toLowerCase();
    while (j < clean.length && /\s/.test(clean[j])) j++;
    if (clean[j] !== '{' && clean[j] !== '(') {
      i = j;
      continue;
    }
    const close = findClose(clean, j);
    const body = clean.slice(j + 1, close);
    const full = clean.slice(at, close + 1);

    if (type === 'string') {
      // @string{ key = value }
      const m = body.match(/^\s*([\w-]+)\s*=\s*([\s\S]+)$/);
      if (m) strings[m[1].toLowerCase()] = parseValue(m[2], strings);
    } else if (type === 'comment' || type === 'preamble') {
      // skip
    } else {
      rawEntries.push({ type, body, full });
    }
    i = close + 1;
  }

  return rawEntries.map(({ type, body, full }) => {
    const { key, fields } = parseBody(body, strings);
    const year = parseInt(fields.year ?? '0', 10) || 0;
    const monthRaw = (fields.month ?? '').trim().toLowerCase();
    const month = MONTHS[monthRaw] ?? (/^\d+$/.test(monthRaw) ? parseInt(monthRaw, 10) : null);
    const authors = fields.author ? splitAuthors(fields.author) : [];
    const selected = (fields.selected ?? '').toLowerCase() === 'true';
    const featured = (fields.featured ?? '').toLowerCase() === 'true';

    return {
      key,
      type,
      fields,
      raw: full,
      year,
      month,
      authors,
      selected,
      featured,
      title: (fields.title ?? '').replace(/[{}]/g, ''),
      venue: fields.booktitle ?? fields.journal ?? '',
      abbr: fields.abbr ?? null,
      doi: fields.doi ?? null,
      url: fields.url ?? null,
      pdf: fields.pdf ?? null,
      code: fields.code ?? null,
      website: fields.website ?? null,
      video: fields.video ?? null,
      abstract: fields.abstract ?? null,
      preview: fields.preview ?? null,
    } as Paper;
  });
}

// Resolve from cwd → correct in both `astro dev` and bundled build output.
const BIB_PATH = resolve(process.cwd(), 'content/papers.bib');

// True under `astro build`, false in `astro dev` and when gen-papers-json.mjs
// runs under plain bun (where import.meta.env is absent). Guards the PROD
// asset-existence check so a paper added before its asset lands doesn't block
// dev iteration, while a typo'd path still fails the deploy build.
const isProd =
  (import.meta as { env?: { PROD?: boolean } }).env?.PROD ?? process.env.NODE_ENV === 'production';

// Cache only in PROD. In dev, re-read papers.bib every call so edits apply
// without a server restart: papers.bib is read via readFileSync (outside Vite's
// module graph → no HMR), and a watcher in astro.config.mjs triggers a full
// browser reload on change; a non-cached read then picks up the edit. Parse is
// cheap for a small bib. (The content/*.yaml files ARE imported → already HMR.)
let cache: Paper[] | null = null;
export function getPapers(): Paper[] {
  if (isProd && cache) return cache;
  const src = readFileSync(BIB_PATH, 'utf-8');
  const papers = parseBibtex(src);
  // Newest first; stable within a year by original order.
  papers.sort((a, b) => b.year - a.year);

  // PROD asset check: preview/pdf/video are free strings (Zod can't check the
  // filesystem), so a typo would render a broken image/link on the live site
  // under a green build. Verify each root-relative path resolves under public/.
  if (isProd) {
    const missing: string[] = [];
    for (const p of papers) {
      for (const fld of ['preview', 'pdf', 'video'] as const) {
        const v = p[fld];
        if (
          v &&
          v.startsWith('/') &&
          !v.startsWith('//') &&
          !existsSync(resolve(process.cwd(), 'public', v.slice(1)))
        )
          missing.push(`${p.key}.${fld} → ${v}`);
      }
    }
    if (missing.length) {
      throw new Error(
        `[content] ${missing.length} paper asset path(s) in content/papers.bib do not resolve under public/ (would render a broken image/link). Add the asset or fix the path:\n  ` +
          missing.map((m) => `- ${m}`).join('\n  '),
      );
    }
  }

  if (isProd) cache = papers;
  return papers;
}
