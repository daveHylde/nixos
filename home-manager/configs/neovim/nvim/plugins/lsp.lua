local util = require("lspconfig.util")

-- Set up LspAttach autocmd for on_attach behavior
vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(ev)
		-- Create a command `:Format` local to the LSP buffer
		vim.api.nvim_buf_create_user_command(ev.buf, 'Format', function(_)
			vim.lsp.buf.format()
		end, { desc = 'Format current buffer with LSP' })
	end,
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.diagnostic.dynamicRegistration = true

-- Lua Language Server
vim.lsp.config('lua_ls', {
	capabilities = capabilities,
	root_dir = function()
		return vim.loop.cwd()
	end,
	cmd = { "lua-language-server" },
	settings = {
		Lua = {
			workspace = { checkThirdParty = false },
			telemetry = { enable = false },
		},
	}
})
vim.lsp.enable('lua_ls')

-- Angular Language Server
vim.lsp.config('angularls', {
	capabilities = capabilities,
	root_dir = util.root_pattern("nx.json", "package.json", "angular.json", "project.json"), -- This is for monorepo's
	filetypes = { 'typescript', 'angular.html', 'angular' }
})
vim.lsp.enable('angularls')

-- TypeScript Language Server
vim.lsp.config('vtsls', {
	capabilities = capabilities,
	root_dir = util.root_pattern("nx.json", "package.json", "angular.json", "project.json"), -- This is for monorepo's
})
vim.lsp.enable('vtsls')

-- HTML Language Server
vim.lsp.config('html', {
	capabilities = capabilities,
	filetypes = { "html", "typescript", "angular", "freemarker" },
})
vim.lsp.enable('html')

-- ESLint Language Server
vim.lsp.config('eslint', {
	capabilities = capabilities,
})
vim.lsp.enable('eslint')

-- Nix Language Server
vim.lsp.config('nixd', {
	capabilities = capabilities,
	cmd = { "nixd" }
})
vim.lsp.enable('nixd')

-- CSS Language Server
vim.lsp.config('cssls', {
	capabilities = capabilities,
	filetypes = { "css", "scss", "less", "html", "angular", "freemarker" },
})
vim.lsp.enable('cssls')

-- Docker Language Server
vim.lsp.config('dockerls', {
	capabilities = capabilities,
})
vim.lsp.enable('dockerls')

-- YAML Language Server
vim.lsp.config('yamlls', {
	capabilities = capabilities,
	settings = {
		yaml = {
			schemaStore = {
				enable = false,
				url = "",
			},
			schemas = require('schemastore').yaml.schemas(),
		},
	},
})
vim.lsp.enable('yamlls')

-- SQL Language Server
vim.lsp.config('sqlls', {
	capabilities = capabilities,
})
vim.lsp.enable('sqlls')

-- Markdown Language Server
vim.lsp.config('marksman', {
	capabilities = capabilities,
	cmd = { "marksman" },
})
vim.lsp.enable('marksman')

-- JSON Language Server
vim.lsp.config('jsonls', {
	capabilities = capabilities,
	settings = {
		json = {
			schemas = require('schemastore').json.schemas(),
			validate = { enable = true },
		},
	},
})
vim.lsp.enable('jsonls')

-- Tailwind CSS Language Server
vim.lsp.config('tailwindcss', {
	capabilities = capabilities,
	root_dir = util.root_pattern("nx.json", "package.json", "angular.json", "project.json"), -- This is for monorepo's
})
vim.lsp.enable('tailwindcss')
