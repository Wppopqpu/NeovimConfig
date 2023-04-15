
-- global mapleader
vim.g.mapleader = ''

-- local mapleader
vim.g.maplocalleader = ''

-- line numbers
vim.o.number=true

-- relative line numbers : specifies the distance from the cursor
vim.o.relativenumber = true

-- reserved space when moving
vim.o.scrolloff = 8
vim.o.sidescrolloff = 8

-- tab settings
vim.o.tabstop = 4
vim.o.expandtab = false
vim.o.autoindent = true
vim.o.smartindent = true

-- shift adjustments
vim.o.shiftwidth = 4
vim.o.shiftround = true

-- background colour support
vim.o.background = 'dark'
vim.o.termguicolors = true

-- cursor
vim.o.cursorline = true


-- auto read & write
vim.o.autowrite = true
vim.o.autoread = true


vim.o.laststatus = 2

-- sign column
vim.o.signcolumn = 'yes'

vim.o.colorcolumn = '80'

-- search
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.hlsearch = true
vim.o.incsearch = true

vim.o.showmode = false

-- command
vim.o.showcmd = true
vim.o.cmdheight = 2

vim.o.wrap = false

vim.o.whichwrap = 'b,s,<,>,[,],h,l'

vim.o.hidden = true

-- no backup
vim.o.swapfile = false
vim.o.backup = false
vim.o.writebackup = false

vim.o.updatetime = 300

vim.o.splitbelow = true
vim.o.splitbelow = true

-- invisible characters
vim.o.list = true
vim.o.listchars = 'space:·'

vim.wildmenu = true

vim.o.showtabline = 2
