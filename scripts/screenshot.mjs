// Captures full-page screenshots of every route in light + dark.
// Run while `npm run preview` is serving dist on :4321.
import { chromium } from 'playwright';
import { mkdirSync } from 'node:fs';

const BASE = process.env.BASE || 'http://localhost:4321';
const OUT = './shots';
mkdirSync(OUT, { recursive: true });

const routes = ['/', '/publications', '/cv', '/projects', '/research', '/blog', '/news', '/search'];

const browser = await chromium.launch();
for (const theme of ['light', 'dark']) {
  for (const route of routes) {
    const ctx = await browser.newContext({
      viewport: { width: 1280, height: 900 },
      deviceScaleFactor: 2,
    });
    await ctx.addInitScript((t) => {
      try {
        localStorage.setItem('theme', t);
      } catch (e) {}
    }, theme);
    const page = await ctx.newPage();
    try {
      await page.goto(BASE + route, { waitUntil: 'networkidle', timeout: 20000 });
      await page.waitForTimeout(900);
      const name = route === '/' ? 'home' : route.replace(/\//g, '_').replace(/^_/, '');
      await page.screenshot({ path: `${OUT}/${theme}-${name}.png`, fullPage: true });
      console.log(`  ${theme} ${route} -> ${theme}-${name}.png`);
    } catch (e) {
      console.log(`  ! ${theme} ${route} failed: ${e.message}`);
    }
    await ctx.close();
  }
}
await browser.close();
console.log('done');
