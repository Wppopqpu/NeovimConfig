
-- global mapleader
vim.g.mapleader = ''

-- local mapleader
vim.g.maplocalleader = ''

-- line numbers
vim.wo.number=true

-- relative line numbers : specifies the distance from the cursor
vim.wo.relativenumber = true

-- tab settings
vim.o.tabstop = 4
vim.o.expandtab = false

-- shift adjustments
vim.o.shiftwidth = 4
vim.o.shiftround = true

-- background colour support
vim.o.background = 'dark'
vim.o.termguicolors = true

-- cursor
vim.o.cursorline = true

-- swapfile
vim.o.swapfile = false

-- auto read & write
vim.o.autowrite = true
vim.o.autoread = true

-- system settings
vim.o.laststatus = 2
vim.o.showcmd = true
