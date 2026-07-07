-- Entry.lua
require("NeovimConfig.details.mod_loader")
-- fix missing vim.iter
if nil == vim.iter then
	vim.iter = detail("iter")
end
--[[
if nil == table.merge then
	table.merge = detail("table_merge")
end
--]]

on_lazy = detail("on_lazy")
fast_remove = detail("fast_remove").remove
common_remove = function (t, i)
	t[i] = nil
end,

detail("events")

on_lazy.register(function()
	detail("float_mod").setup{}
	detail("helper")
end)

core("options")

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
	web_basic = true,
	zig = true,

	default = true,
}
local user_capabilities = user("local_capabilities") or {}
vim.tbl_deep_extend("force", capabilities, user_capabilities)
-- filter for plugin system
g_filter = cap.get_filter(capabilities)
-- filter for common usage (table)
c_filter = cap.get_filter(capabilities, false, common_remove)
-- filter for common usage (array)
a_filter = cap.get_filter(capabilities, false, fast_remove)

function test_capability(name)
	return cap.test_capability(capabilities, name)
end



detail("zig")


core("plugins")
