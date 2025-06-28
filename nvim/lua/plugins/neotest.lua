return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter",
		"Issafalcon/neotest-dotnet",
	},
	keys = {
		{
			"<leader>tr",
			function()
				-- Run nearest test, fallback to current file
				local current_file = vim.fn.expand("%:p")

				if current_file:match("%.cs$") then
					local neotest = require("neotest")

					-- Force discovery of tests in current file
					print("Discovering tests in current file...")
					neotest.summary.open()

					-- Wait a bit for discovery to complete
					vim.defer_fn(function()
						-- Try to run nearest test first
						local success = pcall(function()
							neotest.run.run()
						end)

						if not success then
							-- If no test found under cursor, try running file
							print("Trying to run all tests in file...")
							local file_success = pcall(function()
								neotest.run.run(current_file)
							end)

							if not file_success then
								print("Try using <leader>tA to run all tests, or run from summary window")
							end
						end
					end, 500) -- Wait 500ms for discovery
				else
					print("Not a .cs file. Current file: " .. current_file)
				end
			end,
			desc = "[T]est [R]un",
		},
		{
			"<leader>tR",
			function()
				-- Run all tests in current file
				require("neotest").run.run(vim.fn.expand("%"))
			end,
			desc = "[T]est [R]un (all in file)",
		},
		{
			"<leader>tA",
			function()
				-- Run all tests in the project
				require("neotest").run.run(vim.fn.getcwd())
			end,
			desc = "[T]est [A]ll",
		},
		{
			"<leader>td",
			function()
				require("neotest").run.run({ strategy = "dap" })
			end,
			desc = "[T]est [D]ebug",
		},
		{
			"<leader>ts",
			function()
				local summary_window = require("neotest").summary
				summary_window.toggle()
				local win = vim.api.nvim_get_current_win()
				vim.api.nvim_win_set_width(win, 40)
			end,
			desc = "[T]est [S]ummary",
		},
		{
			"<leader>to",
			function()
				require("neotest").output.open({ enter = true })
			end,
			desc = "[T]est [O]utput",
		},
		{
			"<leader>tp",
			function()
				require("neotest").output_panel.toggle()
			end,
			desc = "[T]est [P]anel",
		},
		{
			"<leader>tt",
			function()
				require("neotest").run.stop()
			end,
			desc = "[T]est S[T]op",
		},
		{
			"<leader>ta",
			function()
				require("neotest").run.attach()
			end,
			desc = "[T]est [A]ttach",
		},
		{
			"<leader>tf",
			function()
				require("neotest").summary.toggle()
				-- Force refresh of test discovery
				vim.defer_fn(function()
					require("neotest").summary.close()
					require("neotest").summary.open()
				end, 100)
			end,
			desc = "[T]est Re[f]resh",
		},
		{
			"<leader>tl",
			function()
				-- Open neotest logs for debugging
				local log_file = vim.fn.stdpath("log") .. "/neotest.log"
				vim.cmd("edit " .. log_file)
			end,
			desc = "[T]est [L]ogs",
		},
		{
			"<leader>tc",
			function()
				-- Clear test cache and refresh properly
				require("neotest").summary.close()
				vim.defer_fn(function()
					require("neotest").summary.open()
				end, 100)
			end,
			desc = "[T]est [C]lear cache",
		},
		{
			"<leader>trf",
			function()
				-- Force refresh all test statuses
				local neotest = require("neotest")
				-- Close and reopen summary to force status refresh
				neotest.summary.close()
				vim.defer_fn(function()
					neotest.summary.open()
					-- Try to trigger status update
					vim.cmd("redraw!")
				end, 200)
			end,
			desc = "[T]est [R]e[f]resh status",
		},
		{
			"<leader>ti",
			function()
				-- Debug: show what neotest sees at cursor
				local tree = require("neotest").state.tree()
				local pos = tree:get_current_node()
				if pos then
					print("Found test: " .. pos.name)
					print("Type: " .. pos.type)
					print("Path: " .. pos.path)
				else
					print("No test found at cursor position")
					print("Current file: " .. vim.fn.expand("%:p"))
				end
			end,
			desc = "[T]est [I]nfo (debug)",
		},
	},
	config = function()
		require("neotest").setup({
			adapters = {
				require("neotest-dotnet")({
					dap = {
						args = { justMyCode = false },
						adapter_name = "netcoredbg",
					},
					-- Minimal configuration to avoid parsing issues
					dotnet_additional_args = {},
					discovery_root = "solution",
				}),
			},
			-- Simplified output configuration
			output = {
				enabled = true,
				open_on_run = false,
			},
			status = {
				enabled = true,
				signs = true,
				virtual_text = true,
			},
			-- Disable problematic features that might interfere
			running = {
				concurrent = false,
			},
			log_level = vim.log.levels.INFO,
		})
	end,
}
