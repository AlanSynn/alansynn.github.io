// RSS feed for the blog.
import rss from '@astrojs/rss';
import type { APIContext } from 'astro';
import { getCollection } from 'astro:content';
import { site } from '@/lib/data';

export async function GET(context: APIContext) {
  const posts = (await getCollection('blog')).sort((a, b) => b.data.date.valueOf() - a.data.date.valueOf());
  return rss({
    title: `${site.name} — Blog`,
    description: site.description,
    site: context.site ?? site.url,
    items: posts.map((p) => ({
      title: p.data.title,
      pubDate: p.data.date,
      link: `/blog/${p.id}/`,
      description: p.data.description ? String(p.data.description) : undefined,
      categories: p.data.tags ?? [],
    })),
  });
}
