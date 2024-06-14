-- Entry.lua
-- fix missing vim.iter
if nil == vim.iter then
	vim.iter = require"NeovimConfig.details.iter"
end

if nil == table.merge then
	table.merge = require("NeovimConfig.details.table_merge")
end

require("NeovimConfig.details.float_mod").setup{}

require'NeovimConfig.Core.Options'
require'NeovimConfig.Core.plugins'
