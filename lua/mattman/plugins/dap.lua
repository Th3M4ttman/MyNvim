return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"nvim-neotest/nvim-nio", -- required by nvim-dap-ui
		"rcarriga/nvim-dap-ui",
		"theHamsta/nvim-dap-virtual-text",
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")
		local dapvt = require("nvim-dap-virtual-text")

		dapui.setup()
		dapvt.setup({
			enabled = true,
			enabled_commands = true,
			highlight_changed_variables = true,
			highlight_new_as_changed = true,
			show_stop_reason = true,
		})

		dap.adapters.codelldb = {
			type = "server",
			port = "${port}",
			executable = {
				command = "/data/data/com.termux/files/usr/bin/codelldb", -- adjust path
				args = { "--port", "${port}" },
			},
		}

		dap.configurations.rust = {
			{
				name = "Debug executable",
				type = "codelldb",
				request = "launch",
				program = function()
					-- assume binary is target/debug/<folder-name>
					local cargo_toml = vim.fn.getcwd() .. "/Cargo.toml"
					local pkg_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t") -- folder name
					return vim.fn.getcwd() .. "/target/debug/" .. pkg_name
				end,
				cwd = "${workspaceFolder}",
				stopOnEntry = false,
			},
		}
	end,
}
