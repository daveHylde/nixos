local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
	-- see :help lsp-zero-keybindings
	-- to learn the available actions
	lsp_zero.default_keymaps({ buffer = bufnr })
end)

local lspconfig = require('lspconfig')
local util = require('lspconfig.util')

lspconfig.csharp_ls.setup {
  filtypes = { "cs", "razor", "cshtml", "html" }
}

lspconfig.jsonls.setup {}

lspconfig.yamlls.setup {}

lspconfig.cssls.setup {}

lspconfig.html.setup {}

lspconfig.sqls.setup {}

lspconfig.dockerls.setup {}

lspconfig.eslint.setup {
	on_attach = function(client, bufnr)
		vim.api.nvim_create_autocmd("BufWritePre", {
			buffer = bufnr,
			command = "EslintFixAll",
		})
	end,
}

-- Setup tsserver as monorepo first
lspconfig.tsserver.setup {
	root_dir = util.root_pattern("package.json", ".git", "tsconfig.base.json"),
}

lspconfig.lua_ls.setup {}

lspconfig.nixd.setup {}


lspconfig.angularls.setup {
	root_dir = util.root_pattern("angular.json", "project.json"), -- This is for monorepo's
	filetypes = { "html", "typescript", "typescriptreact", "angular" },
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
		{ name = 'bulma' , keyword_length = 2 },
	},
	formatting = lsp_zero.cmp_format(),
	mapping = cmp.mapping.preset.insert({
		['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
		['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
		['<C-y>'] = cmp.mapping.confirm({ select = true }),
		['<C-Space>'] = cmp.mapping.complete(),
	}),
})
