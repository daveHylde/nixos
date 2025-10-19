require("dap.ext.vscode").load_launchjs(nil, { netcoredbg = { "cs", "sln" } })

require("dap").adapters["netcoredbg"] = {
	type = "executable",
	command = "/etc/profiles/per-user/david/bin/netcoredbg",
	args = { "--interpreter=vscode" },
}
require("easy-dotnet.netcoredbg").register_dap_variables_viewer() -- special variables viewer specific for .NET

