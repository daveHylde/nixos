local map = vim.keymap.set

-- generic
map({ "n", "v" }, "<c-s>", ":w<cr>", { desc = "Save" })
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and Clear hlsearch" })
map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })
map('v', '>', '>gv', { noremap = true, silent = true, desc = "Indent" })
map('v', '<', '<gv', { noremap = true, silent = true, desc = "Indent" })

-- Send all delete and change operations to the black hole register
map({ 'n', 'v' }, 'd', '"_d', { noremap = true })
map({ 'n', 'v' }, 'D', '"_D', { noremap = true })
map({ 'n', 'v' }, 'c', '"_c', { noremap = true })
map('n', 'C', '"_C', { noremap = true })
map('n', 'x', '"_x', { noremap = true })
map('n', 'X', '"_X', { noremap = true })
-- Preserve the yank operation
map({ 'n', 'v' }, 'y', 'y', { noremap = true })
map('n', 'Y', 'Y', { noremap = true })
-- Override paste in visual mode to not capture overwritten text
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


-- GP
local function keymapOptions(desc)
	return {
		noremap = true,
		silent = true,
		nowait = true,
		desc = "GPT prompt " .. desc,
	}
end

-- Chat commands
vim.keymap.set({ "n", "i" }, "<leader>ac", "<cmd>GpChatNew<cr>", keymapOptions("New Chat"))
vim.keymap.set({ "n", "i" }, "<leader>at", "<cmd>GpChatToggle<cr>", keymapOptions("Toggle Chat"))
vim.keymap.set({ "n", "i" }, "<leader>af", "<cmd>GpChatFinder<cr>", keymapOptions("Chat Finder"))

vim.keymap.set("v", "<leader>ac", ":<C-u>'<,'>GpChatNew<cr>", keymapOptions("Visual Chat New"))
vim.keymap.set("v", "<leader>ap", ":<C-u>'<,'>GpChatPaste<cr>", keymapOptions("Visual Chat Paste"))
vim.keymap.set("v", "<leader>at", ":<C-u>'<,'>GpChatToggle<cr>", keymapOptions("Visual Toggle Chat"))

vim.keymap.set({ "n", "i" }, "<leader>a<C-x>", "<cmd>GpChatNew split<cr>", keymapOptions("New Chat split"))
vim.keymap.set({ "n", "i" }, "<leader>a<C-v>", "<cmd>GpChatNew vsplit<cr>", keymapOptions("New Chat vsplit"))
vim.keymap.set({ "n", "i" }, "<leader>a<C-t>", "<cmd>GpChatNew tabnew<cr>", keymapOptions("New Chat tabnew"))

vim.keymap.set("v", "<leader>a<C-x>", ":<C-u>'<,'>GpChatNew split<cr>", keymapOptions("Visual Chat New split"))
vim.keymap.set("v", "<leader>a<C-v>", ":<C-u>'<,'>GpChatNew vsplit<cr>", keymapOptions("Visual Chat New vsplit"))
vim.keymap.set("v", "<leader>a<C-t>", ":<C-u>'<,'>GpChatNew tabnew<cr>", keymapOptions("Visual Chat New tabnew"))

-- Prompt commands
vim.keymap.set({ "n", "i" }, "<leader>ar", "<cmd>GpRewrite<cr>", keymapOptions("Inline Rewrite"))
vim.keymap.set({ "n", "i" }, "<leader>aa", "<cmd>GpAppend<cr>", keymapOptions("Append (after)"))
vim.keymap.set({ "n", "i" }, "<leader>ab", "<cmd>GpPrepend<cr>", keymapOptions("Prepend (before)"))

vim.keymap.set("v", "<leader>ar", ":<C-u>'<,'>GpRewrite<cr>", keymapOptions("Visual Rewrite"))
vim.keymap.set("v", "<leader>aa", ":<C-u>'<,'>GpAppend<cr>", keymapOptions("Visual Append (after)"))
vim.keymap.set("v", "<leader>ab", ":<C-u>'<,'>GpPrepend<cr>", keymapOptions("Visual Prepend (before)"))
vim.keymap.set("v", "<leader>ai", ":<C-u>'<,'>GpImplement<cr>", keymapOptions("Implement selection"))

