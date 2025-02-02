return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 300
	end,

	config = function()
		local wk = require("which-key")
		wk.add({
			{
				"<leader>j",
				"<Cmd>Lspsaga diagnostic_jump_next<CR>",
				desc = "Lspsaga diagnostic_jump_next",
			},
			{
				"<leader>k",
				"<Cmd>Lspsaga diagnostic_jump_prev<CR>",
				desc = "Lspsaga diagnostic_jump_prev",
			},
			{
				"<leader>l",
				"<Cmd>Lspsaga show_line_diagnostics<CR>",
				desc = "Lspsaga show_line_diagnostics ",
			},
			{
				"K",
				"<Cmd>Lspsaga hover_doc<CR>",
				desc = "Lspsaga hover doc",
			},
			{
				{ "<leader>f", group = "+file" },
				mode = { "n" },
				{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find File" },
				{ "<leader>fb", "<cmd>Telescope file_browser<cr>", desc = "Open file browser" },
				{ "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Open Recent File" },
			},
			{
				{ "<leader>w", group = "+window" },
				mode = { "n" },
				{ "<leader>ww", "<C-w>w", desc = "Go to next window" },
				{ "<leader>w<left>", "<C-w><", desc = "Resize window to left" },
				{ "<leader>w<right>", "<C-w>>", desc = "Resize window to right" },
				{ "<leader>w<top>", "<C-w>+", desc = "Resize window to top" },
				{ "<leader>w<down>", "<C-w>-", desc = "Resize window to down" },
				{ "<leader>wl", "<C-w>l", desc = "Go to left window" },
				{ "<leader>we", "<C-w>=", desc = "Make windows equal" },
				{ "<leader>wh", "<C-w>h", desc = "Go to right window" },
				{ "<leader>wj", "<C-w>j", desc = "Go to bottom window" },
				{ "<leader>wk", "<C-w>k", desc = "Go to top window" },
				{ "<leader>ws", ":split<Return><C-w>w", desc = "Split window horisontaly" },
				{ "<leader>wv", ":vsplit<Return><C-w>w", desc = "Split window vertically" },
				{ "<leader>wq", ":close<cr>", desc = "Close window" },
			},
			{
				{ "<leader>g", group = "+git" },
				mode = { "n" },
				{ "<leader>gg", ":LazyGit<cr>", desc = "Open Lazy git" },
				{ "<leader>gb", "<cmd>Gitsigns toggle_current_line_blame<cr>", desc = "Blame line" },
				{ "<leader>gk", "<cmd>Gitsigns next_hunk<cr>", desc = "Go to next change" },
				{ "<leader>gj", "<cmd>Gitsigns prev_hunk<cr>", desc = "Go to previous change" },
			},
			{
				{ "<leader>c", group = "+code" },
				mode = { "n" },
				{
					"<leader>cfb",
					function()
						vim.lsp.buf.format({ async = true })
					end,
					desc = "Format buffer",
				},
				{ "<leader>cs", "<Cmd>Lspsaga outline<cr>", desc = "Code structure" },

				{
					"<leader>cff",
					"<Cmd>Lspsaga finder<CR>",
					desc = "Lspsaga finder",
				},
				{
					"<leader>cR",
					"<Cmd>Lspsaga rename<CR>",
					desc = "Lspsaga rename",
				},
				{
					"<leader>ca",
					"<Cmd>Lspsaga code_action<CR>",
					desc = "Code action",
				},
				{
					"<leader>cpd",
					"<Cmd>Lspsaga peek_definition<CR>",
					desc = "Lspsaga peek definition",
				},
			},
			{
				{ "<leader>x", group = "+diagnostics" },
				mode = { "n" },
				{
					"<leader>xx",
					"<cmd>Telescope diagnostics<cr>",
					desc = "Diagnostics (Trouble)",
				},
				{
					"<leader>xX",
					"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
					desc = "Buffer Diagnostics (Trouble)",
				},
				{
					"<leader>cs",
					"<cmd>Trouble symbols toggle focus=false<cr>",
					desc = "Symbols (Trouble)",
				},
				{
					"<leader>cl",
					"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
					desc = "LSP Definitions / references / ... (Trouble)",
				},
				{
					"<leader>xL",
					"<cmd>Trouble loclist toggle<cr>",
					desc = "Location List (Trouble)",
				},
				{
					"<leader>xQ",
					"<cmd>Trouble qflist toggle<cr>",
					desc = "Quickfix List (Trouble)",
				},
			},
			{
				{ "<leader>b", group = "+buffers" },
				{ "<leader>bb", "<cmd>Telescope buffers<cr>", desc = "Show all buffers" },
			},

			{
				{ "<leader>s", group = "+search" },
				{ "<leader>ss", "<cmd>Telescope live_grep<cr>", desc = "Quick sarch" },
				{
					"<leader>sf",
					function()
						local telescope = require("teleskope")
						local function telescope_buffer_dir()
							return vim.fn.expand("%:p:h")
						end

						telescope.extensions.file_browser.file_browser({
							path = "%:p:h",
							cwd = telescope_buffer_dir(),
							respect_gitignore = false,
							hidden = true,
							grouped = true,
							previewer = false,
							initial_mode = "normal",
							layout_config = { height = 40 },
						})
					end,
					desc = "Find file",
				},
			},
		})
	end,
}
