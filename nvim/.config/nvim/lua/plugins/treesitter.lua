return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",
	dependencies = {
		{ "windwp/nvim-ts-autotag", opts = {} },
	},
	config = function()
		local treesitter = require("nvim-treesitter")
		local parsers = {
			"c",
			"lua",
			"bash",
			"json",
			"javascript",
			"typescript",
			"tsx",
			"html",
			"css",
			"scss",
			"php",
			"phpdoc",
			"yaml",
			"dockerfile",
			"gitignore",
			"markdown",
			"markdown_inline",
			"vim",
			"vimdoc",
			"query",
		}

		treesitter.setup({})
		treesitter.install(parsers)
		vim.treesitter.language.register("yaml", "yaml.docker-compose")

		local group = vim.api.nvim_create_augroup("treesitter_features", { clear = true })
		vim.api.nvim_create_autocmd("FileType", {
			group = group,
			pattern = {
				"c",
				"lua",
				"sh",
				"bash",
				"json",
				"javascript",
				"javascriptreact",
				"typescript",
				"typescriptreact",
				"html",
				"css",
				"scss",
				"php",
				"yaml",
				"yaml.docker-compose",
				"dockerfile",
				"gitignore",
				"markdown",
				"vim",
				"vimdoc",
				"query",
			},
			callback = function(args)
				if pcall(vim.treesitter.start, args.buf) then
					vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end
			end,
		})

		vim.keymap.set({ "n", "x" }, "<C-Space>", function()
			vim.treesitter.select("parent")
		end, { desc = "Select parent syntax node" })
		vim.keymap.set("x", "<BS>", function()
			vim.treesitter.select("child")
		end, { desc = "Select child syntax node" })
	end,
}
