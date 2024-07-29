local on_lazy = require("NeovimConfig.details.on_lazy")
--[[
local hl = 'Statement'
local startUpImage = {
	'    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⠤⠖⠚⢉⣩⣭⡭⠛⠓⠲⠦⣄⡀⠀⠀⠀⠀⠀⠀⠀  ',
	'    ⠀⠀⠀⠀⠀⠀⢀⡴⠋⠁⠀⠀⠊⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠳⢦⡀⠀⠀⠀⠀  ',
	'    ⠀⠀⠀⠀⢀⡴⠃⢀⡴⢳⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⣆⠀⠀⠀  ',
	'    ⠀⠀⠀⠀⡾⠁⣠⠋⠀⠈⢧⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢧⠀⠀  ',
	'    ⠀⠀⠀⣸⠁⢰⠃⠀⠀⠀⠈⢣⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⣇⠀  ',
	'    ⠀⠀⠀⡇⠀⡾⡀⠀⠀⠀⠀⣀⣹⣆⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹⠀  ',
	'    ⠀⠀⢸⠃⢀⣇⡈⠀⠀⠀⠀⠀⠀⢀⡑⢄⡀⢀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡇  ',
	'    ⠀⠀⢸⠀⢻⡟⡻⢶⡆⠀⠀⠀⠀⡼⠟⡳⢿⣦⡑⢄⠀⠀⠀⠀⠀⠀⠀⠀⢸⡇  ',
	'    ⠀⠀⣸⠀⢸⠃⡇⢀⠇⠀⠀⠀⠀⠀⡼⠀⠀⠈⣿⡗⠂⠀⠀⠀⠀⠀⠀⠀⢸⠁  ',
	'    ⠀⠀⡏⠀⣼⠀⢳⠊⠀⠀⠀⠀⠀⠀⠱⣀⣀⠔⣸⠁⠀⠀⠀⠀⠀⠀⠀⢠⡟⠀  ',
	'    ⠀⠀⡇⢀⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠠⠀⡇⠀⠀⠀⠀⠀⠀⠀⠀⢸⠃⠀  ',
	'    ⠀⢸⠃⠘⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⠁⠀⠀⢀⠀⠀⠀⠀⠀⣾⠀⠀  ',
	'    ⠀⣸⠀⠀⠹⡄⠀⠀⠈⠁⠀⠀⠀⠀⠀⠀⠀⡞⠀⠀⠀⠸⠀⠀⠀⠀⠀⡇⠀⠀  ',
	'    ⠀⡏⠀⠀⠀⠙⣆⠀⠀⠀⠀⠀⠀⠀⢀⣠⢶⡇⠀⠀⢰⡀⠀⠀⠀⠀⠀⡇⠀⠀  ',
	'    ⢰⠇⡄⠀⠀⠀⡿⢣⣀⣀⣀⡤⠴⡞⠉⠀⢸⠀⠀⠀⣿⡇⠀⠀⠀⠀⠀⣧⠀⠀  ',
	'    ⣸⠀⡇⠀⠀⠀⠀⠀⠀⠉⠀⠀⠀⢹⠀⠀⢸⠀⠀⢀⣿⠇⠀⠀⠀⠁⠀⢸⠀⠀  ',
	'    ⣿⠀⡇⠀⠀⠀⠀⠀⢀⡤⠤⠶⠶⠾⠤⠄⢸⠀⡀⠸⣿⣀⠀⠀⠀⠀⠀⠈⣇⠀  ',
	'    ⡇⠀⡇⠀⠀⡀⠀⡴⠋⠀⠀⠀⠀⠀⠀⠀⠸⡌⣵⡀⢳⡇⠀⠀⠀⠀⠀⠀⢹⡀  ',
	'    ⡇⠀⠇⠀⠀⡇⡸⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⠮⢧⣀⣻⢂⠀⠀⠀⠀⠀⠀⢧  ',
	'    ⣇⠀⢠⠀⠀⢳⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⡎⣆⠀⠀⠀⠀⠀⠘  ',
}
--]]

