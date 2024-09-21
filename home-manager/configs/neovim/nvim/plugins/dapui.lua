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
			size = 10
		}
	}
}

dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open({})
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close({})
end
dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close({})
end
