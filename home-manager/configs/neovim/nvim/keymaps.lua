local map = vim.keymap.set

-- generic
map({ "n", "v" }, "<c-s>", ":wa<cr>", { desc = "Save all" })
map({ "n", "v" }, "<a-down>", ":m '>+1<CR>gv=gv", { desc = "Move down" })
map({ "n", "v" }, "<a-up>", ":m '<-2<CR>gv=gv", { desc = "Move up" })
map({ "n", "v" }, "<leader>sh", ":noh<cr>", { desc = "Clear Highlight" })
map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })
map('v', '>', '>gv', { noremap = true, silent = true, desc = "Indent" })
map('v', '<', '<gv', { noremap = true, silent = true, desc = "Indent" })

-- Git
map({ "n", "v" }, "<leader>gg", "<cmd>LazyGit<cr>", { desc = "LazyGit" })
map({ "n", "v" }, "<leader>gp", "<cmd>Gitsigns preview_hunk_inline<cr>", { desc = "View hunk change" })
map({ "n", "v" }, "<leader>gr", "<cmd>Gitsigns reset_hunk<cr>", { desc = "Reset hunk" })
map({ "n", "v" }, "<leader>gb", "<cmd>Gitsigns blame_line<cr>", { desc = "Blame line" })

-- buffer
map({ "n", "v" }, "<leader>bd", ":bd<cr>", { desc = "Delete buffer" })
map({ "n", "v" }, "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", { desc = "Toggle Pin" })
map({ "n", "v" }, "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", { desc = "Delete Non-Pinned Buffers" })
map({ "n", "v" }, "<leader>bo", "<Cmd>BufferLineCloseOthers<CR>", { desc = "Delete Other Buffers" })
map({ "n", "v" }, "<leader>br", "<Cmd>BufferLineCloseRight<CR>", { desc = "Delete Buffers to the Right" })
map({ "n", "v" }, "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", { desc = "Delete Buffers to the Left" })
map({ "n", "v" }, "<S-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev Buffer" })
map({ "n", "v" }, "<S-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next Buffer" })
map({ "n", "v" }, "[b", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev Buffer" })
map({ "n", "v" }, "]b", "<cmd>BufferLineCycleNext<cr>", { desc = "Next Buffer" })
map({ "n", "v" }, "[B", "<cmd>BufferLineMovePrev<cr>", { desc = "Move buffer prev" })
map({ "n", "v" }, "]B", "<cmd>BufferLineMoveNext<cr>", { desc = "Move buffer next" })

-- window
map("n", "<leader>ww", "<C-W>p", { desc = "Other Window", remap = true })
map("n", "<leader>wd", "<C-W>c", { desc = "Delete Window", remap = true })
map("n", "<leader>w-", "<C-W>s", { desc = "Split Window Below", remap = true })
map("n", "<leader>w|", "<C-W>v", { desc = "Split Window Right", remap = true })
map("n", "<leader>-", "<C-W>s", { desc = "Split Window Below", remap = true })
map("n", "<leader>|", "<C-W>v", { desc = "Split Window Right", remap = true })

-- Telescope
map("n", "<leader><space>", "<cmd>Telescope find_files<cr>", { desc = "Find Files" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Live Grep" })
map("n", "<leader>fm", "<cmd>Telescope media_files<cr>", { desc = "Media Files" })
map("n", "<leader>fq", "<cmd>Telescope quickfix<cr>", { desc = "Quickfix" })
map('n', '<leader>fw', function() require('telescope.builtin').grep_string({ search = vim.fn.expand("<cword>") }) end,
	{ noremap = true, silent = true, desc = "Grep current word" })

-- Neotree
map({ "n", "v" }, "<leader>e", "<cmd>Neotree toggle<cr>", { desc = "Toggle Neotree" })

-- Move to window using the <alt> yneo keys
map("n", "<c-Left>", ":TmuxNavigateLeft<CR>", { desc = "Go to Left Window", silent = true, remap = true })
map("n", "<c-Down>", ":TmuxNavigateDown<CR>", { desc = "Go to Lower Window", silent = true, remap = true })
map("n", "<c-Up>", ":TmuxNavigateUp<CR>", { desc = "Go to Upper Window", silent = true, remap = true })
map("n", "<c-Right>", ":TmuxNavigateRight<CR>", { desc = "Go to Right Window", silent = true, remap = true })
map(
	"n",
	"<c-p>",
	":TmuxNavigatePrevious<CR>",
	{ desc = "Go to Previous Window", silent = true, remap = true }
)

-- Format
map("n", "<leader>cf", function() vim.lsp.buf.format() end, { desc = "Format" })

-- Diagnostics
local diagnostic_goto = function(next, severity)
	local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
	severity = severity and vim.diagnostic.severity[severity] or nil
	return function()
		go({ severity = severity })
	end
end
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
map("n", "[d", diagnostic_goto(true), { desc = "Next Diagnostic" })
map("n", "]d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
map("n", "[e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
map("n", "]e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
map("n", "[w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
map("n", "]w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })

-- DAP
vim.keymap.set("n", "<leader>dEs", function()
	require("dap").set_exception_breakpoints()
end, { desc = "Stop on exceptions" })
vim.keymap.set("n", "<leader>dEc", function()
	require("dap").set_exception_breakpoints({})
end, { desc = "Don't stop on exceptions" })
vim.keymap.set("n", "<leader>dx", function()
	require("dap").clear_breakpoints()
end, { desc = "Clear all breakpoints" })
vim.keymap.set("n", "<F5>", function()
	require("dap").continue()
end, { desc = "Continue" })
vim.keymap.set("n", "<F10>", function()
	require("dap").step_into()
end, { desc = "Step Into" })
vim.keymap.set("n", "<F11>", function()
	require("dap").step_out()
end, { desc = "Step Out" })
vim.keymap.set("n", "<F12>", function()
	require("dap").step_over()
end, { desc = "Step Over" })

-- nx
vim.keymap.set("n", "<leader>nx", "<cmd>Telescope nx actions<CR>", {})
vim.keymap.set("n", "<leader>ng", "<cmd>Telescope nx generators<CR>", {})
vim.keymap.set("n", "<leader>nm", "<cmd>Telescope nx run_many<CR>", {})
vim.keymap.set("n", "<leader>na", "<cmd>Telescope nx affected<CR>", {})

-- Resize window using <alt> arrow keys
vim.keymap.set("n", "<M-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
vim.keymap.set("n", "<M-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
vim.keymap.set("n", "<M-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
vim.keymap.set("n", "<M-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- Neotest
map("n", "<leader>t", "", { desc = "+test" })
map("n", "<leader>tt", function() require("neotest").run.run(vim.fn.expand("%")) end, { desc = "Run File" })
map("n", "<leader>tT", function() require("neotest").run.run(vim.uv.cwd()) end, { desc = "Run All Test Files" })
map("n", "<leader>tr", function() require("neotest").run.run() end, { desc = "Run Nearest" })
map("n", "<leader>tl", function() require("neotest").run.run_last() end, { desc = "Run Last" })
map("n", "<leader>ts", function() require("neotest").summary.toggle() end, { desc = "Toggle Summary" })
map("n", "<leader>to", function() require("neotest").output.open({ enter = true, auto_close = true }) end,
	{ desc = "Show Output" })
map("n", "<leader>tO", function() require("neotest").output_panel.toggle() end, { desc = "Toggle Output Panel" })
map("n", "<leader>tS", function() require("neotest").run.stop() end, { desc = "Stop" })
map("n", "<leader>tw", function() require("neotest").watch.toggle(vim.fn.expand("%")) end, { desc = "Toggle Watch" })
