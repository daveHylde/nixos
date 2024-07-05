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

-- Create the directory if it doesn't exist
if vim.fn.isdirectory(vim.opt.undodir) == 0 then
  vim.fn.mkdir(vim.opt.undodir, 'p')
end
