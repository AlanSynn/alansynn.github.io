// ============================================================================
// Content collections. Blog = Typst (framework pattern). News + Projects =
// Markdown, one file per item - scalable, al-folio-like, ready for a future
// lab page (multi-author).
// ============================================================================
import { glob } from 'astro/loaders';
import { defineCollection, z } from 'astro:content';

const blog = defineCollection({
  loader: glob({ base: './content/blog', pattern: '**/*.typ' }),
  schema: z.object({
    title: z.string(),
    author: z.string().optional(),
    description: z.any().optional(),
    date: z.coerce.date(),
    updatedDate: z.coerce.date().optional(),
    tags: z.array(z.string()).optional(),
  }),
});

const news = defineCollection({
  loader: glob({ base: './content/news', pattern: '**/*.md' }),
  schema: z.object({
    date: z.coerce.date(),
    link: z.string().url().optional(),
    highlight: z.boolean().default(false),
  }),
});

const projects = defineCollection({
  loader: glob({ base: './content/projects', pattern: '**/*.md' }),
  schema: z.object({
    title: z.string(),
    period: z.string().optional(),
    org: z.string().optional(),
    category: z.string().default('work'),
    order: z.number().default(0),
    date: z.coerce.date().optional(),
    summary: z.string().optional(),
    image: z.string().optional(),
    video: z.string().optional(),          // YouTube id or full URL
    links: z.array(z.object({ label: z.string(), url: z.string() })).default([]),
  }),
});

export const collections = { blog, news, projects };
