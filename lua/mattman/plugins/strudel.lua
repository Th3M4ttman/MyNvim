return {
  "jakobkhansen/strudel.nvim",
  build = false, -- prevents puppeteer install

  config = function()
    local strudel = require("strudel")

    -- Disable browser stuff completely
    strudel.setup({
      browser = false,
      debug = false,
    })

    -------------------------------------------------------------
    -- Safely remove the builtin :Strudel command if it exists
    -------------------------------------------------------------
    pcall(vim.api.nvim_del_user_command, "Strudel")

    -------------------------------------------------------------
    -- Create a Termux-safe :Strudel command
    -------------------------------------------------------------
    vim.api.nvim_create_user_command("Strudel", function()
      -- Start Strudel's pattern server (no browser)
      strudel.launch({
        browser = false,
        headless = true,
        server = true,
      })

      local url = "http://127.0.0.1:3333"

      -- Try opening browser automatically (Termux will succeed)
      os.execute("xdg-open " .. url .. " >/dev/null 2>&1 &")

      print("Strudel server running → " .. url)
      print("Your browser should open with audio.")
    end, {})
  end,
}
