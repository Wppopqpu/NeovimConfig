return {
	{
		'williamboman/mason.nvim',
		lazy = true,
		config = true,
	},
	{
		'williamboman/mason-lspconfig.nvim',
		lazy = true,
		config = function()
			require'mason-lspconfig'.setup{
				ensure_installed = {
					'clangd',
					'html',
					'jsonls',
					'ltex',
					'lua_ls',
					'pyre',
					'tsserver',
				},
			}
		end,
	},
	{
		'neovim/nvim-lspconfig',
		event = 'VeryLazy',
		config = function()
			require'mason'
			require'mason-lspconfig'
			local lspconfig = require'lspconfig'
			for i, v in pairs(lspconfig) do
				v.setup{}
			end
		end
	},
	{
		'nvimdev/lspsaga.nvim',
		config = function()
			require'lspsaga'.setup{
				code_action = {
					extend_gitsigns = true,
				},
			}
			local wk = require'which-key'
			wk.register({
				c = {
					name = 'call hierarchy',
					i = { ':Lspsaga incoming_calls<CR>', 'incoming' },
					o = { ':Lspsaga outgoing_calls<CR>', 'outgoing' },
				},
				a = { ':Lspsaga code_action<CR>', 'code action' },
				d = {
					name = 'to defination',
					p = {
						name = '+peek',
						f = { ':Lspsaga peek_defination<CR>' },
						t = { ':Lspsaga peek_type_defination<CR>' },
					},
					g = {
						name = '+go to',
						f = { ':Lspsaga goto_defination<CR>' },
						t = { ':Lspsaga goto_type_defination<CR>' },
					},
				},
			}, {prefix = '<leader'})
		end,
		dependencies = {
			'nvim-treesitter/nvim-treesitter',
			'nvim-tree/nvim-web-devicons',
		},
		event = 'LspAttach',
	},

}
