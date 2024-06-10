return function(dst, ...)
	for _, each in ipairs(arg) do
		for k, v in pairs(each) do
			dst[k] = v
		end
	end
end
