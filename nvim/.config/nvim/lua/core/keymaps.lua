local keymap = vim.keymap
vim.g.mapleader = " "
keymap.set("n", "<leader>h", ":nohlsearch<CR>")
keymap.set("n", "x", '"_x')

-- Increment/decrement
keymap.set("n", "+", "<C-a>")
keymap.set("n", "-", "<C-x>")

-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G")
keymap.set("n", "<C-q>", "<cmd>write<cr>", { desc = "Save file" })
keymap.set("i", "<C-q>", "<Esc><cmd>write<cr>", { desc = "Save file" })
keymap.set("n", "<C-d>", "<cmd>t.<cr>", { desc = "Duplicate line" })
keymap.set("i", "<C-d>", "<Esc><cmd>t.<cr>", { desc = "Duplicate line" })

-- Insert mode
keymap.set("i", "<C-l>", "<right>")
keymap.set("i", "<C-h>", "<left>")
keymap.set("i", "<C-k>", "<up>")
keymap.set("i", "<C-j>", "<down>")

keymap.set({ "i", "n" }, "<C-s>", "<esc>:w<CR>")

-- Tmux --
keymap.set("n", "<C-h>", "<cmd>TmuxNavigateLeft<cr>")
keymap.set("n", "<C-j>", "<cmd>TmuxNavigateDown<cr>")
keymap.set("n", "<C-k>", "<cmd>TmuxNavigateUp<cr>")
keymap.set("n", "<C-l>", "<cmd>TmuxNavigateRight<cr>")

keymap.set("n", "<leader>LL", ":Lazy<cr>")

-- Files --
keymap.set("n", "QQ", ":q!<enter>")

-- Window --
keymap.set("n", "<leader>ww", "<C-w>w", { desc = "Go to next window" })
keymap.set("n", "<leader>w<left>", "<C-w><", { desc = "Resize window to left" })
keymap.set("n", "<leader>w<right>", "<C-w>>", { desc = "Resize window to right" })
keymap.set("n", "<leader>w<top>", "<C-w>+", { desc = "Resize window to top" })
keymap.set("n", "<leader>w<down>", "<C-w>-", { desc = "Resize window to down" })
keymap.set("n", "<leader>wl", "<C-w>l", { desc = "Go to right window" })
keymap.set("n", "<leader>we", "<C-w>=", { desc = "Make windows equal" })
keymap.set("n", "<leader>wh", "<C-w>h", { desc = "Go to left window" })
keymap.set("n", "<leader>wj", "<C-w>j", { desc = "Go to bottom window" })
keymap.set("n", "<leader>wk", "<C-w>k", { desc = "Go to top window" })
keymap.set("n", "<leader>w-", "<cmd>split<cr>", { desc = "Split window horizontally" })
keymap.set("n", "<leader>wv", ":vsplit<Return><C-w>w", { desc = "Split window vertically" })
keymap.set("n", "<leader>wq", ":close<cr>", { desc = "Close window" })

-- Editor --
keymap.set("n", "H", function()
	local filter = { bufnr = 0 }
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled(filter), filter)
end, { desc = "Toggle inlay hints" })
