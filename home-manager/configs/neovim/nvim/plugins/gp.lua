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
	agents = {
		{
			provider = "anthropic",
			name = "Claude-Sonnet-4",
			chat = true,
			command = true,
			model = { model = "claude-sonnet-4-20250514" },
			system_prompt = "Be brief and to the point. Attach resources if possible. Skip formality and avoid fluff.",
		},
		{
			provider = "openai",
			name = "o4-mini",
			chat = true,
			command = true,
			model = { model = "o4-mini-2025-04-16" },
			system_prompt = "Be brief and to the point. Attach resources if possible. Skip formality and avoid fluff.",
		},
		{
			provider = "ollama",
			name = "Llama3.2",
			chat = true,
			command = false,
			model = "llama3.2",
			system_prompt = "Be brief and to the point. Attach resources if possible. Skip formality and avoid fluff.",
		},
	}
}
