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
--    require("neotest-playright"),
    require("neotest-jest"),
  }
})
