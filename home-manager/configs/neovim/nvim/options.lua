vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.o.clipboard = 'unnamedplus'

vim.o.number = true
vim.o.linebreak = true
vim.o.wrap = true
vim.o.swapfile = false

vim.o.signcolumn = 'yes'

vim.o.tabstop = 2
vim.o.shiftwidth = 2

vim.o.updatetime = 50

vim.o.termguicolors = true

-- Enable persistent undo
vim.opt.undofile = true

-- Set the directory where the undo files will be stored
-- Make sure the directory exists
vim.opt.undodir = vim.fn.expand('~/.config/nvim/undodir')

vim.g.db_ui_use_nerd_fonts = 1
vim.g.db_ui_winwidth = 50
vim.g.db_ui_expanded_layout = 1
vim.g.db_up_execute_on_save = 0
vim.g.db_ui_auto_execute_table_helpers = 0

-- Ignore case when completing file names and directories
vim.o.wildignorecase = true

-- Ignore case in search patterns, but become case-sensitive if the pattern contains uppercase letters
vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.pumheight = 10
