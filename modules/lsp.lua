local expected = {
	clangd = {
		settings = {
			C_Cpp = {
				defaultLanguageVersion = 'cpp20',
			},
		},
	},
	html = {},
	jsonls = {},
	ltex = {},
	lua_ls = {},
	pyre = {},
	tsserver = {},
}



return {
	{
		'williamboman/mason.nvim',
		lazy = true,
		config = true,
	},
	{
		'williamboman/mason-lspconfig.nvim',
		lazy = true,
		config = true
	},
	{
		'neovim/nvim-lspconfig',
		event = 'VeryLazy',
		config = function()
			require'mason'
			require'mason-lspconfig'


			local lspconfig = require'lspconfig'

			local startServer = function(name, config)
				lspconfig[name].setup(config)
			end

			for k, v in pairs(expected) do
				pcall(startServer, k, v)
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
			'neovim/nvim-lspconfig',
		},
		event = 'VeryLazy',
	},

}
