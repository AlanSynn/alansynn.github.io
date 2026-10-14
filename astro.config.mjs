// @ts-check
import { defineConfig } from 'astro/config';
import { typst } from 'astro-typst';
import sitemap from '@astrojs/sitemap';
import yaml from '@modyfi/vite-plugin-yaml';
import { resolve } from 'node:path';
import { existsSync, readdirSync, readFileSync, writeFileSync } from 'node:fs';
import { fileURLToPath } from 'node:url';
import { execFileSync } from 'node:child_process';

// Blog drafts (draft: true) build + are reachable by direct URL but must never
// be indexed or advertised to crawlers — parity with project `unlisted`.
// [...slug].astro → Base.astro's `noindex` prop emits <meta robots>; the sitemap
// filter below also drops them. The filter sees only URL strings, so compute the
// draft slugs once at config load by scanning the .typ sources (the draft flag
// lives in the #show: main.with(...) header near the top of each file). Project
// `unlisted` pages are excluded by hardcoded path (rare; currently
// example-graphics — the feature-exercising template). young-makers is
// `draft: true` during CHI review (never built at all), but its filter line
// below stays as a second layer while held — see content/projects/CLAUDE.md.
const blogDir = resolve(process.cwd(), 'content/blog');
const blogDraftSlugs = readdirSync(blogDir)
  .filter((f) => f.endsWith('.typ'))
  .filter((f) =>
    /^\s*draft:\s*true\b/m.test(readFileSync(resolve(blogDir, f), 'utf-8').slice(0, 800)),
  )
  .map((f) => f.slice(0, -'.typ'.length));

// Injects a <lastmod> per URL into dist/sitemap-0.xml AFTER @astrojs/sitemap
// writes it — so this integration MUST be registered after `sitemap()`
// (build:done hooks run in registration order). lastmod is the one sitemap
// field search engines actually use, and only when they can trust it, so each
// URL gets its SOURCE file's last git commit date — never the build time, so
// redeploying unchanged content never claims fake freshness. Where no git
// date is determinable (unmapped path, or a shallow CI checkout) the URL keeps
// NO lastmod: absent is honest, wrong is worse (deploy.yml pins
// fetch-depth: 0 for this reason).
function sitemapLastmod() {
  /** Map a sitemap URL to the content source that governs its freshness. */
  const sourceFor = (loc) => {
    const path = loc.replace(/^https?:\/\/[^/]+/, '');
    if (path === '/') return 'content'; // homepage freshness = newest content change
    if (/^\/blog\/?$/.test(path)) return 'content/blog'; // the list re-dates on any post change
    const post = path.match(/^\/blog\/([^/]+)\/$/);
    if (post) return `content/blog/${post[1]}.typ`;
    const project = path.match(/^\/projects\/([^/]+)\/$/);
    if (project) return `content/projects/${project[1]}.md`;
    return null;
  };
  return {
    name: 'sitemap-lastmod',
    hooks: {
      'astro:build:done': ({ dir }) => {
        const file = resolve(fileURLToPath(dir), 'sitemap-0.xml');
        if (!existsSync(file)) return;
        let xml = readFileSync(file, 'utf-8');
        for (const m of xml.matchAll(/<loc>([^<]+)<\/loc>/g)) {
          const src = sourceFor(m[1]);
          if (!src) continue;
          let date = '';
          try {
            date = execFileSync('git', ['log', '-1', '--format=%cI', '--', src], {
              cwd: process.cwd(),
              encoding: 'utf-8',
            }).trim();
          } catch {
            date = ''; // no git history reachable → omit, don't guess
          }
          if (date) {
            // String replace on the exact <loc> — locs are unique, and the
            // file is machine-generated in this exact shape.
            xml = xml.replace(`<loc>${m[1]}</loc>`, `<loc>${m[1]}</loc><lastmod>${date}</lastmod>`);
          }
        }
        writeFileSync(file, xml);
      },
    },
  };
}

