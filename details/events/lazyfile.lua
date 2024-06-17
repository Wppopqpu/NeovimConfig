local M = {}

M.handlers = {}

--- add new handlers
---@param ft string filetype
---@param fun fun() handler
function M.new(ft, fun)
	M[ft] = M[ft] or {}
	if M.lazied and M.triggered then
		fun()
		return
	end
	table.insert(M[ft], fun)
end

--- generate init fun
---@param ft string filetype
---@param mod string modname
---@param func? fun() additional func to exec
---@return fun()
function M.loader(ft, mod, func)
	func = func or function()end
	return function()
		events.lazyfile.new(ft, function()
			require(mod)
		end)
		func()
	end
end

local augroup = vim.api.nvim_create_augroup("__lazyfile_impl", { clear = true })

vim.api.nvim_create_autocmd("User", {
	group = augroup,
	pattern = "VeryLazy",
	callback = function()
		M.lazied = true
		for _, each in pairs(M.handlers) do
			if each.triggered then
				for _, handler in ipairs(each) do
					handler()
				end
			end
		end
	end,
})

vim.api.nvim_create_autocmd("Filetype", {
	group = augroup,
	pattern = "*",
	callback = function(info)
		local ft = info.match

		M.handlers[ft] = M.handlers[ft] or {}
		if M.lazied then
			for _, each in ipairs(M.handlers[ft]) do
				each()
			end
			M.handlers[ft] = { triggered = true }
			return
		end
		M.handlers[ft].triggered = true
	end,
})

return M
