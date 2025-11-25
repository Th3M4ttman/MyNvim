local dap = require('dap')

-- Helper function
local function debug_with_args()
  -- Ask for program arguments
  local input = vim.fn.input("Program arguments: ")
  local args = {}
  if input ~= "" then
    args = vim.split(input, " ", { plain = true })
  end

  -- Detect binary (current folder name)
  local binary = vim.fn.getcwd() .. "/target/debug/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t")

  -- Launch DAP with args
  dap.run({
    type = "codelldb",
    request = "launch",
    name = "Debug with Args",
    program = binary,
    args = args,
    cwd = vim.fn.getcwd(),
    stopOnEntry = false,
  })
end

-- Make it a Vim command
vim.api.nvim_create_user_command("DapDebugArgs", debug_with_args, {})

vim.keymap.set('n', '<leader>dw', function()
  local var = vim.fn.expand('<cword>')  -- get word under cursor
  require('dap').repl.eval(var, { context = 'watch' })
  print("Watching:", var)
end, { desc = "Add DAP watch (cursor word)" })


return {
  { "<leader>d", group = "Debug" },  -- group declaration
{ "<leader>da", "<cmd>DapDebugArgs<CR>", desc = "Debug with Args", group = "Debug" },
  { "<leader>dc", "<cmd>lua require'dap'.continue()<CR>", desc = "Continue" },
  { "<leader>do", "<cmd>lua require'dap'.step_over()<CR>", desc = "Step Over" },
  { "<leader>di", "<cmd>lua require'dap'.step_into()<CR>", desc = "Step Into" },
  { "<leader>du", "<cmd>lua require'dap'.step_out()<CR>", desc = "Step Out" },
  { "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", desc = "Toggle Breakpoint" },
  { "<leader>dB", "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", desc = "Conditional Breakpoint" },
  { "<leader>dr", "<cmd>lua require'dap'.repl.open()<CR>", desc = "Open REPL" },
  { "<leader>dU", "<cmd>lua require'dapui'.toggle()<CR>", desc = "Toggle DAP UI" },
  { "<leader>dl", "<cmd>lua vim.cmd('!cargo build') vim.cmd('lua require\"dap\".continue()')<CR>", desc = "Build & Debug" },
}
