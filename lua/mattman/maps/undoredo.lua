
return {
  -- === Undo / Redo Group ===
  { "<leader>u",  group = "Undo / Redo", mode = { "n", "v", "i" } },

  -- Undo
  { "<leader>uu", "u",        desc = "Undo", mode = { "n", "v" } },
  { "<leader>uu", "<C-o>u",   desc = "Undo", mode = "i" },
  { "<C-z>",      "u",        desc = "Undo", mode = { "n", "v" } },
  { "<C-z>",      "<C-o>u",   desc = "Undo", mode = "i" },

  -- Redo
  { "<leader>ur", "<C-r>",          desc = "Redo", mode = { "n", "v" } },
  { "<leader>ur", "<C-o><C-r>",     desc = "Redo", mode = "i" },
  { "<A-z>",      "<C-r>",          desc = "Redo", mode = { "n", "v" } },
  { "<A-z>",      "<C-o><C-r>",     desc = "Redo", mode = "i" },

  -- Undo All (undo to the earliest point)
  { "<leader>ua", "gguG", desc = "Undo All", mode = "n" },
  -- Visual undo-all is weird, so skip it unless you want a custom operator

  -- Placeholder for undo tree plugin (toggle)
  -- If you install `mbbill/undotree`
  -- { "<leader>ut", "<cmd>UndotreeToggle<CR>", desc = "Undo Tree", mode = "n" },
}
