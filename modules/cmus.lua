return {
	{
		'azadkuh/vim-cmus',
		event = 'VeryLazy',
		config = function()
			vim.cmd('source '..require'NeovimConfig.Core.lazypath'
				.. 'vim-cmus/plugin/cmus.vim')
		end,
	},
}
