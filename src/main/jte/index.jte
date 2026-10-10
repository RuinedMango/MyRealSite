@param boolean dev

<!doctype html>

<html lang="en">
	<head>
    	<meta charset="UTF-8">
    	<meta name="viewport" content="width=device-width, initial-scale=1.0">

    	<title>RuinedMango</title>

    	@if(dev)
        	<script type="module" src="http://localhost:5173/src/main.ts"></script>
    	@else
        	<link rel="stylesheet" href="/assets/index.css">
        	<script type="module" src="/assets/index.js"></script>
    	@endif
	</head>

	<header>
		<h1 class="text-3xl font-bold p-5">
			Ruinedmango
		</h1>
	</header>

	<body class="min-h-screen bg-zinc-950 text-zinc-100">
    	<main class="mx-auto max-w-5xl px-6 py-16">
        	<p class="mt-4 text-zinc-400">
            	Javalin + JTE + HTMX + Alpine + Tailwind
        	</p>
			<button
    			hx-get="/api/hello"
    			hx-target="#response"
    			hx-swap="innerHTML"
    			class="rounded-lg bg-white px-4 py-2 font-medium text-black"
			>
    			Say hello
			</button>

			<div
				x-data="{ open: false }"
    			class="mt-8"
			>
    			<button
        			@click="open = !open"
        			class="rounded-lg bg-white px-4 py-2 font-medium text-black"
    			>
        			Toggle
    			</button>

   				<div
    				x-show="open"
        			class="mt-4 rounded-lg border border-zinc-800 bg-zinc-900 p-4"
    			>
        			Alpine is working.
    			</div>
			</div>

			<div id="response" class="mt-4"></div>
		</main>
	</body>
</html>
