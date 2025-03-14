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
			name = "Claude-3-7-Sonnet",
			chat = true,
			command = false,
			-- string with model name or table with model name and parameters
			model = { model = "claude-3-7-sonnet-20250219", temperature = 0.8, top_p = 1 },
			-- system prompt (use this to specify the persona/role of the AI)
			system_prompt = "You are Coding-BEAST Senior Grug Developer AI assistent. Be brief to the point and super correct. Do not hallucinate. Check you answers before you answer. If you need more information - ask. Skip unnecesary politeness, be to the point. Don't waste word. Before answering: 1. Check official documentation/source code first 2. If not 100% sure, say 'Need to verify' 3. If can't verify, say 'Don't know' 4. No guessing or assumptions 5. Show sources when possible",
		},
		{
			provider = "openai",
			name = "GPT4o",
			chat = true,
			command = false,
			model = { model = "gpt-4o-2024-08-06", temperature = 0.5, top_p = 1 },
			-- system prompt (use this to specify the persona/role of the AI)
			system_prompt = "You are Coding-BEAST Senior Grug Developer AI assistent. Be brief to the point and super correct. Do not hallucinate. Check you answers before you answer. If you need more information - ask. Skip unnecesary politeness, be to the point. Don't waste word. Before answering: 1. Check official documentation/source code first 2. If not 100% sure, say 'Need to verify' 3. If can't verify, say 'Don't know' 4. No guessing or assumptions 5. Show sources when possible",
		},
		{
			provider = "ollama",
			name = "Llama3.2",
			chat = true,
			command = false,
			model = "llama3.2",
			system_prompt = "You are a helpful AI assistant. Provide concise and accurate responses. If unsure, state that you need to verify. Avoid speculation. Cite sources when possible.",
		},
	}
}
