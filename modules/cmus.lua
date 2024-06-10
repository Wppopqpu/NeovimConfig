return {
	{
		'azadkuh/vim-cmus',
		event = 'VeryLazy',
		config = function()
			require'which-key'.register({
				c = {
					name = 'Cmus',
					c = { ':Cmus<CR>', 'Menu' },
					n = { ':CmusCurrent<CR>', 'Current' },
					h = { ':CmusPrevious<CR>', 'Previous' },
					l = { ':CmusNext<CR>', 'Next' },
					z = { ':CmusPlay<CR>', 'Play' },
					x = { ':CmusPause<CR>', 'Pause' },
					d = { ':CmusStop<CR>', 'Stop' },
				}
			}, { prefix = '<leader>' })

		end,
	},
}
