return {
  {
    "github/copilot.vim",
    enabled =false,
    commit = "da369d9", -- LAST GOOD VERSION BEFORE BROKEN LANGUAGE SERVER
    init = function()
      -- Prevent Copilot from binding <Tab>
      vim.g.copilot_no_tab_map = true
    end,
  }
}
