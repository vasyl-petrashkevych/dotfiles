return {
	"smoka7/multicursors.nvim",
	cmd = { "MCstart", "MCvisual", "MCclear", "MCpattern", "MCvisualPattern", "MCunderCursor" },
	dependencies = { "nvimtools/hydra.nvim" },
	opts = {},
	keys = {
		{
			"<Leader>m",
			"<cmd>MCstart<CR>",
			mode = { "n", "v" },
			desc = "Create a selection for selected text or word under the cursor",
		},
	},
}
