return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters = {
				phpcbf = {
					cwd = require("conform.util").root_file({
						"phpcs.xml",
						"phpcs.xml.dist",
						".phpcs.xml",
						".phpcs.xml.dist",
					}),
				},
				php_cs_fixer = {
					args = function(_, ctx)
						local configs = { ".php-cs-fixer.php", ".php-cs-fixer.dist.php" }
						if vim.fs.root(ctx.dirname, configs) then
							return { "fix", "$FILENAME" }
						end

						return { "fix", "--using-cache=no", "--rules=@PER-CS3.0", "$FILENAME" }
					end,
					cwd = function(_, ctx)
						local configs = { ".php-cs-fixer.php", ".php-cs-fixer.dist.php" }
						return vim.fs.root(ctx.dirname, configs) or ctx.dirname
					end,
				},
			},
			formatters_by_ft = {
				javascript = { "prettier" },
				typescript = { "prettier" },
				javascriptreact = { "prettier" },
				typescriptreact = { "prettier" },
				svelte = { "prettier" },
				css = { "prettier" },
				scss = { "prettier" },
				html = { "prettier" },
				json = { "prettier" },
				yaml = { "prettier" },
				markdown = { "prettier" },
				graphql = { "prettier" },
				liquid = { "prettier" },
				lua = { "stylua" },
				python = { "isort", "black" },
				php = { "phpcbf", "php_cs_fixer", stop_after_first = true },
			},
			format_on_save = {
				lsp_format = "fallback",
				async = false,
				timeout_ms = 1000,
			},
		})

		vim.keymap.set({ "n", "v" }, "<leader>mp", function()
			conform.format({
				lsp_format = "fallback",
				async = false,
				timeout_ms = 1000,
			})
		end, { desc = "Format file or range (in visual mode)" })
	end,
}
