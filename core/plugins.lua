-- set up capability filter to adapt to different occasions
local cap = detail("capabilities")
-- default values
local capabilities = {
	cpp = false,
	latex = true,
	lean = false,
	lua = true,
	python = true,
	rust = true,
	typst = true,

	default = true,
}
local user_capabilities = user("local_capabilities") or {}
vim.tbl_deep_extend("force", capabilities, user_capabilities)
g_filter = cap.get_filter(capabilities)


local path2Lazy = core("lazypath")..'lazy.nvim'

-- if there is no lazy.nvim, we download it.
if not vim.loop.fs_stat(path2Lazy) then
	print'Downloading lazy.nvim.'
	vim.fn.system{
		'git',
		'clone',
		'--filter=blob:none',
		'https://gitee.com/wppopqpu/lazy.nvim.git',
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
			["<leader>mt"] = {
				function (plugin)
					vim.cmd("close")
					vim.cmd("ToggleTerm dir='"..plugin.dir.."'")
				end,
				desc = "open toggleterm in plugin dir",
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
