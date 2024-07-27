return {
	{
		"MeanderingProgrammer/markdown.nvim",
		main = "render-markdown",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
		event = "User LazyFt markdown",
		config = function ()
			local m = require("render-markdown")

			m.setup {
			}

			vim.cmd("RenderMarkdown enable")
		end,
	},
}
