// Tag display label — single source shared by /blog, the post page, and the
// RSS feed titles (feed.ts must stay server-only, hence this plain module).
// Title-cases a kebab slug (career-advice → "Career Advice"); lowercase
// acronyms go all-caps via an explicit set (ai → "AI"); short stopwords stay
// lowercase mid-label (philosophy-of-science → "Philosophy of Science") but
// capitalize at the start.
const ACRONYMS = new Set(['ai']);
const STOPWORDS = new Set(['of', 'and', 'the', 'in', 'for', 'to']);

export const tagLabel = (t: string) =>
  t
    .split('-')
    .map((w, i) => {
      if (ACRONYMS.has(w)) return w.toUpperCase();
      if (i > 0 && STOPWORDS.has(w)) return w;
      return w.charAt(0).toUpperCase() + w.slice(1);
    })
    .join(' ');
