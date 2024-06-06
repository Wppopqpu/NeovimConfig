return {
	{
		"folke/neoconf.nvim",
		config = function()
			require("neoconf").setup{}

			require("NeovimConfig.details.lsp_setup").setup()
		end,
		priority = 1000,
		event = "VeryLazy",
	},
}
