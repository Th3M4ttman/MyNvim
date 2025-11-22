return{
  "uga-rosa/ccc.nvim",
  lazy = false,
  cmd = { "CccPick", "CccHighlighterToggle" },
  opts = function()
    local ccc = require("ccc")
    return {
      highlighter = {
        auto_enable = true,
        lsp = true,
      },
      inputs = {
        ccc.input.hsl,
        ccc.input.rgb,
      },
      outputs = {
        ccc.output.hex,
        ccc.output.hex_short,
        ccc.output.css_rgb,
      },
    }
  end,
  config = function(_, opts)
    require("ccc").setup(opts)
  end,
}
