-- local function defined once per file
local function gemini()
  -- Find buffer directory
  local dir = vim.fn.expand("%:p:h")
  if dir == "" then
    dir = vim.fn.getcwd()
  end

  -- Directory name (for tab title)
  local folder = vim.fn.fnamemodify(dir, ":t")

  -- Open new tab
  vim.cmd("enew")

  -- Start terminal
  vim.cmd("terminal")
  vim.cmd("startinsert")

  -- Get job id for sending terminal commands
  local chan = vim.b.terminal_job_id

  -- Run gemini inside the correct directory
  vim.fn.chansend(chan, "cd " .. dir .. " && gemini\n")

  -- Rename the terminal buffer itself
  vim.cmd("file " .. folder .. "-Gemini")
end

-- return the which-key style mapping
return {
  { "<leader>nG", gemini, desc = "Gemini Chat" },
}
