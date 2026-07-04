// ============================================================================
// gen-resume-tex.mjs — generate LaTeX (simpleresume class) resume/CV from the
// shared YAML data + papers.json. The output mirrors the canonical overleaf
// resume.tex so the look is preserved exactly, while content is read from
// src/data/*.yaml + src/data/papers.json (single source of truth).
//
// Usage:
//   node scripts/gen-resume-tex.mjs --doc resume [--target <id>]
//   node scripts/gen-resume-tex.mjs --doc cv     [--target <id>]
//
// Output: resume/build/<doc>[-<target>].tex
// ============================================================================
import { readFileSync, writeFileSync, mkdirSync } from 'node:fs';
import { resolve, dirname } from 'node:path';
import { fileURLToPath } from 'node:url';
import yaml from 'js-yaml';

const __dirname = dirname(fileURLToPath(import.meta.url));
process.chdir(resolve(__dirname, '..')); // pin cwd to project root

// ---------------------------------------------------------------------------
// 1. CLI args
// ---------------------------------------------------------------------------
const argv = process.argv.slice(2);
let doc = 'resume';
let target = '';
for (let i = 0; i < argv.length; i++) {
  const a = argv[i];
  if (a === '--doc') doc = argv[++i];
  else if (a === '--target') target = argv[++i] || '';
}
if (doc !== 'resume' && doc !== 'cv') {
  console.error(`--doc must be 'resume' or 'cv' (got '${doc}')`);
  process.exit(2);
}
if (target && !(target in TARGET_KEYWORDS)) {
  console.error(`Unknown --target '${target}'. Known targets: ${Object.keys(TARGET_KEYWORDS).join(', ')}.`);
  process.exit(2);
}

// ---------------------------------------------------------------------------
// 2. Load shared data
// ---------------------------------------------------------------------------
const read = (p) => yaml.load(readFileSync(p, 'utf-8'));
const site = read('src/data/site.yaml');
const education = read('src/data/education.yaml');
const experience = read('src/data/experience.yaml');
const honors = read('src/data/honors.yaml');
const teaching = read('src/data/teaching.yaml');
const activities = read('src/data/activities.yaml');
const references = read('src/data/references.yaml');
const ri = read('src/data/research-interests.yaml');
const papers = JSON.parse(readFileSync('src/data/papers.json', 'utf-8'));

const OWNER = (site.last_name || 'Synn').toLowerCase();

// ---------------------------------------------------------------------------
// 3. Targeting: keyword filters + research-interest lead swap
// ---------------------------------------------------------------------------
const TARGET_KEYWORDS = {
  graphics: ['motion', 'automata', 'kinematic', 'sketch', 'graphics',
             'animation', 'tangible', 'makecode', 'creativity', 'design'],
  'ml-systems': ['training', 'dataloader', 'batch', 'distributed', 'streaming',
                 'privacy', 'inference', 'system', 'cloud', 'kubernetes'],
};

const TARGET_BLURB = {
  graphics:
    'My research explores computational design and creativity, with a focus on ' +
    'representing and supporting creative intent in generative and interactive ' +
    'systems. I build models and interfaces that translate high-level human ' +
    'intent into expressive, controllable outcomes, spanning domains such as ' +
    'computer graphics, motion synthesis, and kinematic design.',
  'ml-systems':
    'My research builds high-efficiency and scalable machine learning systems, ' +
    'with a focus on automated dataloader tuning, memory-aware and distributed ' +
    'training, and privacy-preserving inference. I work across cloud and ' +
    'distributed computing to make ML training and deployment faster, more ' +
    'resource-efficient, and easier to use.',
};

// Split into {matched, rest}, preserving order within each.
function matchPubs(list, targetName) {
  if (!targetName || targetName === 'all') return { matched: list, rest: [] };
  const kws = TARGET_KEYWORDS[targetName] || [];
  if (kws.length === 0) return { matched: list, rest: [] };
  const matched = [];
  const rest = [];
  for (const p of list) {
    const hay = `${p.title || ''} ${p.venue || ''} ${p.abbr || ''}`.toLowerCase();
    if (kws.some((k) => hay.includes(k))) matched.push(p);
    else rest.push(p);
  }
  return { matched, rest };
}

