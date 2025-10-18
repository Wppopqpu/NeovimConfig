-- faster remove operation for arrays
local M = {}

function M.remove(list, i)
	list[i] = list[#list]
end


return M
