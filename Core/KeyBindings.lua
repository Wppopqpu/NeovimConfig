-- KeyBindings.lua
-- only defines common key mappings

local wk = require'which-key'
-- if in initial start
wk.register{
	s = {
		name = 'multiwindow',
		v = { '<cmd>vsp<CR>', 'split vertically' },
		h = { '<cmd>sp<CR>', 'split horizonally' },
		c = { '<C-w>c', 'close current one' },
		o = { '<C-w>o', 'close others' },
		t = { function()
			vim.cmd'vsp'
			vim.cmd('term')
		end, 'split shell window' },
		j = { '<cmd>resize -10<CR>', 'resize (-)' },
		k = { '<cmd>resize +10<CR>', 'resize (+)' },
		[','] = { '<cmd>vertical resize -20<CR>', 'vertical resize (-)' },
		['.'] = { '<cmd>vertical resize +20<CR>', 'vertical resize (+)' },
	},
}
wk.register{
	['<A-h>'] = { '<C-w>h', 'switch window (left)' },
	['<A-j>'] = { '<C-w>j', 'switch window (down)' },
	['<A-k>'] = { '<C-w>k', 'switch window (up)' },
	['<A-l>'] = { '<C-w>l', 'switch window (right}' },
	['<leader>l'] = { function()
		vim.o.list = not vim.o.list
	end, 'toggle list mode' },
}
wk.register({
	['<esc>'] = { '<c-\\><c-n>', 'exit insert mode' },
}, { mode = 't' })

--[[
map('v', '<', '<gv', {desc='Adjust indent (less).'})
map('v', '>', '>gv', {desc='Adjust indent (more).'})


-- vertical
map('n', 'sv', ':vsp<CR>', {desc='Split window (vertical).'})
-- horizonal
map('n', 'sh', ':sp<CR>', {desc='Split window (horizonal).'})
-- close current
map('n', 'sc', '<C-w>c', {desc='Close current window.'})
-- close others
map('n', 'so', '<C-w>o', {desc='Close other window.'})

map('n', 's.', ':vertical resize +20<CR>', {desc='Vertical resize (+).'})
map('n', 's,', ':vertical resize -20<CR>', {desc='Vertical resize (-).'} )
map('n', 's=', '<C-w>=', {desc='Reset window size.'})
map('n', 'sj', ':resize +10<CR>', {desc='Resize (+).'})
map('n', 'sk', ':resize -10<CR>', {desc='Resize (-).'})

map('n', '<A-h>', '<C-w>h', {desc='Change window (left).'})
map('n', '<A-j>', '<C-w>j', {desc='Change window (right).'})
map('n', '<A-k>', '<C-w>k', {desc='Change window (up).'})
map('n', '<A-l>', '<C-w>l', {desc='Change window (down).'})

map('n', '<leader>l', ':set list!<CR>')
--]]

-- Alt+m: open nvim tree menu
-- o: open/close folder
-- a: create new file
-- r: rename
-- x: cut
-- c: copy
-- p: plaste
-- d: delete
--[[
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

-- for the keybindings of nvim-cmp, v Core/Plugins.lua
-- ]]
