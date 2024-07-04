local tree = require('neo-tree')

tree.setup({
	filesystem = {
		bind_to_cwd = false,
		follow_current_file = { enabled = true },
		use_libuv_file_watcher = true,
	},
	window = {
		mappings = {
			["P"] = { "toggle_preview", config = { use_float = false, use_image_nvim = true } },
		},
	},
})
