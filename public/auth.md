# auth.md for alansynn.com

## Audience

Automated agents, crawlers, and LLM applications that read Alan Synn's
academic homepage and its machine-readable resources.

## Authentication

None. The entire site is public and read-only; every supported operation is
an anonymous HTTPS GET. Useful entry points:

- `GET /`: homepage (HTML; send `Accept: text/markdown` for a markdown mirror)
- `GET /llms.txt`: machine-readable site index for agents
- `GET /rss.xml` and `GET /blog/rss.xml`: RSS feeds
- `GET /.well-known/api-catalog`: RFC 9727 API catalog
- `GET /robots.txt`: crawling policy (`Content-Signal: ai-train=yes, search=yes, ai-input=yes`)

## Registration

No registration or provisioning endpoint exists, and none is needed: there
is no write API, no user accounts, and no gated content. Nothing to sign up
for, nothing to provision.

## Credentials

None. No API keys, tokens, or other credentials are issued or accepted, and
no endpoint processes them. Plain anonymous GET is the only supported
method.

## Etiquette

Respect `robots.txt` and the Content Signals above, use a descriptive
User-Agent, and prefer the RSS feeds or `llms.txt` for change tracking
instead of re-crawling everything.
