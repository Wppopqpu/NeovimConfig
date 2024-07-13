local env_name = "NVIM_DISABLED_LSP"
local order = vim.env[env_name]

local result = vim.split(order or "", ";", { trimempty = true })

-- add utils
function result.has(self, k)
	return vim.tbl_contains(self, k)
end

return result
