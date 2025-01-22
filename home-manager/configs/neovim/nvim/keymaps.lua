local map = vim.keymap.set

-- generic
map({ "n", "v" }, "<c-s>", function() vim.cmd('w') end, { desc = "Save" })
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
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move Down" })
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move Up" })

-- Gitsigns
map({ "n", "v" }, "<leader>gp", "<cmd>Gitsigns preview_hunk_inline<cr>", { desc = "View hunk change" })
map({ "n", "v" }, "<leader>gr", "<cmd>Gitsigns reset_hunk<cr>", { desc = "Reset hunk" })
-- map({ "n", "v" }, "<leader>gb", "<cmd>Gitsigns blame_line<cr>", { desc = "Blame line" })
map({ "n", "v" }, "<leader>gB", "<cmd>Gitsigns blame<cr>", { desc = "Blame file" })

-- DiffView
map({ "n", "v" }, "<leader>gdo", "<cmd>DiffviewOpen<cr>", { desc = "Open Diffview" })
map({ "n", "v" }, "<leader>gdc", "<cmd>DiffviewClose<cr>", { desc = "Toggle Diffview" })
map({ "n", "v" }, "<leader>gde", "<cmd>DiffviewToggleFiles<cr>", { desc = "Toggle Diffview Files" })
map({ "n", "v" }, "<leader>gt", function()
	local diffview = require('diffview.lib').get_current_view()
	if diffview then
		vim.cmd("DiffviewClose")
	else
		vim.cmd("DiffviewOpen")
	end
end, { desc = "Toggle Diffview" })


-- buffer
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
local builtinTele = require('telescope.builtin')
map("n", "<leader><space>", builtinTele.find_files, { desc = "Find Files" })
map("n", "<leader>fg",
	function()
		require('telescope').extensions.live_grep_args.live_grep_args()
	end, { desc = "Live Grep Args" })
map("n", "<leader>fm", "<cmd>Telescope media_files<cr>", { desc = "Media Files" })
map("n", "<leader>fq", "<cmd>Telescope quickfix<cr>", { desc = "Quickfix" })
map("n", "<leader>fc", "<cmd>Telescope resume<cr>", { desc = "Resume" })
map("n", "<leader>fu", "<cmd>AdvancedGitSearch<cr>", { desc = "AdvancedGitSearch" })
map("n", "<leader>fb", builtinTele.buffers, { desc = "Buffers" })
map("n", "<leader>ft", builtinTele.help_tags, { desc = "Help tags" })
map("n", "<leader>/", builtinTele.current_buffer_fuzzy_find, { desc = "Fuzzy current buffer" })
map("n", "<leader>fs", builtinTele.lsp_document_symbols, { desc = "LSP symbols" })
map("n", "<leader>fo", builtinTele.oldfiles, { desc = "Old files" })
map("n", "<leader>fh", "<cmd>Telescope find_files hidden=true no_ignore=true<cr>", { desc = "Find hidden files" })
map('n', '<leader>fw', builtinTele.grep_string, { noremap = true, silent = true, desc = "Grep current word" })
-- nx
map("n", "<leader>nx", "<cmd>Telescope nx actions<CR>", {})
map("n", "<leader>ng", "<cmd>Telescope nx generators<CR>", {})
map("n", "<leader>nm", "<cmd>Telescope nx run_many<CR>", {})
map("n", "<leader>na", "<cmd>Telescope nx affected<CR>", {})

-- Snacks
local snacks = require('snacks')
map({ "n", "v" }, "<leader>mx", snacks.notifier.hide, { desc = "Hide notification" })
map({ "n", "v" }, "<leader>mh", snacks.notifier.show_history, { desc = "Notification history" })
map({ "n", "v" }, "<leader>gg", snacks.lazygit.open, { desc = "Lazygit" })
map({ "n", "v" }, "<leader>gf", snacks.lazygit.log_file, { desc = "Lazygit file history" })
map({ "n", "v" }, "<leader>bd", snacks.bufdelete.delete, { desc = "Delete buffer" })
map({ "n", "v" }, "<leader>bo", snacks.bufdelete.other, { desc = "Delete other buffers" })
map({ "n", "v" }, "<leader>ba", snacks.bufdelete.all, { desc = "Delete all buffers" })
map({ "n", "v" }, "<leader>gb", snacks.git.blame_line, { desc = "Blame line" })

-- Neotree
map({ "n", "v" }, "<leader>e", "<cmd>Neotree toggle<cr>", { desc = "Toggle Neotree" })

-- Move to window using the <alt> yneo keys
map("n", "<c-Left>", function() vim.cmd("TmuxNavigateLeft") end,
	{ desc = "Go to Left Window", silent = true, remap = true })
