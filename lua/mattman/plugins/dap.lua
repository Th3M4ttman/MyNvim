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

		--------------------------------------------------------
		-- Python: debugpy
		---------------------------------------------------------
		dap.adapters.python = {
			type = "executable",
			command = os.getenv("HOME") .. "/.local/share/nvim/mason/packages/debugpy/venv/bin/python",
			args = { "-m", "debugpy.adapter" },
		}

		dap.configurations.python = {
			{
				type = "python",
				request = "launch",
				name = "Launch file",
				program = "${file}",
				pythonPath = function()
					local venv = os.getenv("VIRTUAL_ENV")
					if venv then
						return venv .. "/bin/python"
					else
						return os.getenv("HOME") .. "/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
					end
				end,
				console = "integratedTerminal", -- <--- important
			},
		}
	end,
}
