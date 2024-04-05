return {
	{
		'willothy/flatten.nvim',
		opts = {
			nested_if_no_args = true,
			window = {
				focus = 'last',
			},
		},
		-- Make sure it is start first to reduce delay
		-- when opening file from terminal.
		priority = 1001,
	},
}
