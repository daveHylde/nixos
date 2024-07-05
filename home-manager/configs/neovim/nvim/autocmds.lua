vim.api.nvim_create_augroup('bufcheck', { clear = true })

vim.api.nvim_create_autocmd('BufWritePre', {
	group   = 'bufcheck',
	pattern = { '*.tsx', '*.ts', '*.jsx', '*.js' },
	command = 'silent! EslintFixAll',
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
