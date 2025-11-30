return {
  "stevearc/aerial.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
  opts = {
    -- any custom settings go here (otherwise default config used)
    -- e.g. backends = { "treesitter", "lsp" },
  },
  keys = {
    { "<leader>\\", "<cmd>AerialToggle!<CR>", desc = "Toggle Aerial outline" },
  },
  config = function()
    require("aerial").setup({})
  end,
}
