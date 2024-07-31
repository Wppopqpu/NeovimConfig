local M = {}

local config = require("NeovimConfig.details.float_mod.config").blend
assert(config~=nil)

--- calculate new blendness with old blendness
---@param raw integer # old blendness
---@return integer # new blendness
local function calculate_blendness(raw)
	-- between opt.blendness and 100
	-- return M.opt.blendness * (100 - raw) / 100 + raw
	return math.ceil(config.blendness+(50-config.blendness/2)*(1-math.cos(raw*math.pi/100)))
end

assert(math.abs(calculate_blendness(0)-config.blendness)<=1)
assert(math.abs(calculate_blendness(100)-100)<=1)

local old_open_win = vim.api.nvim_open_win
local old_set_option = vim.api.nvim_set_option_value
M.set_option = old_set_option
local old_set_var = vim.api.nvim_win_set_var


-- make patches

--- @diagnostic disable-next-line
vim.api.nvim_open_win = function(buf, enter, opt)
	local result = old_open_win(buf, enter, opt)

	if not config.enabled then
		goto skip
	end

	if result == 0 then
		return 0
	end
	if opt.relative ~= nil then
		old_set_option("winblend", calculate_blendness(0), { win = result })
	end

	::skip::
	return result
end

--- @diagnostic disable-next-line
vim.api.nvim_win_set_option = function(win, name, value)
	vim.api.nvim_set_option_value(name, value, { win = win })
end

--- @diagnostic disable-next-line
vim.api.nvim_set_option_value = function(name, value, opt)
	if not config.enabled then
		goto skip
	end

	if opt.window ~= nil and name == "winblend" then
		return old_set_option("winblend", calculate_blendness(value), opt)
	end

	::skip::
	return old_set_option(name, value, opt)
end

--- @diagnostic disable-next-line
vim.api.nvim_win_set_var = function(win, name, value)
	if not config.enabled then
		goto skip
	end

	if name == "&winblend" then
		old_set_option("winblend", calculate_blendness(value), { win = win })
		return
	end

	::skip::
	old_set_var(win, name, value)
end

return M
