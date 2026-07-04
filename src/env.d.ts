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
