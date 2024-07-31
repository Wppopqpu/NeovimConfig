vim.api.nvim_create_user_command("ListWindow", function (info)
	local windows = vim.api.nvim_list_wins()

	local msg = ""
	for _, v in ipairs(windows) do
		local buf = vim.api.nvim_win_get_buf(v)
		local ft = vim.bo[buf].filetype
		local relative = vim.api.nvim_win_get_config(v).relative

		msg = msg..v..": "..ft.."; "..relative.."\n"
	end

	print(msg)
end, {
	desc = "list windows and fts",
})
