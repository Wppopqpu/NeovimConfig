local M = {}
_G.shadow = M

--- @class Shadow
--- @field win_handle integer window handle
--- @field target integer handle of the managed window
--- @field init fun(self:Shadow, target:integer):Shadow create shadow
--- @field update fun(self:Shadow):Shadow|nil update shadow
--- @field update_size fun(self:Shadow):Shadow|nil only update size
--- @field update_options fun(self:Shadow):Shadow|nil only update options
--- @field update_config fun(self:Shadow):Shadow|nil only update config
--- @field delete fun(self:Shadow) delete shadow from global table
--- @field close fun(self:Shadow) close shadow and remove it from global table
--- @field is_valid fun(self:Shadow):boolean check if target window and shadow window are valid
--- @field is_open fun(self:Shadow):boolean check if shadow window is valid
--- @field get_desc fun(self:Shadow):string get log desc

local config = require("NeovimConfig.details.float_mod.config").shadow


local managed_windows = {}

vim.api.nvim_create_user_command("ShadowInspect", function(info)
	-- print(vim.inspect(managed_windows))
	for k, v in pairs(managed_windows) do
		print(v:get_desc())
	end
end, {})

--- force update shadows
local function purge()
	for _, each in pairs(managed_windows) do
		each:update()
	end
end

vim.loop.new_timer():start(0, config.purge_interval,  vim.schedule_wrap(purge))

vim.api.nvim_create_user_command("ShadowPurge", purge, {})
--[[
local timer = vim.uv.new_timer()
timer:start(config.purge_interval, config.purge_interval, purge)
--]]

local in_debug = config.use_debug

local fname = vim.fn.stdpath("log").."/shadow.log"
local logfile = io.open(fname, "w+")
logfile = logfile or setmetatable({}, {
	__index = function(k, v)
		return function(...) end
	end,
})
vim.api.nvim_create_autocmd("VimLeave", {
	callback = function()
		logfile:close()
		logfile = setmetatable({}, {
			__index = function(k, v)
				return function(...) end
			end,
		})
	end,
})

vim.api.nvim_create_user_command("ShadowToggleDebug", function()
	in_debug = not in_debug
	if in_debug then
		print("debug enabled")
	else
		print("debug disabled")
	end
end, {})

-- old apis
M.raw = {}

M.raw.old_open_win = vim.api.nvim_open_win
M.raw.old_set_config = vim.api.nvim_win_set_config
M.raw.old_hide = vim.api.nvim_win_hide
M.raw.old_close = vim.api.nvim_win_close
M.raw.old_set_width = vim.api.nvim_win_set_width
M.raw.old_set_height = vim.api.nvim_win_set_height
-- M.raw.old_set_option_value = vim.api.nvim_set_option_value
-- use raw api from blend
M.raw.old_set_option_value = require("NeovimConfig.details.float_mod.blend").set_option
M.raw.old_win_call = vim.api.nvim_win_call


-- use a different hl_group from Normal.

vim.api.nvim_set_hl(0, "ShadowNormal", {
	bg = config.hl,
})
local winhl = "Normal:ShadowNormal"

local function set_hl(win_id)
	vim.wo[win_id].winhighlight = winhl
end

local function check_allowed (win)
	local buf = vim.api.nvim_win_get_buf(win)

	local result = config.filter(win, buf)
	if result == true then
		return true
	elseif result == false then
		return false
	end

	local ft = vim.bo[buf].filetype
	if vim.tbl_contains(config.disabled_fts, ft) then
		return false
	end

	return true
end


--- generate shadow window config
---@param shadow Shadow
---@return table
local function get_win_config(shadow)
	local target_config = vim.api.nvim_win_get_config(shadow.target)
	assert(target_config.relative ~= nil)

	return {
		relative = "win",
		win = shadow.target,
		zindex = config.zindex,
		border = "none",
		style = "minimal",
		focusable = false,
		col = config.h_offset,
		row = config.v_offset,
		width = target_config.width,
		height = target_config.height,
		hide = target_config.hide,
	}
end

--- calculate blendness of shadow window
---@param old integer
---@return integer
local function calculate_blendness(old)
	return math.ceil(100 - (100 - config.blendness)*(100 - old)/100)
	-- return config.blendness
end

--[[
--- get literal expression of a variable
---@param v any
---@return string
local function get_literal(v)
	local t = type(v)
	if t == "string" then
		return "\""..v.."\""
	end
	if t == "table" then
		local result = "{"
		for k, value in pairs(v) do
			result = result.."["..get_literal(k).."]="..get_literal(value)..","
		end
		return result.."}"
	end
	if t == "boolean" then
		if v == true then
			return "true"
		end
		return "false"
	end
	assert(t=="number")
	return v
end
--]]

--- set shadow window option
---@param shadow Shadow
local function set_win_option(shadow)
	local win = shadow.win_handle
	local target = shadow.target

	local options = {
		winblend = calculate_blendness(vim.api.nvim_get_option_value("winblend", { win = target })),
	}

	for k, v in pairs(options) do
		M.raw.old_set_option_value(k, v, { win = win })
	end
end

--- prepare buffer for shadow window
---@return integer
local function prepare_buffer()
	local buf = vim.api.nvim_create_buf(false,true)
	assert(buf > 0)
	return buf
end

--- @type integer
local buffer = prepare_buffer()

