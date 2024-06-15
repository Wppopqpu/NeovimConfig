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


local config = require("NeovimConfig.details.float_mod.config").shadow


local managed_windows = {}

vim.api.nvim_create_user_command("ShadowInspect", function(info)
	print(vim.inspect(managed_windows))
end, {})

--- force update shadows
local function purge()
	for _, each in pairs(managed_windows) do
		each:update()
	end
	vim.cmd("redraw!")
end

vim.api.nvim_create_user_command("ShadowPurge", purge, {})
--[[
local timer = vim.uv.new_timer()
timer:start(config.purge_interval, config.purge_interval, purge)
--]]


-- old apis

local old_open_win = vim.api.nvim_open_win
local old_set_config = vim.api.nvim_win_set_config
local old_hide = vim.api.nvim_win_hide
local old_close = vim.api.nvim_win_close
local old_set_width = vim.api.nvim_win_set_width
local old_set_height = vim.api.nvim_win_set_height
local old_set_option_value = vim.api.nvim_set_option_value
local old_win_call = vim.api.nvim_win_call


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

--- set shadow window option
---@param shadow Shadow
local function set_win_option(shadow)
	local win = shadow.win_handle
	local target = shadow.target

	local options = {
		winblend = calculate_blendness(vim.api.nvim_get_option_value("winblend", { win = target })),
	}

	for k, v in pairs(options) do
		old_set_option_value(k, v, { win = win })
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
		self.target = target

		self.win_handle = old_open_win(buffer, false, get_win_config(self))
		assert(self.win_handle > 0)
		set_win_option(self)
		managed_windows[target] = self

		-- can only be initialised **once**
		self.init = nil
		return self
	end,
	delete = function(self)
		managed_windows[self.win_handle] = nil
	end,
	update = function(self)
		if not self:is_valid() then
			return self:close() -- nil
		end

		old_set_config(self.win_handle, get_win_config(self))
		set_win_option(self)
		return self
	end,
	update_config = function(self)
		if not self:is_valid() then
			return self:close()
		end

		old_set_config(self.win_handle, get_win_config(self))
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

		old_set_width(self.win_handle, vim.api.nvim_win_get_width(self.target))
		old_set_height(self.win_handle, vim.api.nvim_win_get_height(self.target))
		return self
	end,
	is_valid = function(self)
		return vim.api.nvim_win_is_valid(self.win_handle) and vim.api.nvim_win_is_valid(self.target)
	end,
	is_open = function(self)
		return vim.api.nvim_win_is_valid(self.win_handle)
	end,
	close = function(self)
		if self:is_open() then
			old_close(self.win_handle, true)
		end
		self:delete()
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
	local result = old_open_win(buf, enter, opt)

	if result <= 0 then
		return result
	end

	if opt.relative ~= nil then
		new_shadow():init(result)
	end
	return result
end

--- @diagnostic disable-next-line
vim.api.nvim_win_set_config = function(win, opt)
	old_set_config(win, opt)
	if managed_windows[win] ~= nil then
		managed_windows[win]:update_config()
	end
end
--- @diagnostic disable-next-line
vim.api.nvim_win_hide = function(win)
	old_hide(win)
	if managed_windows[win] ~= nil then
		managed_windows[win]:update_config()
	end
end

--- @diagnostic disable-next-line
vim.api.nvim_win_set_width = function(win, width)
	old_set_width(win, width)
	if managed_windows[win] ~= nil then
		managed_windows[win]:update_size()
	end
end

--- @diagnostic disable-next-line
vim.api.nvim_win_set_height = function(win, height)
	old_set_height(win, height)
	if managed_windows[win] ~= nil then
		managed_windows[win]:update_size()
	end
end

--- @diagnostic disable-next-line
vim.api.nvim_win_close = function(win, force)
	old_close(win, force)
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
	old_set_option_value(name, value, opt)

	if opt.win ~= nil and name == "winblend" and managed_windows[opt.win] ~= nil then
		managed_windows[opt.win]:update_options()
	end
end

-- TODO: nvim always gives out a strange error when patch this.
-- fix it.

--[[
--- @diagnostic disable-next-line
vim.api.nvim_win_call = function(win, fun)
	old_win_call(win, fun)
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
				managed_windows[target]:update()
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