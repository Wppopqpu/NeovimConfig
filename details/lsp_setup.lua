local M = {}
local disabled = require("NeovimConfig.details.lsp_disable")

local ts_hint_conf = {
	includeInlayParameterNameHints = "all",
	includeInlayParameterNameHintsWhenArgumentMatchesName = true,
	includeInlayFunctionParameterTypeHints = true,
	includeInlayVariableTypeHints = true,
	includeInlayVariableTypeHintsWhenTypeMatchesName = true,
	includeInlayPropertyDeclarationTypeHints = true,
	includeInlayFunctionLikeReturnTypeHints = true,
	includeInlayEnumMemberValueHints = true,
}

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
				j = { function ()
					vim.g.minianimate_disable = true
					vim.cmd("Lspsaga diagnostic_jump_next")
					vim.uv.new_timer():start(1000, 0, vim.schedule_wrap(function ()
						vim.g.minianimate_disable = false
					end))
				end, 'next' },
				k = { function ()
					vim.g.minianimate_disable = true
					vim.cmd("Lspsaga diagnostic_jump_prev")
					vim.uv.new_timer():start(1000, 0, vim.schedule_wrap(function ()
						vim.g.minianimate_disable = false
					end))
				end, 'prev' },
			},
			f = { '<cmd>Lspsaga finder<CR>', 'lsp finder' },

		}, { prefix = '<leader>', buffer = n_buffer })

	end

	local config = {
		clangd = {
			settings = {
				clangd = {
					InlayHints = {
						Designators = true,
						Enable = true,
						ParameterNames = true,
						DeducedTypes = true,
					},
					fallbackFlags = { "--std=c++20" },
				},
			},
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
			init_options = {
				compilationDatabasePath = ".nvim",
			},
			on_attach = function(client, bufnr)
				on_attach(client, bufnr)

				local clangd_ext = require("clangd_extensions")
				-- hints was managed by nvim-lsp-endhints
				-- local inlay = require("clangd_extensions.inlay_hints")
				local wk = require("which-key")

				--[[
				inlay.setup_autocmd()
				inlay.set_inlay_hints()

				vim.api.nvim_create_autocmd({"TextChanged", "InsertLeave"}, {
					buffer = bufnr,
					callback = function()
						require("clangd_extensions.inlay_hints").set_inlay_hints()
					end,
				})
				--]]

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
			end,
		},
		html = {},
		jsonls = {},
		ltex = {},
		lua_ls = {
			settings = {
				Lua = {
					hint = {
						enable = true,
					},
				},
			},
		},
		pyre = {},
		tsserver = {
			settings = {
				typescript = {
					hint = ts_hint_conf,
				},
				javascript = {
					hint = ts_hint_conf,
				},
			},
		},
		leanls = {},
		lean3ls = {},
	}

	-- use cmp's default capabilities
	local capabilities = require("cmp_nvim_lsp").default_capabilities()

	-- required by nvim-ufo
	capabilities.textDocument.foldingRange = {
		dynamicRegistration = false,
		lineFoldingOnly = true,
	}

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
