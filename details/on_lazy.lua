local M = {}

local api = vim.api

local cmd_group = api.nvim_create_augroup("i_am_lazy", { clear = true })

function M.register(fun)
	api.nvim_create_autocmd("UIEnter", {
		group = cmd_group,
		callback = fun,
	})
end

return M
