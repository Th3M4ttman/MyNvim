return {
    { "<A-Left>",     "gT",         desc = "Go to previous tab" },
    { "<A-Right>",    "gt",         desc = "Go to next tab" },
    { "<C-Left>",     ":bprev<CR>", desc = "Go to previous buffer" },
    { "<C-Right>",    ":bnext<CR>", desc = "Go to next buffer" },
    { "<C-S-Left>",   "<C-w>h",     desc = "Window Left" },
    { "<C-S-Down>",   "<C-w>j",     desc = "Window Down" },
    { "<C-S-Up>",     "<C-w>k",     desc = "Window Up" },
    { "<C-S-Right>",  "<C-w>l",     desc = "Window Right" },
    { "<leader>wsh",   ":wincmd R<CR>",     desc = "Move Split Left" },
    { "<leader>wsj",   ":wincmd J<CR>",     desc = "Move Split Down" },
    { "<leader>wsk",     ":wincmd K<CR>",     desc = "Move Split Up" },
    { "<leader>wsl",  ":wincmd L<CR>",     desc = "Move Split Right" },

    { "<A->>",        "<C-w>+",     desc = "Increase split height" },
    { "<A-<>",        "<C-w>-",     desc = "Decrease split height" },
    { "<A-.>",        "<C-w>>",     desc = "Increase split width" },
    { "<A-,>",        "<C-w><",     desc = "Decrease split width" },
    -- Add line ABOVE without moving cursor
    { "<leader><leader>W",   "mzO<Esc>`z:delmarks z<CR>", desc = "Add line above" },

    -- Add line BELOW without moving cursor
    { "<leader><leader>w", "mzo<Esc>`z:delmarks z<CR>", desc = "Add line below" },

    -- Remove line ABOVE without moving cursor
    { "<leader>C-W",   "mzkdd`z:delmarks z<CR>",    desc = "Delete line above" },


    -- Remove line BELOW without moving cursor
    { "<leader>C-w", "mzjdd`z:delmarks z<CR>",    desc = "Delete line below" },
}
