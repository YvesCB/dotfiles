return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"williamboman/mason.nvim",
			"nvim-neotest/nvim-nio",
			"theHamsta/nvim-dap-virtual-text",
		},
		config = function()
			local dap = require("dap")
			local ui = require("dapui")
			local dapvirt = require("nvim-dap-virtual-text")

			ui.setup()
			dapvirt.setup()

			-- NOTE: We make sure we have lldb installed via our mason ensure_installed config
			dap.adapters.codelldb = {
				type = "server",
				port = "${port}",
				executable = {
					command = "codelldb",
					args = { "--port", "${port}" },
				},
			}

			dap.configurations.rust = {
				{
					name = "lldb debug",
					type = "codelldb",
					request = "launch",
					program = function()
						vim.fn.jobstart("cargo build")
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
					end,
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
					showDisassembly = "never",
				},
			}

			vim.fn.sign_define("DapBreakpoint", { text = "B", texthl = "PmenuSel", linehl = "", numhl = "" })
			vim.fn.sign_define("DapBreakpointCondition", { text = "C", texthl = "PmenuSel", linehl = "", numhl = "" })
			vim.fn.sign_define("DapLogPoint", { text = "L", texthl = "PmenuSel", linehl = "", numhl = "" })
			vim.fn.sign_define("DapStopped", { text = "→", texthl = "PmenuSel", linehl = "", numhl = "" })
			vim.fn.sign_define("DapBreakpointRejected", { text = "R", texthl = "PmenuSel", linehl = "", numhl = "" })

			vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "DAP: Toggle a [B]reakpoint" })
			vim.keymap.set("n", "<leader>cb", dap.clear_breakpoints, { desc = "DAP: [C]lear all [B]reakpoint" })
			vim.keymap.set("n", "<leader>B", function()
				dap.set_breakpoint(vim.fn.input("Condition: "))
			end, { desc = "DAP: Set a conditional [B]reakpoint" })

			vim.keymap.set("n", "<leader>d?", function()
				ui.eval(nil, { enter = true })
			end, { desc = "DAP: Eval under cursor" })

			vim.keymap.set("n", "<F8>", dap.continue, { silent = true, desc = "DAP: Continue" })
			vim.keymap.set("n", "<F9>", dap.step_into, { silent = true, desc = "DAP: Step into" })
			vim.keymap.set("n", "<F10>", dap.step_over, { silent = true, desc = "DAP: Step over" })
			vim.keymap.set("n", "<F11>", dap.step_out, { silent = true, desc = "DAP: Step out" })
			vim.keymap.set("n", "<F7>", dap.step_back, { silent = true, desc = "DAP: Step back" })
			vim.keymap.set("n", "<F12>", dap.terminate, { silent = true, desc = "DAP: Terminate" })

			dap.listeners.before.attach.dapui_config = function()
				ui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				ui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				ui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				ui.close()
			end
		end,
	},
}
