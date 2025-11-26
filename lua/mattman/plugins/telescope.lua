return {

    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "jvgrootveld/telescope-zoxide",

            -- FZF-native sorting
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
            },

            -- UI select menu
            "nvim-telescope/telescope-ui-select.nvim",

            -- GitHub Telescope extension
            "nvim-telescope/telescope-github.nvim",
        },

        config = function()
            local telescope = require("telescope")

            telescope.setup({

                -- UI select
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown({})
                    },

                    -- Zoxide config unchanged
                    zoxide = {
                        prompt_title = "[ Zoxide ]",
                        mappings = {
                            default = {
                                action = function(selection)
                                    vim.cmd("cd " .. selection.path)
                                end,
                                after_action = function(selection)
                                    print("Directory changed to " .. selection.path)
                                end,
                            },
                        },
                    },
                },
            })

            ---------------------------------------------------------
            -- Load extensions
            ---------------------------------------------------------
            pcall(telescope.load_extension, "zoxide")
            pcall(telescope.load_extension, "fzf")
            pcall(telescope.load_extension, "ui-select")
            pcall(telescope.load_extension, "gh")

            ---------------------------------------------------------
            -- Keymaps
            ---------------------------------------------------------
            vim.keymap.set("n", "<leader>z", function()
                telescope.extensions.zoxide.list()
            end, { desc = "Telescope Zoxide" })
        end,
    },

}
