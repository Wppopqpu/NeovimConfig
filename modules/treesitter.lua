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
		"romus204/tree-sitter-manager.nvim",
		opts = {
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
				"hjson",
				"html",
				'javascript',
				'json',
				-- "jsonc", -- required by neoconf setting file
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
				"yaml",
				"zig",
			},
			auto_install = true,
			noauto_install = {
				"c", "lua", "markdown", "markdown_inline", "query", "vim", "vimdoc",
			},
		},
		event = { "VeryLazy", "BufReadPre" },
	},
	-- {
	-- 	'nvim-treesitter/nvim-treesitter',
	-- 	dependencies = { "nvim-treesitter/treesitter-parser-registry" },
	-- 	lazy = false,
	-- 	branch = "main",
	-- 	event = 'VeryLazy',
	-- 	build = function()
	-- 		vim.cmd'TSUpdate'
	-- 	end,
	-- 	config = function()
	-- 		-- require'nvim-treesitter.install'.prefer_git = true
	-- 		-- require'nvim-treesitter.configs'.setup{
	-- 		-- 	ensure_installed = {
	-- 		-- 		'bash',
	-- 		-- 		'c',
	-- 		-- 		'cmake',
	-- 		-- 		'cpp',
	-- 		-- 		'csv',
	-- 		-- 		"doxygen",
	-- 		-- 		'gitattributes',
	-- 		-- 		'gitcommit',
	-- 		-- 		'gitignore',
	-- 		-- 		'git_config',
	-- 		-- 		'git_rebase',
	-- 		-- 		"html",
	-- 		-- 		'javascript',
	-- 		-- 		'json',
	-- 		-- 		"jsonc", -- required by neoconf setting file
	-- 		-- 		"kdl",
	-- 		-- 		'lua',
	-- 		-- 		"latex",
	-- 		-- 		'make',
	-- 		-- 		'markdown',
	-- 		-- 		'markdown_inline', -- two markdown plugin are for lspsaga
	-- 		-- 		'query',
	-- 		-- 		"regex", -- required by noice
	-- 		-- 		"rust",
	-- 		-- 		"toml",
	-- 		-- 		'vim',
	-- 		-- 		'vimdoc',
	-- 		-- 		"yaml",
	-- 		-- 		"zig",
	-- 		-- 	},
	-- 		-- 	highlight = {
	-- 		-- 		enable = true,
	-- 		-- 		disabled = function(lang, buf)
	-- 		-- 			local max = 100*1024
	-- 		-- 			local ok, stats = pcall(vim.loop.fs_stat
	-- 		-- 				, vim.api.nvim_buf_get_name(buf))
	-- 		-- 			if ok and stats and stats.size > max then
	-- 		-- 				return true
	-- 		-- 			end
	-- 		-- 		end,
	-- 		-- 	},
	-- 		-- 	incremental_selection = {
	-- 		-- 		enable = true,
	-- 		-- 	},
	-- 		-- }
	-- 		require("nvim-treesitter").install{
	-- 			'bash',
	-- 			'c',
	-- 			'cmake',
	-- 			'cpp',
	-- 			'csv',
	-- 			"doxygen",
	-- 			'gitattributes',
	-- 			'gitcommit',
	-- 			'gitignore',
	-- 			'git_config',
	-- 			'git_rebase',
	-- 			"html",
	-- 			'javascript',
	-- 			'json',
	-- 			"jsonc", -- required by neoconf setting file
	-- 			"kdl",
	-- 			'lua',
	-- 			"latex",
	-- 			'make',
	-- 			'markdown',
	-- 			'markdown_inline', -- two markdown plugin are for lspsaga
	-- 			'query',
	-- 			"regex", -- required by noice
	-- 			"rust",
	-- 			"toml",
	-- 			'vim',
	-- 			'vimdoc',
	-- 			"yaml",
	-- 			"zig",
	-- 		}
	-- 		vim.api.nvim_create_autocmd("FileType", {
	-- 			pattern = "*",
	-- 			callback = function()
	-- 				vim.treesitter.start()                                    -- highlighting
	-- 				vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'     -- folds
	-- 				vim.wo.foldmethod = 'expr'
	-- 				vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()" -- indentation
	-- 			end,
	-- 		})
	-- 	end,
	-- },
}
