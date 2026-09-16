# Task: Add Email Subscription to the Blog Using Hosted Simple Newsletter

Repository:

`AlanSynn/alansynn.github.io`

## Objective

Add a minimal, native-looking email subscription form to `/blog` using the hosted **Simple Newsletter** RSS-to-email service.

The existing site remains the canonical blog.

The existing RSS implementation remains the canonical content source.

Do not build or deploy any backend, Cloudflare Worker, database, queue, serverless function, proxy, newsletter platform, or custom email infrastructure.

The desired architecture is only:

```text
content/blog/*.typ
        ↓
existing Astro RSS generation
        ↓
/rss.xml
        ↓
Simple Newsletter hosted service
        ↓
subscriber email
```

The website integration should be only:

```text
/blog
  ↓
native HTML subscription form
  ↓
Simple Newsletter hosted subscription endpoint
```

This is intentionally a very small integration.

---

# 1. Read repository instructions first

Before editing anything:

1. Read `AGENTS.md` / `CLAUDE.md` completely enough to understand the repository conventions relevant to this task.
2. Inspect the current versions of:

   * `src/pages/blog.astro`
   * `src/styles/components.css`
   * `src/lib/feed.ts`
   * `src/layouts/Base.astro`
3. Inspect the existing blog subscription strip and its View Transition scripts.
4. Verify the current official Simple Newsletter publisher integration documentation before implementing.

Do not rely on an old remembered version of the Simple Newsletter API.

The repository instructions are authoritative for site conventions.

---

# 2. Existing behavior that must remain intact

The blog already has:

* canonical `/rss.xml`
* `/blog/rss.xml` alias
* per-topic RSS feeds
* RSS link
* copy-feed button
* Feedly link
* tag filtering
* active-tag-aware RSS/Feedly behavior
* Astro View Transitions
* `data-astro-rerun` behavior for blog scripts

Do not replace or remove any of these.

The existing RSS subscription controls must continue behaving exactly as they do before this task.

In particular, the active tag currently changes RSS/copy/Feedly to the corresponding topic feed.

Preserve these existing DOM hooks unless there is an unavoidable reason not to:

```text
#blog-subscribe
#sub-rss
#sub-feedly
.blog-subscribe__copy
data-site-url
data-feed-url
```

Prefer leaving the existing RSS block structurally unchanged.

---

# 3. Important product decision

Email subscription is **site-wide only** in v1.

It always subscribes to:

```text
https://alansynn.com/rss.xml
```

Do not make the email subscription follow the currently selected tag.

Do not offer topic-specific email subscriptions.

The existing RSS/Feedly controls may continue following the selected tag.

This distinction is intentional.

---

# 4. Scope

Expected files to modify:

```text
src/pages/blog.astro
src/styles/components.css
```

Only add another file if it materially improves clarity.

Do not modify:

```text
content/*
src/lib/feed.ts
src/pages/rss.xml.ts
src/pages/blog/rss.xml.ts
src/pages/blog/rss/*
src/content.config.ts
astro.config.mjs
Base.astro
package.json
bun.lock
PDF code
project pages
```

Do not add dependencies.

Do not modify generated files.

---

# 5. Do not overengineer this

Explicitly forbidden for this task:

* Cloudflare Worker
* D1
* KV
* Queue
* Turnstile
* API key
* server-side proxy
* server-side form handler
* custom subscriber database
* custom confirmation system
* custom unsubscribe system
* custom RSS poller
* custom mail sender
* GitHub Action for email sending
* JavaScript SDK
* iframe
* newsletter popup
* modal
* third-party script
* client-side AJAX request to Simple Newsletter
* custom retry logic
* custom anti-spam infrastructure

Simple Newsletter already handles:

```text
subscription storage
double opt-in
RSS polling
email delivery
daily digest generation
unsubscribe
```

Use it as designed.

---

# 6. Verify the provider contract before coding

At implementation time, inspect the current official Simple Newsletter publisher documentation and its source/OpenAPI specification.

As of this task specification, the relevant production API is:

```text
host: simple-newsletter.com
path: /v1/subscriptions/
```

Current documented behavior:

```text
GET/POST /v1/subscriptions/
```

with query parameters:

```text
uri       required feed URL
email     required subscriber email
return    optional return URL
redirect  optional boolean
```

Redirect mode currently redirects to `return` and appends:

```text
title
message
ok
```

Current hosted implementation reads these subscription fields from the query string.

Therefore the integration should use a **native GET form**, matching the hosted service's official publisher integration.

Do not change it to a POST body merely because POST would normally be preferable.

