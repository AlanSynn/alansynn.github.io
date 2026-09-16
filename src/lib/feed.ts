// Shared blog RSS feed builder. One content source (the `blog` collection),
// three route families: `/rss.xml` (canonical, advertised in <head>/footer),
// `/blog/rss.xml` (alias, reachable by direct URL — some readers expect the
// feed at the blog subpath), and `/blog/rss/<tag>.xml` (per-topic feeds, one
// static file per tag appearing on at least one PUBLISHED post — draft tags
// never surface, mirroring the /blog chip bar). All endpoints are thin callers
// of this helper so feed content is never duplicated.
import rss from '@astrojs/rss';
import type { APIContext } from 'astro';
import { getCollection } from 'astro:content';
import { site } from '@/lib/data';
import { tagLabel } from '@/lib/tags';

export async function blogFeedResponse(context: APIContext, tag?: string) {
  const posts = (await getCollection('blog'))
    .filter((p) => !p.data.draft)
    // Topic feed (`/blog/rss/<tag>.xml`): only posts carrying that tag. The
    // undefined-tag case is the whole-blog feed, unchanged.
    .filter((p) => !tag || (p.data.tags ?? []).includes(tag))
    .sort((a, b) => b.data.date.valueOf() - a.data.date.valueOf());
  return rss({
    title: tag ? `${site.name} - Blog: ${tagLabel(tag)}` : `${site.name} - Blog`,
    description: site.description,
    site: context.site ?? site.url,
    // Declare atom so item `<atom:updated>` (below) is namespace-valid. RSS 2.0
    // has no native "updated" element; the Atom namespace is the conventional
    // way to carry a per-item last-modified date, mirroring the BlogPosting
    // `dateModified` (and the source field name `updatedDate`).
    xmlns: { atom: 'http://www.w3.org/2005/Atom' },
    items: posts.map((p) => ({
      title: p.data.title,
      pubDate: p.data.date,
      link: `/blog/${p.id}/`,
      description: p.data.description ? String(p.data.description) : undefined,
      categories: p.data.tags ?? [],
      // `<atom:updated>` only when the post declares an updatedDate — same
      // source→output coupling as date → pubDate above.
      customData: p.data.updatedDate
        ? `<atom:updated>${p.data.updatedDate.toISOString()}</atom:updated>`
        : undefined,
    })),
  });
}