// ---------------------------------------------------------------------------
// 4. LaTeX escaping + markdown-ish body conversion
// ---------------------------------------------------------------------------
function esc(s) {
  if (s == null) return '';
  return String(s)
    .replace(/\\/g, '\\textbackslash{}')
    .replace(/([&#$%_{}])/g, '\\$1')
    .replace(/~/g, '\\textasciitilde{}')
    .replace(/\^/g, '\\textasciicircum{}');
}

function escUrl(u) {
  // In \href{URL}, only % and # need escaping; ~ and / are handled by hyperref.
  return String(u == null ? '' : u).replace(/%/g, '\\%').replace(/#/g, '\\#');
}

function escName(s) {
  // Convert ASCII double-quotes around nicknames to LaTeX open/close quotes.
  return esc(s).replace(/"([^"]*)"/g, '``$1\'\'');
}

// Inline markdown → LaTeX: **bold**, *italic*, [label](url). Recursive.
function mdInline(s) {
  if (s == null) return '';
  s = String(s);
  const out = [];
  let i = 0;
  while (i < s.length) {
    const rest = s.slice(i);
    let m;
    if ((m = rest.match(/^\[([^\]]*)\]\(([^)]*)\)/))) {
      out.push(`\\href{${escUrl(m[2])}}{${mdInline(m[1])}}`);
      i += m[0].length;
    } else if ((m = rest.match(/^\*\*([\s\S]+?)\*\*/))) {
      out.push(`\\textbf{${mdInline(m[1])}}`);
      i += m[0].length;
    } else if ((m = rest.match(/^\*([^*]+?)\*/))) {
      out.push(`\\textit{${mdInline(m[1])}}`);
      i += m[0].length;
    } else {
      const j = rest.search(/[\[\*]/);
      if (j === -1) { out.push(esc(rest)); break; }
      if (j > 0) { out.push(esc(rest.slice(0, j))); i += j; }
      else { out.push(esc(rest[0])); i += 1; }
    }
  }
  return out.join('');
}

// Markdown bullet body → LaTeX \BulletItem/\SubBulletItem lines.
// Inside a \Detail block the top level becomes \SubBulletItem.
function mdBody(body, inDetail) {
  if (!body) return [];
  const top = inDetail ? '\\SubBulletItem' : '\\BulletItem';
  const mid = inDetail ? '\\SubSubBulletItem' : '\\SubBulletItem';
  const deep = '\\SubSubBulletItem';
  const out = [];
  for (const raw of String(body).split('\n')) {
    if (raw.trim() === '') continue;
    const indent = raw.length - raw.trimStart().length;
    const trimmed = raw.trim();
    if (!trimmed.startsWith('- ')) {
      console.warn(`[gen-resume-tex] non-bullet line in a CV body was omitted from the PDF (web still renders it): "${trimmed.slice(0, 60)}..."`);
      continue;
    }
    const text = trimmed.slice(2);
    const cmd = indent >= 8 ? deep : indent >= 4 ? mid : top;
    out.push(`${cmd} ${mdInline(text)}`);
  }
  return out;
}

// ---------------------------------------------------------------------------
// 5. Block renderers
// ---------------------------------------------------------------------------
function section(name) {
  const slug = 'sec:' + name.toLowerCase().replace(/[^a-z0-9]+/g, '-').replace(/^-|-$/g, '');
  return `\\Section\n{${esc(name)}}\n{${esc(name)}}\n{${slug}}`;
}

function researchBlurb(docName, targetName) {
  // Run through mdInline so *italic*/**bold**/[label](url) in the statements
  // render as LaTeX rather than leaking as literal markdown.
  let text;
  if (targetName && TARGET_BLURB[targetName]) {
    text = mdInline(TARGET_BLURB[targetName]);
  } else if (docName === 'cv' && ri.statements && ri.statements.length > 1) {
    text = ri.statements.map(mdInline).join('\n\n');
  } else {
    text = mdInline(ri.statements && ri.statements[0] || '');
  }
  return `\\Entry\n${text}`;
}

// {period, title, location?, body} → Entry block
function entryBlock(e) {
  const lines = ['\\Entry'];
  const title = `\\textbf{${esc(e.title || '')}}`;
  const period = esc(e.period || '');
  lines.push(period ? `${title}\\hfill ${period}` : title);
  const detail = [];
  if (e.location) detail.push(`\\SubBulletItem ${esc(e.location)}`);
  detail.push(...mdBody(e.body, true));
  if (detail.length) {
    lines.push('\\begin{Detail}');
    lines.push(...detail);
    lines.push('\\end{Detail}');
  }
  return lines.join('\n');
}

function formatAuthors(authors) {
  const parts = (authors || []).map((a) => {
    const given = esc(a.given || '');
    const family = esc(a.family || '');
    const name = a.given ? `${given}~${family}` : family;
    if ((a.family || '').toLowerCase() === OWNER) {
      return `\\underline{\\textbf{${name}}}`;
    }
    return name;
  });
  if (parts.length === 0) return '';
  if (parts.length === 1) return parts[0];
  if (parts.length === 2) return `${parts[0]} and ${parts[1]}`;
  return parts.slice(0, -1).join(', ') + ', and ' + parts[parts.length - 1];
}

function pubItem(n, p) {
  const authors = formatAuthors(p.authors);
  const title = esc(p.title || '');
  const venue = esc(p.abbr || p.venue || '');
  const date = p.month
    ? `\\DatestampYM{${p.year}}{${p.month}}`
    : `\\DatestampY{${p.year}}`;
  return `\\NumberedItem{[${n}]}{${authors},\n\`\`${title},''\n\\textit{${venue}},\n${date}.}`;
}

function pubsBlock(list, { groupByYear }) {
  const lines = ['\\begingroup', '\\renewcommand{\\MaxNumberedItem}{[88]}'];
  let lastYear = null;
  let n = 0;
  for (const p of list) {
    n++;
    if (groupByYear && p.year !== lastYear) {
      if (lastYear !== null) lines.push('\\Gap');
      lines.push(`\\textbf{${p.year}}\\par`);
      lastYear = p.year;
    }
    lines.push(pubItem(n, p));
  }
  lines.push('\\endgroup');
  return lines.join('\n');
}

function honorsBlock(honorsList) {
  const out = [];
  for (const g of honorsList || []) {
    out.push(`\\BulletItem \\textbf{${esc(g.group || '')}}`);
    if (g.items && g.items.length) {
      out.push('\\begin{Detail}');
      for (const item of g.items) out.push(`\\SubBulletItem ${mdInline(item)}`);
      out.push('\\end{Detail}');
    }
  }
  return out.join('\n');
}

function referencesBlock(refs) {
  const out = [];
  (refs || []).forEach((r, i) => {
    if (i > 0) out.push('\\BigGap');
    const lines = [`\\textbf{${esc(r.name || '')}}`];
    if (r.role) lines.push(esc(r.role));
    if (r.affiliation) lines.push(esc(r.affiliation));
    if (r.department) lines.push(esc(r.department));
    if (r.email) lines.push(`\\href{mailto:${escUrl(r.email)}}{${esc(r.email)}}`);
    else if (r.url) lines.push(`\\href{${escUrl(r.url)}}{${escUrl(r.url)}}`);
    out.push('\\BulletItem');
    out.push(lines.join('\n\\newline\n'));
  });
  return out.join('\n');
}

// ---------------------------------------------------------------------------
// 6. Title block
// ---------------------------------------------------------------------------
const nameLatex = escName(site.name);
const emailRaw = site.email || '';
const phoneRaw = site.phone || '';
const urlRaw = site.url || '';
const titleBlock = [
  `\\Title{${nameLatex}}`,
  '',
  '\\begin{SubTitle}',
  `\\href{mailto:${escUrl(emailRaw)}}{${esc(emailRaw)}}` +
    (phoneRaw ? `\\,\\SubBulletSymbol\\,${esc(phoneRaw)}` : '') +
    `\\,\\SubBulletSymbol\\,\\href{${escUrl(urlRaw)}}{\\url{${esc(urlRaw)}}}`,
  '\\end{SubTitle}',
].join('\n');

// ---------------------------------------------------------------------------
// 7. Assemble document body
// ---------------------------------------------------------------------------
const sections = [];
sections.push(section('Research Interests'));
sections.push(researchBlurb(doc, target));

sections.push(section('Education'));
sections.push(education.map(entryBlock).join('\n\n'));

sections.push(section(doc === 'cv' ? 'Professional Experience' : 'Professional Experience'));
sections.push(experience.map(entryBlock).join('\n\n'));

// Publications
const selected = papers.filter((p) => p.selected);
let pubList;
let groupByYear = false;
if (doc === 'resume') {
  const { matched } = target
    ? matchPubs(selected, target)
    : { matched: selected };
  pubList = matched; // all matched/selected pubs (no silent truncation — see Protopia-demo regression)
  sections.push(section('Selected Publications'));
} else {
  // CV: ALL publications, matched-first when a target is set, grouped by year.
  const split = target ? matchPubs(papers, target) : { matched: papers, rest: [] };
  pubList = [...split.matched, ...split.rest];
  groupByYear = true;
  sections.push(section('Publications'));
}
sections.push(pubsBlock(pubList, { groupByYear }));

if (doc === 'cv') {
  sections.push(section('Honors & Awards'));
  sections.push(honorsBlock(honors));

  sections.push(section('Teaching'));
  sections.push(teaching.map(entryBlock).join('\n\n'));

  sections.push(section('Activities & Service'));
  sections.push(activities.map(entryBlock).join('\n\n'));

  sections.push(section('References'));
  sections.push(referencesBlock(references));
}

const body = sections.join('\n\n');

// ---------------------------------------------------------------------------
// 8. Full LaTeX document (preamble mirrors overleaf-resume/resume.tex)
// ---------------------------------------------------------------------------
const docKind = doc === 'cv' ? 'CV' : 'Resume';
const docTitleRaw = target
  ? `${site.name} — ${docKind} (${target})`
  : `${site.name} — ${docKind}`;
const docTitle = escName(docTitleRaw);

const tex = `% !TEX TS-program = xelatex
% !TEX encoding = UTF-8 Unicode
% AUTO-GENERATED by scripts/gen-resume-tex.mjs — do not edit by hand.
% Edits belong in src/data/*.yaml + src/data/papers.bib.

\\documentclass[letterpaper,MMMyyyy,nonstopmode]{simpleresume_no_page}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% PREAMBLE.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\\usepackage{lmodern}

\\newcommand{\\CVAuthor}{${nameLatex}}
\\newcommand{\\CVTitle}{${docTitle}}
\\newcommand{\\CVNote}{${docKind} compiled on {\\today}}
\\newcommand{\\CVWebpage}{${esc(urlRaw)}}

\\hypersetup{
pdftitle={\\CVTitle},
pdfauthor={\\CVAuthor},
pdfsubject={\\CVWebpage},
pdfcreator={XeLaTeX},
pdfproducer={},
pdfkeywords={},
unicode=true,
bookmarksopen=true,
pdfstartview=FitH,
pdfpagelayout=OneColumn,
pdfpagemode=UseOutlines,
hidelinks,
breaklinks}

\\newcommand{\\Code}[1]{\\mbox{\\textbf{#1}}}
\\newcommand{\\CodeCommand}[1]{\\mbox{\\textbf{\\textbackslash{#1}}}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ACTUAL DOCUMENT.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\\begin{document}

${titleBlock}

\\begin{Body}

${body}

\\end{Body}

\\end{document}
`;

// ---------------------------------------------------------------------------
// 9. Write
// ---------------------------------------------------------------------------
mkdirSync('resume/build', { recursive: true });
const stem = target ? `${doc}-${target}` : doc;
const outPath = resolve('resume/build', `${stem}.tex`);
writeFileSync(outPath, tex, 'utf-8');
console.log(`wrote ${outPath} (${pubList.length} pubs${target ? `, target=${target}` : ''})`);
