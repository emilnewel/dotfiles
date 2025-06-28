return {
	"mfussenegger/nvim-dap",
	dependencies = {
		{
			"rcarriga/nvim-dap-ui",
			dependencies = { "nvim-neotest/nvim-nio" },
			keys = {
				{
					"<leader>du",
					function()
						require("dapui").toggle({})
					end,
					desc = "Dap UI",
				},
				{
					"<leader>de",
					function()
						require("dapui").eval()
					end,
					desc = "Eval",
					mode = { "n", "v" },
				},
			},
			opts = {},
			config = function(_, opts)
				local dap = require("dap")
				local dapui = require("dapui")
				dapui.setup(opts)
				dap.listeners.after.event_initialized["dapui_config"] = function()
					dapui.open({})
				end
				dap.listeners.before.event_terminated["dapui_config"] = function()
					dapui.close({})
				end
				dap.listeners.before.event_exited["dapui_config"] = function()
					dapui.close({})
				end

				-- Configure .NET Core debugging
				dap.adapters.netcoredbg = {
					type = "executable",
					command = "netcoredbg",
					args = { "--interpreter=vscode" },
				}

				dap.configurations.cs = {
					{
						type = "netcoredbg",
						name = "Launch - .NET Core",
						request = "launch",
						program = function()
							-- Ask the user for the path to the DLL
							return vim.fn.input("Path to dll: ", vim.fn.getcwd() .. "/bin/Debug/", "file")
						end,
						cwd = "${workspaceFolder}",
						stopOnEntry = false,
						console = "integratedTerminal",
					},
					{
						type = "netcoredbg",
						name = "Attach - .NET Core",
						request = "attach",
						processId = require("dap.utils").pick_process,
					},
				}
			end,
		},
		{
			"theHamsta/nvim-dap-virtual-text",
			opts = {},
		},
	},
	keys = {
		{
			"<leader>db",
			function()
				require("dap").toggle_breakpoint()
			end,
			desc = "Toggle Breakpoint",
		},
		{
			"<F5>",
			function()
				require("dap").continue()
			end,
			desc = "Run/Continue",
		},
		{
			"<F11>",
			function()
				require("dap").step_into()
			end,
			desc = "Step Into",
		},
		{
			"<F10>",
			function()
				require("dap").step_over()
			end,
			desc = "Step Over",
		},
		{
			"<leader>dl",
			function()
				require("dap").run_last()
			end,
			desc = "Run Last",
		},
		{
			"<leader>dt",
			function()
				require("dap").terminate()
			end,
			desc = "Terminate",
		},
	},
}
