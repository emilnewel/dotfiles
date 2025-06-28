return {
	{
		"echasnovski/mini.statusline",
		version = false,
		opts = {},
		config = function()
			require("mini.statusline").setup()
		end,
	},
	{
		"echasnovski/mini.diff",
		version = false,
		config = function()
			require("mini.diff").setup()
		end,
	},
	{
		"echasnovski/mini-git",
		version = false,
		main = "mini.git",
		config = function()
			require("mini.git").setup()
		end,
	},
}
