-- normal mode
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<C-s>", ':w<ENTER>')
vim.keymap.set("n", "<leader>ch", ':noh<ENTER>')
vim.keymap.set("n", "<C-q>", ':bd<ENTER>')

vim.keymap.set('n', '<leader>ve', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>vn', vim.diagnostic.goto_prev)
vim.keymap.set('n', '<leader>vp', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>vl', vim.diagnostic.setloclist)

vim.keymap.set('n', '<M-Right>', '<C-w>w')
vim.keymap.set('n', '<M-Left>', '<C-w>h')

-- visual mode 
vim.keymap.set("v", "<M-Down>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<M-Up>", ":m '<-2<CR>gv=gv")

-- telescope
local telescope = require('telescope.builtin')
vim.keymap.set('n', '<leader>pt', telescope.find_files, {})
vim.keymap.set('n', '<C-p>', telescope.git_files, {})
vim.keymap.set('n', '<leader>pb', telescope.buffers, {})
vim.keymap.set('n', '<leader>ps', function()
	telescope.grep_string({ search = vim.fn.input("Grep > ") })
end)

-- tree
local tree_api = require('nvim-tree.api')
vim.keymap.set('n', '<leader>e', function()
	tree_api.tree.focus({ find_file = true })
end)

-- git
vim.keymap.set('n', '<leader>gs', ':Git<CR>', {})

-- test
local test_api = require('neotest')
vim.keymap.set('n', '<leader>tt', function() test_api.summary.toggle() end, {})
vim.keymap.set('n', '<leader>tc', function() test_api.run.run() end, {})
vim.keymap.set('n', '<leader>tq', function() test_api.run.stop() end, {})
vim.keymap.set('n', '<leader>td', function() test_api.run.run({ strategy = "dap" }) end, {})
vim.keymap.set('n', '<leader>tf', function() test_api.run.run(vim.fn.expand("%")) end, {})
vim.keymap.set('n', '<leader>ta', function() test_api.run.run(vim.fn.getcwd()) end, {})

-- nx
vim.keymap.set('n', '<leader>nr', '<cmd>Telescope nx actions<CR>', {})
vim.keymap.set('n', '<leader>ng', '<cmd>Telescope nx generators<CR>', {})
vim.keymap.set('n', '<leader>nm', '<cmd>Telescope nx run_many<CR>', {})
vim.keymap.set('n', '<leader>na', '<cmd>Telescope nx affected<CR>', {})

-- dap
vim.api.nvim_set_keymap('n', '<F5>', '<Cmd>lua require"dap".continue()<CR>', {silent = true})
vim.api.nvim_set_keymap('n', '<F10>', '<Cmd>lua require"dap".step_over()<CR>', {silent = true})
vim.api.nvim_set_keymap('n', '<F11>', '<Cmd>lua require"dap".step_into()<CR>', {silent = true})
vim.api.nvim_set_keymap('n', '<F12>', '<Cmd>lua require"dap".step_out()<CR>', {silent = true})
vim.api.nvim_set_keymap('n', '<Leader>b', '<Cmd>lua require"dap".toggle_breakpoint()<CR>', {silent = true})
vim.api.nvim_set_keymap('n', '<Leader>B', '<Cmd>lua require"dap".set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>', {silent = true})
vim.api.nvim_set_keymap('n', '<Leader>lp', '<Cmd>lua require"dap".set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>', {silent = true})
vim.api.nvim_set_keymap('n', '<Leader>dr', '<Cmd>lua require"dap".repl.open()<CR>', {silent = true})
vim.api.nvim_set_keymap('n', '<Leader>dl', '<Cmd>lua require"dap".run_last()<CR>', {silent = true})
