return {
	{
		"gbprod/yanky.nvim",
		event = "VeryLazy",
		config = function()
			require("yanky").setup{}

			local which = require("which-key")

			which.register({
				p = { "<plug>(YankyPutAfter)", "put after" },
				P = { "<plug>(YankyPutBefore)", "put before" },
				gp = { "<plug>(YankyGPutAfter)", "g put after" },
				gP = { "<plug>(YankyGPutBefore)", "g put before" },
			}, { mode = { "n", "x" } })

			which.register{
				["<c-p>"] = { "<plug>(YankyPreviosEntry)", "previos entry" },
				["<c-n>"] = { "<plug>(YankyNextEntry)", "next entry" },
				["["] = {
					p = { "<plug>(YankyPutIndentBeforeLinewise)", "put indent before linewise" },
				},
			}
		end,
	},
}
