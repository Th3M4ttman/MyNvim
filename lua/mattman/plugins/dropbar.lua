return {
    "Bekaboo/dropbar.nvim",
    dependencies = {
        "nvim-telescope/telescope-fzf-native.nvim",
        "nvim-treesitter/nvim-treesitter",
        build = "make",
    },
    config = function()
        local dropbar_api = require("dropbar.api")

        -- Keymaps
        vim.keymap.set("n", "<Leader>;", dropbar_api.pick, { desc = "Dropbar: Pick symbol" })
        vim.keymap.set("n", "<Leader>#", function()
            dropbar_api.pick("telescope")
        end, { desc = "Dropbar: Telescope picker" })
        vim.keymap.set("n", "[;", dropbar_api.goto_context_start, { desc = "Dropbar: Context start" })
        vim.keymap.set("n", "];", dropbar_api.select_next_context, { desc = "Dropbar: Next context" })

        vim.o.mousemoveevent = true

        require("dropbar").setup({
            terminal = {
                sources = { "shell" },
            },
            icons = {
                enabled = true, -- optional, this is default
            },
        })
    end,
}
