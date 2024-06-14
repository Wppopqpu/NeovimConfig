return {
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
