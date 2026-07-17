// @ts-check
import { defineConfig } from 'astro/config';
import { typst } from 'astro-typst';
import sitemap from '@astrojs/sitemap';
import yaml from '@modyfi/vite-plugin-yaml';
import { resolve } from 'node:path';
import { readdirSync, readFileSync } from 'node:fs';

// Blog drafts (draft: true) build + are reachable by direct URL but must never
// be indexed or advertised to crawlers — parity with project `unlisted`.
// [...slug].astro → Base.astro's `noindex` prop emits <meta robots>; the sitemap
// filter below also drops them. The filter sees only URL strings, so compute the
// draft slugs once at config load by scanning the .typ sources (the draft flag
// lives in the #show: main.with(...) header near the top of each file). Project
// `unlisted` pages are excluded by hardcoded path instead (rare; one example).
const blogDir = resolve(process.cwd(), 'content/blog');
const blogDraftSlugs = readdirSync(blogDir)
  .filter((f) => f.endsWith('.typ'))
  .filter((f) =>
    /^\s*draft:\s*true\b/m.test(readFileSync(resolve(blogDir, f), 'utf-8').slice(0, 800)),
  )
  .map((f) => f.slice(0, -'.typ'.length));

// Alan Synn — academic homepage. Deploys to alansynn.com (root path).
// https://astro.build/config
export default defineConfig({
  site: 'https://alansynn.com',
  base: '/',

  integrations: [
    sitemap({
      changefreq: 'weekly',
      priority: 0.7,
      // Reachable-but-not-indexed pages (project `unlisted` + blog drafts) build
      // and serve by direct URL but must never be advertised to crawlers. The
      // filter sees only URL strings, so exclusions are path-based; each page
      // ALSO emits <meta robots noindex> as a belt-and-suspenders guard
      // (MicrositeShell `noindex` for unlisted projects, Base.astro `noindex`
      // for draft posts). Two exclusion kinds: project `unlisted` → hardcoded
      // path (rare; one example template); blog drafts → blogDraftSlugs, scanned
      // at config load above, so adding a draft needs no manual filter edit.
      filter: (page) =>
        !page.includes('/projects/example-graphics') &&
        !page.endsWith('/rss.xml') &&
        !blogDraftSlugs.some((slug) => page.includes(`/blog/${slug}/`)),
    }),
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
