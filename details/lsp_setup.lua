local M = {}
local disabled = require("NeovimConfig.details.lsp_disable")

local get_config = function()
	local function on_attach(client, n_buffer)
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

	local config = {
		clangd = {
			--[[
			capabilities = {
				textDocument = {
					semanticHighlightingCapabilities = {
						semanticHighlighting = true,
					},
				},
			},
			on_init = require'nvim-lsp-clangd-highlight'.on_init,
			--]]
			on_attach = function(client, bufnr)
				on_attach(client, bufnr)

				local clangd_ext = require("clangd_extensions")
				local inlay = require("clangd_extensions.inlay_hints")
				local wk = require("which-key")

				inlay.setup_autocmd()
				inlay.set_inlay_hints()

				vim.api.nvim_create_autocmd({"TextChanged", "InsertLeave"}, {
					buffer = bufnr,
					callback = function()
						require("clangd_extensions.inlay_hints").set_inlay_hints()
					end,
				})

				wk.register({
					gs = { "<cmd>ClangdSwitchSourceHeader<cr>", "switch between src & header" },
					["<leader>"] = {
						d = {
							name = "definition",
							a = { "<cmd>ClangdAst<cr>", "view ast" },
							-- TODO: auto open symbol info when cusor dont
							-- move for seconds
							s = { "<cmd>ClangdSymbolInfo<cr>", "symbol info" },
						},
					},
				}, { buf = bufnr })

				vim.api.nvim_set_option_value("omnifunc", "v:lua.vim.lsp.omnifunc", { buf = bufnr })
				require("nvim-clangd-hl").on_attach()
			end,
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

	-- use cmp's default capabilities
	local capabilities = require("cmp_nvim_lsp").default_capabilities()

	local default = {
		on_attach = on_attach,
		capabilities = capabilities,
	}

	for k, each in pairs(config) do
		config[k] = vim.tbl_deep_extend("keep", each, default)
	end

	return config
end

local config_server = function(name, config)
	local lspconfig = require'lspconfig'

	config.capabilities =
		require'cmp_nvim_lsp'.default_capabilities()
	lspconfig[name].setup(config)
end




function M.setup()


	for k, v in pairs(get_config()) do
		if not disabled:has(k) then
			config_server(k, v)
		end
	end


end

return M