If the current official service contract has changed by implementation time, follow the current documented contract and record that deviation in the final report.

If the service no longer provides the free hosted integration described here, stop and report instead of inventing replacement infrastructure.

---

# 7. Form behavior

Create a separate email subscription element immediately adjacent to the existing RSS subscribe strip.

Prefer this structure conceptually:

```text
Get new posts by email

[ Email address                      ] [ Subscribe ]

New posts are delivered by email. Unsubscribe anytime.

Subscribe:
RSS · copy · Feedly
```

The visual treatment should remain restrained and consistent with the rest of the site.

Do not create a card-like marketing component.

Do not add a large heading.

Do not create a CTA banner.

Do not create excessive vertical space.

This should read as a small utility attached to the blog index.

---

# 8. Form fields

Use native HTML.

Conceptually:

```html
<form>
  <input type="hidden" name="uri" ... />
  <input type="hidden" name="return" ... />
  <input type="hidden" name="redirect" value="true" />

  <label ...>Email address</label>
  <input
    type="email"
    name="email"
    autocomplete="email"
    maxlength="254"
    required
  />

  <button type="submit">Subscribe</button>
</form>
```

The actual `action` must be the current official Simple Newsletter hosted subscription endpoint verified from its documentation.

Set:

```text
uri = absolute canonical site-wide feed URL
```

which must resolve to:

```text
site.url + /rss.xml
```

Use the existing `feedUrl` value where appropriate rather than creating another independent feed URL constant.

Set:

```text
return = absolute /blog URL
redirect = true
```

The return URL must be a clean `/blog` URL with no existing query string.

Do not include `?tag=...`.

Do not send any field other than those supported by the service.

---

# 9. No JavaScript is needed to submit

The browser should submit the native HTML form directly to Simple Newsletter.

Do not intercept the submit event.

Do not use `fetch()`.

Do not use XHR.

Do not add CORS logic.

Do not disable native HTML validation.

Do not send any network request to Simple Newsletter merely by loading `/blog`.

There must be **zero Simple Newsletter network traffic until the user explicitly submits the email form.**

---

# 10. Redirect result handling

Simple Newsletter currently redirects back with query parameters resembling:

```text
?title=...&message=...&ok=1
```

or:

```text
?title=...&message=...&ok=0
```

Do not render provider-supplied `title` or `message` into the DOM.

Do not use:

```text
innerHTML
```

with redirect parameters.

Do not display the submitted email address.

Only inspect the `ok` parameter.

Behavior:

```text
ok=1
→ show:
"Check your inbox to confirm your subscription."

ok=0
→ show:
"Could not start the email subscription. Please try again, or use RSS."

no ok parameter
→ show nothing
```

The visible strings above are controlled locally.

Provider response text is untrusted input.

---

# 11. Clean the redirect URL

After reading the provider redirect state, remove these parameters from the address bar:

```text
title
message
ok
```

Use `history.replaceState`.

Preserve unrelated parameters if any exist.

For example, do not blindly replace the complete URL with `/blog` if doing so would unnecessarily destroy another legitimate query parameter.

Do not reload the page.

The status message may remain visible in the current DOM after the query parameters are removed.

---

# 12. View Transition compatibility

The site uses Astro View Transitions.

Any new inline script added to `/blog` must follow the repository's established pattern:

```html
<script is:inline data-astro-rerun>
```

The script must be idempotent.

If it binds any event listeners, guard against duplicate binding using a data attribute.

Prefer avoiding new event listeners entirely for the result message if possible.

The redirect-state script should safely execute:

* on normal full page load
* after returning to `/blog`
* after navigating away and back with View Transitions

Do not break the existing tag-filter or RSS-copy scripts.

---

# 13. Status element

Add a dedicated status element such as:

```text
#blog-email-subscribe-status
```

Requirements:

```text
aria-live="polite"
role="status"
```

It should be hidden when empty.

Success and failure must not be communicated solely by color.

Keep styling subtle.

Do not use alert popups.

---

# 14. Accessibility

The email input must have a real `<label>`.

A visually hidden label is acceptable only if the repository already has an established visually-hidden utility or if adding one is clearly necessary.

Do not use placeholder text as the only accessible label.

Required input attributes:

```text
type="email"
name="email"
autocomplete="email"
maxlength="254"
required
```

The submit control must be a real button.

Keyboard behavior must remain native.

---

# 15. Visual design

Match the current site's existing design system.

Reuse:

* typography tokens
* border colors
* accent color
* spacing conventions
* focus treatment
* dark-mode variables

