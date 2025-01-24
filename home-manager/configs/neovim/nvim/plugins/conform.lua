require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		nix = { "nixpkgs-fmt" },
		typescript = { "eslint_d" },
		javascript = { "eslint_d" },
		angular = { "eslint_d" },
	},
	default_format_opts = {
		lsp_format = "fallback",
	},
	-- format_on_save = {
	-- 	-- These options will be passed to conform.format()
	-- 	timeout_ms = 500,
	-- 	lsp_format = "fallback",
	-- },
})
