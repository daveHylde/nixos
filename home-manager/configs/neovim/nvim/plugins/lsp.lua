local util = require("lspconfig.util")

local on_attach = function(_, bufnr)
	local bufmap = function(keys, func)
		vim.keymap.set('n', keys, func, { buffer = bufnr })
	end

	bufmap('<leader>cr', vim.lsp.buf.rename)
	bufmap('<leader>ca', vim.lsp.buf.code_action)

	bufmap('gd', vim.lsp.buf.definition)
	bufmap('gD', vim.lsp.buf.declaration)
	bufmap('gI', vim.lsp.buf.implementation)
	bufmap('<leader>D', vim.lsp.buf.type_definition)

	bufmap('gr', require('telescope.builtin').lsp_references)
	bufmap('<leader>s', require('telescope.builtin').lsp_document_symbols)
	bufmap('<leader>S', require('telescope.builtin').lsp_dynamic_workspace_symbols)

	bufmap('K', vim.lsp.buf.hover)

	require("tailwindcss-colors").buf_attach(bufnr)

	vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
		vim.lsp.buf.format()
	end, {})
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

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
	filetypes = { "html", "typescript", "typescriptreact", "angular" },
}
lsp.vtsls.setup {
	on_attach = on_attach,
	capabilities = capabilities,
	root_dir = util.root_pattern("package.json", ".git", "tsconfig.base.json"),
}
lsp.csharp_ls.setup {
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes = { "cs" },
}
lsp.html.setup {
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes = { "html" },
}
lsp.tailwindcss.setup {
	on_attach = on_attach,
	capabilities = capabilities,
}
lsp.eslint.setup {
	on_attach = on_attach,
	capabilities = capabilities,
}
lsp.nixd.setup {
	on_attach = on_attach,
	capabilities = capabilities,
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
}
