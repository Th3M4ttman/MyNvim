local Path = require("plenary.path")
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local dap = require("dap")
local dapui = require("dapui")

local function open_console_float()
	dapui.float_element("console", { enter = true })
end

-- find Cargo.toml upwards
local function find_cargo_toml()
	local path = vim.fn.getcwd()
	while path ~= "/" do
		local candidate = path .. "/Cargo.toml"
		if vim.fn.filereadable(candidate) == 1 then
			return candidate
		end
		path = Path:new(path):parent().filename
	end
	return nil
end

-- parse [[bin]] names from Cargo.toml
local function get_cargo_bins(cargo_toml_path)
	local bins = {}
	local in_bin_section = false
	for line in io.lines(cargo_toml_path) do
		if line:match("^%s*%[%[bin%]%]") then
			in_bin_section = true
		elseif in_bin_section then
			local name = line:match('^%s*name%s*=%s*"(.-)"')
			if name then
				table.insert(bins, name)
			end
			if line:match("^%s*%[") then
				in_bin_section = false
			end
		end
	end

	-- fallback to package name if no bins
	if #bins == 0 then
		for line in io.lines(cargo_toml_path) do
			local pkg_name = line:match('^%s*name%s*=%s*"(.-)"')
			if pkg_name then
				table.insert(bins, pkg_name)
				break
			end
		end
	end

	return bins
end

-- telescope picker helper
local function pick_from_list(prompt, list, callback)
	pickers
		.new({}, {
			prompt_title = prompt,
			finder = finders.new_table(list),
			sorter = conf.generic_sorter({}),
			attach_mappings = function(prompt_bufnr, map)
				local actions = require("telescope.actions")
				local action_state = require("telescope.actions.state")
				actions.select_default:replace(function()
					actions.close(prompt_bufnr)
					callback(action_state.get_selected_entry()[1])
				end)
				return true
			end,
		})
		:find()
end

-- cargo build for binary (blocking until finish)
local function cargo_build(binary, profile)
	if not profile then
		return
	end
	local cmd = "cargo build --bin " .. binary
	if profile == "release" then
		cmd = cmd .. " --release"
	end
	print("Running:", cmd)
	local result = vim.fn.system(cmd)
	print(result)
end

-- main Rust debugger helper
local function debug_rust_with_optional_args(args)
	local cargo_toml = find_cargo_toml()
	if not cargo_toml then
		vim.notify("Could not find Cargo.toml!", vim.log.levels.ERROR)
		return
	end

	local bins = get_cargo_bins(cargo_toml)
	pick_from_list("Select Binary", bins, function(binary)
		local profile = "debug"
		if profile then
			cargo_build(binary, profile)
		end

		local target_dir = profile == "release" and "target/release" or "target/debug"
		local binary_path = target_dir .. "/" .. binary

		dap.run({
			type = "codelldb",
			request = "launch",
			name = "Debug Rust",
			program = binary_path,
			args = args or {},
			cwd = vim.fn.getcwd(),
			stopOnEntry = false,
		})

		open_console_float()
	end)
end

-- public functions
function debug_rust()
	debug_rust_with_optional_args()
end

function debug_rust_with_args()
	local input = vim.fn.input("Program arguments: ")
	local args = {}
	if input ~= "" then
		args = vim.split(input, " ", { plain = true })
	end
	debug_rust_with_optional_args(args)
end

-- Debug current Python file
local function debug_python()
	dap.run({
		type = "python",
		request = "launch",
		name = "Debug Python",
		program = vim.fn.expand("%:p"),
		console = "integratedTerminal", -- required for dap-ui console
	})
	open_console_float()
end

-- Debug current Python file with args
local function debug_python_args()
	local input = vim.fn.input("Program arguments: ")
	local args = {}
	if input ~= "" then
		args = vim.split(input, " ", { plain = true })
	end

	dap.run({
		type = "python",
		request = "launch",
		name = "Debug Python with Args",
		program = vim.fn.expand("%:p"),
		args = args,
		console = "integratedTerminal",
	})
	open_console_float()
end

-- Make it a Vim command
vim.api.nvim_create_user_command("DebugPythonArgs", debug_python_args, {})
vim.api.nvim_create_user_command("DebugRustArgs", debug_rust_with_args, {})
vim.api.nvim_create_user_command("DebugPython", debug_python, {})
vim.api.nvim_create_user_command("DebugRust", debug_rust, {})
vim.api.nvim_create_user_command("DebugConsole", open_console_float, {})

vim.keymap.set("n", "<leader>dw", function()
	local var = vim.fn.expand("<cword>") -- get word under cursor
	require("dap").repl.eval(var, { context = "watch" })
	print("Watching:", var)
end, { desc = "Add DAP watch (cursor word)" })

return {
	{ "<leader>d", group = "Debug" },
	{ "<leader>dd", group = "Start Debugger" },
	{ "<leader>ddP", "<cmd>DebugPythonArgs<CR>", desc = "Debug Python with Args" },
	{ "<leader>ddR", "<cmd>DebugRustArgs<CR>", desc = "Debug Rust with Args" },
	{ "<leader>ddp", "<cmd>DebugPython<CR>", desc = "Debug Python" },
	{ "<leader>ddr", "<cmd>DebugRust<CR>", desc = "Debug Rust" },
	{ "<leader>dw", "<cmd>DebugConsole<CR>", desc = "Open Debug Console Window" },
	{ "<leader>dc", "<cmd>lua require'dap'.continue()<CR>", desc = "Continue" },
	{ "<leader>do", "<cmd>lua require'dap'.step_over()<CR>", desc = "Step Over" },
	{ "<leader>di", "<cmd>lua require'dap'.step_into()<CR>", desc = "Step Into" },
	{ "<leader>du", "<cmd>lua require'dap'.step_out()<CR>", desc = "Step Out" },
	{ "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", desc = "Toggle Breakpoint" },
	{
		"<leader>dB",
		"<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
		desc = "Conditional Breakpoint",
	},
	{ "<leader>dr", "<cmd>lua require'dap'.repl.open()<CR>", desc = "Open REPL" },
	{ "<leader>dU", "<cmd>lua require'dapui'.toggle()<CR>", desc = "Toggle DAP UI" },
	{ "<leader>dq", "<cmd>DapTerminate<CR>", desc = "Terminate Dap Session" },
	{
		"<leader>dl",
		"<cmd>lua vim.cmd('!cargo build') vim.cmd('lua require\"dap\".continue()')<CR>",
		desc = "Rust Build & Debug",
	},
}
