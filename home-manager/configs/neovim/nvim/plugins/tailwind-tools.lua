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

require('tailwind-tools').setup {
	---@type TailwindTools.Option
	{
		server = {
			override = true, -- setup the server from the plugin if true
			settings = {
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
			},                                    -- shortcut for `settings.tailwindCSS`
			on_attach = on_attach, -- callback triggered when the server attaches to a buffer
		},
		document_color = {
			enabled = true, -- can be toggled by commands
			kind = "inline", -- "inline" | "foreground" | "background"
			inline_symbol = "󰝤 ", -- only used in inline mode
			debounce = 200, -- in milliseconds, only applied in insert mode
		},
		conceal = {
			enabled = false, -- can be toggled by commands
			min_length = nil, -- only conceal classes exceeding the provided length
			symbol = "󱏿", -- only a single character is allowed
			highlight = { -- extmark highlight options, see :h 'highlight'
				fg = "#38BDF8",
			},
		},
		cmp = {
			highlight = "foreground", -- color preview style, "foreground" | "background"
		},
		telescope = {
			utilities = {
				callback = function(name, class) end, -- callback used when selecting an utility class in telescope
			},
		},
		-- see the extension section to learn more
		extension = {
			queries = {}, -- a list of filetypes having custom `class` queries
			patterns = { -- a map of filetypes to Lua pattern lists
				-- exmaple:
				-- rust = { "class=[\"']([^\"']+)[\"']" },
				-- javascript = { "clsx%(([^)]+)%)" },
			},
		},
	}
}
