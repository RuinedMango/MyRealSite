@param boolean dev
@param String title
@param String description

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="${description}">
<meta name="author" content="RuinedMango">
<meta name="theme-color" content="#050608">
<meta name="color-scheme" content="dark">

<meta property="og:type" content="website">
<meta property="og:title" content="${title}">
<meta property="og:description" content="${description}">
<meta name="twitter:card" content="summary">

<title>${title}</title>

<link rel="icon" href="data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 32 32'%3E%3Crect width='32' height='32' rx='4' fill='%23050608'/%3E%3Ccircle cx='16' cy='16' r='5' fill='%23ff3b30'/%3E%3C/svg%3E">

@if(dev)
<script type="module" src="http://localhost:5173/@vite/client"></script>
<script type="module" src="http://localhost:5173/src/main.ts"></script>
@else
<link rel="stylesheet" href="/assets/index.css">
<script type="module" src="/assets/index.js"></script>
@endif
