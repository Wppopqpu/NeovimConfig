local M = {}

M.config = {
	global_default = false,
	capability_field = "capability",
	default_capability = "default",
}

local function setup(opt)
	opt = opt or {}

	M.config = vim.tbl_deep_extend("force", M.config, opt)
end

local function test_capability(c, name)
	assert(type(c) == "table")
	assert(type(name) == "string")
	
	if c[name] == nil then
		return c.default or M.config.global_default
	else
		return c[name]
	end
end

function M.get_filter(c, to_remove, delete_action)
	to_remove = to_remove or true
	delete_action = delete_action or function (t, i)
		t[i].enabled = false
	end

	assert(type(c) == "table")
	return function(t)
		assert(type(t) == "table")
		for i, v in pairs(t) do
			if test_capability(c, v[M.config.capability_field] 
				or M.config.default_capability) then
				if to_remove then
					v[M.config.capability_field] = nil
				end
			else
				-- t[i].enabled = false
				delete_action(t, i)
			end
		end
		return t
	end
end

return setmetatable({}, {
	__index = function(_, k)
		if k == "setup" then
			return setup
		end
		return M[k]
	end,
})
