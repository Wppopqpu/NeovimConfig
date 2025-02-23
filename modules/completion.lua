local blink_keymap = {
	preset = "default",
	["<c-k>"] = { "select_prev", "fallback" },
	["<c-j>"] = { "select_next", "fallback" },
	["<c-p>"] = { "fallback" }, -- disabled
	["<c-n>"] = { "fallback" },
	["<c-space>"] = { "show", "fallback" },
	["<a-space>"] = { "show", "fallback" },
}

for i = 1,10 do
	blink_keymap["<a-"..tostring(i)..">"] = {
		function(cmp)
			cmp.accept({ index = 1 })
		end,
	}
end

return {
	{
		"saghen/blink.cmp",
		dependencies = "rafamadriz/friendly-snippets",
		version = "*",
		lazy = false, -- handled internally
		opts_extend = { "sources.default" },
		opts = {
			snippets = {
				preset = "luasnip",
			},
			completion = {
				accept = {
					auto_brackets = {
						enabled = true,
					},
				},
				menu = {
					auto_show = false,
					draw = {
						columns = { { 'item_idx' }, { 'kind_icon' }, { 'label', 'label_description', gap = 1 } },
						components = {
							kind_icon = {
								ellipsis = false,
								text = function (ctx)
									local lspkind = require("lspkind")
									local icon = ctx.kind_icon
									local provider = require("nvim-web-devicons")
									if vim.tbl_contains({ "Path" }, ctx.source_name) then
										local dev_icon, _ = provider.get_icon(ctx.label)
										if dev_icon then
											icon = dev_icon
										end
									else
										icon = lspkind.symbolic(ctx.kind, {
											mode = "symbol",
										})
									end

									return icon .. ctx.icon_gap
								end,
							},
							item_idx = {
								text = function (ctx)
									return ctx.idx == 10 and '0' or ctx.idx >= 10 and ' ' or tostring(ctx.idx)
								end,
							},
						},
						treesitter = { "lsp" },
					},
				},
				documentation = {
					auto_show = true,
				},
				ghost_text = {
					enabled = true,
				},
			},
			keymap = blink_keymap,
			appearance = {
				use_nvim_cmp_as_default = false,
				nerd_font_variant = "mono",
			},
			sources = {
				default = {
					"lsp",
					"buffer",
					"lazydev",
					"snippets",
					"path",
					"cmdline",
				},
				providers = {
					lsp = {},
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						fallbacks = { "lsp" },
					},
					cmdline = {
						enabled = function ()
							return vim.fn.getcmdtype() ~= ":" or not vim.fn.getcmdline():match("^[%%0-9,'<>%-]*!")
						end,
					},
				}
			},
			signature = {
				enabled = true,
				window = {
					scrollbar = true,
				},
			},
		},
	},
	{
		'onsails/lspkind.nvim',
		lazy = true,
	},
-- 	{
-- 		'hrsh7th/cmp-nvim-lsp',
-- 		lazy = true,
-- 	},
-- 	{
-- 		'hrsh7th/cmp-buffer',
-- 		lazy = true,
-- 	},
-- 	{
-- 		'hrsh7th/cmp-path',
-- 		lazy = true,
-- 	},
-- 	{
-- 		'hrsh7th/cmp-cmdline',
-- 		lazy = true,
-- 	},
-- 	{
-- 		"hrsh7th/cmp-emoji",
-- 		lazy = true,
-- 	},
-- 	{
-- 		"petertriho/cmp-git",
-- 		lazy = true,
-- 		config = true,
-- 	},
-- 	{
-- 		'hrsh7th/nvim-cmp',
-- 		event = {
-- 			"InsertEnter",
-- 			"CmdlineEnter",
-- 		},
-- 		config = function()
-- 			local cmp = require'cmp'
-- 			local lspkind = require'lspkind'
--
-- 			cmp.setup {
-- 				experimental = {
-- 					-- ghost_text = true,
-- 				},
-- 				view = {
-- 					docs = {
-- 						auto_open = true,
-- 					},
-- 				},
-- 				preselect = cmp.PreselectMode.Item,
-- 				formatting = {
-- 					format = lspkind.cmp_format{
-- 						mode = 'symbol',
-- 						maxwidth = 50,
-- 						ellipsis_char = '...',
-- 					},
-- 				},
-- 				snippet = {
-- 					expand = function(args)
-- 						require("luasnip").lsp_expand(args.body)
-- 					end,
-- 				},
-- 				mapping = cmp.mapping.preset.insert{
-- 					['<c-b>'] = cmp.mapping.scroll_docs(-4),
-- 					['<c-f>'] = cmp.mapping.scroll_docs(4),
-- 					["<c-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
-- 					["<c-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
-- 					['<c-e>'] = cmp.mapping.abort(),
-- 					['<cr>'] = cmp.mapping.confirm{ select = true },
-- 				},
-- 				sources = cmp.config.sources({
-- 					{ name = "lazydev", group_index=0 },
-- 					{ name = 'nvim_lsp' },
-- 					{ name = "luasnip" },
-- 					{ name = "emoji" },
-- 				}, {
-- 					{ name = 'buffer' },
-- 					{ name = "path" },
-- 				}),
-- 				window = {
-- 					completion = {
-- 						winblend = 15,
-- 					},
-- 					documentation = {
-- 						winblend = 15
-- 					},
-- 				},
-- 			}
--
-- 			cmp.setup.filetype('gitcommit', {
-- 				sources = cmp.config.sources({
-- 					{ name = 'git' },
-- 				}, {
-- 					{ name = "emoji" },
-- 				}, {
-- 					{ name = 'buffer' },
-- 					{ name = "path" },
-- 				}),
-- 			})
--
-- 			cmp.setup.cmdline({ '/', '?' }, {
-- 				mapping = cmp.mapping.preset.cmdline(),
-- 				sources = {
-- 					{ name = 'buffer' },
-- 				},
-- 			})
--
-- 			cmp.setup.cmdline(':', {
-- 				mapping = cmp.mapping.preset.cmdline(),
-- 				sources = cmp.config.sources({
--     				{ name = 'path' }
-- 				}, {
-- 					{ name = 'cmdline' }
--     			}),
--     			matching = { disallow_symbol_nonprefix_matching = false },
-- 			})
-- 		end,
-- 		dependencies = {
-- 			"hrsh7th/cmp-path",
-- 			"petertriho/cmp-git",
-- 			"hrsh7th/cmp-emoji",
-- 			"hrsh7th/cmp-buffer",
-- 			"hrsh7th/cmp-cmdline",
-- 			"hrsh7th/cmp-nvim-lsp",
-- 			"onsails/lspkind.nvim",
-- 			"L3MON4D3/LuaSnip",
-- 			"saadparwaiz1/cmp_luasnip",
-- 		},
-- 	},
-- --[[
-- 	{
-- 		'hrsh7th/cmp-vsnip',
-- 		lazy = true,
-- 		event = 'VeryLazy',
-- 	},
-- 	{
-- 		'hrsh7th/vim-vsnip',
-- 		lazy = true,
-- 		event = 'VeryLazy',
-- 	},
-- --]]
	{
		"L3MON4D3/LuaSnip",
		lazy = true,
		version = "v2.*",
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
