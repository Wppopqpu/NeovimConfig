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
	{
		"folke/zen-mode.nvim",
		config = function()
			require("zen-mode").setup{}
			require("which-key").register({
				z = { "<cmd>ZenMode<cr>", "toggle zen mode" },
			}, { prefix = "<leader>" })
		end,
		event = "VeryLazy"
	},
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local todo = require("todo-comments")
			todo.setup{}
			require("which-key").register({
				t = {
					name = "todo comments",
					["["] = { todo.jump_prev, "previos" },
					["]"] = { todo.jump_next, "next" },
					l = { "<cmd>TodoTrouble<cr>", "list" },
				}
			}, { prefix = "<leader>" })
		end,
		event = "VeryLazy",
	},
	{
		"folke/trouble.nvim",
		event = "VeryLazy",
		config = function()
			local trouble = require("trouble")
			require("which-key").register({
				k = {
					name = "trouble list",
					x = { trouble.toggle, "common" },
					w = { function()
						trouble.toggle("workspace_diagnostics")
					end, "workspace diagnostics" },
					d = { function()
						trouble.toggle("document_diagnostic")
					end, "document diagnostics" },
					q = { function()
						trouble.toggle("quickfix")
					end, "quickfix" },
					l = { function()
						trouble.toggle("loclist")
					end, "loclist" },
					r = { function()
						trouble.toggle("lsp_references")
					end, "lsp ref" },
				},
			}, { prefix = "<leader>" })
		end,
	},
	{
		'folke/which-key.nvim',
		event = 'VeryLazy',
		init = function()
			vim.opt.timeout = true
			vim.opt.timeoutlen = 500
		end,
		config = function()
			require'which-key'.setup{}
			require'NeovimConfig.Core.KeyBindings'
		end,
	},
	{
		"folke/neoconf.nvim",
		config = function()
			require("neoconf").setup{}
		end,
		event = "VeryLazy",
	},
	{
		'azadkuh/vim-cmus',
		event = 'VeryLazy',
		config = function()
			require'which-key'.register({
				c = {
					name = 'Cmus',
					c = { '<cmd>Cmus<CR>', 'Menu' },
					n = { '<cmd>CmusCurrent<CR>', 'Current' },
					h = { '<cmd>CmusPrevious<CR>', 'Previous' },
					l = { '<cmd>CmusNext<CR>', 'Next' },
					z = { '<cmd>CmusPlay<CR>', 'Play' },
					x = { '<cmd>CmusPause<CR>', 'Pause' },
					d = { '<cmd>CmusStop<CR>', 'Stop' },
				}
			}, { prefix = '<leader>' })

		end,
	},
}
