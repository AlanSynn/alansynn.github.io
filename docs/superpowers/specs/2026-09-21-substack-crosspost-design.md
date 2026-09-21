# Substack Cross-Posting — Design

Date: 2026-09-21
Status: approved (pending user review of this document)

## Goal

Every published blog post on alansynn.com is automatically cross-posted — full
text, published, web-only — to Alan's Substack publication by the existing
`push main → deploy.yml` pipeline. Editing a post in `content/blog/*.typ`
remains the single act of authorship; Substack stays in sync without a second
manual step.

## Locked decisions

| Decision | Choice |
|---|---|
| Body scope | Full text + first-line "Originally published at …" link + CC BY-NC-ND footer |
| Publish mode | Fully automatic publish (no human gate) |
| Email | `send: false` always — CI never triggers the subscriber email blast |
| Post scope | All non-draft posts; per-post opt-out via frontmatter; existing posts backfilled |
| Opted out | `usage-guide` (repo meta doc; also avoids inline-LaTeX risk, see below) |
| Channel | Substack only (dev.to / Hashnode deferred — generator/client split keeps them cheap to add) |
| API transport | Raw `fetch` against Substack's undocumented drafts API |
| Math | Typst math stays the single source; converted to LaTeX at sync time via `typst2tex`; pushed as native ProseMirror LaTeX nodes |

### Rejected alternatives (with reasons, so we don't relitigate)

- **npm `substack-api`** — post entity is read-only; no draft create/publish.
- **`jakub-k-slys/substack-gateway-oss`** — no publish endpoint for posts
  (drafts only, notes publish excluded), no raw ProseMirror body passthrough
  (it converts HTML↔Markdown itself), and it would add a self-hosted Python
  service on top of the *same* session-cookie auth. Zero risk reduction, pure
  infra cost.
- **Email-in (`send` to secret address)** — formatting loss, no updates, no
  control.
- **Write LaTeX in post sources** — inverts the dependency: the site renders
  Typst, so a second LaTeX→Typst conversion would appear and the single-source
  invariant would break.
- **Medium / beehiiv** — Medium stopped issuing integration tokens (2024);
  beehiiv's write API is Max/Enterprise-only.
- **Image pre-rendering of math** — unnecessary; native LaTeX nodes work
  (verified via ma2za/python-substack, e2e-tested for exactly this).

## Architecture

```
push main
  └─ deploy.yml
       ├─ (existing) just web + Pages deploy
       └─ (new) sync-substack job, needs: deploy
            └─ scripts/sync-substack.mjs
                 1. collect dist/blog/<slug>/index.html (drafts never build → naturally excluded)
                 2. gate: <meta name="substack" content="false"> → skip
                 3. extract prose root from the post page (drop TOC, subscribe
                    postscript, giscus, "← All posts", page header)
                 4. HTML → ProseMirror JSON
                      h2/h3 → heading · blockquote → blockquote ·
                      code fence → codeBlock · links/bold/italic/inline code → marks ·
                      blogimg figure → upload image + captionedImage ·
                      footnotes stay as the site's existing endnotes list (plain nodes —
                      no special footnote ProseMirror nodes needed)
                 5. math: extract $...$ spans from content/blog/<slug>.typ source
                      (skip raw blocks/fences) → typst2tex →
                      display (space-delimited $ … $) → latex_block node
                      inline                       → latex node
                      zip-match against <math> elements in the page in order;
                      count mismatch = hard fail for that post
                 6. idempotent upsert:
                      match slug in GET /post_management/published + GET /drafts
                        found  → PUT /drafts/{id} (update body/title) → publish
                        absent → POST /drafts → PUT /drafts/{id} {slug} (force slug
                                 before first publish) → publish
                 7. publish: PUT /drafts/{id}/publish { send: false, share_automatically: false }
                 8. prepend origin line; append CC BY-NC-ND line
```

No local state file: CI cannot commit back, and deterministic slugs + API
listing give idempotency statelessly. A re-run can never duplicate a post.

## Content plumbing (the opt-out flag)

One flag, written once, in the post source:

1. `content/blog.typ` — `main.with(...)` gains an optional `substack:` param,
   carried into the emitted Astro frontmatter via the existing `#metadata` path.
2. `src/content.config.ts` — blog collection schema gains
   `substack: z.boolean().optional()`.
3. `src/pages/blog/[...slug].astro` — emits
   `<meta name="substack" content="false">` when the flag is set (absent = sync).
