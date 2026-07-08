// Content collections. Blog = Typst. Projects = Markdown (one file per item,
// al-folio-like). News lives in content/news.yaml read directly, not a collection.
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
  schema: z
    .object({
      title: z.string(),
      period: z.string().optional(),
      org: z.string().optional(),
      // 'work' (default) → homepage grid; 'research' routed at /projects/<slug>
      // but filtered OUT of the grid (research output lives in #publications).
      category: z.string().default('work'),
      order: z.number().default(0),
      date: z.coerce.date().optional(),
      summary: z.string().optional(),
      image: z.string().optional(),
      video: z.string().optional(), // YouTube id or full URL
      links: z.array(z.object({ label: z.string(), url: z.string() })).default([]),
      // --- academic paper-page fields (category: 'research') ---
      // citekey into content/papers.bib; the hero/citation/BibTeX/scholar-meta
      // DERIVE from the linked Paper (single source of truth). Required when
      // category === 'research'; citekey existence is verified at build in
      // src/pages/projects/[slug].astro getStaticPaths.
      paper: z.string().optional(),
      teaser_caption: z.string().optional(),
      // Hero eyebrow override (defaults to "<Venue> <year>"). Original
      // motionsmith uses "CHI 2026 Full Paper".
      hero_eyebrow: z.string().optional(),
      // Bold/dark title prefix (e.g. "MotionSmith:") — the rest of the title
      // renders muted. Optional; absent → uniform title.
      title_mark: z.string().optional(),
      // Explicit hero title line-breaks for pixel-exact parity with the original
      // microsite (which hand-breaks the <h1> into .hero__title-line spans).
      // Each entry is one visual line; `mark` is the bold/dark prefix (line 1),
      // `rest` is the muted text. Optional; absent → title_mark + rest inline.
      title_lines: z
        .array(z.object({ mark: z.string().optional(), rest: z.string() }).strict())
        .optional(),
      // Conference/workshop date range shown in the venue line (e.g.
      // "April 13–17, 2026"); the venue + city already derive from the bib.
      event_dates: z.string().optional(),
      // Institution legend + per-author superscript index (1-based, in bib
      // author order). Renders affiliation superscripts + a legend line.
      affiliations: z.array(z.string()).optional(),
      author_affil: z.array(z.number().int().positive()).optional(),
      // Overview section h2 (the rich-copy prose comes from the markdown body).
      overview_heading: z.string().optional(),
      // Overview key-findings list (renders after the body prose).
      takeaways: z.array(z.object({ title: z.string(), text: z.string() }).strict()).optional(),
      // sticky section-nav labels (e.g. [Overview, Demo, System, Cases, Citation]).
      nav: z.array(z.string()).optional(),
      // tabbed case carousel (one entry per maker/case); rendered by <CaseTabs>.
      cases: z
        .array(
          z
            .object({
              tab: z.string(), // tab label (e.g. maker name)
              subtitle: z.string().optional(), // e.g. "Shy elephant / Four-bar"
              image: z.string(), // case figure path under /public
              alt: z.string(),
              caption: z.string().optional(), // figure figcaption
              lede: z.string().optional(), // one-sentence case intro
              facts: z.array(z.object({ label: z.string(), text: z.string() }).strict()).optional(), // e.g. Mechanism / Fabrication / Why it matters
            })
            .strict(),
        )
        .optional(),
      // Cases section h2 + intro (cases itself is an array, so these sit beside it).
      cases_heading: z.string().optional(),
      cases_intro: z.string().optional(),
      // Citation section h2 + copy (the BibTeX block derives from papers.bib).
      citation_heading: z.string().optional(),
      citation_intro: z.string().optional(),
      // Structured media sections rendered by AcademicProject (not the markdown
      // body — Astro .md can't inject custom components, so bespoke blocks are
      // frontmatter-driven like `cases:`). All optional; present → section shows.
      demo: z
        .object({
          src: z.string(), // video path
          poster: z.string(), // poster image path
          alt: z.string(),
          intro: z.string().optional(), // one-line lead above the video
        })
        .strict()
        .optional(),
      system: z
        .object({
          heading: z.string().optional(), // section h2
          intro: z.string().optional(), // section__center subcopy
          workflow: z
            .object({ src: z.string(), alt: z.string(), caption: z.string().optional() })
            .strict()
            .optional(),
          stages: z
            .array(
              z
                .object({
                  index: z.string().optional(), // e.g. "01"
                  title: z.string(),
                  text: z.string(),
                })
                .strict(),
            )
            .optional(), // pipeline stage panels
          zoom: z
            .object({ src: z.string(), alt: z.string(), caption: z.string().optional() })
            .strict()
            .optional(), // hover magnifier via <ZoomImage>
          // Interface sub-panel: lens image + heading + copy (the magnifier).
          interface: z.object({ heading: z.string(), copy: z.string() }).strict().optional(),
        })
        .strict()
        .optional(),
      // --- graphics-researcher media (category: 'research', optional) ---
      // Rendered by dedicated components in src/components/project/. Flat
      // fields, grouped into sections at render time: results+ablation → one
      // "Results" section; comparisons+video_comparison → one "Comparison"
      // section; gallery → its own "Gallery" section.
      // before/after image-comparison sliders (the graphics money shot).
      comparisons: z
        .array(
          z
            .object({
              before: z.object({ src: z.string(), alt: z.string() }).strict(),
              after: z.object({ src: z.string(), alt: z.string() }).strict(),
              label_before: z.string().optional(),
              label_after: z.string().optional(),
              caption: z.string().optional(),
            })
            .strict(),
        )
        .optional(),
      // Quantitative results table (mono numerics, highlighted best row).
      results: z
        .object({
          caption: z.string().optional(),
          note: z.string().optional(),
          columns: z.array(z.string()),
          rows: z.array(
            z
              .object({
                cells: z.array(z.union([z.string(), z.number()])),
                highlight: z.boolean().optional(),
              })
              .strict(),
          ),
        })
        .strict()
        .optional(),
      // Ablation table (same shape as results; rendered in the Results section).
      ablation: z
        .object({
          caption: z.string().optional(),
          note: z.string().optional(),
          columns: z.array(z.string()),
          rows: z.array(
            z
              .object({
                cells: z.array(z.union([z.string(), z.number()])),
                highlight: z.boolean().optional(),
              })
              .strict(),
          ),
        })
        .strict()
        .optional(),
      // Results gallery — multi-image grid with optional per-tile label + caption.
      gallery: z
        .object({
          columns: z.number().int().positive().optional(),
          items: z.array(
            z
              .object({
                src: z.string(),
                alt: z.string(),
                caption: z.string().optional(),
                label: z.string().optional(),
              })
              .strict(),
          ),
        })
        .strict()
        .optional(),
      // Synced side-by-side video comparison (rendered in the Comparison section).
      video_comparison: z
        .object({
          left: z
            .object({ src: z.string(), poster: z.string().optional(), label: z.string() })
            .strict(),
          right: z
            .object({ src: z.string(), poster: z.string().optional(), label: z.string() })
            .strict(),
          caption: z.string().optional(),
        })
        .strict()
        .optional(),
      // Draft pages are skipped in the production build (getStaticPaths filters
      // on import.meta.env.PROD) but still render in `just dev` — used for the
      // unpublished full-featured example page.
      draft: z.boolean().default(false),
    })
    .strict()
    .superRefine((data, ctx) => {
      // Academic paper pages must link a papers.bib entry — the hero derives
      // title/authors/venue/BibTeX from it. Without `paper:` the academic layout
      // has nothing to render.
      if (data.category === 'research' && !data.paper) {
        ctx.addIssue({
          code: 'custom',
          message: "category: 'research' requires a `paper:` citekey linking content/papers.bib.",
        });
      }
    }),
});

export const collections = { blog, projects };
