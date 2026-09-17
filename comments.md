> **COMPLETED 2026-09 — task finished.** Backend repo `AlanSynn/comments`
> created (Discussions-only, `giscus.json` origins = alansynn.com), `Comments`
> Announcement category + giscus App installed by owner, IDs wired into
> `src/lib/giscus.ts`. Site integration = `GiscusComments.astro` (lazy
> IntersectionObserver load, specific mapping `alansynn:blog:<post.id>`).
> Deviations: CSS lives in `src/styles/blog.css` (pre-existing `.comments`
> block there), Feedly-style note N/A.

# Task: Build a Shared GitHub Discussions Comment Backend and Integrate giscus into alansynn.com

## Objective

Implement a zero-cost, low-maintenance, performance-conscious comment system using:

* GitHub Discussions as persistent storage
* giscus as the embedding layer
* one reusable GitHub repository named `AlanSynn/comments`
* the existing Astro blog at `AlanSynn/alansynn.github.io`

The `comments` repository must be designed as a shared comment backend for multiple current and future websites.

Do not name the repository after the current blog or domain.

Do not create:

* `alansynn-comments`
* `blog-comments`
* `alansynn.github.io-comments`

The canonical shared repository is:

```text
AlanSynn/comments
```

The architecture is:

```text
Site A
Site B
alansynn.com
future sites
      │
      │ giscus
      ▼
AlanSynn/comments
      │
      ▼
GitHub Discussions
```

No database, Cloudflare Worker, server, paid service, API server, or custom moderation UI is needed.

---

# 1. Important architectural rule

Because the same comments repository will serve multiple websites:

**DO NOT use `pathname`, page URL, page title, or og:title as the global giscus mapping strategy.**

Different sites can have identical paths:

```text
site-a.example/blog/test
site-b.example/blog/test
```

and page titles are mutable.

Instead use giscus:

```text
mapping = specific
```

with a stable namespaced term:

```text
<site-key>:<content-kind>:<stable-content-id>
```

Examples:

```text
alansynn:blog:spatial-interfaces
research-tool:docs:getting-started
project-x:article:introduction
```

For the current website:

```text
site-key      = alansynn
content-kind  = blog
stable-id     = Astro post.id
```

Therefore:

```text
alansynn:blog:${post.id}
```

is the canonical giscus term.

Do not include the mutable post title in the term.

Do not include the domain name unless it is intentionally selected as the permanent site key.

The site key is an application namespace, not a hostname.

---

# 2. Read existing repository instructions first

Before changing `AlanSynn/alansynn.github.io`:

1. Read `AGENTS.md` / `CLAUDE.md`.
2. Inspect the current:

   * `src/pages/blog/[...slug].astro`
   * `src/layouts/Base.astro`
   * `src/components/ThemeToggle.astro`
   * `src/styles/components.css`
3. Understand the existing Astro ClientRouter / View Transition behavior.
4. Understand how `data-theme` is managed.
5. Understand the existing obfuscated `Reply by email` feature.
6. Confirm draft blog semantics.

Repository instructions override assumptions in this document if the repository has evolved materially.

Do not modify code before this inspection.

---

# 3. Verify local GitHub CLI authentication

Start with:

```bash
gh auth status
gh api user --jq '.login'
```

Expected authenticated owner:

```text
AlanSynn
```

If the authenticated account is not able to administer `AlanSynn` repositories, stop and report.

Do not create the repository under another account.

---

# 4. Check whether `AlanSynn/comments` already exists

Before creating anything:

```bash
gh repo view AlanSynn/comments
```

If it does not exist, continue with repository creation.

If it already exists:

1. inspect its README
2. inspect repository description
3. inspect Discussions
4. inspect existing files
5. determine whether it is already intended as a comments repository

If the existing repository is unrelated:

**STOP.**

Do not overwrite, delete, rename, repurpose, or empty an existing unrelated repository.

Report the conflict.

If it is clearly an earlier version of this same comment backend, reuse it and make changes idempotently.

---

# 5. Create the shared comments repository

If absent:

```bash
gh repo create AlanSynn/comments \
  --public \
  --description "Shared GitHub Discussions backend for comments across Alan Synn sites." \
  --add-readme
```

Requirements:

```text
owner       AlanSynn
name        comments
visibility  public
```

Public visibility is required for normal giscus use.

