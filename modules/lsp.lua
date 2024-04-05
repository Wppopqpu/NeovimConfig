local expected = {
	clangd = {},
	html = {},
	jsonls = {},
	ltex = {},
	lua_ls = {},
	pyre = {},
	tsserver = {},
}



return {
	{
		'williamboman/mason-lspconfig.nvim',
		lazy = true,
		config = true
	},
	{
		'neovim/nvim-lspconfig',
		event = 'VeryLazy',
		config = function()
			-- load order solved there.
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
				h = {
					name = 'call hierarchy',
					i = { ':Lspsaga incoming_calls<CR>', 'incoming' },
					o = { ':Lspsaga outgoing_calls<CR>', 'outgoing' },
				},
				a = { ':Lspsaga code_action<CR>', 'code action' },
				d = {
					name = 'defination',
					p = {
						name = 'peek',
						f = { ':Lspsaga peek_defination<CR>' },
						t = { ':Lspsaga peek_type_defination<CR>' },
					},
					g = {
						name = 'go to',
						f = { ':Lspsaga goto_defination<CR>' },
						t = { ':Lspsaga goto_type_defination<CR>' },
					},
					o = { '<cmd>Lspsaga outline', 'symbols outline' },
					r = { '<cmd>Lspsaga rename', 'rename' },
				},
				e = {
					name = 'diagnostic',
					j = { ':Lspsaga diagnostic_jump_next<CR>', 'next' },
					k = { ':Lspsaga diagnostic_jump_prev<CR>', 'prev' },
				},
				f = { ':Lspsaga finder<CR>', 'lsp finder' },
				t = { ':Lspsaga term_toggle<CR>', 'terminal' },


			}, {prefix = '<leader>'})
			wk.register({
				K = { '<cmd>Lspsaga hover_doc', 'hover doc' },
			},{})

		end,
		dependencies = {
			'nvim-treesitter/nvim-treesitter',
			'nvim-tree/nvim-web-devicons',
			'neovim/nvim-lspconfig',
		},
		event = 'VeryLazy',
	},
	-- auto kill lsp to free ram
	{
		'zeioth/garbage-day.nvim',
		dependencies = 'neovim/nvim-lspconfig',
		opts = {
			-- time to wait before killing after nvim lose focus.
			grace_period = 60*15,
		},
	},

}
