return {
	"nvimdev/lspsaga.nvim",
	config = function()
		local lspsaga = require("lspsaga")
		lspsaga.setup({
			diagnostic = {
				max_height = 0.8,
				keys = {
					quit = { "q", "<ESC>" },
				},
			},
			rename = {
				keys = {
					quit = { "<ESC>" },
				},
			},
		})
		-- set keymaps
		local keymap = vim.keymap -- for conciseness
		keymap.set({ "n", "v" }, "<leader>ca", ":Lspsaga code_action<CR>", { desc = "Code action" })
		keymap.set({ "n", "v" }, "<leader>cr", ":Lspsaga rename<CR>", { desc = "Rename" })
		keymap.set({ "n", "v" }, "<leader>lo", ":Lspsaga outline<CR>", { desc = "File structure" })
		keymap.set({ "n", "v" }, "K", ":Lspsaga hover_doc<CR>", { desc = "How info" })
	end,
	dependencies = {
		"nvim-treesitter/nvim-treesitter", -- optional
		"nvim-tree/nvim-web-devicons", -- optional
	},
}
