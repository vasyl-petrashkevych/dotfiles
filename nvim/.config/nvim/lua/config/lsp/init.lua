pcall(function()
	require("neodev").setup({})
end)
require("config.lsp.ensure")
local M = {}

function M.setup()
	local lspconfig = require("lspconfig")
	local mason_lspconfig = require("mason-lspconfig")
	local cmp_nvim_lsp = require("cmp_nvim_lsp")

	-- neodev improves lua_ls for Neovim runtime
	pcall(require, "neodev")

	-- Capabilities (cmp-nvim-lsp)
	local capabilities = cmp_nvim_lsp.default_capabilities()

	-- on_attach (keymaps etc.)
	local on_attach = require("config.lsp.on_attach")

	-- Diagnostics (modern signs API, no sign_define deprecation)
	require("config.lsp.diagnostics").setup()

	-- Optional: inlay hints (Neovim 0.10+)
	if vim.lsp.inlay_hint then
		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function(args)
				local buf = args.buf
				local client = vim.lsp.get_client_by_id(args.data.client_id)
				if client and client.server_capabilities.inlayHintProvider then
					vim.lsp.inlay_hint.enable(true, { bufnr = buf })
				end
			end,
		})
	end

	-- Autoformat on save (toggle if you prefer)
	vim.api.nvim_create_autocmd("BufWritePre", {
		callback = function(args)
			-- Keep it simple; adapt if you need per-server logic
			vim.lsp.buf.format({ bufnr = args.buf, async = false })
		end,
	})

	-- mason-lspconfig handlers
	mason_lspconfig.setup({
		handlers = {
			-- Default handler for any installed server
			function(server_name)
				local server_opts = {
					capabilities = capabilities,
					on_attach = on_attach,
				}

				-- If we have a local file with extra opts, merge it
				local ok, extras = pcall(require, "config.lsp.servers." .. server_name)
				if ok then
					for k, v in pairs(extras) do
						server_opts[k] = v
					end
				end

				lspconfig[server_name].setup(server_opts)
			end,
		},
	})

	-- Filetype for docker-compose
	vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
		pattern = { "docker-compose*.yml", "docker-compose*.yaml" },
		callback = function()
			vim.bo.filetype = "yaml.docker-compose"
		end,
	})
end

return M
