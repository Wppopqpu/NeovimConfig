return {
	{
		"folke/zen-mode.nvim",
		config = function()
			require("zen-mode").setup{}
			require("which-key").register({
				z = { ":ZenMode<cr>", "toggle zen mode" },
			}, { prefix = "<leader>" })
		end,
		event = "VeryLazy"
	},
}
