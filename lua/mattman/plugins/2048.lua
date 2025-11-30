return {
  "NStefan002/2048.nvim",
  cmd = "Play2048", -- lazy-load when command is used
  keys = {
    { "<leader>G2", "<cmd>Play2048<CR>", desc = "Play 2048" },
  },
  config = function()
    require("2048").setup({
      -- optional: customize keys
      keys = {
        up = "k",
        down = "j",
        left = "h",
        right = "l",
        undo = "u",
        restart = "r",
        new_game = "n",
        confirm = "<CR>",
        cancel = "<Esc>",
      },
    })
  end,
}
