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
		config = function()
			local wk = require("which-key")

			wk.setup {
				preset = "helix",
				-- TODO: use new spec for key mappings.
				notify = false,
			}

			wk.add {
				{ "<leader>?", function ()
					wk.show{ global = true }
				end, desc = "which key" },
			}
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
