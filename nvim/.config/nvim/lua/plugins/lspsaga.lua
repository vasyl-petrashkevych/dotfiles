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
		keymap.set({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<CR>", { desc = "Code action" })
		keymap.set({ "n", "v" }, "<leader>cr", "<cmd>Lspsaga rename<CR>", { desc = "Rename" })
		keymap.set({ "n", "v" }, "<leader>lo", "<cmd>Lspsaga outline<CR>", { desc = "File structure" })
		keymap.set(
			{ "n", "v" },
			"<leader>j",
			"<cmd>Lspsaga diagnostic_jump_next<CR>",
			{ desc = "Next diagnostic message" }
		)
		keymap.set(
			{ "n", "v" },
			"<leader>k",
			"<cmd>Lspsaga diagnostic_jump_prev<CR>",
			{ desc = "Previous diagnostic message" }
		)
		keymap.set({ "n", "v" }, "K", "<cmd>Lspsaga hover_doc<CR>", { desc = "How info" })
		keymap.set({ "n", "v" }, "L", "<cmd>Lspsaga show_line_diagnostics<CR>", { desc = "Show diagnostic message" })
	end,
	dependencies = {
		"nvim-treesitter/nvim-treesitter", -- optional
		"nvim-tree/nvim-web-devicons", -- optional
	},
}
