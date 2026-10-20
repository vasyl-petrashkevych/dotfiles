local M = {}

function M.setup()
	local cmp_nvim_lsp = require("cmp_nvim_lsp")
	local servers = require("config.lsp.ensure")

	local capabilities = cmp_nvim_lsp.default_capabilities()
	local on_attach = require("config.lsp.on_attach")

	for _, server_name in ipairs(servers) do
		local server_opts = {
			capabilities = capabilities,
			on_attach = on_attach,
		}

		local ok, extras = pcall(require, "config.lsp.servers." .. server_name)
		if ok then
			server_opts = vim.tbl_deep_extend("force", server_opts, extras)
		end

		vim.lsp.config(server_name, server_opts)
	end

	require("mason-lspconfig").setup({
		ensure_installed = servers,
		automatic_enable = servers,
	})

	local group = vim.api.nvim_create_augroup("lsp_inlay_hints", { clear = true })
	vim.api.nvim_create_autocmd("LspAttach", {
		group = group,
		callback = function(args)
			local client = vim.lsp.get_client_by_id(args.data.client_id)
			if client and client.server_capabilities.inlayHintProvider then
				vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
			end
		end,
	})
end

return M
