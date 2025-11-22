-- in your plugins.lua (LazyVim style)
return {
    {
        "akinsho/bufferline.nvim",
        version = "*",
        dependencies = "nvim-web-devicons",
        config = function()
            require("bufferline").setup({
                options = {
                    show_buffer_icons = true,
                    show_buffer_close_icons = true,
                    show_close_icon = true,
                    show_tab_indicators = true,
                    separator_style = "thin",
                    enforce_regular_tabs = true,
                    always_show_bufferline = true,
                }
            })
        end,
    }
}