Do not create a private repository.

---

# 6. Keep the repository focused

Enable Discussions.

Using `gh`:

```bash
gh api \
  --method PATCH \
  repos/AlanSynn/comments \
  -F has_discussions=true
```

It is desirable for this repository to be focused on Discussions rather than software issue tracking.

If safe on the newly created repository, disable unnecessary features:

```bash
gh api \
  --method PATCH \
  repos/AlanSynn/comments \
  -F has_issues=false \
  -F has_wiki=false \
  -F has_projects=false \
  -F has_discussions=true
```

Do this only for the newly created dedicated `comments` repository.

Do not apply these settings to an unrelated preexisting repository.

Add useful repository topics if supported:

```bash
gh repo edit AlanSynn/comments \
  --add-topic giscus \
  --add-topic comments
```

---

# 7. Configure the repository contents

Clone the comments repository into a temporary working directory:

```bash
TMP_DIR="$(mktemp -d)"
cd "$TMP_DIR"
gh repo clone AlanSynn/comments
cd comments
```

Replace the default README with a concise operational README.

Use approximately this content:

```markdown
# comments

Shared GitHub Discussions backend for comments across Alan Synn websites.

Comments are rendered with giscus and stored as GitHub Discussions.

## Mapping contract

Every embedding site must use:

mapping = specific

with the term:

<site-key>:<content-kind>:<stable-content-id>

Examples:

- alansynn:blog:example-post
- project-x:docs:introduction

Do not use pathname as the shared-repository mapping strategy because
different sites may have identical paths.

## Origins

Allowed embedding origins are explicitly listed in `giscus.json`.

When adding a new website:

1. Add its exact canonical origin to `giscus.json`.
2. Choose a unique permanent site key.
3. Use the shared `Comments` Discussion category.
4. Use `specific` mapping.
5. Never reuse another site's mapping namespace.

Avoid wildcard origin rules unless there is a concrete requirement.

## Moderation

All comments are stored in GitHub Discussions.

Moderate comments directly through GitHub.

This repository contains no application backend and no user database.
```

Do not add a software license merely because most code repositories have one.

This repository is primarily configuration and user discussion data.

---

# 8. Add giscus origin restrictions

Create:

```text
giscus.json
```

at the root of `AlanSynn/comments`.

Initial content:

```json
{
  "origins": [
    "https://alansynn.com"
  ],
  "defaultCommentOrder": "oldest"
}
```

Important:

* use exact origins
* do not use a broad regex
* do not allow arbitrary origins
* do not add `*`
* do not add every GitHub Pages domain
* do not add localhost
* do not add staging domains unless explicitly requested

Future sites should be added by appending an exact origin.

Example future shape:

```json
{
  "origins": [
    "https://alansynn.com",
    "https://some-future-site.example"
  ],
  "defaultCommentOrder": "oldest"
}
```

Do not introduce `originsRegex` unless an actual use case requires it.

---

# 9. Commit repository configuration

Commit:

```bash
git add README.md giscus.json
git commit -m "Initialize shared giscus comments backend"
git push
```

Verify:

```bash
gh repo view AlanSynn/comments
```

and inspect the root files.

---

# 10. Create a dedicated Discussion category

The desired category is:

```text
Name: Comments
Emoji: 💬
Description: Comments created by giscus for Alan Synn websites.
Format: Announcement
```

The **Announcement** format is intentional.

It prevents ordinary visitors from creating arbitrary top-level Discussions while still allowing replies/comments.

giscus itself and repository maintainers should be able to create the Discussion threads.

Do not use Q&A format.

Do not use Poll format.

Do not make the category answerable.

## Category creation method

Use GitHub automation/browser tooling if available.

Prefer the GitHub UI for this specific step because the Announcement format must be configured correctly and API support for category formats may differ.

If browser automation is available:

1. open `AlanSynn/comments`
2. open Discussions
3. manage Discussion categories
4. create `Comments`
5. select Announcement format
6. use the description above
7. save

If the category already exists:

* verify its name
* verify its type
* reuse it

Do not create a duplicate `Comments` category.

## If browser interaction is unavailable

Do not silently substitute an open-ended category.

Pause at this exact step and give the human these instructions:

```text
Open AlanSynn/comments → Discussions → manage categories → New category.

Name: Comments
Format: Announcement
Emoji: 💬
Description: Comments created by giscus for Alan Synn websites.
```

