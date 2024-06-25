local map = vim.keymap.set
map("n", "<leader>n", "<cmd>Neotree toggle left<CR>")
map("n", "<ESC>", "<cmd>nohlsearch<CR>")

-- LSP
map("n", "K", vim.lsp.buf.hover, {})
map("n", "gd", vim.lsp.buf.definition, {})
map({ "n" }, "<leader>ca", vim.lsp.buf.code_action, {})

-- Diagnostics
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
map("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
