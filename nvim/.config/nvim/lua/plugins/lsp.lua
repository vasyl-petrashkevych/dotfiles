return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/neodev.nvim", opts = {} },
	},
	config = function()
		local lspconfig = require("lspconfig")
		local mason_lspconfig = require("mason-lspconfig")
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		-- Icons for diagnostics
		local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
		end

		-- Global diagnostics settings
		vim.diagnostic.config({
			virtual_text = {
				prefix = "●",
				spacing = 4,
			},
			signs = true,
			underline = true,
			update_in_insert = false,
			severity_sort = true,
			float = {
				source = true,
				border = "round",
			},
		})

		local on_attach = function(_, bufnr)
			local opts = { buffer = bufnr, silent = true }
			local keymap = vim.keymap

			opts.desc = "Show LSP references"
			keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)
			opts.desc = "Go to declaration"
			keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
			opts.desc = "Show LSP definitions"
			keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
			opts.desc = "Show LSP implementations"
			keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)
			opts.desc = "Show LSP type definitions"
			keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)
			opts.desc = "Show buffer diagnostics"
			keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)
			keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
			opts.desc = "Go to previous diagnostic"
			keymap.set("n", "[d", function()
				vim.diagnostic.jump({ count = -1, float = true })
			end, opts)
			opts.desc = "Go to next diagnostic"
			keymap.set("n", "]d", function()
				vim.diagnostic.jump({ count = -1, float = true })
			end, opts)
			opts.desc = "Restart LSP"
			keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
		end

		local capabilities = cmp_nvim_lsp.default_capabilities()

		mason_lspconfig.setup_handlers({
			function(server_name)
				lspconfig[server_name].setup({
					capabilities = capabilities,
					on_attach = on_attach,
				})
			end,

			-- Special configs
			["lua_ls"] = function()
				lspconfig.lua_ls.setup({
					capabilities = capabilities,
					on_attach = on_attach,
					settings = {
						Lua = {
							diagnostics = { globals = { "vim" } },
							completion = { callSnippet = "Replace" },
						},
					},
				})
			end,

			["emmet_ls"] = function()
				lspconfig.emmet_ls.setup({
					capabilities = capabilities,
					on_attach = on_attach,
					filetypes = {
						"html",
						"typescriptreact",
						"javascriptreact",
						"css",
						"sass",
						"scss",
						"less",
						"svelte",
					},
				})
			end,

			["graphql"] = function()
				lspconfig.graphql.setup({
					capabilities = capabilities,
					on_attach = on_attach,
					filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
				})
			end,

			["ts_ls"] = function()
				lspconfig.ts_ls.setup({
					capabilities = capabilities,
					on_attach = on_attach,
				})
			end,

			["clangd"] = function()
				lspconfig.clangd.setup({
					capabilities = capabilities,
					on_attach = on_attach,
					cmd = {
						"clangd",
						"--offset-encoding=utf-16",
						"--background-index",
						"--clang-tidy",
						"--header-insertion=iwyu",
						"--completion-style=detailed",
						"--function-arg-placeholders",
						"--fallback-style=llvm",
					},
				})
			end,

			["bashls"] = function()
				lspconfig.bashls.setup({
					capabilities = capabilities,
					on_attach = on_attach,
				})
			end,

			["cmake"] = function()
				lspconfig.cmake.setup({
					capabilities = capabilities,
					on_attach = on_attach,
				})
			end,

			["marksman"] = function() -- Markdown
				lspconfig.marksman.setup({
					capabilities = capabilities,
					on_attach = on_attach,
				})
			end,

			["dockerls"] = function()
				lspconfig.dockerls.setup({
					capabilities = capabilities,
					on_attach = on_attach,
					filetypes = { "Dockerfile" },
				})
			end,

			["docker_compose_language_service"] = function()
				lspconfig.docker_compose_language_service.setup({
					capabilities = capabilities,
					on_attach = on_attach,
					filetypes = { "yaml.docker-compose" },
				})
			end,
		})

		-- Optional: Filetype detection for docker-compose
		vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
			pattern = { "docker-compose*.yml", "docker-compose*.yaml" },
			callback = function()
				vim.bo.filetype = "yaml.docker-compose"
			end,
		})
	end,
}
