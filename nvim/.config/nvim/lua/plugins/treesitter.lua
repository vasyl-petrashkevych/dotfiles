return {
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPre", "BufNewFile" },
		build = ":TSUpdate",
		dependencies = {
			"windwp/nvim-ts-autotag",
		},
		config = function()
			require("nvim-treesitter.config").setup({
				sync_install = false,
				auto_install = true,

				highlight = { enable = true },
				indent = { enable = true },

				autotag = { enable = true },

				ensure_installed = {
					"c",
					"lua",
					"bash",
					"json",
					"javascript",
					"typescript",
					"tsx",
					"html",
					"css",
					"yaml",
					"dockerfile",
					"gitignore",
					"markdown",
					"markdown_inline",
					"vim",
					"vimdoc",
					"query",
				},

				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<C-space>",
						node_incremental = "<C-space>",
						node_decremental = "<bs>",
					},
				},
			})
		end,
	},
}
