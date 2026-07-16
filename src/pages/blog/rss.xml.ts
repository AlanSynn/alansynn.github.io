// RSS feed for the blog at the /blog subpath (unadvertised alias of /rss.xml).
// A literal filename shadows `pages/blog/[...slug].astro` by route precedence,
// so /blog/rss.xml resolves here, not to a blog post with slug "rss.xml".
// Same feed content as /rss.xml via the shared helper — advertise only one.
import type { APIContext } from 'astro';
import { blogFeedResponse } from '@/lib/feed';

export const GET = (ctx: APIContext) => blogFeedResponse(ctx);
