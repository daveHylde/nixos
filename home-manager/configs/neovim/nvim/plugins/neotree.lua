local tree = require('neo-tree')
local events = require("neo-tree.events")

local function on_move(data)
	require('snacks').rename.on_rename_file(data.source, data.destination)
end

tree.setup({
	filesystem = {
		bind_to_cwd = false,
		follow_current_file = { enabled = true },
		use_libuv_file_watcher = true,
		filtered_items = {
			visible = true, -- This is what you want: If you set this to `true`, all "hide" just mean "dimmed out"
			hide_dotfiles = false,
			hide_gitignored = false,
		},
		commands = {
			["easy"] = function(state)
				local node = state.tree:get_node()
				local path = node.type == "directory" and node.path or vim.fs.dirname(node.path)
				require("easy-dotnet").create_new_item(path, function()
					require("neo-tree.sources.manager").refresh(state.name)
				end)
			end
		}
	},
	event_handlers = {
		{ event = events.FILE_MOVED,   handler = on_move },
		{ event = events.FILE_RENAMED, handler = on_move },
		{ 
			event = events.GIT_EVENT,
			handler = function()
				require("neo-tree.sources.manager").refresh("filesystem")
			end
		},
	},
	window = {
		mappings = {
			["P"] = { "toggle_preview", config = { use_float = false, use_image_nvim = true } },
			["A"] = "easy",
		},
	},
})

