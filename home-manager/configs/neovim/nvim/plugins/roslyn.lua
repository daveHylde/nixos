local ros = require('roslyn')

local on_attach = function(_, bufnr)
	-- Create a command `:Format` local to the LSP buffer
	vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
		vim.lsp.buf.format()
	end, { desc = 'Format current buffer with LSP' })
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())
capabilities.textDocument.completion.completionItem.snippetSupport = true

ros.setup {
	args = {
		'--logLevel=Information',
		'--extensionLogDirectory=' .. vim.fs.dirname(vim.lsp.get_log_path()),
	},
	config = {
		on_attach = on_attach,
		capabilities = capabilities,
		settings = {
			["csharp|inlay_hints"] = {
				csharp_enable_inlay_hints_for_implicit_object_creation = false,
				csharp_enable_inlay_hints_for_implicit_variable_types = false,
				csharp_enable_inlay_hints_for_lambda_parameter_types = false,
				csharp_enable_inlay_hints_for_types = false,
				dotnet_enable_inlay_hints_for_indexer_parameters = false,
				dotnet_enable_inlay_hints_for_literal_parameters = true,
				dotnet_enable_inlay_hints_for_object_creation_parameters = true,
				dotnet_enable_inlay_hints_for_other_parameters = false,
				dotnet_enable_inlay_hints_for_parameters = false,
				dotnet_suppress_inlay_hints_for_parameters_that_differ_only_by_suffix = true,
				dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = true,
				dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent = true,
			},
			["csharp|symbol_search"] = {
				dotnet_search_reference_assemblies = true,
			},
			["csharp|code_lens"] = {
				dotnet_enable_references_code_lens = true,
			},
		}
	},
	filewatching = true,
	broad_search = true,
	lock_target = true,
	choose_target = function(target)
		local knowsSlns = { "Ebh.sln", "Jobbi.sln" }
		return vim.iter(target):find(function(item)
			return vim.iter(knowsSlns):any(function(pattern)
				return string.match(item, pattern)
			end)
		end)
	end
}