return {
	{
		'folke/tokyonight.nvim',
		lazy = false,
		priority = 1000, -- Make sure to load this plugin before others.
		config = function()
			vim.cmd'colorscheme tokyonight'
		end,
	},
	{
		'stevearc/dressing.nvim',
		event = 'VeryLazy', -- Not important for the initial UI
		config = true,
	},
	{
		'folke/noice.nvim',
		event = 'VeryLazy',
		config = function ()
			require("noice").setup {
				lsp = {
					override = {
						['vim.lsp.util.convert_input_to_markdown_lines'] = true,
						['vim.lsp.util.stylize_markdown'] = true,
						['cmp.entry.get_documentation'] = true,
					},
				},

				presets = {
					bottom_search = true,
					command_palette = true,
					long_messages_to_split = false,
				},
			}

			require("which-key").add {
				{ "<a-a>", "<cmd>NoiceLast<cr>", desc = "noice: last msg" },
			}
		end,
		dependencies = {
			'MunifTanjim/nui.nvim',
			'rcarriga/nvim-notify',
		}
	},
	{
		'nvim-lualine/lualine.nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		config = true,
	},
	{
		'goolord/alpha-nvim',
		config = function()
			--[[
			local alpha = require'alpha'
			local dashboard = require'alpha.themes.dashboard'
			dashboard.section.header.val = startUpImage
			alpha.setup(dashboard.config)
			--]]
			local modname = "NeovimConfig.details.startup_image"
			local image = require(modname)

			require'alpha'.setup{
				layout = {
					header = {
						type = 'text',
						val = image.text,
						opts = {
							hl = image.hl,
							position = 'center',
						},
					},
				},
			}

			package.preload[modname]=nil
		end,
		dependencies = {
			{'nvim-tree/nvim-web-devicons'}
		},
	},
	{
		'akinsho/bufferline.nvim',
		dependencies = 'nvim-tree/nvim-web-devicons',
		config = function()
			require'bufferline'.setup {
				options = {
					separator_style = 'slant',
					get_element_icon = function(element)
						local icon, hl = require'nvim-web-devicons'
							.get_icon_by_filetype(element.filetype
								, { default = false })
						return icon, hl
					end,

					numbers = function(opts)
						return string.format('%s%s', opts.id
							, opts.lower(opts.ordinal))
					end,

					offsets = {
						{
							filetype = 'NvimTree',
							text = 'explorer',
							highlight = 'Directory',
							text_align = 'center',
						},
						{
							filetype = 'sagaoutline',
							text = 'outline',
							highlight = 'Directory',
							text_align = 'center',
						},
					},
				},
			}
			on_lazy.register(function()
				local wk = require'which-key'
				wk.register{
					['<C-h>'] = { '<cmd>BufferLineCyclePrev<CR>', 'next buffer' },
					['<C-l>'] = { '<cmd>BufferLineCycleNext<CR>', 'prev buffer' },
					['<C-p>'] = { '<cmd>BufferLinePick<CR>', 'pick buffer' },
				}
				wk.register({
					b = {
						name = 'bufferline operations',
						x = { '<cmd>bdelete<cr>', 'close buffer' },
						X = { '<cmd>bdelete!<cr>', 'force close buffer' },
						t = { '<cmd>term<cr>', 'open terminal buffer' },
					}
				}, { prefix = '<leader>' })
			end)
		end,
	},
	{
		'nvim-tree/nvim-tree.lua',
		dependencies = {
			'nvim-tree/nvim-web-devicons'
		},
		init = function()
			vim.g.loaded_netrw = 1
			vim.g.loaded_netrwPlugin = 1
		end,
		event = "VeryLazy",
		config = function()
			local function setup()
				require'nvim-tree'.setup{
					view = {
						float = {
							enable = true,
							quit_on_focus_loss = false,
						},
					},
					hijack_unnamed_buffer_when_opening = true,
					on_attach = function(bufnr)
						local wk = require("which-key")
						local preview = require("nvim-tree-preview")
						local api = require("nvim-tree.api")

						-- use default mappings
						api.config.mappings.default_on_attach(bufnr)
						wk.register({
							P = { preview.watch, "nvim-tree: open preview" },
							["<esc>"] = { preview.unwatch, "nvim-tree: close preview" },
							-- smart tab behavior: only preview files, expand/collapse directories (recommended)
							["<tab>"] = {function()
								local ok, node = pcall(api.tree.get_node_under_cursor)
								if ok and node then
									if node.type == 'directory' then
										api.node.open.edit()
									else
										preview.node(node, { toggle_focus = true })
									end
								end
							end, "nvim-tree preview" },
						}, { buffer = bufnr, nowait = true })
					end,
				} -- setup

				local tree = require("nvim-tree.api").tree
				require'which-key'.register{
					['<A-m>'] = { tree.toggle, 'toggle file explorer' },
					["<A-M>"] = { tree.open, "open file explorer" },
				}
			end

			setup()
		end,
	},
	{
		"b0o/nvim-tree-preview.lua",
		config = function()
			require("nvim-tree-preview").setup{}
		end,
		lazy = true,
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},

	{
		"lewis6991/satellite.nvim",
		config = true,
		event = "VeryLazy",
		enabled = function()
			local version = vim.version()
			if version.major == 0 and version.minor < 10 then
				return false
			end
			return true
		end,
	},
	{
		'echasnovski/mini.animate',
		config = true,
		event = 'VeryLazy',
	},
	{
		"b0o/incline.nvim",
		event =  "VeryLazy",
		config = function ()
			local incline = require("incline")
			incline.setup {
				window = {
					padding = 0,
					margin = {
						horizontal = 0,
					},
					zindex = 50,
				},
				render = function (props)
					local helpers = require("incline.helpers")
					local devicon = require("nvim-web-devicons")

					local fname = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
					if fname == "" then
						fname = "%NO NAME%"
					end

					local icon, color = devicon.get_icon_color(fname)
					local mod = vim.bo[props.buf].modified

					return {
						icon and { " ", icon, " ", guibg = color, guifg = helpers.contrast_color(color) },
						" ",
						{ fname, gui = mod and "bold,italic" or "bold" },
						" ",
						guibg = "#44406e",
					}
				end,
			}
			incline.enable()
		end,
	},
}
