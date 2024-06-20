return {
	{
		"danymat/neogen",
		config = function()
			require("neogen").setup{}

			require("which-key").register({
				n = { "<cmd>Neogen<cr>", "create doc" },
			}, { prefix = "<leader>" })
		end,
		event = "VeryLazy",
	},
	{
		"kylechui/nvim-surround",
		version = "*",
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup {
			}
		end,
	},
	{
		"folke/edgy.nvim",
		event = "VeryLazy",
		config =function()
			require("edgy").setup{
			}
		end,
	},
	{
		"madskjeldgaard/cppman.nvim",
		event = "User LazyFt cpp",
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
		config = function()
			-- what can i say
			local man = require("cppman")
			man.setup()

			require("which-key").register({
				r = {
					name = "cppman",
					m = { function ()
						man.open_manual_for(vim.fn.expand("<cword>"))
					end, "for current word" },
					c = { man.input, "search" },
				},
			}, { prefix = "<leader>" })
		end,
	},
}
