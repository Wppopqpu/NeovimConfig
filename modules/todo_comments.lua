return {
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local todo = require("todo-comments")
			todo.setup{}
			require("which-key").register({
				t = {
					name = "todo comments",
					["["] = { todo.jump_prev, "previos" },
					["]"] = { todo.jump_next, "next" },
					l = { "<cmd>TodoTrouble", "list" },
				}
			}, { prefix = "<leader>" })
		end,
		event = "VeryLazy",
	},
}
