-- Function to setup Neo-tree and keymaps
local function setup_neotree()
  -- Neo-tree setup
  require("neo-tree").setup({
    close_if_last_window = true,
    popup_border_style = "rounded",
    filesystem = {
      follow_current_file = {
        enabled = true,       -- updated from boolean to table
        -- optional sub-options:
        -- leave_dirs_open = true,
        -- group_empty_dirs = false,
      },
      filtered_items = {
        visible = true,        -- show hidden files
        hide_dotfiles = false, -- show dotfiles
        hide_gitignored = false,
      },
    },
  })

  -- Keymap to toggle Neo-tree with hidden files visible
  vim.keymap.set("n", "<C-b>", function()
    require("neo-tree.command").execute({
      toggle = true,
      dir = vim.loop.cwd(),
      reveal_hidden = true,
    })
  end, { noremap = true, silent = true })
end

-- Plugin spec
return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons", -- optional, but recommended
    },
    lazy = false, -- load immediately
    config = setup_neotree, -- reference the function here
  }
}
