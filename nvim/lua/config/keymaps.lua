vim.keymap.set("n", "-", "<cmd>Oil --float<CR>", { desc = "Open Oil in float mode" })
vim.keymap.set("n", "gl", function()
	vim.diagnostic.open_float()
end, { desc = "Open Diagnostics in Float" })

vim.keymap.set("n", "gf", function()
	require("conform").format({
		lsp_format = "fallback",
	})
end, { desc = "Format current file" })

vim.keymap.set("n", "<ESC>", ":nohl<CR>", { silent = true })
