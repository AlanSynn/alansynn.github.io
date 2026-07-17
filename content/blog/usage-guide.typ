#import "/content/blog.typ": *
#import "/src/3rd_party/mathyml/lib.typ" as mathyml
#import mathyml.prelude: *

// Unpublished (draft: true) — excluded from the /blog feed but reachable at
// /blog/usage-guide. A reference for how this site is written and a tour of
// what the Typst→HTML pipeline renders. Not an essay.
#show: main.with(
  title: "How this site is written",
  desc: "A short usage guide: how posts are authored in Typst and what the build pipeline renders.",
  date: "2026-07-04",
  tags: ("meta", "typst"),
  draft: true,
  // Demonstrates `updatedDate` (→ BlogPosting `dateModified` + RSS
  // `<atom:updated>`). This is the maintained reference post, so it legitimately
  // carries a revision date; it also exercises the template's `dateModified`
  // branch end-to-end (Typst → frontmatter → Zod → JSON-LD).
  updatedDate: "2026-07-17",
)

This is a reference post, not an essay. It exists to show how content on this
site is written and what the *Typst*-to-HTML build pipeline renders. It is kept
out of the public blog feed.

== One source of truth

Every page here is built from structured files: `YAML` for data, `BibTeX` for
publications, and `Typst` for prose. Edit the source, rebuild, and the web and
PDF outputs both update. There is no second copy to drift.

A blog post is a single `.typ` file under `content/blog/`. The header wires up
the title, description, date, and tags:

```typst
#import "/content/blog.typ": *
#import "/src/3rd_party/mathyml/lib.typ" as mathyml
#import mathyml.prelude: *

#show: main.with(
  title: "Post title",
  desc: "One-line description for the blog list.",
  date: "2026-07-04",
  tags: ("research",),
)

Body prose starts here.
```

== Sections and emphasis

Use `==` for sections, `===` for subsections. *Bold* with asterisks, _italic_
with underscores. Lists work as expected:

- Bullet items with a hyphen.
- Inline math like $E = m c^2$ sits in a sentence.
- Display math gets its own line.

== Math, typeset at build time

Because the site compiles Typst to HTML at build time, equations become MathML
— no client-side MathJax, no layout shift. Inline math is wrapped in dollar
signs: the mean-squared loss is
$cal(L)(theta) = (1)/(2n) sum_(i=1)^n (hat(y)_i - y_i)^2$.

A display equation:

$ integral_0^infinity e^(-x^2) dif x = (sqrt(pi))/(2) $

A reinforcement-learning objective, written almost as you would on paper:

$ cal(J)_text("PPO")(theta) = bb(E)_((q,a)~cal(D)) [ min(r_t(theta) hat(A)_t, "clip"(r_t(theta), 1 - epsilon, 1 + epsilon) hat(A)_t) ] $

where $r_t(theta) = (pi_theta(a_t | s_t))/(pi_(theta_text("old"))(a_t | s_t))$
is the importance-sampling ratio and $hat(A)_t$ is the advantage estimate.

== Figures

Diagrams drawn in native Typst render as embedded SVG. Coordinates may be
absolute or relative to the container:

#figure(
  html.frame(
    block(fill: rgb("eef2f6"), inset: 8pt, width: 460pt, radius: 4pt)[
      #box(width: 460pt, height: 3.4cm)[
        #place(center)[
          #polygon(
            fill: rgb("ffffff"),
            stroke: 1pt + rgb("9fb0c2"),
            (50%, 18%), (12%, 86%), (88%, 86%),
          )
        ]
      ]
    ]
  ),
  caption: [A native Typst polygon, rendered to SVG at build time.],
)

That is the whole pipeline — write prose and math, get crisp typeset output.

== Callouts and images

A blockquote callout:

#blockquote[
This is a callout block — a left accent bar with a sunken background. Use it for illustrative sentences or key restatements.
]

A co-located image lives in a folder next to the post's `.typ` file
(`content/blog/<slug>/`) and is embedded at build time via `#blogimg`:

#blogimg(
  "/content/blog/usage-guide/diagram.svg",
  alt: "One source (src/data and Typst) feeds both the web and the PDF outputs.",
  caption: [The whole site from one source. `#blogimg` embeds a co-located SVG.],
  width: 460pt,
)

