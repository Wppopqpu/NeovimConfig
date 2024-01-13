return {
	{
		'Mythos-404/xmake.nvim',
		lazy = true,
		event = 'BufReadPost xmake.lua',
		dependencies = {
			'MunifTanjim/nui.nvim',
			'nvim-lua/plenary.nvim',
		},
		config = function()
			require'xmake'.setup{}
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

			local map = vim.keymap.set
			map('n', '<leader>xi', ':XmakeSetMenu<CR>')
			map('n', '<leader>xm', ':XmakeSetMode<CR>')
			map('n', '<leader>xt', ':XmakeSetTarget<CR>')
			map('n', '<leader>xb', ':XmakeBuild')
			map('n', '<leader>xc', ':XmakeClean')
		end,
	},
}
