require("gp").setup {
	openai_api_key = { 'cat', vim.fs.joinpath(vim.fn.stdpath("data"), 'OPENAI_API_KEY') },
	-- Providers must be explicitly added to make them available.
	providers = {
		openai = {
			endpoint = "https://api.openai.com/v1/chat/completions",
			secret = { 'cat', vim.fs.joinpath(vim.fn.stdpath("data"), 'OPENAI_API_KEY') },
		},

		ollama = {
			endpoint = "http://localhost:11434/v1/chat/completions",
		},

		anthropic = {
			endpoint = "https://api.anthropic.com/v1/messages",
			secret = { 'cat', vim.fs.joinpath(vim.fn.stdpath("data"), 'ANTHROPIC_API_KEY') },
		},
	},
}
