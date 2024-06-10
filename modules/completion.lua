return {
	{
		'onsails/lspkind.nvim',
		lazy = true,
	},
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
		"hrsh7th/cmp-emoji",
		lazy = true,
	},
	{
		"petertriho/cmp-git",
		lazy = true,
		config = true,
	},
	{
		'hrsh7th/nvim-cmp',
		event = "VeryLazy",
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
						require("luasnip").lsp_expand(args.body)
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
					{ name = "luasnip" },
					{ name = "emoji" },
				}, {
					{ name = 'buffer' },
					{ name = "path" },
				}),
			}

			cmp.setup.filetype('gitcommit', {
				sources = cmp.config.sources({
					{ name = 'git' },
				}, {
					{ name = 'buffer' },
					{ name = "path" },
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
		end,
		dependencies = {
			"hrsh7th/cmp-path",
			"petertriho/cmp-git",
			"hrsh7th/cmp-emoji",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-nvim-lsp",
			"onsails/lspkind.nvim",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
		},
	},
--[[
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
--]]
	{
		"L3MON4D3/LuaSnip",
		lazy = true,
		-- see the doc of friendly-snippets
		dependencies = { "rafamadriz/friendly-snippets" },
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load()
		end,
		build = "make install_jsregexp",
	},
	{
		"saadparwaiz1/cmp_luasnip",
		lazy = true,
	},
	{
		"rafamadriz/friendly-snippets",
		lazy = true, -- load by luasnip
	},
}
