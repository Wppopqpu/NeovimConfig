return {
	{
		"folke/neoconf.nvim",
		config = function()
			require("neoconf").setup{}

			require("NeovimConfig.details.lsp_setup").setup()
		end,
		event = "VeryLazy",
	},
}
