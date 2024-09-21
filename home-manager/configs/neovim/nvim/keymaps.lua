local map = vim.keymap.set

-- generic
map({ "n", "v" }, "<c-s>", ":w<cr>", { desc = "Save" })
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and Clear hlsearch" })
map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })
map('v', '>', '>gv', { noremap = true, silent = true, desc = "Indent" })
map('v', '<', '<gv', { noremap = true, silent = true, desc = "Indent" })
map('x', 'p', '"_dP', { noremap = true })

-- Move lines
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move Down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move Up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move Down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move Up" })

-- Git
map({ "n", "v" }, "<leader>gg", "<cmd>LazyGit<cr>", { desc = "LazyGit" })
map({ "n", "v" }, "<leader>gp", "<cmd>Gitsigns preview_hunk_inline<cr>", { desc = "View hunk change" })
map({ "n", "v" }, "<leader>gr", "<cmd>Gitsigns reset_hunk<cr>", { desc = "Reset hunk" })
map({ "n", "v" }, "<leader>gb", "<cmd>Gitsigns blame_line<cr>", { desc = "Blame line" })
map({ "n", "v" }, "<leader>gB", "<cmd>Gitsigns blame<cr>", { desc = "Blame file" })
map({ "n", "v" }, "<leader>gf", function() require("telescope").extensions.git_file_history.git_file_history() end,
	{ desc = "File History" })

-- buffer
map({ "n", "v" }, "<leader>bd", ":bd!<cr>", { desc = "Delete buffer" })
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
map("n", "<leader>fg", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>",
	{ desc = "Live Grep Args" })
map("n", "<leader>fm", "<cmd>Telescope media_files<cr>", { desc = "Media Files" })
map("n", "<leader>fq", "<cmd>Telescope quickfix<cr>", { desc = "Quickfix" })
map("n", "<leader>fc", "<cmd>Telescope resume<cr>", { desc = "Resume" })
map("n", "<leader>fc", "<cmd>Telescope resume<cr>", { desc = "Resume" })
map('n', '<leader>fw', function() require('telescope.builtin').grep_string({ search = vim.fn.expand("<cword>") }) end,
	{ noremap = true, silent = true, desc = "Grep current word" })
-- nx
map("n", "<leader>nx", "<cmd>Telescope nx actions<CR>", {})
map("n", "<leader>ng", "<cmd>Telescope nx generators<CR>", {})
map("n", "<leader>nm", "<cmd>Telescope nx run_many<CR>", {})
map("n", "<leader>na", "<cmd>Telescope nx affected<CR>", {})

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


-- Resize window using <alt> arrow keys
map("n", "<M-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
map("n", "<M-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
map("n", "<M-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
map("n", "<M-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- Neotest
local neotest = require("neotest")
map("n", "<leader>t", "", { desc = "+test" })
map("n", "<leader>tt", function() neotest.run.run(vim.fn.expand("%")) end, { desc = "Run File" })
map("n", "<leader>td", function() neotest.run.run({ strategy = "dap" }) end, { desc = "Debug Nearest" })
map("n", "<leader>tT", function() neotest.run.run(vim.uv.cwd()) end, { desc = "Run All Test Files" })
map("n", "<leader>tr", function() neotest.run.run() end, { desc = "Run Nearest" })
map("n", "<leader>tl", function() neotest.run.run_last() end, { desc = "Run Last" })
map("n", "<leader>ts", function() neotest.summary.toggle() end, { desc = "Toggle Summary" })
map("n", "<leader>to", function() neotest.output.open({ enter = true, auto_close = true }) end, { desc = "Show Output" })
map("n", "<leader>tO", function() neotest.output_panel.toggle() end, { desc = "Toggle Output Panel" })
map("n", "<leader>tS", function() neotest.run.stop() end, { desc = "Stop" })
map("n", "<leader>tw", function() neotest.watch.toggle(vim.fn.expand("%")) end, { desc = "Toggle Watch" })

-- Dap
local dap = require("dap")
local dapui = require("dapui")
map({ "n", "v" }, "<leader>d", "", { desc = "+debug" })
map({ "n", "v" }, "<leader>dB", function() dap.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end,
	{ desc = "Breakpoint Condition" })
map({ "n", "v" }, "<leader>db", function() dap.toggle_breakpoint() end, { desc = "Toggle Breakpoint" })
map({ "n", "v" }, "<leader>dl", function() dap.run_last() end, { desc = "Run Last" })
map({ "n", "v" }, "<leader>dr", function() dap.repl.toggle() end, { desc = "Toggle REPL" })
map({ "n", "v" }, "<leader>ds", function() dap.session() end, { desc = "Session" })
map({ "n", "v" }, "<leader>dt", function() dap.terminate() end, { desc = "Terminate" })
map({ "n", "v" }, "<leader>dw", function() require("dap.ui.widgets").hover() end, { desc = "Widgets" })
map({ "n", "v" }, "<leader>du", function() dapui.toggle({}) end, { desc = "Dap UI" })
map({ "n", "v" }, "<leader>de", function() dapui.eval() end, { desc = "Eval" })
map({ "n", "v" }, "<leader>dEs", function() dap.set_exception_breakpoints() end, { desc = "Stop on exceptions" })
map({ "n", "v" }, "<leader>dEc", function() dap.set_exception_breakpoints({}) end, { desc = "Don't stop on exceptions" })
map({ "n", "v" }, "<leader>dx", function() dap.clear_breakpoints() end, { desc = "Clear all breakpoints" })
map({ "n", "v" }, "<F5>", function() dap.continue() end, { desc = "Continue" })
map({ "n", "v" }, "<F10>", function() dap.step_into() end, { desc = "Step Into" })
map({ "n", "v" }, "<F11>", function() dap.step_out() end, { desc = "Step Out" })
map({ "n", "v" }, "<F12>", function() dap.step_over() end, { desc = "Step Over" })

-- Undotree
map('n', '<leader>uu', vim.cmd.UndotreeToggle, { desc = "Toggle undotree" })

-- Dadbod
map("n", "<leader>kk", "<cmd>DBUIToggle<cr>", { noremap = true, silent = true, desc = "Toggle DB UI" })

-- Trouble
map("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)" })
map("n", "leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Buffer Diagnostics (Trouble)", })
map("n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Buffer Diagnostics (Trouble)" })
map("n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Buffer Diagnostics (Trouble)" })
map("n", "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", { desc = "Symbols (Trouble)" })
map("n", "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
	{ desc = "LSP Definitions / references / ... (Trouble)" })
map("n", "<leader>xL", "<cmd>Trouble loclist toggle<cr>", { desc = "Location List (Trouble)" })
map("n", "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", { desc = "Quickfix List (Trouble)" })
