require("dap.ext.vscode").load_launchjs(nil, { netcoredbg = { "cs", "sln" } })

require("dap").adapters["netcoredbg"] = {
	type = "executable",
	command = "netcoredbg",
	args = { "--interpreter=vscode" },
}