vim.keymap.set({ "n", "i" }, "<leader>agp", "<cmd>GpPopup<cr>", keymapOptions("Popup"))
vim.keymap.set({ "n", "i" }, "<leader>age", "<cmd>GpEnew<cr>", keymapOptions("GpEnew"))
vim.keymap.set({ "n", "i" }, "<leader>agn", "<cmd>GpNew<cr>", keymapOptions("GpNew"))
vim.keymap.set({ "n", "i" }, "<leader>agv", "<cmd>GpVnew<cr>", keymapOptions("GpVnew"))
vim.keymap.set({ "n", "i" }, "<leader>agt", "<cmd>GpTabnew<cr>", keymapOptions("GpTabnew"))

vim.keymap.set("v", "<leader>agp", ":<C-u>'<,'>GpPopup<cr>", keymapOptions("Visual Popup"))
vim.keymap.set("v", "<leader>age", ":<C-u>'<,'>GpEnew<cr>", keymapOptions("Visual GpEnew"))
vim.keymap.set("v", "<leader>agn", ":<C-u>'<,'>GpNew<cr>", keymapOptions("Visual GpNew"))
vim.keymap.set("v", "<leader>agv", ":<C-u>'<,'>GpVnew<cr>", keymapOptions("Visual GpVnew"))
vim.keymap.set("v", "<leader>agt", ":<C-u>'<,'>GpTabnew<cr>", keymapOptions("Visual GpTabnew"))

vim.keymap.set({ "n", "i" }, "<leader>ax", "<cmd>GpContext<cr>", keymapOptions("Toggle Context"))
vim.keymap.set("v", "<leader>ax", ":<C-u>'<,'>GpContext<cr>", keymapOptions("Visual Toggle Context"))

vim.keymap.set({ "n", "i", "v", "x" }, "<leader>as", "<cmd>GpStop<cr>", keymapOptions("Stop"))
vim.keymap.set({ "n", "i", "v", "x" }, "<leader>an", "<cmd>GpNextAgent<cr>", keymapOptions("Next Agent"))

-- optional Whisper commands with prefix <leader>aw
vim.keymap.set({ "n", "i" }, "<leader>aww", "<cmd>GpWhisper<cr>", keymapOptions("Whisper"))
vim.keymap.set("v", "<leader>aww", ":<C-u>'<,'>GpWhisper<cr>", keymapOptions("Visual Whisper"))

vim.keymap.set({ "n", "i" }, "<leader>awr", "<cmd>GpWhisperRewrite<cr>", keymapOptions("Whisper Inline Rewrite"))
vim.keymap.set({ "n", "i" }, "<leader>awa", "<cmd>GpWhisperAppend<cr>", keymapOptions("Whisper Append (after)"))
vim.keymap.set({ "n", "i" }, "<leader>awb", "<cmd>GpWhisperPrepend<cr>", keymapOptions("Whisper Prepend (before) "))

vim.keymap.set("v", "<leader>awr", ":<C-u>'<,'>GpWhisperRewrite<cr>", keymapOptions("Visual Whisper Rewrite"))
vim.keymap.set("v", "<leader>awa", ":<C-u>'<,'>GpWhisperAppend<cr>", keymapOptions("Visual Whisper Append (after)"))
vim.keymap.set("v", "<leader>awb", ":<C-u>'<,'>GpWhisperPrepend<cr>", keymapOptions("Visual Whisper Prepend (before)"))

vim.keymap.set({ "n", "i" }, "<leader>awp", "<cmd>GpWhisperPopup<cr>", keymapOptions("Whisper Popup"))
vim.keymap.set({ "n", "i" }, "<leader>awe", "<cmd>GpWhisperEnew<cr>", keymapOptions("Whisper Enew"))
vim.keymap.set({ "n", "i" }, "<leader>awn", "<cmd>GpWhisperNew<cr>", keymapOptions("Whisper New"))
vim.keymap.set({ "n", "i" }, "<leader>awv", "<cmd>GpWhisperVnew<cr>", keymapOptions("Whisper Vnew"))
vim.keymap.set({ "n", "i" }, "<leader>awt", "<cmd>GpWhisperTabnew<cr>", keymapOptions("Whisper Tabnew"))

