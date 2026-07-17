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
  title: none,
  desc: none,
  date: none,
  tags: (),
  draft: false,
  body,
  author: "Alan Synn",
  updatedDate: none,
) = {

  // Every post must declare its own title / desc / date — never fall through to
  // a stock placeholder. `desc` drives <meta description>, OG/Twitter, RSS, and
  // the BlogPosting JSON-LD, so a missing one silently leaks a placeholder into
  // all of them. Fail the build loudly (same discipline as the strict content
  // schemas: a missing required field must never render as a stock string).
  assert(type(title) == str and title.trim() != "", message: "blog post requires a non-empty `title:`. Add it to #show: main.with(...).")
  assert(type(desc) == str and desc.trim() != "", message: "blog post requires a non-empty `desc:` (a one-line summary). Add it to #show: main.with(...).")
  // Dates must be zero-padded YYYY-MM-DD: the updatedDate>=date compare below is
  // lexicographic, which is only chronologically correct for that exact format.
  // Without this guard a dropped leading zero (e.g. updatedDate:"2026-2-28" vs
  // date:"2026-12-01") would sort BEFORE Dec and silently ship dateModified
  // < datePublished — the very defect this assert exists to catch. Reject
  // non-conforming values at the source so the error points here, not at a
  // downstream Zod parse. Semantic validity (month/day range, leap years) is
  // left to z.coerce.date() in content.config.ts as a second backstop.
  // repr() (not str()) in the messages: assert args are evaluated eagerly even
  // when the condition holds, and str(none) is itself a Typst error — so a
  // post with no updatedDate would crash compiling the message, not failing the
  // assert. repr() stringifies any value (none → "none", "2026-2-28" → that).
  let iso = regex("^\\d{4}-\\d{2}-\\d{2}$")
  assert(type(date) == str and date.matches(iso).len() > 0, message: "blog post `date:` must be YYYY-MM-DD (zero-padded, e.g. 2026-07-17). Got: " + repr(date) + ".")
  assert(updatedDate == none or (type(updatedDate) == str and updatedDate.matches(iso).len() > 0), message: "blog post `updatedDate:` must be YYYY-MM-DD (zero-padded) or omitted. Got: " + repr(updatedDate) + ".")
  // Now provably safe: both are zero-padded ISO strings → lex compare = chronological.
  assert(updatedDate == none or updatedDate >= date, message: "updatedDate must be on or after date (dateModified >= datePublished per Google's Article spec).")

  show: it => {


    // Generate metadata for Astro content collections. `updatedDate` is emitted
    // only when set: emitting Typst `none` as YAML null would coerce to the Unix
    // epoch under z.coerce.date(), so the key must be absent (not null) when
    // unset. When set, it lights up the BlogPosting `dateModified` in Base.astro.
    let frontmatter = (
      title: title,
      author: author,
      description: desc,
      date: date,
      tags: tags,
      draft: draft,
    )
    if updatedDate != none { frontmatter.insert("updatedDate", updatedDate) }
    [
      #metadata(frontmatter) <frontmatter>
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
    

    // Footnotes: the inline marker is an HTML anchor to #footnote-N (not a
    // Typst link(label()) — that needs a real <footnote-N> label, which the
    // endnote div below can't synthesize). The matching id lives on the div.
    show footnote: it => context {
      let num = counter(footnote).get().at(0)
      html.elem("a", attrs: ("href": "#footnote-" + str(num)), super(str(num)))
    }
    // Suppress Typst's NATIVE footnote entries — they would double-render
    // alongside the manual query(footnote) endnote list below. Must live at
    // this (document) scope, NOT nested in a `show: it =>` block: footnote
    // entries are emitted at document finalize, outside the body content `it`,
    // so a show rule nested inside `it` never reaches them.
    show footnote.entry: none


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
            attrs: ("id": "footnote-" + str(idx + 1)),
            it.body,
          )
        ]
      })
      .join()
  }

}