return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lint = require("lint")

		lint.linters_by_ft = {
			javascript = { "eslint_d" },
			typescript = { "eslint_d" },
			javascriptreact = { "eslint_d" },
			typescriptreact = { "eslint_d" },
		}

		local phpcs_configs = { "phpcs.xml", "phpcs.xml.dist", ".phpcs.xml", ".phpcs.xml.dist" }
		local stylelint_configs = {
			"stylelint.config.js",
			"stylelint.config.cjs",
			"stylelint.config.mjs",
			".stylelintrc",
			".stylelintrc.json",
			".stylelintrc.yaml",
			".stylelintrc.yml",
			".stylelintrc.js",
			".stylelintrc.cjs",
		}

		local function project_root(names)
			local path = vim.api.nvim_buf_get_name(0)
			return path ~= "" and vim.fs.root(path, names) or nil
		end

		local function lint_buffer()
			lint.try_lint()

			if vim.bo.filetype == "php" then
				local root = project_root(phpcs_configs)
				if root then
					lint.try_lint("phpcs", { cwd = root })
				end
			elseif vim.bo.filetype == "css" or vim.bo.filetype == "scss" then
				local root = project_root(stylelint_configs)
				if root then
					lint.try_lint("stylelint", { cwd = root })
				end
			end
		end

		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = lint_buffer,
		})

		vim.keymap.set("n", "<leader>l", lint_buffer, { desc = "Trigger linting for current file" })
	end,
}
