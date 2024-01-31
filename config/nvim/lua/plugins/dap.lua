return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"theHamsta/nvim-dap-virtual-text",
			"leoluz/nvim-dap-go",
		},
		init = function()
			local sign = vim.fn.sign_define

			sign("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
			sign("DapBreakpointCondition", { text = "●", texthl = "DapBreakpointCondition", linehl = "", numhl = "" })
			sign("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = "" })
		end,
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")
			local daptext = require("nvim-dap-virtual-text")
			local dapgo = require("dap-go")

			daptext.setup()
			dapui.setup()
			dapgo.setup()

			-- require("dap.ext.vscode").load_launchjs(nil, {})

			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open(1)
			end

			dap.listeners.after.event_terminated["dapui_config"] = function()
				dapui.close()
			end

			dap.listeners.after.event_exited["dapui_config"] = function()
				dapui.close()
			end
		end,
		keys = {
			{ "<leader>vc", "<cmd>lua require'dap'.continue()<cr>" },
			{
				"<leader>vs",
				function()
					local dap = require("dap")
					local dapui = require("dapui")
					dap.close()
					dapui.close()
				end,
			},
			{ "<leader>b", "<cmd>lua require'dap'.toggle_breakpoint()<cr>" },
			{
				"<leader>B",
				function()
					local dap = require("dap")
					dap.set_breakpoint(vim.fn.input("Breakpoint Condition: "))
				end,
			},
			{ "<F10>", "<cmd>lua require'dap'.step_over()<cr>" },
			{ "<F11>", "<cmd>lua require'dap'.step_into()<cr>" },
			{ "<F12>", "<cmd>lua require'dap'.step_out()<cr>" },
		},
	},
}
