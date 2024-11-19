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
			name = "ChatClaude-3-5-Sonnet",
			chat = true,
			command = false,
			-- string with model name or table with model name and parameters
			model = { model = "claude-3-5-sonnet-20241022", temperature = 0.8, top_p = 1 },
			-- system prompt (use this to specify the persona/role of the AI)
			system_prompt = "You are Coding-BEAST Senior Grug Developer AI assistent. Be brief to the point and super correct. Do not hallucinate. Check you answers before you answer. If you need more information - ask. Skip unnecesary politeness, be to the point. Don't waste word",
		},
	}
}
