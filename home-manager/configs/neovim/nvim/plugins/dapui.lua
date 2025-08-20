local dap = require("dap")
local dapui = require("dapui")

dapui.setup {
	layouts = { {
		elements = {
			{
				id = "breakpoints",
				size = 0.1
			},
			{
				id = "stacks",
				size = 0
			},
			{
				id = "watches",
				size = 0
			},
			{
				id = "scopes",
				size = 0.9
			}
		},
		position = "left",
		size = 60
	},
		{
			elements = {
				{
					id = "repl",
					size = 1
				},
			},
			position = "bottom",
			size = 15
		}
	},

	render = {
		max_type_length = 50,
		max_value_lines = 100,
		indent = 2,
	},

	controls = {
		enabled = true,
		element = "repl",
		icons = {
			pause = "⏸",
			play = "▶",
			step_into = "⏎",
			step_over = "⏭",
			step_out = "⏮",
			step_back = "b",
			run_last = "▶▶",
			terminate = "⏹",
		},
	},

	element_mappings = {
		repl = {
			open = "<CR>",
			remove = "d",
			edit = "e",
			repl = "r",
			toggle = "t"
		}
	},

	floating = {
		max_height = 0.8,
		max_width = 0.8,
		border = "rounded",
		mappings = {
			close = { "q", "<Esc>" },
		},
	},
}


local function eval_enumerable_enhanced(expr)
	local session = dap.session()
	if not session then
		vim.notify("No active debug session", vim.log.levels.WARN)
		return
	end

	-- First show in floating window
	local eval_expr = string.format("(%s).ToArray()", expr)
	dapui.eval(eval_expr, {
		context = "hover",
		enter = true
	})
end

_G.eval_enumerable_interactive = eval_enumerable_interactive
_G.add_enumerable_to_watch = add_enumerable_to_watch
_G.eval_enumerable_buffer = eval_enumerable_buffer
_G.eval_enumerable_enhanced = eval_enumerable_enhanced

-- Event listeners
dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open({})
end

dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close({})
end

dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close({})
end
