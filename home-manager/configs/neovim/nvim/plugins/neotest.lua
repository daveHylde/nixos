local neotest = require('neotest')

neotest.setup {
	adapters = {
		require("neotest-dotnet")({
			dap = {
				justMyCode = false,
				adapter_name = "coreclr",
			},
			discovery_root = "solution",
		}),
	},
	quickfix = {
		open = function()
			vim.cmd("Trouble quickfix")
		end,
		enabled = true,
	},
}
