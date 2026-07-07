// ============================================================================
// Content collections. Blog = Typst (framework pattern). Projects = Markdown,
// one file per item - scalable, al-folio-like, ready for a future lab page
// (multi-author). News lives in a single list file (content/news.yaml) read
// directly, not a collection.
// ============================================================================
import { glob } from 'astro/loaders';
import { defineCollection } from 'astro:content';
import { z } from 'astro/zod';

const blog = defineCollection({
  loader: glob({ base: './content/blog', pattern: '**/*.typ' }),
  schema: z.object({
    title: z.string(),
    author: z.string().optional(),
    description: z.any().optional(),
    date: z.coerce.date(),
    updatedDate: z.coerce.date().optional(),
    tags: z.array(z.string()).optional(),
    draft: z.boolean().default(false),
  }),
});

const projects = defineCollection({
  loader: glob({ base: './content/projects', pattern: '**/*.md' }),
  schema: z.object({
    title: z.string(),
    period: z.string().optional(),
    org: z.string().optional(),
    // 'work' (default) appears in the homepage project grid; 'research' is
    // filtered OUT of the grid (index.astro) because research output lives in
    // #publications via papers.bib. Use 'research' for files you want routed
    // at /projects/<slug> but NOT surfaced on the homepage.
    category: z.string().default('work'),
    order: z.number().default(0),
    date: z.coerce.date().optional(),
    summary: z.string().optional(),
    image: z.string().optional(),
    video: z.string().optional(), // YouTube id or full URL
    links: z.array(z.object({ label: z.string(), url: z.string() })).default([]),
  }),
});

export const collections = { blog, projects };
