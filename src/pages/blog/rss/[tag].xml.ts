// Per-topic RSS feeds at /blog/rss/<tag>.xml — one static file per tag that
// appears on at least one PUBLISHED post. Deriving tags from published posts
// only mirrors the /blog chip bar, so a draft's registered tags never surface
// as a feed. Thin caller of the shared builder in @/lib/feed.
//
// NOTE: the sitemap filter in astro.config.mjs drops every path matching
// `rss.xml` or a `rss/` directory segment, so these feeds are automatically
// excluded from sitemap-0.xml — no manual filter edit when a tag is added.
import type { APIContext } from 'astro';
import { getCollection } from 'astro:content';
import { blogFeedResponse } from '@/lib/feed';

export async function getStaticPaths() {
  const posts = await getCollection('blog');
  const tags = [
    ...new Set(posts.filter((p) => !p.data.draft).flatMap((p) => p.data.tags ?? [])),
  ].sort();
  return tags.map((tag) => ({ params: { tag }, props: { tag } }));
}

export const GET = (ctx: APIContext) => blogFeedResponse(ctx, ctx.props.tag);