vim.keymap.set("v", "<leader>awp", ":<C-u>'<,'>GpWhisperPopup<cr>", keymapOptions("Visual Whisper Popup"))
vim.keymap.set("v", "<leader>awe", ":<C-u>'<,'>GpWhisperEnew<cr>", keymapOptions("Visual Whisper Enew"))
vim.keymap.set("v", "<leader>awn", ":<C-u>'<,'>GpWhisperNew<cr>", keymapOptions("Visual Whisper New"))
vim.keymap.set("v", "<leader>awv", ":<C-u>'<,'>GpWhisperVnew<cr>", keymapOptions("Visual Whisper Vnew"))
vim.keymap.set("v", "<leader>awt", ":<C-u>'<,'>GpWhisperTabnew<cr>", keymapOptions("Visual Whisper Tabnew"))
map({ "n", "i" }, "<leader>ac", "<cmd>GpChatNew<cr>", keymapOptions("New Chat"))
map({ "n", "i" }, "<leader>at", "<cmd>GpChatToggle<cr>", keymapOptions("Toggle Chat"))
map({ "n", "i" }, "<leader>af", "<cmd>GpChatFinder<cr>", keymapOptions("Chat Finder"))

map("v", "<leader>ac", ":<C-u>'<,'>GpChatNew<cr>", keymapOptions("Visual Chat New"))
map("v", "<leader>ap", ":<C-u>'<,'>GpChatPaste<cr>", keymapOptions("Visual Chat Paste"))
map("v", "<leader>at", ":<C-u>'<,'>GpChatToggle<cr>", keymapOptions("Visual Toggle Chat"))

map({ "n", "i" }, "<leader>a<C-x>", "<cmd>GpChatNew split<cr>", keymapOptions("New Chat split"))
map({ "n", "i" }, "<leader>a<C-v>", "<cmd>GpChatNew vsplit<cr>", keymapOptions("New Chat vsplit"))
map({ "n", "i" }, "<leader>a<C-t>", "<cmd>GpChatNew tabnew<cr>", keymapOptions("New Chat tabnew"))

map("v", "<leader>a<C-x>", ":<C-u>'<,'>GpChatNew split<cr>", keymapOptions("Visual Chat New split"))
map("v", "<leader>a<C-v>", ":<C-u>'<,'>GpChatNew vsplit<cr>", keymapOptions("Visual Chat New vsplit"))
map("v", "<leader>a<C-t>", ":<C-u>'<,'>GpChatNew tabnew<cr>", keymapOptions("Visual Chat New tabnew"))

-- Prompt commands
map({ "n", "i" }, "<leader>ar", "<cmd>GpRewrite<cr>", keymapOptions("Inline Rewrite"))
map({ "n", "i" }, "<leader>aa", "<cmd>GpAppend<cr>", keymapOptions("Append (after)"))
map({ "n", "i" }, "<leader>ab", "<cmd>GpPrepend<cr>", keymapOptions("Prepend (before)"))

map("v", "<leader>ar", ":<C-u>'<,'>GpRewrite<cr>", keymapOptions("Visual Rewrite"))
map("v", "<leader>aa", ":<C-u>'<,'>GpAppend<cr>", keymapOptions("Visual Append (after)"))
map("v", "<leader>ab", ":<C-u>'<,'>GpPrepend<cr>", keymapOptions("Visual Prepend (before)"))
map("v", "<leader>ai", ":<C-u>'<,'>GpImplement<cr>", keymapOptions("Implement selection"))

map({ "n", "i" }, "<leader>agp", "<cmd>GpPopup<cr>", keymapOptions("Popup"))
map({ "n", "i" }, "<leader>age", "<cmd>GpEnew<cr>", keymapOptions("GpEnew"))
map({ "n", "i" }, "<leader>agn", "<cmd>GpNew<cr>", keymapOptions("GpNew"))
map({ "n", "i" }, "<leader>agv", "<cmd>GpVnew<cr>", keymapOptions("GpVnew"))
map({ "n", "i" }, "<leader>agt", "<cmd>GpTabnew<cr>", keymapOptions("GpTabnew"))

