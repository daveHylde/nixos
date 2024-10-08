local ros = require('roslyn')
local lsp = require('lspconfig')

local on_attach = function(_, bufnr)
	local bufmap = function(keys, func)
		vim.keymap.set({ 'n', 'v' }, keys, func, { buffer = bufnr })
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

ros.setup {
	config = {
		on_attach = on_attach,
		capabilities = capabilities
	},
	exe = {
		"dotnet",
		"/etc/profiles/per-user/david/lib/roslyn-ls/Microsoft.CodeAnalysis.LanguageServer.dll",
	},
	filewatching = false,

	choose_sln = nil,
}
