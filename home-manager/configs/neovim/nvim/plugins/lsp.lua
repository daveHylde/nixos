local util = require("lspconfig.util")

local on_attach = function(_, bufnr)
	local bufmap = function(keys, func)
		vim.keymap.set('n', keys, func, { buffer = bufnr })
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
	on_attach = on_attach,
	capabilities = capabilities,
	root_dir = util.root_pattern("package.json", ".git", "tsconfig.base.json"),
}
local cs_ext = require('omnisharp_extended')
lsp.omnisharp.setup {
	on_attach = function(_, bufnr)
		local bufmap = function(keys, func)
			vim.keymap.set('n', keys, func, { buffer = bufnr })
		end
		on_attach(_, bufnr)
		bufmap('gd', cs_ext.telescope_lsp_definition)
		bufmap('gD', cs_ext.telescope_lsp_type_definition)
		bufmap('gr', cs_ext.telescope_lsp_references)
		bufmap('gI', cs_ext.telescope_lsp_implementation)
	end,
	capabilities = capabilities,
	filetypes = { "cs" },
	cmd = { "omnisharp", "--languageserver", "--hostPID", tostring(vim.fn.getpid()) },
	root_dir = require('lspconfig').util.root_pattern("*.sln", "*.csproj"),
	settings = {
		FormattingOptions = {
			EnableEditorConfigSupport = true,
			OrganizeImports = true,
		},
		MsBuild = {
			LoadProjectsOnDemand = true,
		},
		RoslynExtensionsOptions = {
			EnableAnalyzersSupport = true,
			EnableImportCompletion = false,
			AnalyzeOpenDocumentsOnly = false,
		},
		Sdk = {
			IncludePrereleases = true,
		},
	}
}
lsp.html.setup {
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes = { "html", "typescript", "angular" },
}
lsp.tailwindcss.setup {
	on_attach = function(_, bufnr)
		on_attach(_, bufnr)
		require("tailwindcss-colors").buf_attach(bufnr)
	end,
	capabilities = capabilities,
	settings = {
		tailwindCSS = {
			classAttributes = { "class", "className", "class:list", "classList", "ngClass", "routerLinkActive", "xClasses" },
			lint = {
				cssConflict = "warning",
				invalidApply = "error",
				invalidConfigPath = "error",
				invalidScreen = "error",
				invalidTailwindDirective = "error",
				invalidVariant = "error",
				recommendedVariantOrder = "warning"
			},
			validate = true
		}
	},
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
