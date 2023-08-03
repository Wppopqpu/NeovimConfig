-- Plugins.lua
return require( 'packer' ).startup(function( use )
	use {
		'goolord/alpha-nvim',
		config = function ()
			require'alpha'.setup(require'alpha.themes.dashboard'.config)
		end
	}

	use 'wbthomason/packer.nvim'

	use 'folke/tokyonight.nvim'

	use 'lukas-reineke/indent-blankline.nvim'

	use 'lewis6991/gitsigns.nvim'

	use 'neovim/nvim-lspconfig'
	use 'williamboman/nvim-lsp-installer'


	use 'nvim-lualine/lualine.nvim'

	use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

	use 'nvim-tree/nvim-tree.lua'
	use 'nvim-tree/nvim-web-devicons'

	use 'akinsho/bufferline.nvim'

	vim.cmd( 'colorscheme tokyonight' )
	vim.opt.list = true
	vim.opt.listchars:append "eol:↴"
	
	require"indent_blankline".setup{
    	show_end_of_line = true,
	}

	require'gitsigns'.setup{
		signs = {
			add = {text = '▎'},
			change = {text = '▎'},
			delete = {text = '➤'},
			topdelete = {text = '➤'},
			changedelete = {text = '▎'},
		},
	}


	require'lualine'.setup{
		options = {
			theme = 'tokyonight',
			icons_enabled = true,
			component_separators = '|',
			section_separators = ' ',
		},
	}

	require'nvim-treesitter.configs'.setup {
		ensure_installed =
		{ 'html'
		, 'css'
		, 'vim'
		, 'lua'
		, 'javascript'
		, 'typescript'
		, 'cpp'
		, 'c'
		, 'python'},

	highlight = {
		enabled = true,
		additional_vim_regex_highlighting = false,
		disable = function(lang, buf)
			local max_filesize = 100 * 1024 -- 100 KB
			local ok, stats = pcall(
				vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf)
			)
			if ok and stats and stats.size > max_filesize then
				return true
			end
		end
		},
	}

	require'nvim-tree'.setup {
    	git = {
        	enable = true
    	}
	}


	require('bufferline').setup {
		options = {
			diagnostic = 'nvim_lsp',
			offsets = {
				{
					filetype = 'NvimTree',
					text = 'File Explorer',
					highlight = 'Directory',
					text_align = 'left'
				}
			}
		}
	}

end)
