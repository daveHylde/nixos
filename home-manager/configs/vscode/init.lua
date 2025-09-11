-- Clear search highlights when pressing Esc in normal mode
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.o.clipboard = 'unnamedplus'

-- Enable persistent undo
vim.opt.undofile = true
-- Set the directory where the undo files will be stored
-- Make sure the directory exists
vim.opt.undodir = vim.fn.expand('~/.vscode/undodir')
vim.o.termguicolors = true
-- Ignore case when completing file names and directories
vim.o.wildignorecase = true
-- Ignore case in search patterns, but become case-sensitive if the pattern contains uppercase letters
vim.o.ignorecase = true
vim.o.smartcase = true

vim.keymap.set('n', '<Esc>', ':nohlsearch<CR><Esc>', { noremap = true, silent = true })

vim.keymap.set({ "n", "x" }, "<leader>sw", function()
  require('vscode').action('workbench.action.findInFiles', { args = { query = vim.fn.expand('<cword>') } })
end, { noremap = true, silent = true })