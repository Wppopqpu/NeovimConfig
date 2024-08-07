return {
	'lewis6991/gitsigns.nvim',
	event = 'VeryLazy',
	config = function()
		local gs = require'gitsigns'
		gs.setup{
			on_attach = function(buf)
				local wk = require'which-key'
				wk.register({
						['h'] = {
						name = 'Gitsignes.',
						[']'] = { function()
							if vim.wo.diff then return ']' end
							vim.schedule(function() gs.nav_hunk("next") end)
							return '<Ignore>'
						end, '(gitsignes) Next hunk.', expr = true },
						['['] = { function()
							if vim.wo.diff then return '[' end
							vim.schedule(function() gs.nav_hunk("prev") end)
						end, '(gitsignes) Prev hunk.', expr = true },

						s = { gs.stage_hunk, 'Stage hunk' },
						r = { gs.reset_hunk, 'Reset hunk' },
						S = { gs.stage_buffer, 'Stage buffer.' },
						R = { gs.reset_buffer, 'Reset buffer.' },
						u = { gs.undo_stage_hunk, 'Undo stage hunk.' },
						p = { gs.preview_hunk, 'Preview hunk' },
						b = { function()
							gs.blame_line{ full = true }
						end, 'Blame line.'},
						-- tb = { gs.toggle_current_line_blame, 'Current line blame' },
						d = { gs.diffthis, 'Diff this.' },
						D = { function()
							gs.diffthis'~'
						end, 'Diff this (~)' },
						-- td = { gs.toggle_deleted, 'Toggle deleted.' },
						t = {
							name = 'Toggle option',
							b = {
								gs.toggle_current_line_blame,
								'Current line blame',
							},
							d = {
								gs.toggle_deleted,
								'Deleted',
							},
						},
					},
				}, { prefix = '<leader>', buffer = buf })
				wk.register({
					h = {
						name = 'Gitsignes.',
						s = { function()
							gs.stage_hunk { vim.fn.line'.', vim.fn.line'v' }
						end, 'stage hunk' },
						r = { function()
							gs.reset_hunk { vim.fn.line'.', vim.fn.line'v' }
						end, 'reset hunk' },
					},
				}, { prefix = '<leader>', buffer = buf, mode = 'v' })
				wk.register({
					h = {
						name = 'Gitsignes.',
						i = { gs.select_hunk
							, 'Text object.' },
					},
				}, { prefix = '<leader>', buffer = buf, mode = {'o', 'x'} })


			end,
		}
	end,
}
