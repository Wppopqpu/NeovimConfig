local branch = "v2"
if vim.system == nil then
	branch = "v1"
end

return {
	{
		'Mythos-404/xmake.nvim',
		lazy = true,
		branch = branch,
		-- event = 'BufReadPost xmake.lua',
		event = "User LazyFname xmake.lua",
		dependencies = {
			'MunifTanjim/nui.nvim',
			'nvim-lua/plenary.nvim',
		},
		init = function ()
			on_lazy.after(function ()
				if vim.uv.fs_stat("./xmake.lua") then
					vim.cmd("e xmake.lua")
				end
			end)
		end,
		config = function()
			require'xmake'.setup{
				compile_command = {
					lsp = "clangd",
					dir = ".nvim",
				},
			}
			local xmakeComponent = {
				function()
					local xmake = require'xmake.project'.info
					if xmake.target.tg == '' then
						return ''
					end
					return xmake.target.tg..'('..xmake.mode..')'
				end,
				cond = function()
					return vim.o.columns > 100
				end,
				on_click = function()
					require'xmake.project._menu'.init()
				end,
			}
			require'lualine'.setup {
				sections = {
					lualine_y = {
						xmakeComponent,
					},
				},
			}

			require'which-key'.register({
				x = {
					name = 'xmake',
					i = { '<cmd>XmakeSetMenu<cr>', 'Open menu.' },
					m = { '<cmd>XmakeSetMode<cr>', 'Select build mode.' },
					t = { '<cmd>XmakeSetTarget<cr>', 'Set build target.' },
					b = { '<cmd>XmakeBuild<cr>', 'Build.' },
					c = { '<cmd>XmakClean<cr>', 'Clean.' },
				},

			}, { prefix = '<leader>' })
			--[[
			map('n', '<leader>xi', ':XmakeSetMenu<CR>')
			map('n', '<leader>xm', ':XmakeSetMode<CR>')
			map('n', '<leader>xt', ':XmakeSetTarget<CR>')
			map('n', '<leader>xb', ':XmakeBuild<CR>')
			map('n', '<leader>xc', ':XmakeClean<CR>')
			--]]
		end,
	},
}
