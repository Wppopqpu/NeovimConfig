local M = {}
local disabled = require("NeovimConfig.details.lsp_disable")

local get_config = function()
	local config = {
		clangd = {
			capabilities = {
				textDocument = {
					semanticHighlightingCapabilities = {
						semanticHighlighting = true,
					},
				},
			},
			on_init = require'nvim-lsp-clangd-highlight'.on_init
		},
		html = {},
		jsonls = {},
		ltex = {},
		lua_ls = {},
		pyre = {},
		tsserver = {},
		leanls = {},
		lean3ls = {},
	}
	function on_attach(client, n_buffer)
		local wk = require'which-key'
		wk.register({
			h = {
				name = 'call hierarchy',
				i = { '<cmd>Lspsaga incoming_calls<CR>', 'incoming' },
				o = { '<cmd>Lspsaga outgoing_calls<CR>', 'outgoing' },
			},
			a = { '<cmd>Lspsaga code_action<CR>', 'code action' },
			d = {
				name = '+definition',
				p = { '<cmd>Lspsaga peek_definition<CR>', "peek definition" },
				P = { '<cmd>Lspsaga peek_type_definition<CR>', "peek type definition" },
				g = { '<cmd>Lspsaga goto_definition<CR>', "goto definition" },
				G = { '<cmd>Lspsaga goto_type_definition<CR>', "goto type definition" },
				o = { '<cmd>Lspsaga outline<cr>', 'symbols outline' },
				r = { '<cmd>Lspsaga rename<cr>', 'rename' },
				k = { '<cmd>Lspsaga hover_doc<cr>', 'hover doc' },
				K = { "<cmd>Lspsaga hover_doc ++keep<cr>", "hover doc (keep)" },
			},
			e = {
				name = 'diagnostic',
				j = { '<cmd>Lspsaga diagnostic_jump_next<CR>', 'next' },
				k = { '<cmd>Lspsaga diagnostic_jump_prev<CR>', 'prev' },
			},
			f = { '<cmd>Lspsaga finder<CR>', 'lsp finder' },

		}, { prefix = '<leader>', buffer = n_buffer })

	end


	-- use cmp's default capabilities
	local capabilities = require("cmp_nvim_lsp").default_capabilities()

	local default = {
		on_attach = on_attach,
		capabilities = capabilities,
	}

	for _, each in pairs(config) do
		each = vim.tbl_deep_extend("keep", each, default)
	end

	return config
end

local startServer = function(name, config)
	local lspconfig = require'lspconfig'

	config.capabilities =
		require'cmp_nvim_lsp'.default_capabilities()
	lspconfig[name].setup(config)
end




function M.setup()


	for k, v in pairs(get_config()) do
		if not disabled:has(k) then
			startServer(k, v)
		end
	end


end

return M
