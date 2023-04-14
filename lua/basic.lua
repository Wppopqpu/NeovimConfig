-- utf8
vim.g.encoding = "UTF-8"
vim.o.fileencoding = "utf-8"

-- reserved lines for j's and k'
vim.o.scrolloff = 8
vim.o.sidescrolloff = 8

-- line numbers
vim.wo.numver = true
vim.wo.relativenumber = true

-- cursor line highlight
vim.wo.cursorline = true

-- sign column
vim.wo.signcolumn = "yes"


local basicLength = 4

-- tabs
vim.o.tabstop = basicLength
vim.bo.tabstop = basicLength
vim.o.softtabstop = basicLength
vim.o.shifttound = true
vim.o.expandtab = false
vim.bo.expandtab = false

-- the length to move when >> or <<
vim.o.shiftwidth = basicLength
vim.bo.shiftwidth = basicLength

-- auto indent
vim.o.autoindent = true
vim.bo.autonindent = true
vim.o.smartindent = true

-- whether to ignore case
vim.o.ignorecase = true
vim.o.smartcase = true

-- search options
vim.o.hlsearch = true
vim.o.insearch = true

