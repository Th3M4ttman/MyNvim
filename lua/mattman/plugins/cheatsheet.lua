return {
    {
        "sudormrfbin/cheatsheet.nvim",
        event = "VeryLazy",
        dependencies = {
            "nvim-telescope/telescope.nvim",
            "nvim-lua/popup.nvim",
            "nvim-lua/plenary.nvim",
        },
        opts = {
            bundled_cheatsheets = true,
            bundled_plugin_cheatsheets = true,
            include_only_installed_plugins = true,
        },
        keys = {
            { "<leader>Cs", "<cmd>Cheatsheet<CR>", desc = "Open Cheatsheet" },
            { "<leader>Ce", "<cmd>CheatsheetEdit<CR>", desc = "Edit Cheatsheet" },
        },
    },
}
