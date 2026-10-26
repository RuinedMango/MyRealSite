import "./style.css";

import htmx from "htmx.org";
import Alpine from "alpinejs";

declare global {
  interface Window {
    Alpine: typeof Alpine;
    htmx: typeof htmx;
  }
}

window.htmx = htmx;
window.Alpine = Alpine;

Alpine.start();
