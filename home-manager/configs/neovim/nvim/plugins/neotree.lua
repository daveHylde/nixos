local tree = require('neo-tree')
local events = require("neo-tree.events")

local function on_move(data)
	require('snacks').rename.on_rename_file(data.source, data.destination)
end

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
	event_handlers = {
		{ event = events.FILE_MOVED,   handler = on_move },
		{ event = events.FILE_RENAMED, handler = on_move },
	},
	window = {
		mappings = {
			["P"] = { "toggle_preview", config = { use_float = false, use_image_nvim = true } },
		},
	},
})
