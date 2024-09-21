require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		nix = { "nixpkgs-fmt" },
		typescript = { "eslint_d", "eslint" },
		javascript = { "eslint_d", "eslint" },
		angular = { "eslint_d", "eslint" },
	},
	format_on_save = {
		-- These options will be passed to conform.format()
		timeout_ms = 500,
		lsp_format = "fallback",
	},
})
