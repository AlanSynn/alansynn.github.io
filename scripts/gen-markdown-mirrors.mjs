// gen-markdown-mirrors.mjs — emit a text/markdown sibling for every built page.
//
// "Markdown for Agents" (Cloudflare's documented agent-content pattern): agents
// that send `Accept: text/markdown` should get markdown instead of dense HTML.
// GitHub Pages can't negotiate on Accept headers, so negotiation happens at the
// Cloudflare edge (a free-plan URL Rewrite rule on the request header) and this
// script supplies the static target: one .md file per HTML page in dist/.
//
// Mirror layout is `<dir>/index.md` on purpose: the edge rule rewrites
// `/blog/foo/` → `/blog/foo/index.md` and `/` → `/index.md` — the rules
// language has no conditional functions, so the applied rule is a plain
// `concat(uri.path, "index.md")` against this uniform `…/index.md` layout.
// Keep the two in sync.
//
// Output shape mirrors Cloudflare's converter: YAML frontmatter
// (title/description/canonical/og image), body markdown with page chrome
// stripped, then any JSON-LD appended as fenced blocks. Runs inside
// `bun run build` after pagefind (pagefind indexes *.html only, so the mirrors
// are invisible to it).

import { readdirSync, readFileSync, writeFileSync, rmSync, statSync } from 'node:fs';
import { dirname, join, relative } from 'node:path';
import { NodeHtmlMarkdown } from 'node-html-markdown';

const DIST = new URL('../dist', import.meta.url).pathname;
const SKIP = new Set(['404.html']); // error artifact, no agent value

const converter = new NodeHtmlMarkdown();

function walk(dir, ext, out = []) {
  for (const name of readdirSync(dir)) {
    const p = join(dir, name);
    if (statSync(p).isDirectory()) walk(p, ext, out);
    else if (name.endsWith(ext)) out.push(p);
  }
  return out;
}

// dist/blog/foo/index.html → blog/foo/index.md · dist/index.html → index.md
// (exactly the paths the edge rule's if_else/ends_with mapping produces).
function mirrorPath(htmlPath) {
  return join(DIST, dirname(relative(DIST, htmlPath)), 'index.md');
}

// Pages carry exactly one content container: site pages use
// <main id="main" data-pagefind-body>, academic project pages (MicrositeShell)
// use their own markup — fall back to <body> minus scripts/styles.
function extractContent(html) {
  const main = html.match(/<main[^>]*>([\s\S]*?)<\/main>/i);
  const chunk = main ? main[1] : (html.match(/<body[^>]*>([\s\S]*?)<\/body>/i)?.[1] ?? '');
  return chunk
    .replaceAll(/<script[\s\S]*?<\/script>/gi, '')
    .replaceAll(/<style[\s\S]*?<\/style>/gi, '')
    .replaceAll(/<template[\s\S]*?<\/template>/gi, '');
}

// Media elements have no markdown equivalent, so replace them with plain
// links and let agents keep a path to the asset instead of losing it
// silently. Returns whether any media was present, so the mirror can point
// readers at the HTML page for the full interactive version.
function preserveMedia(chunk) {
  let hasMedia = false;
  const videoLink = (src) => `<p><a href="${src}">▶ Video: ${src}</a></p>`;
  chunk = chunk
    .replaceAll(/<video[^>]*\bsrc="([^"]+)"[^>]*>([\s\S]*?)<\/video>/gi, (_, src, inner) => {
      hasMedia = true;
      return videoLink(inner.match(/<source[^>]*\bsrc="([^"]+)"/i)?.[1] ?? src);
    })
    .replaceAll(/<video[^>]*>([\s\S]*?)<\/video>/gi, (m, inner) => {
      const src = inner.match(/<source[^>]*\bsrc="([^"]+)"/i)?.[1];
      if (!src) return m;
      hasMedia = true;
      return videoLink(src);
    })
    .replaceAll(/<iframe[^>]*\bsrc="([^"]+)"[^>]*>([\s\S]*?)<\/iframe>/gi, (_, src) => {
      hasMedia = true;
      return `<p><a href="${src}">▶ Embedded content: ${src}</a></p>`;
    });
  return { chunk, hasMedia };
}

function firstMatch(html, ...patterns) {
  for (const re of patterns) {
    const m = html.match(re);
    if (m) return decodeEntities(m[1]);
  }
  return null;
}

function decodeEntities(s) {
  return s
    .replaceAll(/&quot;/g, '"')
    .replaceAll(/&#x27;|&#39;/g, "'")
    .replaceAll(/&lt;/g, '<')
    .replaceAll(/&gt;/g, '>')
    .replaceAll(/&amp;/g, '&');
}

// JSON.stringify strings are valid YAML scalars, so quoting is safe for any
// title/description content.
function frontmatter(html) {
  const fields = {
    title: firstMatch(html, /<title>([^<]*)<\/title>/i),
    description: firstMatch(
      html,
      /<meta[^>]*name="description"[^>]*content="([^"]*)"/i,
      /<meta[^>]*property="og:description"[^>]*content="([^"]*)"/i,
    ),
    url: firstMatch(html, /<link[^>]*rel="canonical"[^>]*href="([^"]*)"/i),
    image: firstMatch(html, /<meta[^>]*property="og:image"[^>]*content="([^"]*)"/i),
  };
  const lines = Object.entries(fields)
    .filter(([, v]) => v)
    .map(([k, v]) => `${k}: ${JSON.stringify(v)}`);
  return lines.length ? `---\n${lines.join('\n')}\n---\n\n` : '';
}

// Cloudflare's converter appends structured data as fenced JSON; do the same.
function jsonLdBlocks(html) {
  return [...html.matchAll(/<script type="application\/ld\+json">([\s\S]*?)<\/script>/gi)]
    .map((m) => `\n\`\`\`json\n${m[1].trim()}\n\`\`\`\n`)
    .join('\n');
}

// Remove stale mirrors first so pages deleted from the site can't linger.
for (const stale of walk(DIST, '.md')) rmSync(stale);

const htmlFiles = walk(DIST, '.html').filter((p) => !SKIP.has(relative(DIST, p)));
let written = 0;
for (const htmlPath of htmlFiles) {
  const html = readFileSync(htmlPath, 'utf8');
  const { chunk, hasMedia } = preserveMedia(extractContent(html));
  const body = converter.translate(chunk).trim();
  if (!body && !hasMedia && !html.includes('application/ld+json')) continue;
  const canonical = firstMatch(html, /<link[^>]*rel="canonical"[^>]*href="([^"]*)"/i);
  const mediaNote =
    hasMedia && canonical
      ? `\n> This page embeds video and interactive figures that plain text can't carry. View the HTML page at ${canonical} for the full version.\n`
      : '';
  const md = `${frontmatter(html)}${body}${mediaNote}\n${jsonLdBlocks(html)}`;
  writeFileSync(mirrorPath(htmlPath), md.endsWith('\n') ? md : `${md}\n`);
  written++;
}
console.log(`markdown mirrors: ${written} of ${htmlFiles.length} pages → dist/**/*.md`);
