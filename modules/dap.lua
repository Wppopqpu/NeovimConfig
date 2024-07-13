return {
	{
		"mfussenegger/nvim-dap",
		event = "VeryLazy",
		dependencies = {
			"jay-babu/mason-nvim-dap.nvim",
		},
		config = function ()
			local dap = require("dap")
			local wk = require("which-key")

			dap.configurations.cpp = {
				{
					name = "Launch file",
					type = "codelldb",
					program = function ()
						return require("xmake.project").info.target.exec_path
					end,
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
				},
			}

			wk.add {
				{ "<f5>", dap.continue, desc = "dap: continue" },
				{ "<f10>", dap.step_over, desc = "dap: step over" },
				{ "<f11>", dap.step_into, desc = "dap: step into" },
				{ "<f12>", dap.step_out, desc = "dap: step out" },
				{ "<a-B>", dap.toggle_breakpoint, desc = "dap: toggle breakpoint" },
				{ "<a-b>", group = "dap" },
				{ "<a-b>m", function ()
					dap.set_breakpoint(nil, nil, vim.fn.input("message:"))
				end, desc = "message" },
				{ "<a-b>c", function ()
					dap.set_breakpoint(vim.fn.input("condition"))
				end, desc = "condition" },
				{ "<a-b>o", dap.repl.open, desc = "open reply" },
				{ "<a-b>r", dap.run_last, desc = "run last" },
			}
		end,
	},
	{
		"theHamsta/nvim-dap-virtual-text",
		event = "VeryLazy",
		dependencies = {
			"mfussenegger/nvim-dap",
		},
		config = true,
	},
	{
		"jay-babu/mason-nvim-dap.nvim",
		lazy = true,
		dependencies = {
			"williamboman/mason.nvim",
		},
		config = function ()
			require("mason-nvim-dap").setup {
				ensure_installed = {
					"codelldb",
				},
			}
		end,
	},
}
