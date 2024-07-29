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
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function ()
			local npairs = require("nvim-autopairs")
			local npairs_cmp = require("nvim-autopairs.completion.cmp")
			local cmp = require("cmp")

			npairs.setup {
				check_ts = true,
			}

			cmp.event:on("confirm_done", npairs_cmp.on_confirm_done)
		end,
	},
}
