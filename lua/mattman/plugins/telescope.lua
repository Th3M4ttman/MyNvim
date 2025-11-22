return {

    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "jvgrootveld/telescope-zoxide",
        },
        config = function()
            local telescope = require("telescope")

            telescope.setup({
                extensions = {
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

            -- Load extension
            pcall(telescope.load_extension, "zoxide")

            -- OPTIONAL: Keybind to open zoxide picker
            vim.keymap.set("n", "<leader>z", function()
                telescope.extensions.zoxide.list()
            end, { desc = "Telescope Zoxide" })
        end,
    },

}
