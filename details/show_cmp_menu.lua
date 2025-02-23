local M = {}

M.config = {
	delay = 700,
}

function M.setup(opt)
	opt = opt or {}

	vim.tbl_deep_extend("force", opt, M.config)
end

local api = vim.api
local loop = vim.loop
local cmp = require("blink.cmp")

local seq_lock = 0LL

local function up()
	seq_lock = seq_lock + 1LL
	return seq_lock
end

local function is_uninterrupted(old_value)
	if old_value == seq_lock then
		return true
	end
	return false
end

local augroup = api.nvim_create_augroup("cmp_menu_helper", {
	clear = true,
})

local function on_enter_insert()
	local timer = loop.new_timer()
	local seq = seq_lock

	timer:start(M.config.delay, 0, vim.schedule_wrap(function ()
		timer:stop()
		timer:close()
		if is_uninterrupted(seq) then
			cmp.show()
		end
	end))
end


local function need_resume()
	local mode = api.nvim_get_mode().mode
	return (string.find(mode, "^i")~=nil) or (string.find(mode, "^c")~=nil)
end

local function on_interruption()
	up()
	if need_resume() then
		on_enter_insert()
	end
end


local autocmd = api.nvim_create_autocmd


autocmd({"InsertEnter", "CmdlineEnter"}, {
	pattern = "*",
	callback = vim.schedule_wrap(on_enter_insert),
	group = augroup,
})

autocmd({
	"InsertLeave",
	"CmdlineLeave",
	"CursorMovedI",
	"BufEnter",
	"FocusLost",
	"CmdlineChanged",
	"TabEnter",
	"TextChanged",
	"TextChangedI",
	"TextChangedP",
	"TextYankPost",
	"Winscrolled",
}, {
	pattern = "*",
	callback = vim.schedule_wrap(on_interruption),
	group = augroup,
})


return M
