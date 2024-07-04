local map = vim.keymap.set

-- generic
map({ "n", "v" }, "<c-s>", ":wa<cr>", { desc = "Save all" })
map({ "n", "v" }, "<a-down>", ":m '>+1<CR>gv=gv", { desc = "Move down" })
map({ "n", "v" }, "<a-up>", ":m '<-2<CR>gv=gv", { desc = "Move up" })
map({ "n", "v" }, "<Esc><Esc>", ":noh<cr>", { desc = "Clear Highlight" })
map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })

-- buffer
map({ "n", "v" }, "<leader>bd", ":bufdo delete<cr>", { desc = "Delete buffer" })
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
