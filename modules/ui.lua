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
			map('n', '<leader>bp', ':BufferLinePick<CR>')
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
		end,
		keys = {
			{ '<A-m>', ':NvimTreeToggle<CR>' }
		},
	},

}
