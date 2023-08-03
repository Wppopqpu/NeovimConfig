-- KeyBindings.lua

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local map = vim.api.nvim_set_keymap
local opt = { noremap = true, silent = true }


map( 'n', '<C-u>', '9k', opt )
map( 'n', '<C-d>', '9j', opt )

map( 'v', '<', '<gv', opt )
map( 'v', '>', '>gv', opt )


-- vertical
map( 'n', 'sv', ':vsp<CR>', opt )
-- horizonal
map( 'n', 'sh', ':sp<CR>', opt )
-- close current
map( 'n', 'sc', '<C-w>c', opt )
-- close others
map( 'n', 'so', '<C-w>o', opt )

map( 'n', 's.', ':vertical resize +20<CR>', opt )
map( 'n', 's,', ':vertical resize -20<CR>', opt )
map( "n", "s=", "<C-w>=", opt )
map( "n", "sj", ":resize +10<CR>",opt )
map( "n", "sk", ":resize -10<CR>",opt )

map( "n", "<A-h>", "<C-w>h", opt )
map( "n", "<A-j>", "<C-w>j", opt )
map( "n", "<A-k>", "<C-w>k", opt )
map( "n", "<A-l>", "<C-w>l", opt )

-- Alt+m: open nvim tree menu
-- o: open/close folder
-- a: create new file
-- r: rename
-- x: cut
-- c: copy
-- p: plaste
-- d: delete
map('n', '<A-m>', ':NvimTreeToggle<CR>', opt)

map('n', '<C-h>', ':BufferLineCyclePrev<CR>', opt)
map('n', '<C-l>', ':BufferLineCycleNext<CR>', opt)

