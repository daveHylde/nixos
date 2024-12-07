local snacks = require("snacks")
snacks.setup {
	bigfile = { enabled = true, },
	lazygit = { enabled = true, },
	git = { enabled = true, },
	notify = { enabled = true, },
	notifier = { enabled = true, },
	rename = { enabled = true, },
	bufdelete = { enabled = true },
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
	}
}

local banned_messages = { "No information available" }
vim.notify = function(msg)
	for _, banned in ipairs(banned_messages) do
		if msg == banned then
			return
		end
	end
	return snacks.notify
end