map("n", "<c-Down>", function() vim.cmd("TmuxNavigateDown") end,
	{ desc = "Go to Lower Window", silent = true, remap = true })
map("n", "<c-Up>", function() vim.cmd("TmuxNavigateUp") end,
	{ desc = "Go to Upper Window", silent = true, remap = true })
map("n", "<c-Right>", function() vim.cmd("TmuxNavigateRight") end,
	{ desc = "Go to Right Window", silent = true, remap = true })
map("n", "<c-p>", function() vim.cmd("TmuxNavigatePrevious") end,
	{ desc = "Go to Previous Window", silent = true, remap = true }
)

-- Format
map("n", "<leader>cf", require("conform").format, { desc = "Format" })

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
map({ "n", "i" }, "<C-g>c", "<cmd>GpChatNew<cr>", keymapOptions("New Chat"))
map({ "n", "i" }, "<C-g>t", "<cmd>GpChatToggle<cr>", keymapOptions("Toggle Chat"))
map({ "n", "i" }, "<C-g>f", "<cmd>GpChatFinder<cr>", keymapOptions("Chat Finder"))

map("v", "<C-g>c", ":<C-u>'<,'>GpChatNew<cr>", keymapOptions("Visual Chat New"))
map("v", "<C-g>p", ":<C-u>'<,'>GpChatPaste<cr>", keymapOptions("Visual Chat Paste"))
map("v", "<C-g>t", ":<C-u>'<,'>GpChatToggle<cr>", keymapOptions("Visual Toggle Chat"))

map({ "n", "i" }, "<C-g><C-x>", "<cmd>GpChatNew split<cr>", keymapOptions("New Chat split"))
map({ "n", "i" }, "<C-g><C-v>", "<cmd>GpChatNew vsplit<cr>", keymapOptions("New Chat vsplit"))
map({ "n", "i" }, "<C-g><C-t>", "<cmd>GpChatNew tabnew<cr>", keymapOptions("New Chat tabnew"))

map("v", "<C-g><C-x>", ":<C-u>'<,'>GpChatNew split<cr>", keymapOptions("Visual Chat New split"))
map("v", "<C-g><C-v>", ":<C-u>'<,'>GpChatNew vsplit<cr>", keymapOptions("Visual Chat New vsplit"))
map("v", "<C-g><C-t>", ":<C-u>'<,'>GpChatNew tabnew<cr>", keymapOptions("Visual Chat New tabnew"))

-- Prompt commands
map({ "n", "i" }, "<C-g>r", "<cmd>GpRewrite<cr>", keymapOptions("Inline Rewrite"))
map({ "n", "i" }, "<C-g>a", "<cmd>GpAppend<cr>", keymapOptions("Append (after)"))
map({ "n", "i" }, "<C-g>b", "<cmd>GpPrepend<cr>", keymapOptions("Prepend (before)"))

map("v", "<C-g>r", ":<C-u>'<,'>GpRewrite<cr>", keymapOptions("Visual Rewrite"))
map("v", "<C-g>a", ":<C-u>'<,'>GpAppend<cr>", keymapOptions("Visual Append (after)"))
map("v", "<C-g>b", ":<C-u>'<,'>GpPrepend<cr>", keymapOptions("Visual Prepend (before)"))
map("v", "<C-g>i", ":<C-u>'<,'>GpImplement<cr>", keymapOptions("Implement selection"))

map({ "n", "i" }, "<C-g>gp", "<cmd>GpPopup<cr>", keymapOptions("Popup"))
map({ "n", "i" }, "<C-g>ge", "<cmd>GpEnew<cr>", keymapOptions("GpEnew"))
map({ "n", "i" }, "<C-g>gn", "<cmd>GpNew<cr>", keymapOptions("GpNew"))
map({ "n", "i" }, "<C-g>gv", "<cmd>GpVnew<cr>", keymapOptions("GpVnew"))
map({ "n", "i" }, "<C-g>gt", "<cmd>GpTabnew<cr>", keymapOptions("GpTabnew"))

map("v", "<C-g>gp", ":<C-u>'<,'>GpPopup<cr>", keymapOptions("Visual Popup"))
map("v", "<C-g>ge", ":<C-u>'<,'>GpEnew<cr>", keymapOptions("Visual GpEnew"))
map("v", "<C-g>gn", ":<C-u>'<,'>GpNew<cr>", keymapOptions("Visual GpNew"))
map("v", "<C-g>gv", ":<C-u>'<,'>GpVnew<cr>", keymapOptions("Visual GpVnew"))
map("v", "<C-g>gt", ":<C-u>'<,'>GpTabnew<cr>", keymapOptions("Visual GpTabnew"))

