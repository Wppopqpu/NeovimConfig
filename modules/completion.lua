return {
	{
		'hrsh7th/cmp-nvim-lsp',
		lazy = true,
	},
	{
		'hrsh7th/cmp-buffer',
		lazy = true,
	},
	{
		'hrsh7th/cmp-path',
		lazy = true,
	},
	{
		'hrsh7th/cmp-cmdline',
		lazy = true,
	},
	{
		'hrsh7th/nvim-cmp',
		lazy = true,
		config = function()
			local cmp = require'cmp'

			cmp.setup {
				snippet = {
					expand = function(args)
						vim.fn['vsnip#anonymous'](args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert{
					['<c-b>'] = cmp.mapping.scroll_docs(-4),
					['<c-f>'] = cmp.mapping.scroll_docs(4),
					['<c-space>'] = cmp.mapping.complete(),
					['<c-e>'] = cmp.mapping.abort(),
					['<cr>'] = cmp.mapping.confirm{ select = true },
				},
				sources = cmp.config.sources({
					{ name = 'nvim_lsp' },
					{ name = 'vsnip' },
				}, {
					{ name = 'buffer' },
				}),
			}

			cmp.setup.filetype('gitcommit', {
				sources = cmp.config.sources({
					{ name = 'git' },
				}, {
					{ name = 'buffer' },
				}),
			})

			cmp.setup.cmdline({ '/', '?' }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = 'buffer' },
				},
			})

			cmp.setup.cmdline(':', {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
    				{ name = 'path' }
				}, {
					{ name = 'cmdline' }
    			}),
    			matching = { disallow_symbol_nonprefix_matching = false },
			})
		end
	},
	{
		'hrsh7th/cmp-vsnip',
		lazy = true,
	},
	{
		'hrsh7th/vim-vsnip',
		lazy = true,
	},
}
