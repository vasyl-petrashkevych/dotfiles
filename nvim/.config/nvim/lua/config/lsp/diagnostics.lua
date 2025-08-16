local M = {}

function M.setup()
	local icons = { Error = " ", Warn = " ", Hint = " ", Info = " " }

	vim.diagnostic.config({
		virtual_text = { prefix = "●", spacing = 4 },
		signs = {
			text = {
				[vim.diagnostic.severity.ERROR] = icons.Error,
				[vim.diagnostic.severity.WARN] = icons.Warn,
				[vim.diagnostic.severity.HINT] = icons.Hint,
				[vim.diagnostic.severity.INFO] = icons.Info,
			},
		},
		underline = true,
		update_in_insert = false,
		severity_sort = true,
		float = { source = true, border = "rounded" },
	})
end

return M
