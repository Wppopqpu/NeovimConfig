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

detail("events")

on_lazy.register(function()
	detail("float_mod").setup{}
	detail("helper")
end)

core("options")
core("plugins")
