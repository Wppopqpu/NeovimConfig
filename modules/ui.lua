local hl = 'Statement'
local startUpImage = {
	'    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⠤⠖⠚⢉⣩⣭⡭⠛⠓⠲⠦⣄⡀⠀⠀⠀⠀⠀⠀⠀  ',
	'    ⠀⠀⠀⠀⠀⠀⢀⡴⠋⠁⠀⠀⠊⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠳⢦⡀⠀⠀⠀⠀  ',
	'    ⠀⠀⠀⠀⢀⡴⠃⢀⡴⢳⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⣆⠀⠀⠀  ',
	'    ⠀⠀⠀⠀⡾⠁⣠⠋⠀⠈⢧⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢧⠀⠀  ',
	'    ⠀⠀⠀⣸⠁⢰⠃⠀⠀⠀⠈⢣⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⣇⠀  ',
	'    ⠀⠀⠀⡇⠀⡾⡀⠀⠀⠀⠀⣀⣹⣆⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹⠀  ',
	'    ⠀⠀⢸⠃⢀⣇⡈⠀⠀⠀⠀⠀⠀⢀⡑⢄⡀⢀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡇  ',
	'    ⠀⠀⢸⠀⢻⡟⡻⢶⡆⠀⠀⠀⠀⡼⠟⡳⢿⣦⡑⢄⠀⠀⠀⠀⠀⠀⠀⠀⢸⡇  ',
	'    ⠀⠀⣸⠀⢸⠃⡇⢀⠇⠀⠀⠀⠀⠀⡼⠀⠀⠈⣿⡗⠂⠀⠀⠀⠀⠀⠀⠀⢸⠁  ',
	'    ⠀⠀⡏⠀⣼⠀⢳⠊⠀⠀⠀⠀⠀⠀⠱⣀⣀⠔⣸⠁⠀⠀⠀⠀⠀⠀⠀⢠⡟⠀  ',
	'    ⠀⠀⡇⢀⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠠⠀⡇⠀⠀⠀⠀⠀⠀⠀⠀⢸⠃⠀  ',
	'    ⠀⢸⠃⠘⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⠁⠀⠀⢀⠀⠀⠀⠀⠀⣾⠀⠀  ',
	'    ⠀⣸⠀⠀⠹⡄⠀⠀⠈⠁⠀⠀⠀⠀⠀⠀⠀⡞⠀⠀⠀⠸⠀⠀⠀⠀⠀⡇⠀⠀  ',
	'    ⠀⡏⠀⠀⠀⠙⣆⠀⠀⠀⠀⠀⠀⠀⢀⣠⢶⡇⠀⠀⢰⡀⠀⠀⠀⠀⠀⡇⠀⠀  ',
	'    ⢰⠇⡄⠀⠀⠀⡿⢣⣀⣀⣀⡤⠴⡞⠉⠀⢸⠀⠀⠀⣿⡇⠀⠀⠀⠀⠀⣧⠀⠀  ',
	'    ⣸⠀⡇⠀⠀⠀⠀⠀⠀⠉⠀⠀⠀⢹⠀⠀⢸⠀⠀⢀⣿⠇⠀⠀⠀⠁⠀⢸⠀⠀  ',
	'    ⣿⠀⡇⠀⠀⠀⠀⠀⢀⡤⠤⠶⠶⠾⠤⠄⢸⠀⡀⠸⣿⣀⠀⠀⠀⠀⠀⠈⣇⠀  ',
	'    ⡇⠀⡇⠀⠀⡀⠀⡴⠋⠀⠀⠀⠀⠀⠀⠀⠸⡌⣵⡀⢳⡇⠀⠀⠀⠀⠀⠀⢹⡀  ',
	'    ⡇⠀⠇⠀⠀⡇⡸⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⠮⢧⣀⣻⢂⠀⠀⠀⠀⠀⠀⢧  ',
	'    ⣇⠀⢠⠀⠀⢳⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⡎⣆⠀⠀⠀⠀⠀⠘  ',
}

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
		'folke/noice.nvim',
		event = 'VeryLazy',
		opts = {
			lsp = {
				override = {
					['vim.lsp.util.convert_input_to_markdown'] = true,
					['vim.lsp.util.stylize_markdown'] = true,
					['cmp.entry.get_documentation'] = true,
				},
			},

			presets = {
				bottom_search = true,
				command_palette = true,
				long_message_to_split = true,
			},
		},
		dependencies = {
			'MunifTanjim/nui.nvim',
			'rcarriga/nvim-notify',
		}
	},
	{
		'nvim-lualine/lualine.nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		config = true,
			
	},
	{
		'goolord/alpha-nvim',
		config = function()
			--[[
			local alpha = require'alpha'
			local dashboard = require'alpha.themes.dashboard'
			dashboard.section.header.val = startUpImage
			alpha.setup(dashboard.config)
			--]]
			require'alpha'.setup{
				layout = {
					header = {
						type = 'text',
						val = startUpImage,
						opts = {
							hl = hl,
							position = 'center',
						},
					},
				},
			}
		end,
		dependencies = {
			{'nvim-tree/nvim-web-devicons'}
		},
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
					get_element_icon = function(element)
						local icon, hl = require'nvim-web-devicons'
							.get_icon_by_filetype(element.filetype
								, { default = false })
						return icon, hl
					end,

					numbers = function(opts)
						return string.format('%s%s', opts.id
							, opts.lower(opts.ordinal))
					end,

					offsets = {
						{
							filetype = 'NvimTree',
							text = 'explorer',
							highlight = 'Directory',
							text_align = 'center',
						},
						{
							filetype = 'sagaoutline',
							text = 'outline',
							highlight = 'Directory',
							text_align = 'center',
						},
					},
				},
			}
			local wk = require'which-key'
			wk.register{
				['<C-h>'] = { ':BufferLineCyclePrev<CR>', 'next buffer' },
				['<C-l>'] = { ':BufferLineCycleNext<CR>', 'prev buffer' },
				['<C-p>'] = { ':BufferLinePick<CR>', 'pick buffer' },
				['<C-x>'] = { ':bdelete<CR>', 'delete buffer' },
				['<c-X>'] = { ':bdelete!<cr>', 'force delete buffer' },
			}
			wk.register({
				b = {
					name = 'bufferline operations',
					x = { '<cmd>bdelete<cr>', 'close buffer' },
					X = { '<cmd>bdelete!<cr>', 'force close buffer' },
					t = { '<cmd>term<cr>', 'open terminal buffer' },
				}
			}, { prefix = '<leader>' })
		end,
	},
	{
		'nvim-tree/nvim-tree.lua',
		lazy = true,
		dependencies = {
			'nvim-tree/nvim-web-devicons'
		},
		config = function()
			require'nvim-tree'.setup{}
			require'which-key'.register{
				['<A-m>'] = { ':NvimTreeToggle<CR>', 'toggle file explorer' },
			}
		end,
		event = 'VeryLazy',
	},
	{
		'echasnovski/mini.animate',
		config = true,
		event = 'VeryLazy',
	},

}
