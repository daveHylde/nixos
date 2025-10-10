local snacks = require("snacks")
snacks.setup {
	bigfile = { enabled = true, },
	lazygit = { enabled = true, },
	git = { enabled = true, },
	notify = { enabled = true, },
	notifier = {
		enabled = true,
		filter = function(msg)
			local banned_messages = { "No information available" }
			for _, banned in ipairs(banned_messages) do
				if msg == banned then
					return
				end
			end
		end
	},
	rename = { enabled = true, },
	image = { enabled = true },
	indent = { enabled = false, },
	input = {
		enabled = true,
		icon = " ",
		icon_hl = "SnacksInputIcon",
		icon_pos = "left",
		prompt_pos = "title",
		win = { style = "input" },
		expand = true,
	},
	bufdelete = { enabled = true },
	picker = {
		enabled = true,
		files = {
			hidden = true,
			ignored = true,
		},
		formatters = {
			file = {
				filename_first = true, -- display filename before the file path
				truncate = 75,     -- truncate the file path to (roughly) this length
				filename_only = false, -- only show the filename
				icon_width = 2,    -- width of the icon (in characters)
				git_status_hl = true, -- use the git status highlight group for the filename
			},
		},
		sources = {
			explorer = {
				layout = "sidebar",
				preview = "main"
			}
		}
	},
	words = { enabled = false },
	dashboard = {
		enabled = true,
		example = "advanced",
		preset = {
			keys = {
				{ icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
				{ icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
				{ icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
				{ icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
				{ icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
				{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
			},
		},
		sections = {
			{ section = "header" },
			{
				pane = 2,
				section = "terminal",
				cmd = "colorscript -e 24",
				height = 5,
				padding = 1,
			},
			{ section = "keys", gap = 1, padding = 1 },
			{ pane = 2, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
			{ pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
			{
				pane = 2,
				icon = " ",
				title = "Git Status",
				section = "terminal",
				enabled = function()
					return snacks.git.get_root() ~= nil
				end,
				cmd = "hub status --short --branch --renames",
				height = 5,
				padding = 1,
				ttl = 5 * 60,
				indent = 3,
			},
		},
	},
	styles = {
		input = {
			backdrop = true,
			border = vim.g.borderStyle,
			title_pos = "left",
			width = 100,
			row = math.ceil(vim.o.lines / 2) - 3,
			keys = {
				i_esc = { "<Esc>", { "cmp_close", "stopinsert" }, mode = "i" },
				BS = { "<BS>", "<Nop>", mode = "n" }, -- prevent accidental closing (<BS> -> :bprev)
				CR = { "<CR>", "confirm", mode = "n" },
			},
		},
		notification = {
			border = vim.g.borderStyle,
			wo = { winblend = 0, wrap = true },
		},
		blame_line = {
			width = 0.6,
			height = 0.6,
			border = vim.g.borderStyle,
			title = " 󰉚 Git blame ",
		},
	},
}
