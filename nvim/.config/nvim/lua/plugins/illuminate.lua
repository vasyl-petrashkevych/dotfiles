return {
	"RRethy/vim-illuminate",
	event = { "BufReadPost", "BufNewFile" },
	lazy = false, -- Ensure it's loaded when needed
	opts = {
		delay = 200,
		filetypes_denylist = {
			"mason",
			"harpoon",
			"neo-tree",
			"DressingInput",
			"NeogitCommitMessage",
			"qf",
			"dirvish",
			"fugitive",
			"alpha",
			"NvimTree",
			"lazy",
			"Trouble",
			"netrw",
			"lir",
			"DiffviewFiles",
			"Outline",
			"Jaq",
			"spectre_panel",
			"toggleterm",
			"DressingSelect",
			"TelescopePrompt",
		},
	},
	config = function(_, opts)
		local illuminate = require("illuminate")
		illuminate.configure(opts)

		-- Keybindings
		local function set_keymaps(buffer)
			local mappings = { ["]w"] = "next", ["[w"] = "prev", ["]]"] = "next", ["[["] = "prev" }
			for key, dir in pairs(mappings) do
				vim.keymap.set("n", key, function()
					illuminate["goto_" .. dir .. "_reference"](false)
				end, { desc = dir:sub(1, 1):upper() .. dir:sub(2) .. " Reference", buffer = buffer })
			end
		end
		set_keymaps(nil)

		vim.api.nvim_create_autocmd("FileType", {
			callback = function()
				set_keymaps(vim.api.nvim_get_current_buf())
			end,
		})

		-- Highlighting
		local function set_highlights()
			local hl_groups = { "IlluminatedWordText", "IlluminatedWordRead", "IlluminatedWordWrite" }
			for _, group in ipairs(hl_groups) do
				vim.api.nvim_set_hl(0, group, { link = "Visual" })
			end
		end
		set_highlights()

		vim.api.nvim_create_autocmd("ColorScheme", {
			callback = set_highlights,
		})
	end,
	keys = {
		{ "]w", desc = "Next Reference" },
		{ "[w", desc = "Prev Reference" },
	},
}
