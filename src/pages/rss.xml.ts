// RSS feed for the blog (canonical, advertised in <head> + footer).
// Feed content lives in `@/lib/feed` — `/blog/rss.xml` calls the same helper.
import type { APIContext } from 'astro';
import { blogFeedResponse } from '@/lib/feed';

export const GET = (ctx: APIContext) => blogFeedResponse(ctx);
