local M = {
	config = {
		blend = {
			enabled = true,
			blendness = 20,
		},
		shade = {
			enabled = true,
			blendness = 60,
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
