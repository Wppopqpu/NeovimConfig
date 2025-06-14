return {
	{
		"lervag/vimtex",
		lazy = false, -- lazy loading handled internally
		init = function ()
			vim.g.vimtex_view_method = "zathura"
			vim.g.vimtex_compiler_latexmk_engines = { ["_"] = "-xelatex" }
		end,
	},
}