map("v", "<leader>agp", ":<C-u>'<,'>GpPopup<cr>", keymapOptions("Visual Popup"))
map("v", "<leader>age", ":<C-u>'<,'>GpEnew<cr>", keymapOptions("Visual GpEnew"))
map("v", "<leader>agn", ":<C-u>'<,'>GpNew<cr>", keymapOptions("Visual GpNew"))
map("v", "<leader>agv", ":<C-u>'<,'>GpVnew<cr>", keymapOptions("Visual GpVnew"))
map("v", "<leader>agt", ":<C-u>'<,'>GpTabnew<cr>", keymapOptions("Visual GpTabnew"))

map({ "n", "i" }, "<leader>ax", "<cmd>GpContext<cr>", keymapOptions("Toggle Context"))
map("v", "<leader>ax", ":<C-u>'<,'>GpContext<cr>", keymapOptions("Visual Toggle Context"))

map({ "n", "i", "v", "x" }, "<leader>as", "<cmd>GpStop<cr>", keymapOptions("Stop"))
map({ "n", "i", "v", "x" }, "<leader>an", "<cmd>GpNextAgent<cr>", keymapOptions("Next Agent"))

-- optional Whisper commands with prefix <leader>aw
map({ "n", "i" }, "<leader>aww", "<cmd>GpWhisper<cr>", keymapOptions("Whisper"))
map("v", "<leader>aww", ":<C-u>'<,'>GpWhisper<cr>", keymapOptions("Visual Whisper"))

map({ "n", "i" }, "<leader>awr", "<cmd>GpWhisperRewrite<cr>", keymapOptions("Whisper Inline Rewrite"))
map({ "n", "i" }, "<leader>awa", "<cmd>GpWhisperAppend<cr>", keymapOptions("Whisper Append (after)"))
map({ "n", "i" }, "<leader>awb", "<cmd>GpWhisperPrepend<cr>", keymapOptions("Whisper Prepend (before) "))

map("v", "<leader>awr", ":<C-u>'<,'>GpWhisperRewrite<cr>", keymapOptions("Visual Whisper Rewrite"))
map("v", "<leader>awa", ":<C-u>'<,'>GpWhisperAppend<cr>", keymapOptions("Visual Whisper Append (after)"))
map("v", "<leader>awb", ":<C-u>'<,'>GpWhisperPrepend<cr>", keymapOptions("Visual Whisper Prepend (before)"))

map({ "n", "i" }, "<leader>awp", "<cmd>GpWhisperPopup<cr>", keymapOptions("Whisper Popup"))
map({ "n", "i" }, "<leader>awe", "<cmd>GpWhisperEnew<cr>", keymapOptions("Whisper Enew"))
map({ "n", "i" }, "<leader>awn", "<cmd>GpWhisperNew<cr>", keymapOptions("Whisper New"))
map({ "n", "i" }, "<leader>awv", "<cmd>GpWhisperVnew<cr>", keymapOptions("Whisper Vnew"))
map({ "n", "i" }, "<leader>awt", "<cmd>GpWhisperTabnew<cr>", keymapOptions("Whisper Tabnew"))

map("v", "<leader>awp", ":<C-u>'<,'>GpWhisperPopup<cr>", keymapOptions("Visual Whisper Popup"))
map("v", "<leader>awe", ":<C-u>'<,'>GpWhisperEnew<cr>", keymapOptions("Visual Whisper Enew"))
map("v", "<leader>awn", ":<C-u>'<,'>GpWhisperNew<cr>", keymapOptions("Visual Whisper New"))
map("v", "<leader>awv", ":<C-u>'<,'>GpWhisperVnew<cr>", keymapOptions("Visual Whisper Vnew"))
map("v", "<leader>awt", ":<C-u>'<,'>GpWhisperTabnew<cr>", keymapOptions("Visual Whisper Tabnew"))