// Alan Synn — academic homepage. Deploys to alansynn.com (root path).
// https://astro.build/config
export default defineConfig({
  site: 'https://alansynn.com',
  base: '/',

  integrations: [
    sitemap({
      // No changefreq/priority: uniform values across every URL carry no
      // signal (engines ignore them). The meaningful field — <lastmod> — is
      // injected per-URL by the sitemapLastmod integration registered below.
      // Reachable-but-not-indexed pages (project `unlisted` + blog drafts) build
      // and serve by direct URL but must never be advertised to crawlers. The
      // filter sees only URL strings, so exclusions are path-based; each page
      // ALSO emits <meta robots noindex> as a belt-and-suspenders guard
      // (MicrositeShell `noindex` for unlisted projects, Base.astro `noindex`
      // for draft posts). Two exclusion kinds: project `unlisted` → hardcoded
      // path (currently example-graphics; young-makers is `draft: true` during
      // CHI review so it never builds — its line below is a second layer while
      // held — see content/projects/CLAUDE.md); blog drafts → blogDraftSlugs,
      // scanned at config load above, so adding a draft needs no manual filter
      // edit.
      filter: (page) =>
        !page.includes('/projects/example-graphics') &&
        !page.includes('/projects/young-makers') &&
        // Feeds: /rss.xml, /blog/rss.xml, and per-topic /blog/rss/<tag>.xml —
        // XML, not pages, so none belong in the sitemap. Anchored to those feed
        // shapes only: a hypothetical post slug `rss` (/blog/rss/, no .xml) is
        // NOT matched, and neither is `rss-guide`.
        !/(^|\/)rss\.xml$|(^|\/)rss\/[^/]+\.xml$/.test(page) &&
        // /search is a thin client-side Pagefind UI, not indexable content —
        // it stays crawlable (robots.txt allows it), just not advertised here.
        !/(^|\/)search\/?$/.test(page) &&
        !blogDraftSlugs.some((slug) => page.includes(`/blog/${slug}/`)),
    }),
    // AFTER sitemap() — see the hook comment for why order is load-bearing.
    sitemapLastmod(),
    typst({
      target: () => 'html',
    }),
  ],

  vite: {
    plugins: [
      yaml(),
      {
        // Data files read via readFileSync (outside Vite's module graph) get no
        // HMR, so editing them in dev does nothing until a manual server restart.
        // Watch them and full-reload the browser; getPapers() skips its cache in
        // dev so the reload re-reads the file. Extend `files` if more such
        // sources appear. (content/*.yaml are imported → already hot-reload.)
        name: 'reload-on-content-change',
        configureServer(server) {
          const files = [resolve(process.cwd(), 'content/papers.bib')];
          for (const f of files) server.watcher.add(f);
          server.watcher.on('change', (file) => {
            if (files.includes(file)) server.ws.send({ type: 'full-reload' });
          });
        },
      },
    ],
    build: {
      cssCodeSplit: true,
      minify: 'esbuild',
      sourcemap: false,
      target: 'es2022', // modern browsers only — skip ES5/ES2015 transpilation
      reportCompressedSize: false, // skip brotli/gzip size reporting → faster builds
    },
    resolve: {
      alias: {
        '@': '/src',
        '@content': '/content',
      },
    },
  },

  build: {
    inlineStylesheets: 'auto',
  },

  output: 'static',

  // The site is a single interactive-CV page; these legacy slugs collapse
  // into anchor sections on /. (Static build emits meta-refresh redirects.)
  redirects: {
    '/research': '/#publications',
    '/projects': '/#projects',
    '/news': '/#news',
    '/publications': '/#publications',
    '/cv': '/#profile',
    // Legacy microsite URL (the old motionsmith repo) → internalized project page.
    '/motionsmith': '/projects/motionsmith',
  },

  markdown: {
    shikiConfig: {
      theme: 'github-light',
      wrap: true,
    },
  },
});
