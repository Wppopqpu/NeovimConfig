local path2Lazy = require'NeovimConfig.Core.lazypath'..'lazy.nvim'

-- if there is no lazy.nvim, we download it.
if not vim.loop.fs_stat(path2Lazy) then
	print'Downloading lazy.nvim.'
	vim.fn.system{
		'git',
		'clone',
		'--filter=blob:none',
		'https://github.com/folke/lazy.nvim.git',
		'--branch=stable',
		path2Lazy,
	}
end

vim.opt.rtp:prepend(path2Lazy)

require'lazy'.setup("NeovimConfig.modules", {
	install = {
		colorscheme = { "tokyonight" },
	},
	ui = {
		border = "rounded",
		custom_keys = {
			["<leader>mm"] = {
				function (plugin)
					require("lazy.util").float_term(nil, {
						cwd = plugin.dir,
					})
				end,
				desc = "open terminal in plugin dir",
			},
		},

	},
	rtp = {
		disabled_plugins = {
			"netrwPlugin",
		},
	},
	change_detection = {
		notify = false,
	},
})