map({ "n", "i" }, "<C-g>x", "<cmd>GpContext<cr>", keymapOptions("Toggle Context"))
map("v", "<C-g>x", ":<C-u>'<,'>GpContext<cr>", keymapOptions("Visual Toggle Context"))

map({ "n", "i", "v", "x" }, "<C-g>s", "<cmd>GpStop<cr>", keymapOptions("Stop"))
map({ "n", "i", "v", "x" }, "<C-g>n", "<cmd>GpNextAgent<cr>", keymapOptions("Next Agent"))

-- optional Whisper commands with prefix <C-g>w
map({ "n", "i" }, "<C-g>ww", "<cmd>GpWhisper<cr>", keymapOptions("Whisper"))
map("v", "<C-g>ww", ":<C-u>'<,'>GpWhisper<cr>", keymapOptions("Visual Whisper"))

map({ "n", "i" }, "<C-g>wr", "<cmd>GpWhisperRewrite<cr>", keymapOptions("Whisper Inline Rewrite"))
map({ "n", "i" }, "<C-g>wa", "<cmd>GpWhisperAppend<cr>", keymapOptions("Whisper Append (after)"))
map({ "n", "i" }, "<C-g>wb", "<cmd>GpWhisperPrepend<cr>", keymapOptions("Whisper Prepend (before) "))

map("v", "<C-g>wr", ":<C-u>'<,'>GpWhisperRewrite<cr>", keymapOptions("Visual Whisper Rewrite"))
map("v", "<C-g>wa", ":<C-u>'<,'>GpWhisperAppend<cr>", keymapOptions("Visual Whisper Append (after)"))
map("v", "<C-g>wb", ":<C-u>'<,'>GpWhisperPrepend<cr>", keymapOptions("Visual Whisper Prepend (before)"))

map({ "n", "i" }, "<C-g>wp", "<cmd>GpWhisperPopup<cr>", keymapOptions("Whisper Popup"))
map({ "n", "i" }, "<C-g>we", "<cmd>GpWhisperEnew<cr>", keymapOptions("Whisper Enew"))
map({ "n", "i" }, "<C-g>wn", "<cmd>GpWhisperNew<cr>", keymapOptions("Whisper New"))
map({ "n", "i" }, "<C-g>wv", "<cmd>GpWhisperVnew<cr>", keymapOptions("Whisper Vnew"))
map({ "n", "i" }, "<C-g>wt", "<cmd>GpWhisperTabnew<cr>", keymapOptions("Whisper Tabnew"))

map("v", "<C-g>wp", ":<C-u>'<,'>GpWhisperPopup<cr>", keymapOptions("Visual Whisper Popup"))
map("v", "<C-g>we", ":<C-u>'<,'>GpWhisperEnew<cr>", keymapOptions("Visual Whisper Enew"))
map("v", "<C-g>wn", ":<C-u>'<,'>GpWhisperNew<cr>", keymapOptions("Visual Whisper New"))
map("v", "<C-g>wv", ":<C-u>'<,'>GpWhisperVnew<cr>", keymapOptions("Visual Whisper Vnew"))
map("v", "<C-g>wt", ":<C-u>'<,'>GpWhisperTabnew<cr>", keymapOptions("Visual Whisper Tab"))

-- harpoon
local harpoon = require("harpoon")
map("n", "<leader>hn", function() harpoon:list():replace_at(1) end)
map("n", "<leader>he", function() harpoon:list():replace_at(2) end)
map("n", "<leader>ho", function() harpoon:list():replace_at(3) end)
map("n", "<leader>hi", function() harpoon:list():replace_at(4) end)
map("n", "<leader>hN", function() harpoon:list():remove_at(1) end)
map("n", "<leader>hE", function() harpoon:list():remove_at(2) end)
map("n", "<leader>hO", function() harpoon:list():remove_at(3) end)
map("n", "<leader>hI", function() harpoon:list():remove_at(4) end)
map("n", "<leader>hc", function() harpoon:list():clear() end)
map("n", "<leader>hh", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

map("n", "<M-n>", function() harpoon:list():select(1) end)
map("n", "<M-e>", function() harpoon:list():select(2) end)
map("n", "<M-o>", function() harpoon:list():select(3) end)
map("n", "<M-i>", function() harpoon:list():select(4) end)

-- Toggle previous & next buffers stored within Harpoon list
map("n", "<M-P>", function() harpoon:list():prev() end)
map("n", "<M-N>", function() harpoon:list():next() end)
