local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
	-- see :help lsp-zero-keybindings
	-- to learn the available actions
	lsp_zero.default_keymaps({ buffer = bufnr })
end)

local lspconfig = require('lspconfig')
local util = require('lspconfig.util')

lspconfig.csharp_ls.setup {}

lspconfig.jsonls.setup {}

lspconfig.yamlls.setup {}

lspconfig.cssls.setup {}

lspconfig.eslint.setup {
	on_attach = function(client, bufnr)
		vim.api.nvim_create_autocmd("BufWritePre", {
			buffer = bufnr,
			command = "EslintFixAll",
		})
	end,
}

lspconfig.tsserver.setup {
	root_dir = util.root_pattern("package.json", ".git", "tsconfig.base.json")
}

lspconfig.lua_ls.setup {}

lspconfig.nixd.setup {}

lspconfig.angularls.setup {
	root_dir = util.root_pattern("angular.json", "project.json"), -- This is for monorepo's
	filetypes = { "angular", "html", "typescript", "typescriptreact" },
}

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }

cmp.setup({
	sources = {
		{ name = 'path' },
		{ name = 'nvim_lsp' },
		{ name = 'nvim_lua' },
		{ name = 'luasnip', keyword_length = 2 },
		{ name = 'buffer',  keyword_length = 3 },
	},
	formatting = lsp_zero.cmp_format(),
	mapping = cmp.mapping.preset.insert({
		['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
		['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
		['<C-y>'] = cmp.mapping.confirm({ select = true }),
		['<C-Space>'] = cmp.mapping.complete(),
	}),
})


-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '{e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '{q', vim.diagnostic.setloclist)

---- Use LspAttach autocommand to only map the following keys
---- after the language server attaches to the current buffer
--vim.api.nvim_create_autocmd('LspAttach', {
--	group = vim.api.nvim_create_augroup('UserLspConfig', {}),
--	callback = function(ev)
--		-- Enable completion triggered by <c-x><c-o>
--		vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
--
--		-- Buffer local mappings.
--		-- See `:help vim.lsp.*` for documentation on any of the below functions
--		local opts = { buffer = ev.buf }
--		vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
--		vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
--		vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
--		vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
--		vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
--		vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
--		vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
--		vim.keymap.set('n', '<leader>wl', function()
--			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
--		end, opts)
--		vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
--		vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
--		vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
--		vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
--		vim.keymap.set('n', '<leader>f', function()
--			vim.lsp.buf.format { async = true }
--		end, opts)
--	end,
--})
