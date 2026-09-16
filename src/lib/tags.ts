// Tag display label — single source shared by /blog, the post page, and the
// RSS feed titles (feed.ts must stay server-only, hence this plain module).
// Title-cases a kebab slug (participatory-design → "Participatory Design");
// lowercase acronyms go all-caps via an explicit set (ai → "AI") rather than a
// length heuristic, which would mislabel a future slug containing a short
// English word (e.g. path-to-production → "Path TO Production").
const ACRONYMS = new Set(['ai']);

export const tagLabel = (t: string) =>
  t
    .split('-')
    .map((w) => (ACRONYMS.has(w) ? w.toUpperCase() : w.charAt(0).toUpperCase() + w.slice(1)))
    .join(' ');
