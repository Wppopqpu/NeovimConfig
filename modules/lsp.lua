local get_config = function()
	local config = {
		clangd = {
			capabilities = {
				textDocument = {
					semanticHighlightingCapabilities = {
						semanticHighlighting = true,
					},
				},
			},
			on_init = require'nvim-lsp-clangd-highlight'.on_init
		},
		html = {},
		jsonls = {},
		ltex = {},
		lua_ls = {},
		pyre = {},
		tsserver = {},
		leanls = {},
		lean3ls = {},
	}
	function on_attach(client, n_buffer)
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
				o = { '<cmd>Lspsaga outline<cr>', 'symbols outline' },
				r = { '<cmd>Lspsaga rename<cr>', 'rename' },
				k = { '<cmd>Lspsaga hover_doc<cr>', 'hover doc' },
			},
			e = {
				name = 'diagnostic',
				j = { ':Lspsaga diagnostic_jump_next<CR>', 'next' },
				k = { ':Lspsaga diagnostic_jump_prev<CR>', 'prev' },
			},
			f = { ':Lspsaga finder<CR>', 'lsp finder' },

		}, { prefix = '<leader>', buffer = n_buffer })

	end

	for _, each in pairs(config) do
		each.on_attach = on_attach
	end

	return config
end



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
				config.capabilities =
					require'cmp_nvim_lsp'.default_capabilities()
				lspconfig[name].setup(config)
			end

			for k, v in pairs(get_config()) do
				pcall(startServer, k, v)
			end

			-- if nvim was start with a file arg,
			-- i.e. the file was opened before lspconfig was setup,
			-- we should manually start it.
		end
	},
	{
		'adam-wolski/nvim-lsp-clangd-highlight',
		lazy = true,
	},
	{
		'nvimdev/lspsaga.nvim',
		config = function()
			require'lspsaga'.setup{
				code_action = {
					extend_gitsigns = true,
				},
			}
				end,
		dependencies = {
			'nvim-treesitter/nvim-treesitter',
			'nvim-tree/nvim-web-devicons',
			'neovim/nvim-lspconfig',
		},
		event = 'LspAttach',
	},
	-- auto kill lsp to free ram
	{
		'zeioth/garbage-day.nvim',
		dependencies = 'neovim/nvim-lspconfig',
		opts = {
			-- time to wait before killing after nvim lose focus.
			grace_period = 60*15,
		},
		event = 'LspAttach',
	},

}