After the human completes it, continue automatically.

---

# 11. Install the official giscus GitHub App

The official giscus GitHub App must be installed on:

```text
AlanSynn/comments
```

and not on the website repository unless independently necessary.

Use browser automation if available.

During installation:

```text
Account:
AlanSynn

Repository access:
Only select repositories

Selected repository:
comments
```

Do not select:

```text
All repositories
```

unless the user has explicitly chosen that broader permission model.

Do not grant giscus access to private repositories merely for convenience.

Review the requested permissions before installation.

The important repository capability is access to Discussions.

## Existing giscus installation

If giscus is already installed:

1. inspect its repository access
2. verify `AlanSynn/comments` is included
3. do not revoke unrelated existing permissions automatically
4. if the existing install has broader access than expected, report it rather than destructively changing it without approval

## If browser interaction is unavailable

Pause only for this authorization step.

Ask the human to:

```text
Install the official giscus GitHub App on AlanSynn.

Choose "Only select repositories".

Select only "comments".
```

Then continue after the installation exists.

This is an interactive GitHub authorization step and must not be faked.

---

# 12. Verify giscus repository readiness

The comments repository is ready only if:

```text
public                    yes
Discussions enabled       yes
Comments category         yes
Comments format           Announcement
giscus App installed      yes
giscus.json present       yes
origin alansynn.com       yes
```

Use the official giscus configurator or repository validation mechanism to confirm the repository is recognized.

Do not start site integration if giscus reports the repository as unavailable.

---

# 13. Obtain stable giscus IDs with GitHub CLI

Retrieve repository GraphQL ID:

```bash
REPO_ID="$(
  gh api graphql \
    -f owner='AlanSynn' \
    -f name='comments' \
    -f query='
      query($owner: String!, $name: String!) {
        repository(owner: $owner, name: $name) {
          id
        }
      }
    ' \
    --jq '.data.repository.id'
)"
```

Verify it is non-empty:

```bash
test -n "$REPO_ID"
printf '%s\n' "$REPO_ID"
```

Retrieve categories:

```bash
gh api graphql \
  -f owner='AlanSynn' \
  -f name='comments' \
  -f query='
    query($owner: String!, $name: String!) {
      repository(owner: $owner, name: $name) {
        discussionCategories(first: 25) {
          nodes {
            id
            name
            slug
            isAnswerable
          }
        }
      }
    }
  '
```

Extract the `Comments` category ID:

```bash
CATEGORY_ID="$(
  gh api graphql \
    -f owner='AlanSynn' \
    -f name='comments' \
    -f query='
      query($owner: String!, $name: String!) {
        repository(owner: $owner, name: $name) {
          discussionCategories(first: 25) {
            nodes {
              id
              name
            }
          }
        }
      }
    ' \
    --jq '.data.repository.discussionCategories.nodes[] | select(.name == "Comments") | .id'
)"
```

Verify:

```bash
test -n "$CATEGORY_ID"
printf '%s\n' "$CATEGORY_ID"
```

Record both values for the website integration.

These IDs are public configuration values.

They are not secrets.

Do not store them in environment secrets.

---

# 14. Do not pre-create Discussion threads

Do not create one Discussion per existing blog post.

giscus should create a Discussion only when someone actually leaves the first comment.

This avoids:

* empty Discussion clutter
* mass creation of unused threads
* unnecessary GitHub activity
* maintenance work for posts nobody comments on

Loading a blog post must not itself create a Discussion.

Do not create test comments against production unless explicitly authorized.

---

# 15. Shared mapping contract

The shared comments repository must use this convention permanently:

```text
<site-key>:<content-kind>:<stable-content-id>
```

Current site:

```text
alansynn:blog:${post.id}
```

Examples:

```text
alansynn:blog:hello-world
alansynn:blog:spatial-computing-notes
```

A future site might use:

```text
motionsmith:docs:installation
lab-site:article:project-overview
```

This is how multiple websites safely share one Discussions repository.

---

# 16. Important slug rule

For the current site, `post.id` is used as the stable content ID.

Therefore changing a blog post slug changes the giscus term.

That can orphan the previous comment thread from the new page.

Document this rule in `CLAUDE.md`:

