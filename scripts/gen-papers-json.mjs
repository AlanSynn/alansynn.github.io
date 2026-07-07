// gen-papers-json.mjs — bridges the BibTeX parser (src/lib/papers.ts) to Typst
// (which can't read .bib): emits a JSON array via json("..."). Reuses getPapers()
// so web + resume + CV agree. Usage: node scripts/gen-papers-json.mjs
import { writeFileSync } from 'node:fs';
import { resolve, dirname } from 'node:path';
import { fileURLToPath } from 'node:url';

// Pin cwd to project root so getPapers() (resolves papers.bib via cwd) works from anywhere.
const __dirname = dirname(fileURLToPath(import.meta.url));
process.chdir(resolve(__dirname, '..'));

const { getPapers } = await import('../src/lib/papers.ts');

const papers = getPapers();

// Project to just the fields Typst templates need.
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
