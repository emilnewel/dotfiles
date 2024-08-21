local map = vim.keymap.set
map("n", "<leader>n", "<cmd>:Neotree filesystem toggle right<CR>", { desc = "Toggle [N]eotree" })
map("n", "<ESC>", "<cmd>nohlsearch<CR>")
map("i", "jk", "<ESC>")
map("i", "kj", "<ESC>")
map("i", "jj", "<ESC>")
map("i", "kk", "<ESC>")

-- Diagnostics
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
map("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

local http_augroup = vim.api.nvim_create_augroup("HttpFileType", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
	pattern = "http",
	callback = function()
		-- Set the keymap for <leader>r in the buffer
		vim.api.nvim_buf_set_keymap(
			0,
			"n",
			"<leader>r",
			'<cmd>echo "Run HTTP request"<CR>',
			{ noremap = true, silent = true }
		)
	end,
	group = http_augroup,
})

map("n", "<leader>z", "<cmd>UndotreeToggle<CR>", { desc = "Toggle UndoTree" })

map("n", "BB", "<cmd>bp<CR>", { desc = "Previous buffer" })
map("n", "<leader>gs", "<cmd>Telescope git_status<CR>", { desc = "[G]it [S]tatus" })
