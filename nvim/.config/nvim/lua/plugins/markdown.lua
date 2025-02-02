return {
	{
		"iamcco/markdown-preview.nvim",
		ft = "markdown",
		cmd = { "MarkdownPreview", "MarkdownPreviewToggle", "MarkdownPreviewStop" }, -- Load only when needed
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
	},

	{
		"mickael-menu/zk-nvim",
		dependencies = { "nvim-telescope/telescope.nvim" },
		opts = { picker = "telescope" },
		config = function(_, opts)
			require("zk").setup(opts)
		end,
		keys = {
			{
				"<leader>zn",
				function()
					vim.cmd("ZkNew { dir = vim.fn.expand('$HOME/notes'), title = vim.fn.input('Title: ') }")
				end,
				desc = "New Note",
			},
			{
				"<leader>zb",
				function()
					vim.cmd.ZkNotes()
				end,
				desc = "Browse Notes",
			},
			{ "<leader>zz", "<cmd>Telescope live_grep cwd=~/notes<CR>", desc = "Find Note" },
		},
	},
}
