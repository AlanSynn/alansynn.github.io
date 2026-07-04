// ============================================================================
// gen-papers-json.mjs — bridge between the BibTeX parser (src/lib/papers.ts)
// and the Typst resume/CV templates. Typst cannot parse .bib, so we emit a
// JSON array the templates can read via json("...").
//
// Reuses getPapers() from src/lib/papers.ts (the SAME parser the Astro site
// uses), so the web + resume + CV always agree.
//
// Run from the project root:  node scripts/gen-papers-json.mjs
// ============================================================================
import { writeFileSync } from 'node:fs';
import { resolve, dirname } from 'node:path';
import { fileURLToPath } from 'node:url';

// Pin cwd to the project root so getPapers() (which resolves papers.bib via
// process.cwd()) works regardless of where node is invoked from.
const __dirname = dirname(fileURLToPath(import.meta.url));
process.chdir(resolve(__dirname, '..'));

const { getPapers } = await import('../src/lib/papers.ts');

const papers = getPapers();

// Project to exactly the fields the Typst templates need.
const out = papers.map((p) => ({
  key: p.key,
  year: p.year,
  month: p.month,
  authors: p.authors.map((a) => ({ given: a.given, family: a.family })),
  title: p.title,
  venue: p.venue,
  abbr: p.abbr,
  selected: p.selected,
  doi: p.doi,
  url: p.url,
  pdf: p.pdf,
  code: p.code,
  website: p.website,
  video: p.video,
}));

const outPath = resolve(process.cwd(), 'src/data/papers.json');
writeFileSync(outPath, JSON.stringify(out, null, 2) + '\n', 'utf-8');

const selected = out.filter((p) => p.selected).length;
console.log(`wrote ${out.length} papers (${selected} selected) -> ${outPath}`);
