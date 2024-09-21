require("gp").setup {
	-- Providers must be explicitly added to make them available.
	providers = {
		--		openai = {
		--			endpoint = "https://api.openai.com/v1/chat/completions",
		--			secret = os.getenv("OPENAI_API_KEY"),
		--		},

		-- azure = {...},

		--		copilot = {
		--			endpoint = "https://api.githubcopilot.com/chat/completions",
		--			secret = {
		--				"bash",
		--				"-c",
		--				"cat ~/.config/github-copilot/hosts.json | sed -e 's/.*oauth_token...//;s/\".*//'",
		--			},
		--		},

		ollama = {
			endpoint = "http://localhost:11434/v1/chat/completions",
		},

		anthropic = {
			endpoint = "https://api.anthropic.com/v1/messages",
			secret = os.getenv("ANTHROPIC_API_KEY"),
		},
	},
}
