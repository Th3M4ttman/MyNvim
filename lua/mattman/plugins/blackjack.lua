return {
  "alanfortlink/blackjack.nvim",
  cmd = "Blackjack",  -- assuming plugin defines a :Blackjack command
  keys = {
    { "<leader>Gb", "<cmd>BlackJackNewGame<CR>", desc = "Play Blackjack" },
  },
  config = function()
    require("blackjack").setup({
      -- optional settings, if any; leave blank for defaults
    })
  end,
}
