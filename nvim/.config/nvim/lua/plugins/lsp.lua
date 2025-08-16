return {
	-- Core LSP config
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
			{ "antosha417/nvim-lsp-file-operations", config = true },
			{ "folke/neodev.nvim", opts = {} },
			{ "nvim-telescope/telescope.nvim", optional = true },
		},
		config = function()
			require("config.lsp").setup()
		end,
	},

	-- Mason UI
	{ "williamboman/mason.nvim", cmd = "Mason", opts = {} },
}
