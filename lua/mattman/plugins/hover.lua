
local function setup_hover()
    local hover = require('hover')

    hover.setup({
        init = function()
            -- require providers
            require('hover.providers.lsp')
            -- you can also add treesitter or markdown if desired
        end, 
        preview_opts = {
            border = nil,  -- 'single', 'rounded', etc
            max_height = 15,
            max_width = 80,
        },
        title = true
    })

    -- Keymap to trigger hover
    vim.keymap.set("n", "<C-k>", function()
        require('hover').hover()
    end, { noremap = true, silent = true })
end


return {
    {
        "lewis6991/hover.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        lazy = false,      -- load immediately
        config = setup_hover,
    }
}
