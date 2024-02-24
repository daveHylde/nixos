vim.cmd('colorscheme flexoki-dark')

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.o.number = true
vim.o.relativenumber = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8

vim.opt.updatetime = 50

-- Define the autocmd for angular html files
--vim.cmd[[
--    augroup AngularFileType
--        autocmd!
--        autocmd BufRead,BufEnter *.component.html set filetype=angular
--    augroup END
--]]

vim.opt.clipboard="unnamed,unnamedplus"
