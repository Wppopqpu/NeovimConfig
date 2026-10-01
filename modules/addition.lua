return g_filter {
	{
		"folke/drop.nvim",
		event = "VeryLazy",
		cond = function ()
			local fname = vim.fn.stdpath("data").."/last_date.txt"
			local date = vim.fn.strftime("%Y%m%d")

			if not vim.loop.fs_stat(fname) then
				local file = io.open(fname, "w+")
				assert(file)
				file:write(date)
				file:close()
				return true
			end

			local file = io.open(fname, "r+")
			assert(file)

			if file:read("*a") ~= date then
				file:seek("set", 0)
				file:write(date)
				file:close()
				return true
			end
			file:close()
			return false

		end,
		config = function ()
			require("drop").setup {
				max = math.floor(vim.o.lines * vim.o.columns / 80)
			}
		end,
		enabled = false,
	},
	{
		"m4xshen/hardtime.nvim",
		event = "VeryLazy",
		dependencies = "MunifTanjim/nui.nvim",
		opts = {
			disable_mouse = false,
			disabled_filetypes = { "qf", "netrw", "NvimTree", "lazy", "mason", "sagaoutline", "help", "man" },
		},
	},
	{
		"rktjmp/playtime.nvim",
		init = function()
			vim.api.nvim_create_user_command("LoadPlaytime", function (info)
				require("playtime")
			end, {
				desc = "load playtime.nvim"
			})
		end,
		lazy = true,
		config = true,
	},
	{
		-- Auto-reload files when changed on disk
		-- Only for nvim < 0.13 (0.13+ has native support)
		"diogo464/hotreload.nvim",
		enabled = function()
			local ok, version = pcall(vim.version)
			if ok and version then
				local num = version.major * 10000 + version.minor * 100 + version.patch
				return num < 1300  -- Enable only for nvim < 0.13.0
			end
			return false  -- Disable if version check fails
		end,
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			interval = nil,  -- Use fs_event watchers (no polling)
			silent = true,   -- No reload notifications
		},
	}
}
