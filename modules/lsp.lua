

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
	{
		"danymat/neogen",
		config = function()
			require("neogen").setup{}

			require("which-key").register({
				n = { "<cmd>Neogen<cr>", "create doc" },
			}, { prefix = "<leader>" })
		end,
		event = "VeryLazy",
	},


}
