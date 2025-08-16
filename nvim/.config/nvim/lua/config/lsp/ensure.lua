local servers = {
	"lua_ls",
	"ts_ls",
	"clangd",
	"bashls",
	"cmake",
	"marksman",
	"dockerls",
	"docker_compose_language_service",
	"emmet_ls",
	"graphql",
}

require("mason-lspconfig").setup({ ensure_installed = servers })
