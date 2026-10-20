local group = vim.api.nvim_create_augroup("core_autocmds", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
	group = group,
	callback = function()
		vim.highlight.on_yank({ higroup = "Visual", timeout = 100 })
	end,
})

-- Undercurl
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])

-- Turn off paste mode when leaving insert
vim.api.nvim_create_autocmd("InsertLeave", {
	group = group,
	pattern = "*",
	command = "set nopaste",
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	group = group,
	pattern = { "docker-compose*.yml", "docker-compose*.yaml" },
	callback = function()
		vim.bo.filetype = "yaml.docker-compose"
	end,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	group = group,
	pattern = { "*.json.*" },
	callback = function()
		vim.bo.filetype = "json"
	end,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	group = group,
	pattern = "Dockerfile*",
	callback = function()
		vim.bo.filetype = "dockerfile"
	end,
})
