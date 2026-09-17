// giscus comment backend — public configuration only. The repo/category GraphQL
// IDs are public values (giscus resolves authorization server-side via its
// GitHub App); there are no secrets here and none belong in env vars.
// Backend: github.com/AlanSynn/comments — a Discussions repo shared by
// multiple sites; allowed embedding origins live in that repo's giscus.json.
export const giscus = {
  repo: 'AlanSynn/comments',
  repoId: 'R_kgDOUeKj1g',
  category: 'Comments',
  categoryId: 'DIC_kwDOUeKj1s4DFxnt',
  // Application namespace for the mapping term — NOT a hostname.
  siteKey: 'alansynn',
} as const;

// giscus term for a blog post: <site-key>:<content-kind>:<stable-id>. The
// shared backend forbids pathname/url/title mapping (two sites can share a
// path; titles are mutable), so identity rides on the stable post.id — which
// is why a published slug is part of the comment identity and must not be
// renamed without migrating its Discussion.
export const commentTerm = (postId: string) => `${giscus.siteKey}:blog:${postId}`;
