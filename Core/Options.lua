-- Options.lua

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '


-- line numbers
vim.filetype.add{
	extension = {
		mpp = 'cpp',
		ixx = 'cpp',
		cppm = 'cpp',
		mxx = 'cpp',
	},
}

vim.loader.enabled = true

vim.opt.number=true

-- relative line numbers : specifies the distance from the cursor
vim.opt.relativenumber = true

-- reserved space when moving
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

-- tab settings
vim.opt.tabstop = 4
vim.opt.expandtab = false
vim.opt.autoindent = true
vim.opt.smartindent = true

-- shift adjustments
vim.opt.shiftwidth = 4
vim.opt.shiftround = true

-- cursor
vim.opt.cursorline = true


-- auto read & write
vim.opt.autowrite = true
vim.opt.autoread = true


vim.opt.laststatus = 2

-- sign column
vim.opt.signcolumn = 'yes'

vim.opt.colorcolumn = '80'

-- search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.showmode = false

-- command
vim.opt.showcmd = true
vim.opt.cmdheight = 2

vim.opt.wrap = false


vim.opt.hidden = true

-- no backup
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false

vim.opt.updatetime = 300

vim.opt.splitbelow = true

vim.opt.background = "dark"
vim.opt.termguicolors = true

vim.wildmenu = false

vim.opt.showtabline = 2


vim.opt.mousemoveevent = true

vim.opt.list = true
vim.opt.listchars = { eol = '↲', trail = '·' }
