require("neotest").setup({
	adapters = {
		require("neotest-dotnet")({
			dap = { justMyCode = false },
			dotnet_additional_args = {
				"--verbosity detailed",
				"--collect:\"XPlat Code Coverage\""
			},
			discovery_root = "solution"
		}),
		require("neotest-playwright").adapter({
			options = {
				enable_dynamic_test_discovery = true,
				get_playwright_binary = function()
					return "playwright" -- use globally installed playwright instance
				end,
			},
		}),
		require("neotest-jest"),
	},
})
