-- Plugins.lua
return require( 'packer' ).startup(function( use )
	use 'wbthomason/packer.nvim'

	use 'folke/tokyonight.nvim'
	vim.cmd( 'colorscheme tokyonight' )



	use "lukas-reineke/indent-blankline.nvim"
		vim.opt.list = true
	vim.opt.listchars:append "eol:↴"
	
	require("indent_blankline").setup {
    	show_end_of_line = true,
	}
end)
