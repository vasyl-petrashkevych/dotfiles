local keymap = vim.keymap
keymap.set("n", "<Space>h", ":nohlsearch<CR>")
keymap.set("n", "x", '"_x')

-- Increment/decrement
keymap.set("n", "+", "<C-a>")
keymap.set("n", "-", "<C-x>")

-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G")
keymap.set("n", "<C-q>", ":w<cr>")
keymap.set("i", "<C-q>", ":w<cr>")
keymap.set({ "i", "n" }, "<C-d>", ":t.<cr>")

-- Insert mode
keymap.set("i", "<C-l>", "<right>")
keymap.set("i", "<C-h>", "<left>")
keymap.set("i", "<C-k>", "<up>")
keymap.set("i", "<C-j>", "<down>")

keymap.set({ "i", "n" }, "<C-s>", "<esc>:w<CR>")

-- Tmux --
keymap.set("n", "<C-h>", "<cmd>TmuxNavigateRight<cr>")
keymap.set("n", "<C-j>", "<cmd>TmuxNavigateDown<cr>")
keymap.set("n", "<C-k>", "<cmd>TmuxNavigateUp<cr>")
keymap.set("n", "<C-l>", "<cmd>TmuxNavigateLeft<cr>")

keymap.set("n", "<Space>LL", ":Lazy<cr>")

-- Files --
keymap.set("n", "QQ", ":q!<enter>")