```text
A published blog slug is part of the giscus comment identity.

Do not rename a published blog slug without explicitly migrating or preserving
its existing giscus Discussion mapping.
```

Do not introduce a new blog frontmatter field solely for comments in this task.

Do not modify the Typst blog schema.

Use the existing `post.id`.

---

# 17. Website integration design

Repository:

```text
AlanSynn/alansynn.github.io
```

Create a reusable component:

```text
src/components/GiscusComments.astro
```

Do not place all giscus logic inline inside `[...slug].astro`.

The reusable component exists because the `comments` backend is intended for use across future parts of the site.

The component should accept at least:

```ts
interface Props {
  term: string;
}
```

Do not pass mutable titles as identity.

---

# 18. Centralize public giscus configuration

Create a small configuration module if useful, for example:

```text
src/lib/giscus.ts
```

It should contain only public configuration.

Conceptual fields:

```ts
export const giscus = {
  repo: 'AlanSynn/comments',
  repoId: '<REPO_ID>',
  category: 'Comments',
  categoryId: '<CATEGORY_ID>',
  siteKey: 'alansynn',
} as const;
```

Use the actual IDs retrieved from GitHub.

Do not guess IDs.

Do not use placeholders in committed production code.

Do not create environment variables for these values.

There are no secrets.

---

# 19. Only published posts get comments

Current draft posts can still be reachable at their production URL.

Do not load giscus on draft posts.

In:

```text
src/pages/blog/[...slug].astro
```

render the comments component only when:

```text
!post.data.draft
```

Conceptually:

```astro
{
  !post.data.draft && (
    <GiscusComments term={`alansynn:blog:${post.id}`} />
  )
}
```

Do not create GitHub Discussions for drafts.

---

# 20. Placement on the post page

Current article flow includes:

```text
post content
All posts
Reply by email
license
```

Integrate comments near the end of the post without changing the article content itself.

Recommended order:

```text
post content
All posts
Discussion
giscus
Reply by email
license
```

If preserving current DOM ordering more closely is materially simpler, this is also acceptable:

```text
post content
All posts
Reply by email
Discussion
giscus
license
```

The important requirement is:

* comments are after the article
* the existing `Reply by email` fallback remains
* license remains visible
* comments do not interrupt article prose

Use a restrained heading such as:

```text
Discussion
```

Avoid:

```text
Join the conversation!!!
```

---

# 21. Performance requirement: do not load giscus on initial page load

Do not place the standard giscus script directly into the initial document.

Instead:

1. render a local comments placeholder
2. create an `IntersectionObserver`
3. wait until the comments section is near the viewport
4. only then inject the giscus client script

Before the comments region approaches the viewport there should be:

```text
zero requests to the giscus client
zero giscus iframe requests
zero GitHub comment API traffic caused by giscus
```

This is a core requirement.

The comment system must have negligible impact on initial article rendering.

---

# 22. IntersectionObserver behavior

Recommended:

```text
rootMargin: 600px 0px
threshold: 0
```

Loading a little before the user reaches the comments is desirable so the UI appears naturally.

When the observer triggers:

1. disconnect it
2. mark the section as loading/loaded
3. inject giscus exactly once

Use a per-element guard such as:

```text
data-giscus-loaded
```

or equivalent.

Do not inject multiple scripts.

---

# 23. Use giscus lazy iframe loading too

In addition to the outer IntersectionObserver, configure giscus itself for lazy iframe loading.

This is intentional defense in depth.

Outer lazy loading:

```text
prevents loading client.js until needed
```

giscus lazy loading:

```text
allows iframe lazy behavior as supported by giscus
```

Do not remove the outer lazy loader just because giscus has its own lazy mode.

---

# 24. giscus configuration

When injecting the official giscus client script, configure:

```text
repo                 AlanSynn/comments
repoId               actual repository GraphQL ID

category             Comments
categoryId           actual Comments category GraphQL ID

mapping              specific
term                 component `term` prop

strict               1

reactionsEnabled     0
emitMetadata         0

inputPosition        top
lang                 en

loading              lazy
```

Why reactions are disabled:

* comments are the feature being added
* reactions add UI noise
* reactions can create otherwise-empty Discussion threads
* the desired design is minimal

Do not enable discussion metadata emission.

Do not use `pathname`.

Do not use `url`.

Do not use page title.

---

# 25. Strict mapping

Enable strict matching.

