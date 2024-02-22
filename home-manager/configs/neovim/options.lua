vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.o.number = true
-- vim.o.relativenumber = true

-- Define the autocmd
vim.cmd[[
    augroup AngularFileType
        autocmd!
        autocmd BufRead,BufEnter *.component.html set filetype=angular
    augroup END
]]

vim.opt.clipboard="unnamed,unnamedplus"
