local neotest = require('neotest')

neotest.setup {
	adapters = {
		require("neotest-dotnet")({
			dap = {
				justMyCode = false,
				adapter_name = "netcoredbg",
			},
			discovery_root = "solution",
		}),
	}
}
