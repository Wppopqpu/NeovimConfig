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






-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})
