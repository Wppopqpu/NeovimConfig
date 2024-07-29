return {
	{
		"gbprod/yanky.nvim",
		event = "VeryLazy",
		config = function()
			require("yanky").setup{
				ring = {
					storage = "sqlite",
				},
			}

			local tele = require("telescope")
			tele.load_extension("yank_history")

			local which = require("which-key")

			which.register({
				p = { "<plug>(YankyPutAfter)", "put after" },
				P = { "<plug>(YankyPutBefore)", "put before" },
				gp = { "<plug>(YankyGPutAfter)", "g put after" },
				gP = { "<plug>(YankyGPutBefore)", "g put before" },
			}, { mode = { "n", "x" } })

			--[[
			which.register{
				["[y"] = { "<plug>(YankyPreviosEntry)", "previos entry" },
				["]y"] = { "<plug>(YankyNextEntry)", "next entry" },
				["["] = {
					p = { "<plug>(YankyPutIndentBeforeLinewise)", "put indent before linewise" },
				},
			}
			--]]
			which.add {
				{ "[y", "<plug>(YankyPreviosEntry)", desc = "yanky: previous entry" },
				{ "]y", "<plug>(YankyNextEntry)", desc = "yanky: next entry" },
				{ "[p", "<plug>(YankyPutIndentBeforeLinewise)", desc = "yanky: indent before linewise" },
				{ "]p", "<plug>(YankyPutIndentAfterLinewise)", desc = "yanky: indent after linewise" },
				{ "<p", "<plug>(YankyPutIndentAfterShiftLeft)", desc = "yanky: indent after shift left" },
				{ "<P", "<plug>(YankyPutIndentBeforeShiftLeft)", desc = "yanky: indent before shift left" },
				{ ">p", "<plug>(YankyPutIndentAfterShiftRight)", desc = "yanky: indent after shift right" },
				{ ">P", "<plug>(YankyPutIndentBeforeShiftRight)", desc = "yanky: indent before shift right" },
				{ "<a-f>", "<plug>(YankyPutAfterFilter)", desc = "yanky: after filter" },
				{ "<a-F>", "<plug>(YankyPutBeforeFilter)", desc = "yanky: before filter" },
				{ "<a-y>", tele.extensions.yank_history.yank_history, desc = "yanky: pick in telescope" },
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
		init = function ()
			vim.opt.laststatus = 3
			vim.opt.splitkeep = "screen"
		end,
		config =function()
			_G.edgy = require("edgy")
			require("edgy").setup{
				bottom = {
					{
						ft = "toggleterm",
						title = "TERMINAL",
						size = { height = 0.4 },
						-- no floating windows
						filter = function (buf, win)
							return vim.api.nvim_win_get_config(win).relative == ""
						end,
					},
					"Trouble",
					{ ft = "qf", title = "QUICKFIX" },
					{
						ft = "dap-repl",
						size = { height = 0.4 },
						title = "DAP REPLY",
					}
				},
				right = {
					{
						ft = "help",
						title = "HELP",
						size = { width = 80 },
						filter = function (buf)
							return vim.bo[buf].buftype == "help"
						end,
					},
					{
						ft = "man",
						title = "MAN PAGES",
						size = { width = 80 },
						filter = function (buf, win)
							return vim.api.nvim_win_get_config(win).relative == ""
						end,
					},
					{
						ft = "sagaoutline",
						title = "OUTLINE",
						size = { width = 30 },
					},
				},
			}

			require("which-key").add {
				{ "<a-o>", edgy.select, desc = "edgy: select window" },
				{ "<a-q>", edgy.goto_main, desc = "edgy: goto last main window" },
				{ "<a-Q>", edgy.close, desc = "edgy: close all" },
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
					r = { man.input, "search" },
				},
			}, { prefix = "<leader>" })
		end,
	},
	{
		"folke/twilight.nvim",
		event = "VeryLazy",
		config = true,
	},
	{
		"folke/zen-mode.nvim",
		config = function()
			local incline = require("incline")
			require("zen-mode").setup{
				kitty = {
					enabled = true,
				},
				on_open = function ()
					incline.disable()
					vim.cmd("Hardtime disable")
				end,
				on_close = function ()
					incline.enable()
					vim.cmd("Hardtime enable")
				end,
			}
			require("which-key").register({
				z = { "<cmd>ZenMode<cr>", "toggle zen mode" },
			}, { prefix = "<leader>" })
		end,
		event = "VeryLazy",
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
	-- project-local configuration management.
	{
		"folke/neoconf.nvim",
		config = function()
			require("neoconf").setup{}
		end,
		event = "VeryLazy",
	},
	{
		"jedrzejboczar/exrc.nvim",
		event = "VeryLazy",
		opt = {
			on_vim_enter = false, -- as it is lazy loaded.
		},
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
	{
		"2KAbhishek/nerdy.nvim",
		event = "VeryLazy",
		config = function ()
			local tele = require("telescope")
			local wk = require("which-key")

			tele.load_extension("nerdy")

			wk.add {
				{ "<leader>u,",tele.extensions.nerdy.nerdy , desc = "nerd icons" },
			}
		end ,
		dependencies = {
			"stevearc/dressing.nvim",
			"nvim-telescope/telescope.nvim",
		},
	},
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		config = function ()
			local wk = require("which-key")
			local fl = require("flash")

			fl.setup {
				search = {
					enabled = true,
				},
				label = {
					rainbow = {
						enable = true,
					},
				},
			}

			wk.add {
				mode = { "n", "x", "o"},
				{ "<leader>j", group = "flash" },
				{ "<leader>jt", fl.treesitter, desc = "treesitter mode" },
				{ "<leader>js", fl.treesitter_search, mode = { "o", "x" }, desc = "treesitter search mode" },
				{ "<leader>jj", fl.jump, desc = "jump" },
				{ "<leader>jr", fl.remote, mode = "o", desc = "remote mode" },
				{ "<c-j>", fl.toggle, mode = "c", desc = "toggle in regular search" },
			}
		end,
	},
	{
		"rainzm/flash-zh.nvim",
		event = "VeryLazy",
		dependencies = {
			"folke/flash.nvim",
		},
		config = function ()
			require("which-key").add {
				mode = { "n", "x", "o" },
				{ "<leader>jc", function ()
					require("flash-zh").jump {
						chinese_only = false,
					}
				end, desc = "chinese mode" },
			}
		end,
	},
	{
		"LunarVim/bigfile.nvim",
		config = true,
	},
}
