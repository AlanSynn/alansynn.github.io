// CSS-isolation guard for academic project pages.
//
// The academic /projects/<slug> route (frontmatter `paper:`) renders through
// MicrositeShell → project-page.css ONLY. NO site main.css / tokens.css /
// base.css may be in that route's stylesheet graph. This script asserts that
// invariant on a real built page in BOTH light and dark so the load-bearing
// route split can't regress silently. Run against `just web && astro preview`
// (default :4321), or any BASE. Exits non-zero on any violation.
//
//   node scripts/check-isolation.mjs
//   BASE=http://localhost:4321 node scripts/check-isolation.mjs
//
// Checks:
//  1. Stylesheet graph (both modes): no <link> matching site main/tokens/base.
//     This is the robust invariant — it discriminates a leak regardless of theme.
//  2. Light-mode body color: the microsite light ink #1b1f28 (rgb(27,31,40)) is
//     DISTINCT from the site light ink #15171c, so this catches an effective
//     leak (base.css would recolor the body). Skipped in dark — the two dark
//     palettes converge by design (mirroring main), so it can't discriminate.
//  3. data-theme set + correct: MicrositeShell's no-flash init must set it, else
//     the theme toggle is broken. (It once had to be ABSENT — that was before
//     the academic route shipped its own theme init for dark mode.)
import { chromium } from 'playwright';

const BASE = process.env.BASE || 'http://localhost:4321';
// Real academic routes (paper: frontmatter → MicrositeShell). Work-project
// routes legitimately use Base + site CSS, so don't add them here.
const ACADEMIC_ROUTES = ['/projects/motionsmith'];

const SITE_STYLESHEET = /(^|\/)(main|tokens|base)(\.|[A-Za-z0-9_]*\.css)/;
const EXPECTED_LIGHT_INK = 'rgb(27, 31, 40)'; // microsite --text #1b1f28

const browser = await chromium.launch();
const failures = [];

for (const route of ACADEMIC_ROUTES) {
  for (const theme of ['light', 'dark']) {
    const ctx = await browser.newContext({
      viewport: { width: 1280, height: 900 },
      colorScheme: theme,
    });
    await ctx.addInitScript((t) => {
      try {
        localStorage.setItem('theme', t);
      } catch (e) {}
    }, theme);
    const page = await ctx.newPage();
    try {
      await page.goto(BASE + route, { waitUntil: 'networkidle', timeout: 20000 });
      await page.waitForTimeout(400);

      // 1. Stylesheet graph.
      const sheets = await page.evaluate(() =>
        Array.from(document.querySelectorAll('link[rel="stylesheet"]')).map((l) => l.href),
      );
      const leaked = sheets.filter((href) => SITE_STYLESHEET.test(href));
      if (leaked.length) {
        failures.push(`${route} [${theme}]: site CSS leaked: ${leaked.join(', ')}`);
      }

      // 2. Light-mode body color (discriminates an effective leak).
      if (theme === 'light') {
        const bodyColor = await page.evaluate(() => getComputedStyle(document.body).color);
        if (bodyColor !== EXPECTED_LIGHT_INK) {
          failures.push(
            `${route} [light]: body ${bodyColor} ≠ microsite ink ${EXPECTED_LIGHT_INK} (site base.css leak or unstyled body)`,
          );
        }
      }

      // 3. data-theme set correctly by MicrositeShell's init.
      const dt = await page.evaluate(() => document.documentElement.getAttribute('data-theme'));
      if (dt !== theme) {
        failures.push(
          `${route} [${theme}]: data-theme="${dt}" ≠ "${theme}" (MicrositeShell no-flash theme init missing or wrong)`,
        );
      }

      console.log(`  ok  ${route} [${theme}] (sheets: ${sheets.length})`);
    } catch (e) {
      failures.push(`${route} [${theme}]: error: ${e.message}`);
    }
    await ctx.close();
  }
}

await browser.close();

if (failures.length) {
  console.error(`\nCSS-ISOLATION GUARD FAILED (${failures.length}):`);
  for (const f of failures) console.error('  ✗ ' + f);
  process.exit(1);
}
console.log(`\nCSS-isolation guard passed (${ACADEMIC_ROUTES.length} route(s) × 2 themes).`);
