vim.api.nvim_create_augroup('bufcheck', { clear = true })

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		require("conform").format({ bufnr = args.buf })
	end,
})

-- highlight yanks
vim.api.nvim_create_autocmd('TextYankPost', {
	group    = 'bufcheck',
	pattern  = '*',
	callback = function() vim.highlight.on_yank { timeout = 500 } end
})

vim.api.nvim_create_autocmd("FileType", {
	group    = 'bufcheck',
	pattern  = { "sql", "mysql", "plsql" },
	callback = function()
		require("cmp").setup.buffer({
			sources = {
				{ name = "vim-dadbod-completion" },
			},
		})
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	group    = 'bufcheck',
	pattern  = { "typescript", "html", "angular", "angularhtml" },
	callback = function()
		vim.b.matchup_matchparen_enabled = 1
		vim.g.matchup_matchparen_offscreen = { method = "popup" }
	end,
})
