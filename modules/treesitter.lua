-- file for treesitter to update at most once a day automatically.
local dateFile = require'NeovimConfig.Core.lazypath'
	..'ts_last_update_time.txt'
--[[
local tsUpdate = function()
	local date = vim.fn.strftime'%Y%m%d'

	local file = io.open(dateFile, 'r+')
	if file:read('*a') ~= date then
		vim.cmd'TSUpdate'
		file:seek('set', 0)
		file:write(date)
	end
	file:close()
end
--]]

return {
	{
		'nvim-treesitter/nvim-treesitter',
		event = 'VeryLazy',
		build = function()
			vim.cmd'TSUpdate'
		end,
		config = function()
			require'nvim-treesitter.install'.prefer_git = true
			require'nvim-treesitter.configs'.setup{
				ensure_installed = {
					'bash',
					'c',
					'cmake',
					'cpp',
					'csv',
					"doxygen",
					'gitattributes',
					'gitcommit',
					'gitignore',
					'git_config',
					'git_rebase',
					'javascript',
					'json',
					"jsonc", -- required by neoconf setting file
					'lua',
					'make',
					'markdown',
					'markdown_inline', -- two markdown plugin are for lspsaga
					'query',
					"regex", -- required by noice
					'vim',
					'vimdoc',
				},
				highlight = {
					enable = true,
					disabled = function(lang, buf)
						local max = 100*1024
						local ok, stats = pcall(vim.loop.fs_stat
							, vim.api.nvim_buf_get_name(buf))
						if ok and stats and stats.size > max then
							return true
						end
					end,
				},
				incremental_selection = {
					enable = true,
				},
			}
		end,
	},
}
