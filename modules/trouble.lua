return {
	{
		"folke/trouble.nvim",
		event = "VeryLazy",
		config = function()
			local trouble = require("trouble")
			require("which-key").register({
				k = {
					name = "trouble list",
					x = { trouble.toggle, "common" },
					w = { function()
						trouble.toggle("workspace_diagnostics")
					end, "workspace diagnostics" },
					d = { function()
						trouble.toggle("document_diagnostic")
					end, "document diagnostics" },
					q = { function()
						trouble.toggle("quickfix")
					end, "quickfix" },
					l = { function()
						trouble.toggle("loclist")
					end, "loclist" },
					r = { function()
						trouble.toggle("lsp_references")
					end, "lsp ref" },
				},
			}, { prefix = "<leader>" })
		end,
	},
}
