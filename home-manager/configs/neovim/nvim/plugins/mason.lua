local mason = require('mason-tool-installer')

mason.setup({
	ensure_installed = {
		"angular-language-server",
		"csharp-language-server",
		"css-lsp",
		"html-lsp",
    "dockerfile-language-server",
    "eslint-lsp",
    "html-lsp",
    "json-lsp",
		"lemminx",
    "marksman",
    "omnisharp",
    "sqlls",
    "tailwindcss-language-server",
    "vtsls",
    "xmlformatter",
    "yaml-language-server",
	},
})
