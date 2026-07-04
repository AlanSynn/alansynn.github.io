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
    },
    resolve: {
      alias: {
        '@': '/src',
      },
    },
  },

  build: {
    inlineStylesheets: 'auto',
  },

  output: 'static',

  markdown: {
    shikiConfig: {
      theme: 'github-light',
      wrap: true,
    },
  },
});