4. The sync script reads it from the built page — the script never parses
   `.typ` sources for the gate (it does for math spans, which is unavoidable).

`usage-guide.typ` gets `substack: false` in the same change.

## API client (raw fetch, ~150 lines)

Base: `https://<publication>.substack.com/api/v1`

| Op | Call |
|---|---|
| Preflight | `GET /user/profile/self` — 200 + expected publication present, else abort |
| Create draft | `POST /drafts` — `draft_title`, `draft_subtitle`, `draft_body` (stringified ProseMirror doc), `type: "newsletter"`, `draft_bylines` (ids from preflight) |
| Update draft | `PUT /drafts/{id}` — same shape (+ `slug` on first create) |
| Publish | `PUT /drafts/{id}/publish` — `{ send: false, share_automatically: false }` (ma2za uses POST on the same path; try PUT, fall back to POST) |
| Image upload | `POST /image` with JSON `{ "image": "data:<mime>;base64,…" }` (multipart 400s), returns `{ id, url, width, height, bytes }` → embed as `captionedImage`; confirm shape during the manual smoke |
| Listings | `GET /post_management/published`, `GET /drafts` — slug matching |

Auth: `Cookie: connect.sid=<secret>` (+ legacy `substack.sid` same value).
Browser-like `User-Agent` required (Substack 403s default Node UAs).

Secrets: `SUBSTACK_PUB` (publication subdomain), `SUBSTACK_COOKIE`.

Failure contract:

- `401/403` → job fails with `SUBSTACK_COOKIE expired — rotate the secret`
  (only the sync job goes red; the site deploy is untouched).
- Any per-post step failure → job fails, log names slug + step. Re-run is safe.
- `send: true` never appears in the Action, so a bug can never email
  subscribers.
- No deletion, ever. Flipping a post to `substack: false` leaves the published
  Substack post in place (log a warning; manual unpublish if desired).

## Math pipeline

- `typst2tex` from npm `tex2typst` (pure JS; verified 6/6 against every
  expression this repo actually uses — `dif`, `cal`, `bb`, attach/sub-sup,
  sums/integrals all exact).
- Span extraction walks the `.typ` source in order, skipping raw blocks and
  code fences (where `$E = m c^2$` appears as literal text).
- Display vs inline follows Typst's own rule: space after the opening `$` =
  block. Both mappings are implemented; display (`latex_block`) is the
  battle-tested path, inline (`latex`) nodes exist in the schema but are
  unsupported in Substack's editor UI — accepted residual risk, and the only
  inline user today (`usage-guide`) is opted out.
- The prose root the script transforms is the post container (`article .post`)
  in the built page, endnotes section included; page chrome (header, TOC rail,
  subscribe postscript, giscus, back-link) is everything outside it.

## Testing

1. `just substack -- --dry` — full transform + ProseMirror JSON printed, zero
   network. The primary local verification loop.
2. Unit snapshots: span extractor and typst2tex output for the six real
   expressions in `usage-guide.typ:57-76`.
3. One manual smoke publish to the real publication before enabling the CI job.
4. Site-side: the meta-tag gate is exercised by `just web` (schema validates
   the new frontmatter field); no other site behavior changes.

## Files touched

- `scripts/sync-substack.mjs` (new)
- `.github/workflows/deploy.yml` (new job)
- `justfile` (`substack` recipe)
- `content/blog.typ`, `src/content.config.ts`, `src/pages/blog/[...slug].astro` (flag plumbing)
- `content/blog/usage-guide.typ` (`substack: false`)
- `CLAUDE.md` (document the pipeline)

## Related fix — separate commit, independent of Substack

`content/blog.typ` imports only `lib.typ: *`, but the shadowing `cal`/`bb`/`dif`
definitions live in `prelude.typ` and are not re-exported. Posts therefore
resolve Typst 0.15 builtins, produce `math.styled` nodes, and the vendored
mathyml converter rejects them — the live `usage-guide` page ships 5 SVG
fallbacks today. Fix: also import `prelude.typ: *` (one line, verified). Do
this first, as its own commit, so the Substack work never contains an unrelated
site fix.

## Out of scope

Subscriber emails from CI (`send: true`), deletions/unpublish, tables
(Substack has none; the blog has none), per-topic targeting, other platforms,
Substack tags (no reliable draft-time tag API found; posts land untagged —
acceptable for v1).
