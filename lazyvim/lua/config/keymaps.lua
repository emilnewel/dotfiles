-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagostic [e]rror under cursor" })
vim.keymap.set("n", "gf", vim.lsp.buf.format, { desc = "Format buffer" })
