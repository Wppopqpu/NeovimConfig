-- file for treesitter to update at most once a day automatically.
local dateFile = core("lazypath")
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

return g_filter {
	{
		'nvim-treesitter/nvim-treesitter',
		event = 'VeryLazy',
		build = function()
			vim.cmd'TSUpdate'
		end,
		init = function ()
			local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
			parser_config.tsqx = {
				install_info = {
					url = "https://github.com/extouchtriangle/tree-sitter-tsqx", -- local path or git repo
					files = { "src/parser.c" }, -- note that some parsers also require src/scanner.c or src/scanner.cc
					-- optional entries:
					branch = "main", -- default branch in case of git repo if different from master
					generate_requires_npm = false, -- if stand-alone parser without npm dependencies
					requires_generate_from_grammar = false, -- if folder contains pre-generated src/parser.c
				},
				filetype = "tsqx", -- if filetype does not match the parser name
			}
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
					"kdl",
					'lua',
					"latex",
					'make',
					'markdown',
					'markdown_inline', -- two markdown plugin are for lspsaga
					'query',
					"regex", -- required by noice
					"rust",
					"toml",
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
