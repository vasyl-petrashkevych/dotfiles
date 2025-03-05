return {
	"williamboman/mason.nvim",
	cmd = "Mason", -- Load only when Mason is needed
	dependencies = {
		{
			"williamboman/mason-lspconfig.nvim",
			event = "BufReadPre", -- Load before opening a file
		},
	},
	config = function()
		local mason = require("mason")
		local mason_conf = require("mason-lspconfig")
		mason.setup()
		mason_conf.setup({
			ensure_installed = {
				"lua_ls",
				"clangd",
				"cmake",
				"html",
				"cssls",
				"intelephense",
				"stylelint_lsp",
				"jsonls",
				"graphql",
				"typos_lsp",
				"docker_compose_language_service",
				"dockerls",
				"bashls",
				"emmet_ls",
			},
			automatic_installation = true,
		})
	end,
	opts = {}, -- Mason will use default setup
}
