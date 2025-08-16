return {
	settings = {
		Lua = {
			runtime = { version = "LuaJIT" },
			diagnostics = {
				-- Allow globals used in Neovim configs
				globals = { "vim" },
			},
			workspace = {
				-- Make server aware of Neovim runtime
				library = vim.api.nvim_get_runtime_file("", true),
				checkThirdParty = false,
			},
			completion = { callSnippet = "Replace" },
			hint = { enable = true }, -- new style in 0.11+
		},
	},
}
