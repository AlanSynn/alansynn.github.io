// llms.txt — machine-readable site index for LLM crawlers (llmstxt.org shape:
// H1 title, blockquote summary, H2 sections of `- [title](url): description`
// lines). Generated at build from the SAME content source as the site — papers
// via getPapers(), posts via the blog collection, projects via the projects
// collection — so it can never drift from what is actually served.
//
// Visibility mirrors the production surfaces exactly:
//   papers   → same predicate as index.astro #publications (demo/web_off out),
//              which keeps the fictional template entry AND young-makers
//              (web_off: fully OFF the web during CHI 2027 double-anonymous
//              review) out of this file too.
//   posts    → published only (drafts never surface, mirroring /blog + RSS).
//   projects → non-draft + non-unlisted (mirrors [slug].astro + sitemap filter).
import { getCollection } from 'astro:content';
import type { APIRoute } from 'astro';
import { site, getPapers, type Paper } from '@/lib/data';
import { projectYear } from '@/lib/projects';

const URL_BASE = site.url.replace(/\/$/, '');

// One-line string: collapse internal whitespace/newlines (bib/YAML values may wrap).
const oneline = (s: string) => s.replace(/\s+/g, ' ').trim();

// Prefix root-relative URLs with the site origin; absolute URLs pass through.
const abs = (u?: string) => (u && !/^https?:\/\//.test(u) ? `${URL_BASE}${u}` : (u ?? ''));

// Priority link for a publication: its project page (paper-page URL), else
// DOI, else canonical URL, else hosted/arXiv PDF. All may be absent.
function paperLink(p: Paper): string | null {
  if (p.website) return /^https?:\/\//.test(p.website) ? p.website : abs(p.website);
  if (p.doi) return `https://doi.org/${p.doi}`;
  if (p.url) return p.url;
  if (p.pdf) return /^https?:\/\//.test(p.pdf) ? p.pdf : abs(p.pdf);
  return null;
}

export const GET: APIRoute = async () => {
  const year = new Date().getFullYear();
  const fmtMonth = (d: Date) =>
    d.toLocaleDateString('en-US', { year: 'numeric', month: 'long', timeZone: 'UTC' });

  const social = (label: string) =>
    (site.socials ?? []).find((s: { label: string }) => s.label === label)?.url;

  // Public papers (same set the homepage lists) + public posts/projects.
  const papers = getPapers().filter((p) => p.fields.demo !== 'true' && p.fields.web_off !== 'true');
  const posts = (await getCollection('blog'))
    .filter((p) => !p.data.draft)
    .sort((a, b) => b.data.date.valueOf() - a.data.date.valueOf());
  const projects = (await getCollection('projects'))
    .filter((p) => !p.data.draft && !p.data.unlisted)
    .sort((a, b) => (projectYear(b) ?? 0) - (projectYear(a) ?? 0));

  const advisors = (site.advisors ?? []).map((a: { name: string }) => a.name).join(' & ');

  const lines: string[] = [];

  lines.push(`# ${site.name}`);
  lines.push('');
  lines.push(
    `> ${oneline(site.description)} ${site.short_name} is a ${site.title} at ` +
      `${site.affiliation} (${site.department})${advisors ? `, advised by ${advisors}` : ''}.`,
  );
  lines.push('');
  lines.push(
    'This index is generated at build time from the same content source as the site; ' +
      'every link below is a canonical page an LLM may quote with attribution.',
  );
  lines.push('');
  lines.push('## About');
  lines.push('');
  lines.push(`- [Homepage](${URL_BASE}/): interactive CV — profile, publications, projects, news.`);
  lines.push(`- [Blog](${URL_BASE}/blog/): long-form essays and notes. RSS: ${URL_BASE}/rss.xml`);
  if (social('CV')) lines.push(`- [Curriculum Vitae (PDF)](${abs(social('CV'))})`);
  if (social('Scholar')) lines.push(`- [Google Scholar](${social('Scholar')})`);
  if (social('GitHub')) lines.push(`- [GitHub](${social('GitHub')})`);
  if (social('LinkedIn')) lines.push(`- [LinkedIn](${social('LinkedIn')})`);
  lines.push('');

  if (papers.length) {
    lines.push('## Publications');
    lines.push('');
    for (const p of papers) {
      const authors = p.authors
        .map((a) => (a.given ? `${a.given} ${a.family}` : a.family))
        .join(', ');
      // Venue + year, but not twice: some booktitles already carry the year
      // ("… Proceedings of the 2026 CHI Conference …") — append only when absent.
      const venue = oneline(p.venue || p.abbr || '');
      const venueLine =
        venue && venue.includes(String(p.year))
          ? venue
          : [venue, String(p.year)].filter(Boolean).join(' ');
      const link = paperLink(p);
      const body = oneline(`${venueLine}. ${authors}.`);
      lines.push(
        link ? `- [${oneline(p.title)}](${link}): ${body}` : `- ${oneline(p.title)}: ${body}`,
      );
    }
    lines.push('');
  }

  if (projects.length) {
    lines.push('## Projects');
    lines.push('');
    for (const pr of projects) {
      const d = pr.data;
      const url = `${URL_BASE}/projects/${pr.id}/`;
      const summary = d.summary ? `: ${oneline(d.summary)}` : '';
      lines.push(`- [${oneline(d.title)}](${url})${summary}`);
    }
    lines.push('');
  }

  if (posts.length) {
    lines.push('## Blog posts');
    lines.push('');
    for (const post of posts) {
      const url = `${URL_BASE}/blog/${post.id}/`;
      const desc = post.data.description ? `: ${oneline(post.data.description)}` : '';
      lines.push(`- [${oneline(post.data.title)}](${url})${desc} (${fmtMonth(post.data.date)})`);
    }
    lines.push('');
  }

  lines.push('## Citing and licensing');
  lines.push('');
  lines.push(
    `Written content on alansynn.com is © ${year} ${site.name}, licensed ` +
      'CC BY-NC-ND 4.0 (https://creativecommons.org/licenses/by-nc-nd/4.0/): quote and link ' +
      'freely WITH attribution; modifications and commercial reuse require permission. ' +
      `Attribute as: ${site.name}, "<page title>", alansynn.com, <year>, <page URL>. ` +
      'Blog posts carry a ready-made citation line at the foot of the page; cite conference ' +
      'papers by their DOI (linked above).',
  );
  lines.push('');

  return new Response(lines.join('\n'), {
    headers: { 'Content-Type': 'text/plain; charset=utf-8' },
  });
};
