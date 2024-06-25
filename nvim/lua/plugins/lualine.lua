return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("lualine").setup({
			tabline = {
				lualine_b = {
					"diff",
					"branch",
					{
						"diagnostics",
						sources = { "nvim_lsp" },
						-- Displays diagnostics for the defined severity types
						sections = { "error", "warn", "info", "hint" },
						colored = true, -- Displays diagnostics status in color if set to true.
						update_in_insert = false, -- Update diagnostics in insert mode.
						always_visible = false, -- Show diagnostics even if there are none.
					},
				},
				lualine_c = { { "filename", path = 1 } },
			},
		})
	end,
}
