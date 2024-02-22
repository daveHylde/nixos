vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<C-s>", ':w<ENTER>')

-- telescope
local builtin_telescope = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin_telescope.find_files, {})
vim.keymap.set('n', '<C-p>', builtin_telescope.git_files, {})

vim.keymap.set('n', '<leader>pu', builtin_telescope.buffers, {})
vim.keymap.set('n', '<leader>ps', function()
	builtin_telescope.grep_string({ search = vim.fn.input("Grep > ") })
end)

-- tree
local tree_api = require('nvim-tree.api')
vim.keymap.set('n', '<leader>ee', function()
	tree_api.tree.focus({ find_file = true })
end)
vim.keymap.set('n', '<leader>eq', function()
	tree_api.tree.close()
end)

-- toggleterm

-- git
vim.keymap.set('n', '<leader>gg', '<cmd>lua _LAZYGIT_TOGGLE()<cr>', {})

-- test

local test_api = require('neotest')
vim.keymap.set('n', '<leader>tt', function() test_api.summary.toggle() end, {})
vim.keymap.set('n', '<leader>tc', function() test_api.run.run() end, {})
vim.keymap.set('n', '<leader>tf', function() test_api.run.run(vim.fn.expand("%")) end, {})
