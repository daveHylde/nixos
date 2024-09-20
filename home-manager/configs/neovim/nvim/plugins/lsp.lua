local util = require("lspconfig.util")

local on_attach = function(_, bufnr)
	local bufmap = function(keys, func)
		vim.keymap.set({'n', 'v'}, keys, func, { buffer = bufnr })
	end

	bufmap('<leader>cr', vim.lsp.buf.rename)
	bufmap('<leader>ca', function() require("actions-preview").code_actions() end)

	bufmap('gd', vim.lsp.buf.definition)
	bufmap('gD', vim.lsp.buf.declaration)
	bufmap('gI', vim.lsp.buf.implementation)
	bufmap('<leader>D', vim.lsp.buf.type_definition)

	bufmap('gr', require('telescope.builtin').lsp_references)
	bufmap('<leader>s', require('telescope.builtin').lsp_document_symbols)
	bufmap('<leader>S', require('telescope.builtin').lsp_dynamic_workspace_symbols)

	bufmap('K', vim.lsp.buf.hover)

	vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
		vim.lsp.buf.format()
	end, {})
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
capabilities.textDocument.completion.completionItem.snippetSupport = true

--require('neodev').setup()
local lsp = require('lspconfig')
lsp.lua_ls.setup {
	on_attach = on_attach,
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
}

lsp.angularls.setup {
	on_attach = on_attach,
	capabilities = capabilities,
	root_dir = util.root_pattern("package.json", "angular.json", "project.json"), -- This is for monorepo's
	filetypes = { 'typescript', 'html', 'typescriptreact', 'typescript.tsx', 'angular.html', 'angular' }
}
lsp.vtsls.setup {
	capabilities = capabilities,
	root_dir = util.root_pattern("package.json", ".git", "tsconfig.base.json"),
}
lsp.html.setup {
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes = { "html", "typescript", "angular" },
}
lsp.eslint.setup {
	on_attach = on_attach,
	capabilities = capabilities,
}
lsp.nixd.setup {
	on_attach = on_attach,
	capabilities = capabilities,
	cmd = { "nixd" }
}
lsp.cssls.setup {
	on_attach = on_attach,
	capabilities = capabilities,
}
lsp.dockerls.setup {
	on_attach = on_attach,
	capabilities = capabilities,
}
lsp.yamlls.setup {
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		yaml = {
			schemaStore = {
				-- You must disable built-in schemaStore support if you want to use
				-- this plugin and its advanced options like `ignore`.
				enable = false,
				-- Avoid TypeError: Cannot read properties of undefined (reading 'length')
				url = "",
			},
			schemas = require('schemastore').yaml.schemas(),
		},
	},
}
lsp.sqlls.setup {
	on_attach = on_attach,
	capabilities = capabilities,
}
lsp.marksman.setup {
	on_attach = on_attach,
	capabilities = capabilities,
	cmd = { "marksman" },
}
lsp.jsonls.setup {
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		json = {
			schemas = require('schemastore').json.schemas(),
			validate = { enable = true },
		},
	},
}
local configs = require('lspconfig.configs')
configs.roslyn = {
	default_config = {
		filetypes = { 'cs', 'razor', 'aspnetcorerazor' },
		root_dir = lsp.util.root_pattern("*.sln", "*.csproj", ".git"),
		cmd = {
			"dotnet",
			vim.fs.joinpath(vim.fn.stdpath("data"), "roslyn", "Microsoft.CodeAnalysis.LanguageServer.dll"),
			"--logLevel=Information",
			"--extensionLogDirectory=/tmp"
		},
		settings = {
			["csharp|inlay_hints"] = {
				csharp_enable_inlay_hints_for_implicit_object_creation = true,
				csharp_enable_inlay_hints_for_implicit_variable_types = true,
				csharp_enable_inlay_hints_for_lambda_parameter_types = true,
				csharp_enable_inlay_hints_for_types = true,
				dotnet_enable_inlay_hints_for_indexer_parameters = true,
				dotnet_enable_inlay_hints_for_literal_parameters = true,
				dotnet_enable_inlay_hints_for_object_creation_parameters = true,
				dotnet_enable_inlay_hints_for_other_parameters = true,
				dotnet_enable_inlay_hints_for_parameters = true,
				dotnet_suppress_inlay_hints_for_parameters_that_differ_only_by_suffix = true,
				dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = true,
				dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent = true,
			},
			["csharp|code_lens"] = {
				dotnet_enable_references_code_lens = true,
			},
		}
	},
}
lsp.roslyn.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

