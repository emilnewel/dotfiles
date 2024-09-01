return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			-- vim.cmd.colorscheme("catppuccin-mocha")
		end,
	},
	{
		"folke/tokyonight.nvim",
		name = "tokyonight",
		priority = 1000,
		config = function()
			-- vim.g.tokyonight_style = "storm"
			-- vim.cmd.colorscheme("tokyonight")
		end,
	},
	{
		"rose-pine/neovim",
		name = "rose-pine",
		priority = 1000,
		config = function()
			-- require("rose-pine").setup({
			-- 	variant = "moon",
			-- })
			-- vim.cmd.colorscheme("rose-pine")
		end,
	},
	{
		"dgox16/oldworld.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			-- vim.cmd.colorscheme("oldworld")
		end,
	},
	{
		"mellow-theme/mellow.nvim",
		lazy = false,
		priority = 1000,
		-- config = function()
		-- 	vim.cmd.colorscheme("mellow")
		-- end,
	},
	{
		"rebelot/kanagawa.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("kanagawa-dragon")
		end,
	},
}
