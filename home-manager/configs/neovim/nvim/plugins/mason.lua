local mason = require('mason-tool-installer')

mason.setup({
	ensure_installed = {
		"angular-language-server",
		"css-lsp",
		"html-lsp",
		"dockerfile-language-server",
		"eslint-lsp",
		"eslint_d",
		"html-lsp",
		"json-lsp",
		"lemminx",
		"nixpkgs-fmt",
		"omnisharp",
		"sqlls",
		"tailwindcss-language-server",
		"vtsls",
		"xmlformatter",
		"yaml-language-server",
	},
})
