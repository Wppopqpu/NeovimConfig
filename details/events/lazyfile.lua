local M = {}

M.ft_handlers = {}
M.triggered_fnames = {}

--- post LazyFt event
---@param ft string filetype
local function post_ft(ft)
	vim.cmd("doautocmd User LazyFt "..ft)
end

local function post_fname(fname)
	vim.cmd("doautocmd User LazyFname "..fname)
end

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
		for ft, each in pairs(M.ft_handlers) do
			if each.triggered then
				post_ft(ft)
				for _, handler in ipairs(each) do
					handler()
				end
				each = { triggered = true }
			end
		end
		for _, each in ipairs(M.triggered_fnames) do
			post_fname(each)
		end
	end,
})

vim.api.nvim_create_autocmd("Filetype", {
	group = augroup,
	pattern = "*",
	callback = function(info)
		local ft = info.match

		M.ft_handlers[ft] = M.ft_handlers[ft] or {}
		if M.lazied then
			post_ft(ft)
			for _, each in ipairs(M.ft_handlers[ft]) do
				each()
			end
			M.ft_handlers[ft] = { triggered = true }
			return
		end
		M.ft_handlers[ft].triggered = true
	end,
})

vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
	group = augroup,
	pattern = "*",
	callback = function(info)
		local fname = vim.fn.fnamemodify(info.file, ":t")

		if M.lazied then
			post_fname(fname)
			return
		end
		table.insert(M.triggered_fnames, fname)
	end,
})

return M
