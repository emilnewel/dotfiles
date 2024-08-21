return {
	"mistweaverco/kulala.nvim",
	config = function()
		vim.filetype.add({
			extension = {
				["http"] = "http",
			},
		})

		local http_augroup = vim.api.nvim_create_augroup("HttpFileType", { clear = true })
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "http",
			callback = function()
				-- Set the keymap for <leader>r in the buffer
				vim.api.nvim_buf_set_keymap(
					0,
					"n",
					"<leader>r",
					'<cmd>lua require("kulala").run()<CR>',
					{ noremap = true, silent = true }
				)
			end,
			group = http_augroup,
		})
	end,
}
