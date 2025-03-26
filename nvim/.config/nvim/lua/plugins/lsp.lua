return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"nvimtools/none-ls.nvim", -- Required for nvim-eslint
		"MunifTanjim/eslint.nvim", -- nvim-eslint plugin
	},
	config = function()
		local lsp_ok, lspconfig = pcall(require, "lspconfig")
		if not lsp_ok then
			return
		end

		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

		local format_on_save = true -- Toggle this variable to enable/disable formatting on save

		local function on_attach(client, bufnr)
			local map = function(keys, func, desc)
				vim.keymap.set("n", keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
			end

			map("gD", vim.lsp.buf.declaration, "Go to declaration")
			map("gd", vim.lsp.buf.definition, "Go to definition")
			map("gi", vim.lsp.buf.implementation, "Go to implementation")
			map("<leader>sh", vim.lsp.buf.signature_help, "Show signature help")
			map("<leader>wa", vim.lsp.buf.add_workspace_folder, "Add workspace folder")
			map("<leader>wr", vim.lsp.buf.remove_workspace_folder, "Remove workspace folder")
			map("<leader>wl", function()
				print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
			end, "List workspace folders")
			map("<leader>D", vim.lsp.buf.type_definition, "Go to type definition")
			map("<leader>ca", vim.lsp.buf.code_action, "Code action")
			map("gr", vim.lsp.buf.references, "Show references")

			if client.server_capabilities.documentHighlightProvider then
				vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
					buffer = bufnr,
					callback = vim.lsp.buf.document_highlight,
				})
				vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
					buffer = bufnr,
					callback = vim.lsp.buf.clear_references,
				})
			end

			if format_on_save and client.server_capabilities.documentFormattingProvider then
				vim.api.nvim_create_autocmd("BufWritePre", {
					buffer = bufnr,
					callback = function()
						vim.lsp.buf.format({ async = true })
					end,
				})
			end
		end

		-- Load nvim-eslint if available
		local eslint_ok, eslint = pcall(require, "eslint")
		if eslint_ok then
			eslint.setup({
				bin = "eslint_d", -- Uses `eslint_d` for faster execution
				code_actions = { enable = true },
				diagnostics = { enable = true },
				disable_if_no_config = true,
			})
		end

		-- LSP Server Configurations
		local servers = {
			lua_ls = {
				settings = {
					Lua = {
						diagnostics = { globals = { "vim" } },
						workspace = { library = vim.api.nvim_get_runtime_file("", true), checkThirdParty = false },
					},
				},
			},
			ts_ls = {
				filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
				root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
				settings = { completions = { completeFunctionCalls = true } },
			},
			eslint = {
				on_attach = function(client, bufnr)
					on_attach(client, bufnr)
					vim.api.nvim_create_autocmd("BufWritePre", {
						buffer = bufnr,
						callback = function()
							if eslint_ok then
								eslint.fix() -- Runs nvim-eslint fix on save
							end
							vim.lsp.buf.format({ async = true })
						end,
					})
				end,
			},
			emmet_ls = {
				filetypes = { "html", "css", "scss", "javascriptreact", "typescriptreact", "markdown", "ejs" },
				init_options = { html = { options = { ["bem.enabled"] = true } } },
			},
			cssls = {},
			html = {
				filetypes = { "html", "ejs" },
				init_options = { provideFormatter = true },
			},
			stylelint_lsp = {
				filetypes = { "css", "scss", "less" },
				settings = { stylelintplus = { autoFixOnSave = true, autoFixOnFormat = true } },
			},
			docker_compose_language_service = {},
			dockerls = {},
			clangd = {
				filetypes = { "c", "cpp", "h", "hpp" },
				init_options = {
					usePlaceholders = true,
					completeUnimported = true,
					clangdFileStatus = true,
				},
				root_dir = function(fname)
					return lspconfig.util.root_pattern(
						"Makefile",
						"configure.ac",
						"compile_commands.json",
						"CMakeLists.txt"
					)(fname) or lspconfig.util.find_git_ancestor(fname)
				end,
			},
			cmake = {},
			bashls = {},
			jsonls = {
				cmd = { "vscode-json-language-server", "--stdio" },
				settings = {
					json = {
						schemas = {
							{ fileMatch = { "package.json" }, url = "https://json.schemastore.org/package.json" },
						},
					},
				},
			},
			intelephense = {
				cmd = { "intelephense", "--stdio" },
				filetypes = { "php" },
				settings = {
					intelephense = {
						diagnostics = { enable = true },
						files = { maxSize = 5000000 },
					},
				},
			},
		}

		-- Setup Mason for easy LSP installations
		local mason_ok, mason = pcall(require, "mason")
		local mason_lsp_ok, mason_lsp = pcall(require, "mason-lspconfig")

		if mason_ok and mason_lsp_ok then
			mason.setup()
			mason_lsp.setup({
				ensure_installed = vim.tbl_keys(servers), -- Auto-install LSPs
			})
		end

		-- Initialize LSP servers
		for server, config in pairs(servers) do
			config.capabilities = capabilities
			config.on_attach = config.on_attach or on_attach
			pcall(function()
				lspconfig[server].setup(config)
			end)
		end
	end,
}
