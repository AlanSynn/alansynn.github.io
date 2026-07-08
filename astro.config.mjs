// @ts-check
import { defineConfig } from 'astro/config';
import { typst } from 'astro-typst';
import sitemap from '@astrojs/sitemap';
import yaml from '@modyfi/vite-plugin-yaml';

// Alan Synn — academic homepage. Deploys to alansynn.com (root path).
// https://astro.build/config
export default defineConfig({
  site: 'https://alansynn.com',
  base: '/',

  integrations: [
    sitemap({
      changefreq: 'weekly',
      priority: 0.7,
      // Unlisted pages build + are reachable by direct URL but must never be
      // advertised to crawlers. The sitemap filter only sees URL strings, so the
      // exclusion is path-based; the page also emits <meta robots noindex>
      // (MicrositeShell noindex prop) as a belt-and-suspenders guard. Today the
      // only unlisted page is the full-featured example/template.
      filter: (page) => !page.includes('/projects/example-graphics'),
    }),
    typst({
      target: () => 'html',
    }),
  ],

  vite: {
    plugins: [yaml()],
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
