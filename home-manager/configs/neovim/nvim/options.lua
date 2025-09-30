vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.o.clipboard = 'unnamedplus'

-- vim.cmd.colorscheme "onenord-light"
vim.o.termguicolors = true
vim.o.background = "dark"

-- Enable persistent undo
vim.opt.undofile = true
-- Set the directory where the undo files will be stored
-- Make sure the directory exists
vim.opt.undodir = vim.fn.expand('~/.config/nvim/undodir')
-- Ignore case when completing file names and directories
vim.o.wildignorecase = true
-- Ignore case in search patterns, but become case-sensitive if the pattern contains uppercase letters
vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.number = true
vim.o.linebreak = true
vim.o.wrap = false
vim.o.swapfile = false

vim.o.signcolumn = 'yes'

vim.o.tabstop = 2
vim.o.shiftwidth = 2

vim.o.updatetime = 50
vim.o.guifont = "JetBrainsMono Nerd Font"

vim.g.db_ui_use_nerd_fonts = 1
vim.g.db_ui_winwidth = 50
vim.g.db_ui_execute_on_save = 0
vim.g.db_ui_auto_execute_table_helpers = 1
vim.g.db_ui_expanded_layout = 1

vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
vim.o.foldlevel = 99

vim.o.pumheight = 10

vim.lsp.inlay_hint.enable();

vim.filetype.add {
	extension = {
		razor = 'razor',
		cshtml = 'razor',
	},
}
