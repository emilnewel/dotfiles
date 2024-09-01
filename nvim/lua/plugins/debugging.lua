local pythonPath = function()
	local cwd = vim.loop.cwd()
	if vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
		return cwd .. "/.venv/bin/python"
	else
		return "/usr/bin/python"
	end
end

return {
	{
		"mfussenegger/nvim-dap-python",
		config = function()
			local dap_python = require("dap-python")
			dap_python.setup("/Users/emil/.pyenv/versions/nvim-dap/bin/python")
			dap_python.test_runner = "pytest"
			vim.keymap.set("n", "<leader>dn", dap_python.test_method, { desc = "Test Method" })
			vim.keymap.set("n", "<leader>df", dap_python.test_class, { desc = "Test Class" })
			vim.keymap.set("v", "<leader>ds", dap_python.debug_selection, { desc = "[D]ebug [S]election" })
		end,
	},
	{
		"mfussenegger/nvim-dap",
		dependencies = { "rcarriga/nvim-dap-ui", "nvim-neotest/nvim-nio", "theHamsta/nvim-dap-virtual-text" },
		config = function()
			local dap, dapui, virtualText = require("dap"), require("dapui"), require("nvim-dap-virtual-text")
			dapui.setup({
				layouts = {
					{
						elements = {
							{
								id = "scopes",
								size = 0.25,
							},
							{
								id = "breakpoints",
								size = 0.25,
							},
							{
								id = "stacks",
								size = 0.25,
							},
							{
								id = "repl",
								size = 0.25,
							},
						},
						position = "left",
						size = 100,
					},
					{
						elements = {
							{
								id = "console",
								size = 1,
							},
						},
						position = "bottom",
						size = 10,
					},
				},
			})
			vim.fn.sign_define("DapBreakpoint", { text = "🛑", texthl = "", linehl = "", numhl = "" })
			virtualText.setup()
			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
			-- dap.listeners.before.event_terminated.dapui_config = function()
			-- 	dapui.close()
			-- end
			-- dap.listeners.before.event_exited.dapui_config = function()
			-- 	dapui.close()
			-- end

			dap.configurations.python = {
				{
					name = "N1 Django",
					type = "python",
					request = "launch",
					program = vim.loop.cwd() .. "/src/n1/manage.py",
					args = {
						"runserver",
						"--noreload",
					},
					django = true,
					justMyCode = true,
					console = "internalConsole",
					pythonPath = pythonPath(),
				},
				{
					name = "Elko Django",
					type = "python",
					request = "launch",
					program = vim.loop.cwd() .. "/src/python/elko/manage.py",
					args = {
						"runserver",
						"--noreload",
					},
					django = true,
					justMyCode = true,
					console = "internalConsole",
					pythonPath = pythonPath(),
				},
			}

			dap.adapters.python = {
				type = "executable",
				command = pythonPath(),
				args = { "-m", "debugpy.adapter" },
			}

			vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "Toggle [B]reakpoint" })
			vim.keymap.set("n", "<F5>", dap.continue, {})
			vim.keymap.set("n", "<F10>", dap.step_over, {})
			vim.keymap.set("n", "<F11>", dap.step_into, {})
			vim.keymap.set("n", "<F12>", dap.step_out, {})
			vim.keymap.set("n", "<leader>dq", dapui.close, { desc = "[D]ebug [Q]uit" })
		end,
	},
}
