
vim.keymap.set('v', 'v', 'j')


return {
    -- Group name
    { "<leader>s", group = "Select", mode = {"n", "i", "v"} },

    -- Select all
    { "<leader>sa", "ggVG",         desc = "Select all", mode = "n" },
    { "<leader>sa", "<Esc>ggVG",    desc = "Select all", mode = {"i", "v"} },

    -- Select line
    { "<leader>sl", "^v$",           desc = "Select line", mode = {"n", "i"} },
    { "<leader>sl", "<Esc>^v$",      desc = "Select line", mode = "v" },

    -- Select word
    { "<leader>sw", "viw",           desc = "Select word", mode = "n" },
    { "<leader>sw", "<Esc>viw",      desc = "Select word", mode = {"i", "v"} },

    -- Select paragraph
    { "<leader>sp", "vip",           desc = "Select paragraph", mode = "n" },
    { "<leader>sp", "<Esc>vip",      desc = "Select paragraph", mode = {"i", "v"} },

    -- Select inside quotes
    { "<leader>siq", 'vi"',           desc = "Select inside quotes", mode = "n" },
    { "<leader>siq", '<Esc>vi"',      desc = "Select inside quotes", mode = {"i", "v"} },

    -- Select inside parentheses
    { "<leader>sip", "vi(",           desc = "Select inside parentheses", mode = "n" },
    { "<leader>sip", "<Esc>vi(",      desc = "Select inside parentheses", mode = {"i", "v"} },

    -- Select to end of line
    { "<leader>se", "v$",            desc = "Select to end of line", mode = "n" },
    { "<leader>se", "<Esc>v$",       desc = "Select to end of line", mode = {"i", "v"} },

    -- Select to beginning of line
    { "<leader>sb", "v0",            desc = "Select to beginning of line", mode = "n" },
    { "<leader>sb", "<Esc>v0",       desc = "Select to beginning of line", mode = {"i", "v"} },

    -- Visual block mode
    { "<leader>sv", "<C-v>",          desc = "Start visual block", mode = "n" },
    { "<leader>sv", "<Esc><C-v>",     desc = "Start visual block", mode = {"i", "v"} },
}
