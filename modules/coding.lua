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
					"log",
					"lspinfo",
				},
				modes_allowlist = {
					"n",
				},
			}
		end,
	},
	-- fold enhancement
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
	{
		"kevinhwang91/nvim-ufo",
		config = function ()
			local ufo = require("ufo")

			ufo.setup {
			}

			require("which-key").add {
				{ "zR", ufo.openAllFolds, desc = "open all folds" },
				{ "zM", ufo.closeAllFolds, desc = "close all folds" },
			}
		end,
		dependencies = "kevinhwang91/promise-async",
		init = function ()
			vim.opt.foldcolumn = "1"
			vim.opt.foldlevel = 99
			vim.opt.foldlevelstart = 99
			vim.opt.foldenable = true
		end,
		event = "VeryLazy",
	},
	{
		"numToStr/Comment.nvim",
		event = "VeryLazy",
		config = true,
	},
	{
		-- abbr reminder
		"0styx0/abbreinder.nvim",
		event = "InsertEnter",
		config = true,
		dependencies = "0styx0/abbremand.nvim",
	}
}
