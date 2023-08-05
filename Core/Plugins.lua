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
	use 'williamboman/mason.nvim'
	use 'williamboman/mason-lspconfig.nvim'


	use 'nvim-lualine/lualine.nvim'

	use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

	use 'nvim-tree/nvim-tree.lua'
	use 'nvim-tree/nvim-web-devicons'

	use 'akinsho/bufferline.nvim'

	-- nvim-cmp
	use 'hrsh7th/cmp-nvim-lsp' -- nvim_lsp
	use 'hrsh7th/cmp-buffer' -- buffer
	use 'hrsh7th/cmp-path' -- path
	use 'hrsh7th/cmp-cmdline' -- cmdline
	use 'hrsh7th/nvim-cmp'
	-- vsnip
	use 'hrsh7th/cmp-vsnip' -- vsnip
	use 'hrsh7th/vim-vsnip'
	use 'rafamadriz/friendly-snippets'
	-- lspkind
	use 'onsails/lspkind-nvim'

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



	-- auto completion
	local lspkind = require'lspkind'
	local cmp =require'cmp'

	cmp.setup {
		-- set snippet engine
		snippet = {
			expand = function(args)
				vim.fn['vsnip#anonymous'](args.body)
			end,
		},
		sources = cmp.config.sources({
				{ name = 'nvim_lsp' },
				{ name = 'vsnip' },
			}, {
				{ name = 'buffer' },
				{ name = 'path' }
			}
		),
		-- key bindings
		mapping = cmp.mapping.preset.insert {
			['<C-b>'] = cmp.mapping.scroll_docs(-4),
			['<C-f>'] = cmp.mapping.scroll_docs(4),
			['<C-space>'] = cmp.mapping.complete(),
			['<C-e>'] = cmp.mapping.abort(),
			['<CR>'] = cmp.mapping.confirm{ select = true },
		},

		-- use lspkind-nvim to show icons
		formatting = {
			format = lspkind.cmp_format{
				with_text = true,
				maxwidth = 50,
				before = function(entry, vim_item)
					vim_item.menu = '['..string.upper(entry.source.name)..']'
					return vim_item
				end
			}
		}
	}-- cmd.setup

	-- use buffer source for '/' and '?'
	-- do not enable 'native_menu',
	-- otherwise these (the fllowing two) won't work
	cmp.setup.cmdline({ '/', '?'}, {
		mapping = cmp.mapping.preset.cmdline(),
		sources = {
			{ name = 'buffer' }
		}
	})

	-- use command line & path source for ':'
	cmp.setup.cmdline(':', {
		mapping = cmp.mapping.preset.cmdline(),
		sources = cmp.config.sources({
				{ name = 'path' }
			}, {
				{ name = 'cmdline' }
			})
	})



	require'mason'.setup()
	local mason_lspconfig = require'mason-lspconfig'
	mason_lspconfig.setup{
		ensure_installed = {
			'clangd', -- cpp
			'lua_ls', -- lua
			'marksman', -- markdown
			'quick_lint_js', -- javascript
		},
		automatic_installation = false,
	}

	local lspconfig = require'lspconfig'
	local capabilities = require'cmp_nvim_lsp'.default_capabilities()
	mason_lspconfig.setup_handlers{
  		function (server_name)
    		lspconfig[server_name].setup {
				capabilities = capabilities
			}
  		end,
		--[[
		clangd = function()
			lspconfig.clangd.setup{
				cmd = {
					'clangd',
					'--header-insertion=never',
					'--all-scopes-completion'
					'--competion-style=detailed'
				}
			}
		end
		--]]
	}

end)