--- @type Shadow
local protoshadow = {
	win_handle = 0,
	target = 0,
	init = function(self, target)
		assert(target > 0)
		if not check_allowed(target) then
			return self
		end
		self.target = target

		-- self.win_handle = M.raw.old_open_win(buffer, false, get_win_config(self))
		shadow.tmp_arg = get_win_config(self)
		vim.cmd("noautocmd lua ".."shadow.tmp=shadow.raw.old_open_win("..buffer..", false, shadow.tmp_arg)")
		self.win_handle = shadow.tmp
		assert(self.win_handle > 0)
		set_win_option(self)
		assert(managed_windows[target] == nil)
		managed_windows[target] = self

		set_hl(self.win_handle)

		if in_debug then
			logfile:write("shadow init: "..self:get_desc().."\n")
		end

		-- can only be initialised **once**
		self.init = nil
		return self
	end,
	delete = function(self)
		if in_debug then
			logfile:write("shadow delete: "..self:get_desc().."\n")
		end
		managed_windows[self.target] = nil
	end,
	update = function(self)
		if not self:is_valid() then
			return self:close() -- nil
		end

		M.raw.old_set_config(self.win_handle, get_win_config(self))
		set_win_option(self)
		return self
	end,
	update_config = function(self)
		if not self:is_valid() then
			return self:close()
		end

		M.raw.old_set_config(self.win_handle, get_win_config(self))
		return self
	end,
	update_options = function(self)
		if not self:is_valid() then
			return self:close()
		end

		set_win_option(self)
		return self
	end,
	update_size = function(self)
		if not self:is_valid() then
			return self:close()
		end

		M.raw.old_set_width(self.win_handle, vim.api.nvim_win_get_width(self.target))
		M.raw.old_set_height(self.win_handle, vim.api.nvim_win_get_height(self.target))
		return self
	end,
	is_valid = function(self)
		return vim.api.nvim_win_is_valid(self.win_handle) and vim.api.nvim_win_is_valid(self.target)
	end,
	is_open = function(self)
		return vim.api.nvim_win_is_valid(self.win_handle)
	end,
	close = function(self)
		if in_debug then
			logfile:write("shadow close: "..self:get_desc().."\n")
		end
		if self:is_open() then
			M.raw.old_hide(self.win_handle)
		end
		self:delete()
	end,
	get_desc = function(self)
		if not vim.api.nvim_win_is_valid(self.target) then
			return self.target.."!:"..self.win_handle
		end
		return self.target.."("..vim.api.nvim_get_option_value("filetype", { buf = vim.api.nvim_win_get_buf(self.target) }).."):"..self.win_handle
	end,
}

--- create uninitialized shadow window
---@return Shadow
local function new_shadow()
	return vim.tbl_extend("error", protoshadow, {})
end

local augroup = vim.api.nvim_create_augroup("__shadow_impl", { clear = true })

--- @diagnostic disable-next-line
vim.api.nvim_open_win = function(buf, enter, opt)
	local result = M.raw.old_open_win(buf, enter, opt)

	if result <= 0 then
		return result
	end

	if opt.relative ~= nil then
		assert(managed_windows[result] == nil)
		new_shadow():init(result)
	end
	return result
end

--- @diagnostic disable-next-line
vim.api.nvim_win_set_config = function(win, opt)
	M.raw.old_set_config(win, opt)
	if managed_windows[win] ~= nil then
		managed_windows[win]:update_config()
	end
end
--- @diagnostic disable-next-line
vim.api.nvim_win_hide = function(win)
	M.raw.old_hide(win)
	if managed_windows[win] ~= nil then
		managed_windows[win]:update_config()
	end
end

--[[
--- @diagnostic disable-next-line
vim.api.nvim_win_set_width = function(win, width)
	M.raw.old_set_width(win, width)
	if managed_windows[win] ~= nil then
		managed_windows[win]:update_size()
	end
end

--- @diagnostic disable-next-line
vim.api.nvim_win_set_height = function(win, height)
	M.raw.old_set_height(win, height)
	if managed_windows[win] ~= nil then
		managed_windows[win]:update_size()
	end
end
--]]

-- lspsaga' window sometimes do nto trigger WinClosed
--- @diagnostic disable-next-line
vim.api.nvim_win_close = function(win, force)
	M.raw.old_close(win, force)
	if managed_windows[win] ~= nil then
		managed_windows[win]:close()
	end
end

--- @diagnostic disable-next-line
vim.api.nvim_win_set_option = function(win, option, value)
	vim.api.nvim_set_option_value(option, value, { win = win })
end

--- @diagnostic disable-next-line
vim.api.nvim_set_option_value = function(name, value, opt)
	M.raw.old_set_option_value(name, value, opt)

	if opt.win ~= nil and name == "winblend" and managed_windows[opt.win] ~= nil then
		managed_windows[opt.win]:update_options()
	end
end

-- TODO: nvim always gives out a strange error when patch this.
-- fix it.

--[[
--- @diagnostic disable-next-line
vim.api.nvim_win_call = function(win, fun)
	N.raw.old_win_call(win, fun)
	if managed_windows[win] ~= nil then
		managed_windows[win]:update()
	end
end
--]]


--[[
vim.api.nvim_create_autocmd("WinNew", {
	pattern = "*",
	group = augroup,
	callback = function(ev)
		local target = ev.match
		print(target)
		assert(target > 0)
		new_shadow():init(target)
	end,
})
--]]
vim.api.nvim_create_autocmd("WinResized", {
	pattern = "*",
	group = augroup,
	callback = function(ev)
		for _, target in ipairs(vim.v.event.windows) do
			if managed_windows[target] ~= nil then
				managed_windows[target]:update_size()
			end
		end
	end,
})
vim.api.nvim_create_autocmd("WinClosed", {
	pattern = "*",
	group = augroup,
	callback = function(ev)
		local target = tonumber(ev.match)

		if managed_windows[target] ~= nil then
			managed_windows[target]:close()
		end
	end,
})
