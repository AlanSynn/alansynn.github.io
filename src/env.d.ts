/// <reference path="../.astro/types.d.ts" />
/// <reference types="astro/client" />

// YAML imports via @modyfi/vite-plugin-yaml
declare module '*.yaml' {
  const data: any;
  export default data;
}
declare module '*.yml' {
  const data: any;
  export default data;
}
// Typst → HTML component imports (astro-typst)
declare module '*.typ?html&body' {
  const Component: () => any;
  export default Component;
}
// Window globals set by site inline scripts — declared so processed <script>
// blocks type-check: Base.astro/MicrositeShell's no-flash theme listener guard,
// GiscusComments' MutationObserver binding guard and its page-scoped
// IntersectionObserver (torn down + replaced on every View-Transition swap).
interface Window {
  __themeListenerBound?: boolean;
  __giscusThemeObserverBound?: boolean;
  __giscusIntersectionObserver?: IntersectionObserver;
}
