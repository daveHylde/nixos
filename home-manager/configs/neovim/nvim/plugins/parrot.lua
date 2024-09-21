require("parrot").setup {
	-- Providers must be explicitly added to make them available.
	providers = {
		anthropic = {
			api_key = os.getenv "ANTHROPIC_API_KEY",
		},
		ollama = {},
		--		openai = {
		--			api_key = os.getenv "OPENAI_API_KEY",
		--		},
		--		github = {
		--			api_key = os.getenv "GITHUB_TOKEN",
		--		},
	},
}
