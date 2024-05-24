-- Entry.lua
-- fix missing vim.iter
if nil == vim.iter then
	vim.iter = require"NeovimConfig.details.iter"
end

require'NeovimConfig.Core.Options'
require'NeovimConfig.Core.plugins'
