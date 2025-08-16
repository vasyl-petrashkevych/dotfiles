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
	end,
	dependencies = {
		"nvim-treesitter/nvim-treesitter", -- optional
		"nvim-tree/nvim-web-devicons", -- optional
	},
}
