return {
	{
		'Julian/lean.nvim',
		event = {
			'BufReadPre *.lean',
			'BufNewFile *.lean',
		},
		dependencies = {
			'neovim/nvim-lspconfig',
			'nvim-lua/plenary.nvim',
			'andrewradev/switch.vim',
		},
		opts = {
			lsp = {
			},
			mappings = true,
		},
	},
}
