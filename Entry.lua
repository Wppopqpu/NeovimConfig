-- Entry.lua
-- fix missing vim.iter
if nil == vim.iter then
	vim.iter = require"NeovimConfig.details.iter"
end
--[[
if nil == table.merge then
	table.merge = require("NeovimConfig.details.table_merge")
end
--]]

local on_lazy = require("NeovimConfig.details.on_lazy")

require("NeovimConfig.details.events")

on_lazy.register(function()
	require("NeovimConfig.details.float_mod").setup{}
	require("NeovimConfig.details.helper")
end)

require'NeovimConfig.Core.Options'
require'NeovimConfig.Core.plugins'
