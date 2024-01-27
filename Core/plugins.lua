local path2Lazy = vim.fn.stdpath'data'..'lazy/lazy.nvim'


-- if there is no lazy.nvim, we download it.
if not vim.loop.fs_stat(path2Lazy) then
	print'Downloading lazy.nvim.'
	vim.system({
		'git',
		'clone',
		'--filter=blob:none',
		'https://github.com/folke/lazy.nvim.git',
		'--branch=stable',
		path2Lazy,
	}, function(obj)
		print(obj.code)
		print(obj.signal)
		print(obj.stdout)
		print(obj.stderr)
	end)
end

vim.opt.rtp:prepend(path2Lazy)

require'lazy'.setup'NeovimConfig.modules'
