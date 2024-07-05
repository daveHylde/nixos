local lga_actions = require("telescope-live-grep-args.actions")
local actions = require('telescope.actions')

require('telescope').setup({
	defaults = {
		mappings = {
			i = {
				["<Esc>"] = actions.close,         -- Close on Esc in insert mode
			},
			n = {
				["<Esc>"] = actions.close,         -- Close on Esc in normal mode
			},
		}
	},
	extensions = {
		fzf = {
			fuzzy = true,                -- false will only do exact matching
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = "smart_case",    -- or "ignore_case" or "respect_case"
			-- the default case_mode is "smart_case"
		},
		media_files = {
			-- filetypes whitelist
			-- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
			filetypes = { "png", "webp", "jpg", "jpeg" },
			-- find command (defaults to `fd`)
			find_cmd = "rg"
		},
		live_grep_args = {
			auto_quoting = true, -- enable/disable auto-quoting
			-- define mappings, e.g.
			mappings = {      -- extend mappings
				i = {
					["<leader>sg"] = lga_actions.quote_prompt(),
					["<leader>sG"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
				},
			},
			-- ... also accepts theme settings, for example:
			-- theme = "dropdown", -- use dropdown theme
			-- theme = { }, -- use own theme spec
			-- layout_config = { mirror=true }, -- mirror preview pane
		}
	},
})
require('telescope').load_extension('fzf')
require('telescope').load_extension('media_files')
require('telescope').load_extension('live_grep_args')
