// Pre-commit guard against PDF drift.
//
// CI is web-only (`bun run build`), so the committed resume/CV PDFs in
// public/pdfs/ are only ever rebuilt locally by `just pdfs`. If a dev edits a
// PDF-source content file and commits WITHOUT rebuilding + staging the PDFs,
// the live site's web reflects the edit but its PDFs go stale — silent drift
// with zero detection. This guard fails the commit in that case (the --no-verify
// escape hatch covers a genuinely PDF-inert edit, e.g. a venue for a paper that
// isn't selected).
//
//   node scripts/check-pdf-sync.mjs
//
// Run automatically by .husky/pre-commit after the build gate.
import { execSync } from 'node:child_process';

// Content files the Typst template reads (lib.typ data loaders). An edit to any
// of these can change PDF output; an edit with no staged PDF = drift risk.
const PDF_SOURCES = [
  'content/papers.bib',
  'content/cv.yaml',
  'content/honors.yaml',
  'content/references.yaml',
  'content/research-interests.yaml',
  'content/venues.yaml',
  'content/targets.yaml',
  'content/site.yaml',
];

const staged = execSync('git diff --cached --name-only', { encoding: 'utf-8' })
  .split('\n')
  .filter(Boolean);

const changedSources = staged.filter((f) => PDF_SOURCES.includes(f));
const changedPdfs = staged.filter((f) => f.startsWith('public/pdfs/') && f.endsWith('.pdf'));

// Nothing PDF-relevant staged → nothing to check.
if (changedSources.length === 0) process.exit(0);
// PDFs staged alongside the source change → in sync.
if (changedPdfs.length > 0) process.exit(0);

console.error(
  '\n[check-pdf-sync] PDF-source content is staged but no public/pdfs/*.pdf is —\n' +
    'the committed PDFs would drift (CI is web-only and never rebuilds them).\n' +
    `  Changed source: ${changedSources.join(', ')}\n` +
    '  Fix: run `just pdfs` (or `just pdfs-all` if targets / cv structure changed),\n' +
    '       then `git add public/pdfs/*.pdf` and re-commit.\n' +
    '  If the change is PDF-inert, bypass with: git commit --no-verify\n',
);
process.exit(1);
