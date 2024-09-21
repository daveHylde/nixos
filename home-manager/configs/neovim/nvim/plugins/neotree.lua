local tree = require('neo-tree')

tree.setup({
	filesystem = {
		bind_to_cwd = false,
		follow_current_file = { enabled = true },
		use_libuv_file_watcher = false,
		filtered_items = {
			visible = true, -- This is what you want: If you set this to `true`, all "hide" just mean "dimmed out"
			hide_dotfiles = false,
			hide_gitignored = false,
		},
	},
	window = {
		mappings = {
			["P"] = { "toggle_preview", config = { use_float = false, use_image_nvim = true } },
		},
	},
})

--local events = require("neo-tree.events")
--events.fire_event(events.GIT_EVENT)
