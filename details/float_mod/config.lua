local M = {
	config = {
		blend = {
			enabled = true,
			blendness = 20,
		},
		shadow = {
			enabled = true,
			blendness = 5,
			zindex = 1,
			h_offset = 3,
			v_offset = 3,
			use_debug = false,
			purge_interval = 500
		},
	},
}

local function setup(opt)
	opt = opt or {}

	M.config = vim.tbl_deep_extend("force", M.config, opt)
end

return setmetatable({}, {
	__index = function(_, k)
		if k == "setup" then
			return setup
		end
		return M.config[k]
	end,
})
