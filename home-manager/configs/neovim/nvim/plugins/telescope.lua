local actions = require('telescope.actions')

require('telescope').setup({
	defaults = {
		path_display = {
			filename_first = {
				reverse_directories = true
			}
		},
		sorting_strategy = "ascending",
		layout_config = {
			horizontal = {
				prompt_position = "top",
				preview_width = 0.67,
			},
			width = 0.98,
			height = 0.98,
		},
		file_ignore_patterns = {
			'%__virtual.cs$',
			'node_modules',
			'dist',
			'.angular',
			'tmp',
			'.nx',
			'.git',
			'.idea',
			'build',
			'out',
			'target',
			'vendor',
			'.cache',
			'.DS_Store',
			'%.o',
			'%.a',
			'%.so',
			'%.pyc',
			'__pycache__'
		},
		mappings = {
			i = {
				["<Esc>"] = actions.close, -- Close on Esc in insert mode
				["<C-Down>"] = actions.cycle_history_next,
				["<C-Up>"] = actions.cycle_history_prev
			},
			n = {
				["<Esc>"] = actions.close, -- Close on Esc in normal mode
				["<C-Down>"] = actions.cycle_history_next,
				["<C-Up>"] = actions.cycle_history_prev
			},
		}
	},
	extensions = {
		fzf = {
			fuzzy = true,                -- false will only do exact matching
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = "ignore_case",   -- or "smart_case" or "respect_case"
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
require("telescope").load_extension("ui-select")
require("telescope").load_extension("advanced_git_search")
