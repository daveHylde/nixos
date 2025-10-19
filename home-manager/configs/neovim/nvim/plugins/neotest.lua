local neotest = require('neotest')

-- neotest-vstest adapter configuration
neotest.setup {
	adapters = {
		require("neotest-vstest")({
			dap_settings = {
				type = "netcoredbg",
			},
		}),
	},
	quickfix = {
		open = function()
			vim.cmd("Trouble quickfix")
		end,
		enabled = true,
	},
}
