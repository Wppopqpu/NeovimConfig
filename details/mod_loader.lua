-- Add utils to load modules. 
_G.detail = function (mod)
	return require("NeovimConfig.details."..mod)
end

_G.core = function (mod)
	return require("NeovimConfig.core."..mod)
end
