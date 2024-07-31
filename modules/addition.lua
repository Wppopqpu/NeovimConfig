return {
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
	},
	{
		"m4xshen/hardtime.nvim",
		event = "VeryLazy",
		dependencies = "MunifTanjim/nui.nvim",
		opt = {
			disable_mouse = false,
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
	}
}
