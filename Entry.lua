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

on_lazy.register(function()
	require("NeovimConfig.details.float_mod").setup{}
end)

require'NeovimConfig.Core.Options'
require'NeovimConfig.Core.plugins'