Do not hard-code a new palette.

The component should look like it was part of the site before this integration existed.

Target visual character:

```text
small
quiet
editorial
functional
no SaaS-widget appearance
```

The input should not look like a generic Bootstrap or newsletter template.

The button should be visually clear but not oversized.

Avoid rounded "pill" SaaS styling unless an existing site component already establishes it.

---

# 16. Responsive behavior

At desktop width:

```text
email input + subscribe button
```

may remain on one row if there is sufficient space.

At narrow/mobile widths:

```text
input
button
```

may wrap or stack.

Do not reduce text below existing site typography scales to force a single line.

Do not allow horizontal overflow.

Measure the result rather than eyeballing it.

---

# 17. Existing RSS strip

Keep the existing RSS strip.

Do not replace:

```text
Subscribe:
RSS
copy
Feedly
```

with email-only subscription.

The desired hierarchy is:

```text
Email convenience layer
+
existing open RSS subscription
```

RSS remains important because it is provider-independent.

---

# 18. Provider branding

Do not add:

```text
Powered by Simple Newsletter
```

or a provider logo unless the current provider Terms explicitly require attribution.

Do not hide attribution if the current Terms require it.

Before finalizing, briefly verify the current provider Terms or publisher integration requirements for mandatory attribution.

If mandatory attribution exists, implement it minimally and report it.

If it does not, keep the component visually native to alansynn.com.

---

# 19. Privacy wording

Do not invent privacy guarantees on behalf of the provider.

Avoid unsupported claims such as:

```text
"We never store your email."
"We will never share your email."
```

The service necessarily stores subscription information.

A safe local line is:

```text
New posts by email. Unsubscribe anytime.
```

If provider disclosure is required by its current Terms, add the minimum accurate disclosure.

---

# 20. Error behavior

If the hosted provider is unavailable, the failure should affect only the email subscription action.

The rest of `/blog` must remain fully functional.

In particular:

```text
blog list works
tag filters work
RSS works
copy works
Feedly works
topic feeds work
```

Do not add runtime code that can throw during normal blog-page rendering because a third-party service is down.

There should be no provider availability check on page load.

---

# 21. Security constraints

Treat all redirect query parameters as untrusted.

Never place provider query values into:

```text
innerHTML
set:html
style
href
src
```

Do not create redirects from provider-returned values.

Use only:

```text
ok === "1"
ok === "0"
```

to choose between locally defined messages.

The return URL itself is hard-coded/generated from the trusted site origin.

---

# 22. No content changes

Do not modify any blog post.

Do not modify `content/blog/*.typ`.

Do not add subscription information to post content.

Do not alter RSS item structure.

Do not add newsletter-specific fields to blog frontmatter.

Simple Newsletter consumes the existing feed as-is.

---

# 23. No feed changes

The existing RSS implementation is already sufficient.

Do not modify:

```text
src/lib/feed.ts
```

for this feature.

Do not add tracking query parameters to RSS links.

Do not create a special newsletter RSS feed.

Do not duplicate feed generation.

Canonical email source remains:

```text
/rss.xml
```

---

# 24. Testing requirements

Do not create a real external subscription automatically during tests.

Automated tests/builds must not send email addresses to Simple Newsletter.

Verify statically and through local browser behavior where possible.

Required checks:

```text
bun run check
just web
```

Also run any repository-prescribed checks relevant to web changes.

Inspect the built `/blog` output and verify:

```text
form exists
email input exists
canonical RSS URI is used
return target is /blog
redirect mode is enabled
existing RSS controls still exist
no API key exists
no third-party script exists
no iframe exists
```

---

# 25. Browser verification

Test at minimum:

### Desktop

Verify:

```text
layout
focus state
input width
button width
status message
RSS strip
tag chips
```

### Mobile

Verify:

```text
no overflow
comfortable tap target
input/button wrapping
status wrapping
```

### Dark mode

Verify input:

```text
background
border
text
placeholder
focus
button
```

all remain readable.

### View Transitions

Navigate:

```text
/blog
→ another site page
→ /blog
```

Verify:

```text
tag filtering works
RSS/copy/Feedly behavior works
subscription result script does not double-bind
```

---

# 26. Verify active tag behavior

This is an explicit regression test.

Before changes:

```text
select #some-tag
→ RSS URL becomes /blog/rss/some-tag.xml
→ copy uses that URL
→ Feedly uses that URL
```

After changes the same must remain true.

Email subscription must still submit:

```text
/rss.xml
```

not the tag feed.

This distinction must be tested explicitly.

---

# 27. No-JavaScript behavior

