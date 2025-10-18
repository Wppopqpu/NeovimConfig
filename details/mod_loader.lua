-- Add utils to load modules. 
_G.detail = function (mod)
	return require("NeovimConfig.details."..mod)
end

_G.core = function (mod)
	return require("NeovimConfig.core."..mod)
end

_G.user = function (mod)
	local res = pcall(require, "NeovimConfig.user."..mod)
	return res
end
