local M = {}

local is_setup = false

--- calculate new blendness with old blendness
---@param raw integer # old blendness
---@return integer # new blendness
local function calculate_blendness(raw)
	-- between opt.blendness and 100
	-- return M.opt.blendness * (100 - raw) / 100 + raw
	return (50-M.opt.blendness/2)*(1-math.cos(raw/100))
end

--- parse user options, and merge with defaults
---@param opt table # user options
local function parse_options(opt)
	opt = opt or {}
	local defaults = {
		blendness = 20,
	}
	M.opt = vim.tbl_extend("keep", opt, defaults)

end

local function patch()
	local old_open_win = vim.api.nvim_open_win
	local old_set_option = vim.api.nvim_set_option_value
	local old_set_var = vim.api.nvim_win_set_var


	-- make patches

	vim.api.nvim_open_win = function(buf, enter, config)
		local result = old_open_win(buf, enter, config)

		if result == 0 then
			return 0
		end
		if config.relative ~= nil then
			old_set_option("winblend", M.opt.blendness, { win = result })
		end
		return result
	end

	vim.api.nvim_win_set_option = function(win, name, value)
		old_set_option(name, value, { win = win })
	end

	vim.api.nvim_set_option_value = function(name, value, option)
		if option.window ~= nil and name == "winblend" then
			return old_set_option("winblend", calculate_blendness(value), option)
		end

		return old_set_option(name, value, option)
	end

	vim.api.nvim_win_set_var = function(win, name, value)
		if name == "&winblend" then
			old_set_option("winblend", calculate_blendness(value), { win = win })
			return
		end

		old_set_var(win, name, value)
	end

end

-- NOTE: this must be called before any related apis is called

--- setup patches
---@param opt table
function M.setup(opt)
	parse_options(opt)

	if is_setup then
		return
	end
	is_setup = true

	patch()

end

return M
