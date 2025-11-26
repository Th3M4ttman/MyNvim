return {
  "sindrets/diffview.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    { "<leader>gd", ":DiffviewOpen<CR>", desc = "Diffview Open" },
    { "<leader>gc", ":DiffviewClose<CR>", desc = "Diffview Close" },
  },
  config = function()
    require("diffview").setup({
      -- Optional: add any custom setup here
    })
  end,
}
