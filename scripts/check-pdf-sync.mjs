// Pre-commit guard against PDF drift.
//
// CI is web-only (`bun run build`), so the committed resume/CV PDFs in
// public/pdfs/ are only ever rebuilt locally by `just pdfs`. If a dev edits a
// PDF-source file and commits WITHOUT rebuilding + staging the PDFs, the live
// site's web reflects the edit but its PDFs go stale — silent drift with zero
// detection. This guard fails the commit in that case (the --no-verify escape
// hatch covers a genuinely PDF-inert edit, e.g. a venue for a paper that isn't
// selected).
//
// Two drift classes are caught:
//   1. A PDF-source is staged with NO public/pdfs/*.pdf at all  → "forgot".
//   2. A variant-affecting source is staged with no targeted-variant PDF
//      (*-graphics.pdf / *-ml-systems.pdf) → `just pdfs` (defaults only) was
//      run; the committed variants would go stale. Needs `just pdfs-all`.
//
//   node scripts/check-pdf-sync.mjs
//
// Run automatically by .husky/pre-commit after the build gate.
import { execSync } from 'node:child_process';

// Content files the Typst template reads (lib.typ data loaders) PLUS the Typst
// sources themselves — any can change PDF output; an edit with no staged PDF =
// drift risk. (Typst sources included because a lib.typ/layout edit changes
// every PDF just as a cv.yaml edit does.)
const PDF_SOURCES = [
  'content/papers.bib',
  'content/cv.yaml',
  'content/honors.yaml',
  'content/references.yaml',
  'content/research-interests.yaml',
  'content/venues.yaml',
  'content/targets.yaml',
  'content/site.yaml',
  'resume/typst/lib.typ',
  'resume/typst/layout.typ',
  'resume/typst/resume.typ',
  'resume/typst/cv.typ',
  'resume/typst/paper-page.typ',
];

// research-interests.yaml feeds ONLY the default resume/CV: targeted variants
// swap in targets[target].blurb (see lib.typ research-blurb), so an ri edit
// never touches *-graphics.pdf / *-ml-systems.pdf. Every OTHER source can change
// the variants, so an edit to one of those needs `just pdfs-all`, not just
// `just pdfs` (which rebuilds the two defaults and leaves the variants stale).
const DEFAULT_ONLY_SOURCES = new Set(['content/research-interests.yaml']);

const staged = execSync('git diff --cached --name-only', { encoding: 'utf-8' })
  .split('\n')
  .filter(Boolean);

const changedSources = staged.filter((f) => PDF_SOURCES.includes(f));
const changedPdfs = staged.filter((f) => f.startsWith('public/pdfs/') && f.endsWith('.pdf'));
// Targeted variants carry a -<target> suffix (alansynn-resume-graphics.pdf);
// the defaults are bare alansynn-resume.pdf / alansynn-cv.pdf.
const variantPdfs = changedPdfs.filter((f) => /alansynn-(resume|cv)-.+\.pdf$/.test(f));

// Nothing PDF-relevant staged → nothing to check.
if (changedSources.length === 0) process.exit(0);

const problems = [];
// No PDFs staged at all → the common "forgot to rebuild" case.
if (changedPdfs.length === 0) {
  problems.push(`no public/pdfs/*.pdf is staged alongside: ${changedSources.join(', ')}`);
}
// A variant-affecting source changed but no targeted-variant PDF was staged →
// `just pdfs` (defaults only) was run; the committed *-<target>.pdf go stale.
// (Typst embeds a build timestamp, so `just pdfs-all` churns every variant —
// "no variant PDF staged" reliably signals pdfs-all was NOT run.)
const variantSourceChanged = changedSources.some((f) => !DEFAULT_ONLY_SOURCES.has(f));
if (variantSourceChanged && variantPdfs.length === 0) {
  problems.push(
    'a variant-affecting source changed but no targeted-variant PDF (*-graphics.pdf / *-ml-systems.pdf) is staged — `just pdfs` rebuilds defaults only; run `just pdfs-all`',
  );
}

if (problems.length === 0) process.exit(0);

console.error(
  '\n[check-pdf-sync] PDF drift — CI is web-only and never rebuilds the committed\n' +
    'PDFs, so a content/Typst edit must ship with its rebuilt public/pdfs/*.pdf:\n' +
    problems.map((p) => `  - ${p}`).join('\n') +
    '\n  Fix: `just pdfs-all` (defaults + every target variant), then\n' +
    '       `git add public/pdfs/*.pdf` and re-commit.\n' +
    '  If the change is PDF-inert, bypass with: git commit --no-verify\n',
);
process.exit(1);
