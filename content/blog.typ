#import "/src/3rd_party/mathyml/lib.typ": *

// ---- Semantic HTML helpers (shared by every post via `#import`: *) -------
// Typst's default block() renders as an opaque <div> in the HTML export, which
// the prose CSS can't target. These emit real semantic elements instead.
#let blockquote(body) = html.elem("blockquote", body)
#let hr = html.elem("hr")

// A stack of short, related example sentences — e.g. "typical sentences sound
// like this". Each argument becomes its own <p> inside a blockquote.examples,
// so the reader can scan one sentence per line instead of meeting a run-on
// italic wall. Use `blockquote` for a single pull-quote/callout, `examples`
// for a list of example utterances. Call as:
//   #examples("We explore a new paradigm.", "This opens a design space.")
#let examples(..items) = html.elem(
  "blockquote",
  attrs: ("class": "examples"),
  items.pos().map((it) => html.elem("p", it)).join(),
)

// A co-located figure: image + optional caption, emitted as a semantic
// <figure>. The image is read at build time and embedded via html.frame, so no
// separate static file is served — co-location (a folder next to the post's
// .typ) is for source organization only. `src` is project-root-absolute, e.g.
// "/content/blog/<slug>/diagram.svg"; `alt` is required (accessibility);
// `caption` adds a <figcaption>. `width` must be an ABSOLUTE length (pt) — the
// html export frame has no reference width, so relative `%` renders at 0.
// Figures are capped to the column on phones via `.prose figure svg` in CSS.
// Call as:
//   #blogimg("/content/blog/my-post/hero.png", alt: "The rig at rest",
//            caption: [The rig at rest.])
#let blogimg(src, alt: "", caption: none, width: 460pt) = {
  let img = html.frame(image(src, width: width, alt: alt))
  // alt doesn't propagate through html.frame; expose it on the figure itself
  // (role="img" + aria-label) so screen readers announce the image.
  html.elem(
    "figure",
    attrs: ("role": "img", "aria-label": alt),
    if caption != none { img + html.elem("figcaption", caption) } else { img },
  )
}

#let main(
  title: "Untitled",
  desc: "This is a blog post.",
  date: "2025-06-08",
  tags: (),
  draft: false,
  body,
  author: "Alan Synn",
) = {

  show: it => {


    // Generate metadata for Astro content collections
    [
      #metadata((
        title: title,
        author: author,
        description: desc,
        date: date,
        tags: tags,
        draft: draft,
      )) <frontmatter>
    ]

    // set basic document metadata
    set document(
      author: author,
      title: title,
    )


    // math rules
    show math.equation: set text(weight: 500)
    // show math.equation: to-mathml
    show math.equation: try-to-mathml
    

    // Footnotes
    show: it => {
      show footnote: it => context {
        let num = counter(footnote).get().at(0)
        link(label("footnote-" + str(num)), super(str(num)))
      }
      it
    }


    // Main body. (No inline outline — the floating scroll-spy TOC is built
    // client-side from the rendered <h2>/<h3> in Toc.astro; see src/pages/blog/[...slug].astro.)
    // Left-aligned (not justified) — justification creates rivers on the web.
    it

  }





  body
  

  context{
    query(footnote)
      .enumerate()
      .map(((idx, it)) => {
        enum.item[
          #html.elem(
            "div",
            attrs: ("data-typst-label": "footnote-" + str(idx + 1)),
            it.body,
          )
        ]
      })
      .join()
  }

}