local ros = require('roslyn')

local on_attach = function(_, bufnr)
	-- In this case, we create a function that lets us more easily define mappings specific
	-- for LSP related items. It sets the mode, buffer and description for us each time.
	local nmap = function(keys, func, desc)
		if desc then
			desc = 'LSP: ' .. desc
		end

		vim.keymap.set({ 'n', 'v' }, keys, func, { buffer = bufnr, desc = desc })
	end

	nmap('<leader>cr', vim.lsp.buf.rename, '[R]e[n]ame')
	nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

	nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
	nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
	nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
	nmap('<leader>cD', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
	nmap('<leader>gs', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
	nmap('<leader>gws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
	-- nmap('<leader>lf', vim.lsp.buf.format, '[L]SP [F]ormat')
	nmap('<leader>ci', function()
		vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled {})
	end, 'Toggle inlay hints')

	-- See `:help K` for why this keymap
	nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
	nmap('<leader>K', vim.lsp.buf.signature_help, 'Signature Documentation')

	-- Lesser used LSP functionality
	nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
	nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
	nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
	nmap('<leader>wl', function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, '[W]orkspace [L]ist Folders')

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
		-- '--razorSourceGenerator=' .. vim.fs.joinpath(
		-- 	vim.fn.stdpath 'data' --[[@as string]],
		-- 	'mason',
		-- 	'packages',
		-- 	'roslyn',
		-- 	'libexec',
		-- 	'Microsoft.CodeAnalysis.Razor.Compiler.dll'
		-- ),
		-- '--razorDesignTimePath=' .. vim.fs.joinpath(
		-- 	vim.fn.stdpath 'data' --[[@as string]],
		-- 	'mason',
		-- 	'packages',
		-- 	'rzls',
		-- 	'libexec',
		-- 	'Targets',
		-- 	'Microsoft.NET.Sdk.Razor.DesignTime.targets'
		-- ),
	},
	config = {
		on_attach = on_attach,
		capabilities = capabilities,
		-- handlers = require 'rzls.roslyn_handlers',
		settings = {
			["csharp|inlay_hints"] = {
				csharp_enable_inlay_hints_for_implicit_object_creation = false,
				csharp_enable_inlay_hints_for_implicit_variable_types = false,
				csharp_enable_inlay_hints_for_lambda_parameter_types = true,
				csharp_enable_inlay_hints_for_types = true,
				dotnet_enable_inlay_hints_for_indexer_parameters = true,
				dotnet_enable_inlay_hints_for_literal_parameters = true,
				dotnet_enable_inlay_hints_for_object_creation_parameters = true,
				dotnet_enable_inlay_hints_for_other_parameters = false,
				dotnet_enable_inlay_hints_for_parameters = true,
				dotnet_suppress_inlay_hints_for_parameters_that_differ_only_by_suffix = true,
				dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = true,
				dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent = true,
			},
			["csharp|code_lens"] = {
				dotnet_enable_references_code_lens = true,
			},
		}
	},
	filewatching = true,
	broad_search = true,
	lock_target = true,
	choose_sln = nil,
}