The shared repository will contain discussions from multiple websites, so fuzzy matching is undesirable.

Use:

```text
strict = 1
```

Do not weaken this without a demonstrated compatibility problem.

---

# 26. Production-only third-party loading

Do not load giscus during local development.

The component may render its local structural placeholder, but the actual giscus script should load only on the canonical production origin.

Use the trusted site configuration already available in the repository.

Conceptually:

```js
if (window.location.origin !== productionOrigin) {
  return;
}
```

This prevents:

* accidental real Discussions during development
* test data pollution
* giscus requests during normal local development

Do not add localhost to `giscus.json`.

---

# 27. Astro View Transition compatibility

The site uses Astro ClientRouter / View Transitions.

A naive one-time giscus script is not acceptable.

The comments initializer must be safe for:

```text
post A
→ homepage
→ post A

post A
→ post B

post B
→ blog index
→ post C
```

The script that initializes observers must follow the repository's existing View Transition convention.

Use:

```astro
<script is:inline data-astro-rerun>
```

where appropriate.

On every execution:

1. disconnect any previous comments IntersectionObserver
2. discover the current comments section
3. create a fresh observer for that section
4. do not carry the previous page's identity into the new page

A global cleanup handle is acceptable:

```js
window.__giscusIntersectionObserver
```

Before assigning a new observer:

```js
window.__giscusIntersectionObserver?.disconnect();
```

Do not allow old page observers to load giscus after navigation.

---

# 28. Prevent duplicate initialization

Use both:

```text
global old-observer cleanup
```

and:

```text
current-element loaded/bound guard
```

The script must be idempotent.

Re-executing it for the same DOM must not produce:

```text
two IntersectionObservers
two giscus scripts
two iframes
two Discussion panes
```

---

# 29. Theme integration

The site already stores its theme on:

```text
<html data-theme="light">
```

or:

```text
<html data-theme="dark">
```

Do not use system `prefers-color-scheme` as the authoritative theme.

The site's explicit `data-theme` value is authoritative.

Initial giscus theme should map:

```text
site light → giscus light
site dark  → giscus dark
```

Do not require a reload after theme changes.

---

# 30. Theme synchronization after giscus loads

giscus supports runtime configuration through `postMessage`.

Implement one global theme observer.

Use a `MutationObserver` watching:

```text
document.documentElement
```

attribute:

```text
data-theme
```

Guard it globally, for example:

```text
window.__giscusThemeObserverBound
```

There should be exactly one theme observer for the whole document lifecycle.

When the theme changes:

1. find the current `.giscus-frame`
2. if no iframe exists, do nothing
3. derive the giscus origin from the iframe or official script origin
4. send `setConfig.theme` through `postMessage`

Do not send `postMessage` to `"*"`.

Use the exact giscus origin.

Do not modify the existing `ThemeToggle.astro` merely to support comments unless absolutely necessary.

The comments component should observe the existing theme mechanism rather than coupling the theme toggle to giscus.

---

# 31. Avoid custom giscus CSS in v1

Do not create a custom hosted giscus theme for this task.

Use built-in light/dark themes.

Style only the outer site container.

Reason:

* no additional hosted stylesheet
* less maintenance
* fewer third-party styling assumptions
* easier giscus upgrades

If built-in themes are clearly unusable after visual verification, report that separately.

Do not silently expand scope.

---

# 32. Outer comments styling

Add minimal site CSS using existing variables.

Example conceptual classes:

```text
.comments
.comments__heading
.comments__mount
.comments__fallback
```

Do not style internal iframe content from the parent page.

Keep:

```text
width: 100%
```

Avoid fixed heights.

Do not introduce a card with a large border/shadow unless consistent with the current site.

Comments should feel like another quiet article section.

---

# 33. No layout shift

Reserve only normal section spacing.

Do not reserve a giant fixed comment area before giscus loads.

When the iframe appears it may increase page height, which is acceptable because it is below the article and close to the user's scroll position.

Do not add fixed-height skeletons.

Do not introduce a layout shift above the current viewport.

---

# 34. Existing Reply by email is mandatory fallback

Preserve the current obfuscated email reply feature.

Do not replace it with giscus.

Do not expose the raw email address in served HTML.

Do not change the anti-crawler email invariant.

The two mechanisms serve different users:

```text
GitHub user     → comments
non-GitHub user → reply by email
```

