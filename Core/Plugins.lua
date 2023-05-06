-- Plugins.lua
return require( 'packer' ).startup(function( use )
	use 'wbthomason/packer.nvim'

	use 'folke/tokyonight.nvim'

	use 'lukas-reineke/indent-blankline.nvim'

	use 'lewis6991/gitsigns.nvim'

	use 'neovim/nvim-lspconfig'
	use 'williamboman/nvim-lsp-installer'

	use 'kyazdani42/nvim-web-devicons'

	use 'nvim-lualine/lualine.nvim'



	vim.cmd( 'colorscheme tokyonight' )
	vim.opt.list = true
	vim.opt.listchars:append "eol:↴"
	
	require("indent_blankline").setup({
    	show_end_of_line = true,
	})

	require('gitsigns').setup({
		signs = {
			add = {text = '▎'},
			change = {text = '▎'},
			delete = {text = '➤'},
			topdelete = {text = '➤'},
			changedelete = {text = '▎'},
		},
	})


	require('lualine').setup({
		options = {
			theme = 'tokyonight',
			icons_enabled = true,
			component_separators = '|',
			section_separators = ' ',
		},
	})



end)
