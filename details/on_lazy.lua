local M = {}

local api = vim.api

local cmd_group = api.nvim_create_augroup("i_am_lazy", { clear = true })

-- do not use this after UIEnter,
-- e.g. config func triggered by VeryLazy
function M.register(fun)
	api.nvim_create_autocmd("User", {
		group = cmd_group,
		pattern = "VeryLazy",
		callback = fun,
	})
end

local after_lazy_handlers = {}

M.register(function ()
	vim.uv.new_timer():start(1000, 0, vim.schedule_wrap(function ()
		for _, each in ipairs(after_lazy_handlers) do
			each()
		end
	end))
end)

function M.after(fun)
	table.insert(after_lazy_handlers, fun)
end

return M
