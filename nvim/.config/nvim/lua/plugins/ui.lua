return {
	{ "norcalli/nvim-colorizer.lua" },
	{ "nvim-tree/nvim-web-devicons", lazy = true },
	{
		"nvimdev/lspsaga.nvim",
		config = function()
			require("lspsaga").setup({
				ui = {
					code_action = "🕭",
				},
			})
		end,
		dependencies = {
			"nvim-treesitter/nvim-treesitter", -- optional
			"nvim-tree/nvim-web-devicons", -- optional
		},
	},
}
