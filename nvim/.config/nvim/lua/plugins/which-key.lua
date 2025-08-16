return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	dependencies = {
		"echasnovski/mini.icons",
	},
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 500
	end,
	opts = {
		preset = "modern",
		spec = {
			-- File system (Neo-tree)
			{ "<leader>e", group = "File system", mode = "n" },
			{ "<leader>ee", ":Neotree toggle<cr>", desc = "Open file explorer", mode = "n", silent = true },
			{
				"<leader>eg",
				":Neotree float git_status git_base=main<cr>",
				desc = "Git status (Neo-tree)",
				mode = "n",
			},

			-- File (Telescope)
			{ "<leader>f", group = "File", mode = "n" },
			{ "<leader>ff", ":Telescope find_files<cr>", desc = "Find files", mode = "n" },
			{ "<leader>fr", ":Telescope oldfiles<cr>", desc = "Recent files", mode = "n" },

			-- Search (Telescope)
			{ "<leader>s", group = "Search", mode = "n" },
			{ "<leader>ss", ":Telescope live_grep<cr>", desc = "Live grep", mode = "n" },
			{ "<leader>sc", ":Telescope grep_string<cr>", desc = "Grep word under cursor", mode = "n" },

			-- Buffer
			{ "<leader>b", group = "Buffer", mode = "n" },
			{ "<leader>bb", ":Telescope buffers<cr>", desc = "List buffers", mode = "n" },

			-- Diagnostic (Trouble)
			{ "<leader>x", group = "Diagnostic", mode = "n" },
			{ "<leader>xw", ":Trouble diagnostics toggle<cr>", desc = "Workspace diagnostics", mode = "n" },
			{
				"<leader>xd",
				":Trouble diagnostics toggle filter.buf=0<cr>",
				desc = "Document diagnostics",
				mode = "n",
			},
			{ "<leader>xq", ":Trouble qflist toggle<cr>", desc = "Quickfix list", mode = "n" },
			{ "<leader>xl", ":Trouble loclist toggle<cr>", desc = "Location list", mode = "n" },
			{ "<leader>xt", ":Trouble todo toggle<cr>", desc = "TODOs", mode = "n" },

			-- LSP (Telescope + diagnostics)
			{ "g", group = "Goto (LSP)", mode = "n" },
			{ "gd", ":Telescope lsp_definitions<cr>", desc = "Go to definition", mode = "n" },
			{ "gR", ":Telescope lsp_references<cr>", desc = "References", mode = "n" },
			{ "gi", ":Telescope lsp_implementations<cr>", desc = "Implementations", mode = "n" },
			{ "gt", ":Telescope lsp_type_definitions<cr>", desc = "Type definitions", mode = "n" },
			{ "<leader>D", ":Telescope diagnostics bufnr=0<cr>", desc = "Buffer diagnostics", mode = "n" },

			-- Diagnostics (float + jump)
			{
				"<leader>d",
				function()
					vim.diagnostic.open_float(nil, { scope = "cursor" })
				end,
				desc = "Hover diagnostics",
				mode = "n",
			},
			{
				"[d",
				function()
					vim.diagnostic.jump({ count = -1, float = true })
				end,
				desc = "Prev diagnostic",
				mode = "n",
			},
			{
				"]d",
				function()
					vim.diagnostic.jump({ count = 1, float = true })
				end,
				desc = "Next diagnostic",
				mode = "n",
			},
			-- Code
			{
				{ "c", group = "Code", mode = { "n", "v" } },
				{ "<leader>ca", ":Lspsaga code_action<CR>", desc = "Code action" },
				{ "<leader>cr", ":Lspsaga rename<CR>", desc = "Rename" },
				{ "<leader>lo", ":Lspsaga outline<CR>", desc = "File structure" },
				{ "<leader>j", ":Lspsaga diagnostic_jump_next<CR>", desc = "Next diagnostic message" },
				{ "<leader>k", ":Lspsaga diagnostic_jump_prev<CR>", desc = "Previous diagnostic message" },
				{ "K", ":Lspsaga hover_doc<CR>", desc = "How info" },
				{ "L", ":Lspsaga show_line_diagnostics<CR>", desc = "Show diagnostic message" },
			},
			-- LSP management
			{ "<leader>rs", ":LspRestart<cr>", desc = "Restart LSP", mode = "n" },
			{
				{ "g", group = "Git", mode = "n" },
				{ "<leader>gg", ":LazyGit<cr>", desc = "Git status" },
				{ "]h", ":Gitsigns next_hunk<cr>", desc = "Next Hunk", mode = "n" },
				{ "[h", ":Gitsigns prev_hunk<cr>", desc = "Prev Hunk", mode = "n" },
				-- Hunk actions
				{
					"<leader>ghs",
					":Gitsigns stage_hunk<cr>",
					desc = "Stage Hunk",
					mode = { "n", "v" },
				},
				{
					"<leader>ghr",
					":Gitsigns reset_hunk<cr>",
					desc = "Reset Hunk",
					mode = { "n", "v" },
				},
				{
					"<leader>gS",
					":Gitsigns stage_buffer<cr>",
					desc = "Stage Buffer",
					mode = "n",
				},
				{
					"<leader>gu",
					":Gitsigns undo_sage_hunk<cr>",
					desc = "Undo Stage Hunk",
					mode = "n",
				},
				{
					"<leader>gR",
					":Gitsigns reset_buffer<cr>",
					desc = "Reset Buffer",
					mode = "n",
				},
				{
					"<leader>gp",
					":Gitsigns preview_hunk_inline<cr>",
					desc = "Preview Hunk Inline",
					mode = "n",
				},
				{
					"<leader>gb",
					":Gitsigns blame_line",
					desc = "Blame Line (full)",
					mode = "n",
				},
				{
					"<leader>gd",
					":Gitsigns diffthis",
					desc = "Diff This",
					mode = "n",
				},

				{
					"<leader>gD",
					function()
						require("gitsigns").diffthis("~")
					end,
					desc = "Diff This ~",
					mode = "n",
				},
				-- Text object
				{
					"<leader>gH",
					":Gitsigns select_hunk<cr>",
					desc = "Select Hunk",
					mode = { "o", "x" },
				},
			},
		},
	},
}
