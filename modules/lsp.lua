

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
			-- neoconf must be setup before setting up servers.
			require"neoconf"

		end,
		init = function()
			require("NeovimConfig.details.on_lazy").register(require("NeovimConfig.details.lsp_setup").setup)
		end,
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
	{
		"folke/lazydev.nvim",
		event = "VeryLazy",
		dependencies = { "Bilal2453/luvit-meta" },
		enabled = function()
			-- only enable when supported
			local version = vim.version()
			if version.major == 0 and version.minor < 10 then
				return false
			end
			return true

		end,
		config = function()
			require("lazydev").setup {
				library = {
					{ path = "luvit-meta/library", words = { "vim%.uv" } },
				},
			}
		end,
	},
}
