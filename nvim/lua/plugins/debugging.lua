return {
	{
		"mfussenegger/nvim-dap-python",
		config = function()
			local dap_python = require("dap-python")
			dap_python.setup("/Users/emil/.pyenv/versions/nvim-dap/bin/python")
			dap_python.test_runner = "pytest"

			vim.keymap.set("n", "<leader>dn", dap_python.test_method, {})
			vim.keymap.set("n", "<leader>df", dap_python.test_class, {})
			vim.keymap.set("v", "<leader>ds", dap_python.debug_selection, {})
		end,
	},
	{
		"mfussenegger/nvim-dap",
		dependencies = { "rcarriga/nvim-dap-ui", "nvim-neotest/nvim-nio" },
		config = function()
			local dap, dapui = require("dap"), require("dapui")
			dapui.setup()
			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end

			dap.configurations.python = {
				{
					name = "Python: Django N1",
					type = "python",
					request = "launch",
					program = "${workspaceFolder}/src/n1/manage.py",
					args = {
						"runserver",
					},
					django = true,
					justMyCode = true,
					purpose = {
						"debug-test",
					},
				},
			}
			vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, {})
			vim.keymap.set("n", "<F5>", dap.continue, {})
			vim.keymap.set("n", "<F10>", dap.step_over, {})
			vim.keymap.set("n", "<F11>", dap.step_into, {})
			vim.keymap.set("n", "<F12>", dap.step_out, {})
		end,
	},
}
