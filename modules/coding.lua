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
	{
		"RRethy/vim-illuminate",
		event = "VeryLazy",
		config = function ()
			local illu = require("illuminate")
			illu.configure {
				filetypes_denylist = {
					"NvimTree",
					"sagaoutline",
					"lazy",
					"dirbuf",
					"dirwish",
					"fugitive",
					"mason",
					"toggleterm",
					"qf",
					"Trouble",
					"noice",
					"dap-repl",
					"help",
					"man",
				},
				modes_allowlist = {
					"n",
				},
			}
		end,
	},
}
