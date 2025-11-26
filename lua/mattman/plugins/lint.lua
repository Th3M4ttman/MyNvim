return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")

    lint.linters_by_ft = {
      lua = { "luacheck" },

      python = { "ruff" },  -- built-in linter definition inside nvim-lint

      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      typescriptreact = { "eslint_d" },

      go = { "golangcilint" },

      -- Add any additional languages you want:
      markdown = { "markdownlint" },
      yaml = { "yamllint" },
      sh = { "shellcheck" },
      json = { "jsonlint" },
      html = { "htmlhint" },
      css = { "stylelint" },
    }

    -- Lint automatically on save
    vim.api.nvim_create_autocmd("BufWritePost", {
      callback = function()
        lint.try_lint()
      end,
    })
  end,
}
