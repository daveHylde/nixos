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
		require('neotest-playwright').adapter({
			options = {
				persist_project_selection = true,
				enable_dynamic_test_discovery = true,
			},
		}),
	}
}
