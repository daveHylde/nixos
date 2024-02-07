vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<C-s>", ':w<ENTER>')

-- telescope
local builtin_telescope = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin_telescope.find_files, {})
vim.keymap.set('n', '<C-p>', builtin_telescope.git_files, {})
vim.keymap.set('n', '<leader>ps', function()
	builtin_telescope.grep_string({ search = vim.fn.input("Grep > ") })
end)

-- tree
local tree_api = require('nvim-tree.api')
vim.keymap.set('n', '<leader>e', function() 
	tree_api.tree.focus({ find_file = true })
end)
vim.keymap.set('n', '<leader>te', function() 
	tree_api.tree.close()
end)

-- toggleterm

-- git
vim.keymap.set('n', '<leader>gg', '<cmd>lua _LAZYGIT_TOGGLE()<cr>', {})

