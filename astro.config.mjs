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
  },

  markdown: {
    shikiConfig: {
      theme: 'github-light',
      wrap: true,
    },
  },
});
