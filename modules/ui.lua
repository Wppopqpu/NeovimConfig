return {
	{
		'folke/tokyonight.nvim',
		lazy = false,
		priority = 1000, -- Make sure to load this plugin before others.
		config = function()
			vim.cmd'colorscheme tokyonight'
		end,
	},
	{
		'stevearc/dressing.nvim',
		event = 'VeryLazy', -- Not important for the initial UI
		config = true,
	},
	{
		'nvim-lualine/lualine.nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		config = function()
			local xmakeComponent = {
				function()
					local xmake = require'xmake.project_config'.info
					if xmake.target.tg == '' then
						return ''
					end
					return xmake.target.tg..'('..xmake.mode..')'
				end,
				cond = function()
					return vim.o.columns > 100
				end,
				on_click = function()
					require'xmake.project_config.menu'.init()
				end,
			}
			require'lualine'.setup {
				sections = {
					lualine_y = {
						xmakeComponent,
					},
				},
			}
		end,

	},
	{
		'akinsho/bufferline.nvim',
		dependencies = 'nvim-tree/nvim-web-devicons',
		config = function()
			require'bufferline'.setup {
				options = {
					hover = {
						enable = true,
						delay = 200,
						reveal = { 'close' },
					},
					separator_style = 'slant',

					offsets = {
						{
							filetype = 'NvimTree',
							text = 'Explorer',
							highlight = 'Directory',
							text_align = 'center',
						},
					},
				},
			}
			local map = vim.keymap.set
			map('n', '<C-h>', ':BufferLineCyclePrev<CR>')
			map('n', '<C-l>', ':BufferLineCycleNext<CR>')
		end,
	},

}
