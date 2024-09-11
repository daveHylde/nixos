local actions = require('telescope.actions')

local function format_path(_, path)
	local tail = require("telescope.utils").path_tail(path)
	local shortened_path = path:gsub("(.*/)(.*)", "%1")
	return string.format("%s ~ %s", tail, shortened_path)
end

require('telescope').setup({
	pickers = {
		find_files = {
			find_command = { 'rg', '--files', '--iglob', '!.git', '--hidden' },
			path_display = format_path,
		}
	},
	defaults = {
		mappings = {
			i = {
				["<Esc>"] = actions.close, -- Close on Esc in insert mode
			},
			n = {
				["<Esc>"] = actions.close, -- Close on Esc in normal mode
			},
		}
	},
	extensions = {
		fzf = {
			fuzzy = true,          -- false will only do exact matching
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = "ignore_case", -- or "smart_case" or "respect_case"
		},
		media_files = {
			filetypes = { "png", "webp", "jpg", "jpeg", "pdf" },
			find_cmd = "rg"
		},
		live_grep_args = {
			auto_quoting = true,
		},
		["ui-select"] = {
			require("telescope.themes").get_dropdown {}
		}
	},
})

require('telescope').load_extension('fzf')
require('telescope').load_extension('media_files')
require('telescope').load_extension('live_grep_args')
-- require("telescope").load_extension("git_file_history")
require("telescope").load_extension("ui-select")
