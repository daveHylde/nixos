-- Minimal telescope config - only for nx.nvim and yanky integration
local actions = require('telescope.actions')

require('telescope').setup({
	defaults = {
		sorting_strategy = "ascending",
		layout_config = {
			horizontal = {
				prompt_position = "top",
			},
		},
		mappings = {
			i = {
				["<Esc>"] = actions.close,
			},
			n = {
				["<Esc>"] = actions.close,
			},
		}
	},
	extensions = {
		fzf = {},
	},
})

-- Load only required extensions
require('telescope').load_extension('fzf')
require("telescope").load_extension("yank_history")
