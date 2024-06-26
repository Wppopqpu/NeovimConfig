return {
	{
		"nvim-telescope/telescope.nvim",
		event = "VeryLazy",
		config = function()
			local tele = require("telescope")
			local builtin = require("telescope.builtin")
			local wk = require("which-key")
			local actions = require("telescope.actions")
			local tr_tele = require("trouble.sources.telescope")
			local tr_open = tr_tele.open
			local tr_add = tr_tele.add

			local mappings = {
				["<c-o>"] = tr_open,
				["<c-a>"] = tr_add,
			}

			tele.setup {
				defaults = {
					mappings = {
						i = mappings,
						n = mappings,
					},
				},
			}

			tele.load_extension("fzf")

			wk.register({
				u = {
					name = "telescope",
					u = { builtin.find_files, "find files" },
					f = { builtin.current_buffer_fuzzy_find, "fuzzy for current buf" },
					p = { builtin.resume, "resume" },
					P = { builtin.pickers, "resume (select)"},
					g = { builtin.live_grep, "live grep" },
					b = { builtin.buffers, "buffers" },
					h = { builtin.help_tags, "help_tags" },
					H = { builtin.highlights, "highlights" },
					k = { builtin.keymaps, "key mappings" },
					s = { builtin.spell_suggest, "spell_suggest" },
					a = { builtin.autocmds, "autocmds" },
					m = { builtin.man_pages, "man pages" },
					n = { builtin.builtin, "pickers" },
					i = {
						name = "git",
						i = { builtin.git_files, "files" },
						t = { builtin.git_stash, "stash" },
						s = { builtin.git_status, "status" },
						c = { builtin.git_commits, "commits" },
						b = { builtin.git_branches, "branches" },
						o = { builtin.git_bcommits, "bcommits" },
					},
				},
			}, { prefix = "<leader>" })
		end,
		version = "*",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
		},
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make",
		lazy = true,
	},
}