With JavaScript disabled:

* the native form must still submit
* Simple Newsletter must still be able to process the subscription
* RSS links must still work
* the blog must still work

It is acceptable if the polished inline return-status message requires JavaScript.

The subscription operation itself must not require JavaScript.

---

# 28. External end-to-end test

Do not use Alan's real email automatically.

If and only if the operator explicitly provides or authorizes a test inbox:

1. submit one subscription
2. confirm that the hosted service sends a double-opt-in message
3. do not confirm a permanent subscription unless authorized
4. verify unsubscribe behavior if an isolated test inbox is available

If no test inbox is authorized, stop at static/browser verification and clearly state that actual mail delivery was not exercised.

Never fabricate a successful email-delivery test.

---

# 29. Code quality

Keep implementation small.

A good implementation should require roughly:

```text
one small HTML form
one status element
one small redirect-result script
focused CSS
```

If the change starts requiring hundreds of lines of application logic, reconsider the approach.

Do not introduce abstractions for hypothetical future newsletter providers.

Migration from Simple Newsletter later is expected to be cheap because RSS remains canonical and the form action can be replaced.

---

# 30. Comments

Add comments only where the reason is non-obvious.

Useful comments:

```text
why email always uses canonical /rss.xml
why redirect response values are not rendered
why data-astro-rerun is required
```

Do not add large architectural essays to production source files.

---

# 31. Expected final UI

The exact typography should follow the site, but the information architecture should approximately be:

```text
Get new posts by email

[ email@example.com                  ]  Subscribe

New posts by email. Unsubscribe anytime.

Subscribe: RSS · copy · Feedly
```

Do not use the phrase:

```text
Join my newsletter
```

This is an RSS-to-email convenience feature, not a separate editorial newsletter product.

Prefer:

```text
Get new posts by email
```

or similarly restrained wording.

---

# 32. Acceptance criteria

The task is done only when all are true:

```text
[ ] /blog has a native-looking email subscription form

[ ] form subscribes to the canonical /rss.xml only

[ ] form uses the current official Simple Newsletter hosted endpoint

[ ] form follows the provider's current documented query-parameter contract

[ ] redirect mode returns the user to /blog

[ ] ok=1 produces a local "check your inbox" message

[ ] ok=0 produces a local generic failure message

[ ] provider title/message are never injected into the DOM

[ ] provider redirect query parameters are cleaned from the address bar

[ ] no JavaScript is required to submit the form

[ ] no third-party request occurs on page load

[ ] no iframe is added

[ ] no third-party JS is added

[ ] no dependency is added

[ ] no backend is added

[ ] no Cloudflare Worker is added

[ ] no API key or secret exists

[ ] existing RSS link still works

[ ] existing RSS copy still works

[ ] existing Feedly link still works

[ ] active-tag RSS behavior still works

[ ] tag filtering still works

[ ] email subscription does NOT follow the active tag

[ ] View Transition navigation still works

[ ] light mode is correct

[ ] dark mode is correct

[ ] mobile layout is correct

[ ] accessibility basics are satisfied

[ ] bun run check passes

[ ] just web passes
```

---

# 33. Stop conditions

Stop and report before implementing an alternative if any of these are discovered:

```text
Simple Newsletter hosted service is no longer free

publisher integration has been removed

provider now requires an account/API key

provider now requires JavaScript or an iframe

provider Terms prohibit this integration

provider requires visible branding that materially conflicts with the requested UI

the canonical /rss.xml no longer validates

the repository has changed enough that these instructions conflict with AGENTS.md
```

Do not respond to these conditions by building custom infrastructure.

Report the conflict first.

---

# 34. Final report format

When finished, report only concrete results.

Include:

### Changed files

```text
path
one-line purpose
```

### Provider contract verified

Report:

```text
endpoint path
HTTP method/form behavior
required fields
redirect behavior
whether attribution is required
```

### Validation

Report exact results for:

```text
bun run check
just web
browser verification
mobile
dark mode
View Transition
RSS/tag regression
```

### External side effects

Explicitly state one of:

```text
No real subscription was created.
```

or:

```text
A test subscription was created using the explicitly authorized test inbox <description>.
```

### Remaining caveats

Mention any provider behavior that was not possible to verify.

Do not claim email delivery was tested unless an actual authorized inbox received the message.

---

# 35. Governing principle

When uncertain, choose the solution with fewer moving parts.

This integration should remain:

```text
Astro static site
        +
existing RSS
        +
one ordinary HTML form
        +
hosted RSS-to-email service
```

Do not turn it into a newsletter application.
