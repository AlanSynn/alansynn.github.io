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