This fallback is important.

---

# 35. JavaScript-disabled behavior

If JavaScript is disabled:

* article must render normally
* Reply by email must behave according to its existing constraints
* no broken empty iframe should appear
* page should remain readable

A small static message is optional:

```text
Comments require JavaScript and a GitHub account.
```

Do not create a large warning.

---

# 36. giscus failure behavior

If giscus is unavailable:

* article remains readable
* navigation remains functional
* Reply by email remains visible
* no uncaught exception should break site JS
* no repeated aggressive retries

Comment failure is non-critical.

Fail quietly.

---

# 37. Security and privacy constraints

Do not add:

* analytics
* open tracking
* custom user database
* custom OAuth
* GitHub personal access token in frontend
* GitHub token in build output
* server-side credential
* comments API proxy

The frontend requires no GitHub secret.

Repository ID and category ID are public.

The giscus App handles GitHub authorization.

---

# 38. Update repository documentation

Update the Blog section in:

```text
CLAUDE.md
```

Because `AGENTS.md` points agents to the same source-of-truth instructions.

Document concisely:

```text
Published blog posts render a lazily loaded giscus Discussion section.

Backend repository:
AlanSynn/comments

Shared mapping convention:
<site-key>:<content-kind>:<stable-id>

Current mapping:
alansynn:blog:<post.id>

Draft posts do not load comments.

The comments backend is shared by multiple sites, so pathname mapping must not
be used.

Allowed embedding origins are controlled by the comments repository's
giscus.json.

A published blog slug is part of the comment identity. Do not rename a
published slug without explicitly handling the existing giscus Discussion
mapping.
```

Do not add several pages of giscus documentation to `CLAUDE.md`.

Keep it operational and concise.

---

# 39. Do not modify blog content

Do not edit:

```text
content/blog/*.typ
content/blog.typ
```

Do not add a `comments:` property to blog posts.

Do not rebuild or modify PDFs for this comments feature unless repository checks independently require it.

Comments are presentation/infrastructure, not post content.

---

# 40. Expected website files

Likely changes:

```text
src/components/GiscusComments.astro
src/lib/giscus.ts
src/pages/blog/[...slug].astro
src/styles/components.css
CLAUDE.md
```

Do not spread giscus constants across several files.

Do not add npm packages.

Do not install:

```text
@giscus/react
giscus-component
```

The existing site does not need a framework wrapper.

Use the official lightweight client script loaded on demand.

---

# 41. Build validation

Run repository-prescribed checks.

At minimum:

```bash
bun run check
just web
```

If `components.css` changed, also run any existing isolation/regression tests relevant to global CSS.

Do not bypass the pre-commit hooks simply because the change is small.

---

# 42. Static verification

Verify built post HTML contains:

```text
comments section
giscus public configuration
specific mapping term
```

but does **not** contain:

```text
GitHub secret
PAT
OAuth secret
raw personal email
pre-created discussion number
```

Verify drafts do not include the comments component.

---

# 43. Performance verification

Use browser automation or Playwright.

On a published blog post:

## Before scrolling near comments

Verify:

```text
no giscus iframe exists
no giscus client has been requested
article is fully usable
```

The exact third-party domain should be determined from the current official giscus client source.

Do not hard-code a test based on an obsolete endpoint.

## Scroll close to comments

Verify:

```text
giscus client loads
exactly one iframe appears
comment UI becomes visible
```

## Scroll away/back

Verify:

```text
no duplicate iframe
no duplicate script
```

---

# 44. Multi-page View Transition verification

Test:

```text
post A → post B
```

without full page reload.

Verify the loaded Discussion identity changes from:

```text
alansynn:blog:<post-A-id>
```

to:

```text
alansynn:blog:<post-B-id>
```

There must not be a stale post A comment thread on post B.

Then test:

```text
post B → home → post A
```

Verify comments initialize correctly again.

---

# 45. Theme verification

On a loaded comments section:

1. start light
2. toggle dark
3. verify giscus changes to dark without reload
4. toggle light
5. verify giscus changes back

Then:

```text
dark mode
→ navigate to another post
→ scroll to comments
```

The newly loaded giscus instance must start dark.

Do not depend only on system color scheme.

---

# 46. Mobile verification

At a narrow viewport verify:

* iframe does not overflow
* discussion area
