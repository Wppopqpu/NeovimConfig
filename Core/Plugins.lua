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
	-- nvim-cmp
	-- use 'hrsh7th/cmp-nvim-lsp' -- { name = nvim_lsp }
	use 'hrsh7th/cmp-buffer'   -- { name = 'buffer' },
	use 'hrsh7th/cmp-path'     -- { name = 'path' }
	use 'hrsh7th/cmp-cmdline'  -- { name = 'cmdline' }
	use 'hrsh7th/nvim-cmp'
	-- vsnip
	use 'hrsh7th/cmp-vsnip'    -- { name = 'vsnip' }
	use 'hrsh7th/vim-vsnip'
	use 'rafamadriz/friendly-snippets'
	-- lspkind
	use 'onsails/lspkind-nvim'
end)
