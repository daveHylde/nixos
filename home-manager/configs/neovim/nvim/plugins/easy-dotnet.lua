 local function get_secret_path(secret_guid)
      local path = ""
      local home_dir = vim.fn.expand('~')
			local secret_path = home_dir .. "/.microsoft/usersecrets/" .. secret_guid .. "/secrets.json"
			path = secret_path
      return path
    end

local dotnet = require("easy-dotnet")
-- Options are not required
dotnet.setup({
	debugger = {
		bin_path = "/etc/profiles/per-user/david/bin/netcoredbg",
		auto_register_dap = true,
	},
	test_runner = {
		viewmode = "float",
		noBuild = false,
		mappings = {
			run_test_from_buffer = { lhs = "<leader>r", desc = "run test from buffer" },
			peek_stack_trace_from_buffer = { lhs = "<leader>p", desc = "peek stack trace from buffer" },
			filter_failed_tests = { lhs = "<leader>fe", desc = "filter failed tests" },
			debug_test = { lhs = "<leader>d", desc = "debug test" },
			go_to_file = { lhs = "g", desc = "go to file" },
			run_all = { lhs = "<leader>R", desc = "run all tests" },
			run = { lhs = "<leader>r", desc = "run test" },
			peek_stacktrace = { lhs = "<leader>p", desc = "peek stacktrace of failed test" },
			expand = { lhs = "o", desc = "expand" },
			expand_node = { lhs = "E", desc = "expand node" },
			expand_all = { lhs = "-", desc = "expand all" },
			collapse_all = { lhs = "W", desc = "collapse all" },
			close = { lhs = "q", desc = "close testrunner" },
			refresh_testrunner = { lhs = "<C-r>", desc = "refresh testrunner" }
		},
	},
	secrets = {
		path = get_secret_path
	},
	csproj_mappings = true,
	fsproj_mappings = true,
	auto_bootstrap_namespace = {
			--block_scoped, file_scoped
			type = "block_scoped",
			enabled = true,
			use_clipboard_json = {
				behavior = "prompt", --'auto' | 'prompt' | 'never',
				register = "+", -- which register to check
			},
	},
	server = {
			log_level = "Error",
	},
	picker = "snacks",
	background_scanning = true,
	notifications = {
		--Set this to false if you have configured lualine to avoid double logging
		handler = function(start_event)
			local spinner = require("easy-dotnet.ui-modules.spinner").new()
			spinner:start_spinner(start_event.job.name)
			return function(finished_event)
				spinner:stop_spinner(finished_event.result.msg, finished_event.result.level)
			end
		end,
	},
	diagnostics = {
		default_severity = "error",
		setqflist = false,
	},
})
