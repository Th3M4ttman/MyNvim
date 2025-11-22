return {
  lazy = false,
  "kevinhwang91/nvim-ufo",
  event = "BufReadPost",  -- load when opening a file
    dependencies = {
    "kevinhwang91/promise-async", -- required for ufo
  },
  opts = function()
    local handler = function(virtText, lnum, endLnum, width, truncate)
      local newVirtText = {}
      local suffix = ("  …%d lines"):format(endLnum - lnum)
      local sufWidth = vim.fn.strdisplaywidth(suffix)
      local targetWidth = width - sufWidth
      local curWidth = 0
      for _, chunk in ipairs(virtText) do
        local chunkText = chunk[1]
        local chunkWidth = vim.fn.strdisplaywidth(chunkText)
        if curWidth + chunkWidth < targetWidth then
          table.insert(newVirtText, chunk)
          curWidth = curWidth + chunkWidth
        else
          chunkText = vim.fn.strcharpart(chunkText, 0, targetWidth - curWidth)
          table.insert(newVirtText, {chunkText, chunk[2]})
          break
        end
      end
      table.insert(newVirtText, {suffix, "MoreMsg"})
      return newVirtText
    end

    return {
      fold_virt_text_handler = handler,
      provider_selector = function(bufnr, filetype, buftype)
        return { "lsp", "indent" } -- use LSP first, fallback to indent
      end,
    }
  end,
  keys = {
    { "zR", function() require("ufo").openAllFolds() end, desc = "Open All Folds" },
    { "zM", function() require("ufo").closeAllFolds() end, desc = "Close All Folds" },
    { "zr", function() require("ufo").openFoldsExceptKinds() end, desc = "Open Folds Less" },
    { "zm", function() require("ufo").closeFoldsWith() end, desc = "Close Folds More" },
  },
}
