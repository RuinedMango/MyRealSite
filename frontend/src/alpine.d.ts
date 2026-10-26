// Alpine ships without TypeScript declarations. Only the API used by this
// project is declared here.
declare module "alpinejs" {
  interface Alpine {
    start(): void;
    stop(): void;
    version: string;
  }

  const Alpine: Alpine;
  export default Alpine;
}
