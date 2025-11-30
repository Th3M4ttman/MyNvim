return {
  "jim-fx/sudoku.nvim",
  cmd = "Sudoku",
  keys = {
    { "<leader>GS", "<cmd>Sudoku<CR>", desc = "Start Sudoku" },
  },
  config = function()
    require("sudoku").setup({
      -- default options are fine; override if you like
      persist_settings = true,
      persist_games = true,
      default_mappings = true,
    })
  end,
}
