return {
	{
		'onsails/lspkind.nvim',
		lazy = true,
	},
	{
		'hrsh7th/cmp-nvim-lsp',
		lazy = true,
		event = 'VeryLazy',
	},
	{
		'hrsh7th/cmp-buffer',
		lazy = true,
		event = 'VeryLazy',
	},
	{
		'hrsh7th/cmp-path',
		lazy = true,
		event = 'VeryLazy',
	},
	{
		'hrsh7th/cmp-cmdline',
		lazy = true,
		event = 'VeryLazy',
	},
	{
		"hrsh7th/cmp-emoji",
		event = "VeryLazy",
	},
	{
		'hrsh7th/nvim-cmp', -- load by lspconfig
		lazy = true,
		config = function()
			local cmp = require'cmp'
			local lspkind = require'lspkind'

			cmp.setup {
				formatting = {
					format = lspkind.cmp_format{
						mode = 'symbol',
						maxwidth = 50,
						ellipsis_char = '...',
					},
				},
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
					{ name = "lazydev", group_index=0 },
					{ name = 'nvim_lsp' },
					{ name = 'vsnip' },
					{ name = "emoji" },
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
		event = 'VeryLazy',
	},
	{
		'hrsh7th/vim-vsnip',
		lazy = true,
		event = 'VeryLazy',
	},
}
