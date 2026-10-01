return {
	{
		"nickjvandyke/opencode.nvim",
		version = "*", -- OpenCode 1.x uses the stable plugin release.
		event = "VeryLazy",
		config = function()
			---@type opencode.Opts
			vim.g.opencode_opts = {
				server = {
					start = function()
						vim.cmd("botright vsplit")
						vim.cmd("terminal opencode --port")

						local buf = vim.api.nvim_get_current_buf()
						vim.bo[buf].filetype = "opencode"
						vim.bo[buf].bufhidden = "hide"
						vim.cmd("wincmd p")
					end,
				},
			}

			vim.keymap.set({ "n", "x" }, "<C-a>", function()
				require("opencode").ask("@this: ")
			end, { desc = "Ask OpenCode" })
			vim.keymap.set({ "n", "x" }, "<C-x>", function()
				require("opencode").select()
			end, { desc = "Select OpenCode" })
			vim.keymap.set({ "n", "x" }, "go", function()
				return require("opencode").operator("@this")
			end, { expr = true, desc = "Send range to OpenCode" })
			vim.keymap.set("n", "goo", function()
				return require("opencode").operator("@this") .. "_"
			end, { expr = true, desc = "Send line to OpenCode" })
		end,
	},
}
