return {
  "stevearc/oil.nvim",
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
    -- Enable all available extensions
    use_default_keymaps = true,  -- optional, enables default keymaps
    keymaps = {},
    default_file_explorer = false, -- set true if you want oil to override netrw
    view_options = {
      show_hidden = true,
      use_icon = true,
    },
    -- List of all extensions
    extensions = {
      "dir",          -- directory view
      "tabs",         -- integrate with tabline
      "trailing",     -- trailing lines preview
      "preview",      -- preview of files
      "vsplit",       -- vertical split
      "split",        -- horizontal split
      "rename",       -- rename extension
      "actions",      -- extra actions (delete, copy, move)
    },
  },
  -- Optional dependencies
  dependencies = { { "nvim-mini/mini.icons", opts = {} } },
  lazy = false,
}
