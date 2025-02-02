vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("core.settings")
require("core.keymaps")
require("core.autocmp")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local opts = {
	git = { log = { "--since=3 days ago" } },
	checker = {
		enabled = true,
		notify = false,
	},
	change_detection = {
		notify = false,
	},
	ui = {
		custom_keys = {
			["<leader>l"] = {
				function(plugin)
					require("lazy.util").float_term({ "lazygit", "log" }, {
						cwd = plugin.dir,
					})
				end,
				desc = "Open lazygit log",
			},

			["<leader>t"] = {
				function(plugin)
					require("lazy.util").float_term(nil, {
						cwd = plugin.dir,
					})
				end,
				desc = "Open terminal in plugin dir",
			},
		},
	},
}
require("lazy").setup({ { import = "plugins" } }, opts)
