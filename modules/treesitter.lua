return {
	{
		'nvim-treesitter/nvim-treesitter',
		event = 'VeryLazy',
		config = function()
			require'nvim-treesitter.install'.prefer_git = true
			require'nvim-treesitter.configs'.setup{
				ensure_installed = {
					'bash',
					'c',
					'cmake',
					'cpp',
					'csv',
					'gitattributes',
					'gitcommit',
					'gitignore',
					'git_config',
					'git_rebase',
					'javascript',
					'json',
					'lua',
					'make',
					'markdown',
					'query',
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
				indent = { enable = true },
			}
			vim.cmd':TSUpdate'
		end,
	},
}
