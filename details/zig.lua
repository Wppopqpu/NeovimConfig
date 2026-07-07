if test_capability("zig") == false then
	return
end

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.zig",
	callback = function ()
		vim.lsp.buf.format({async = false })
	end,
})
