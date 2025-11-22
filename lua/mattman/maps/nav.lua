-- This file contains custom key mappings for enhanced navigation and editing in Neovim.o

return {
    ---------------------------------------------------------
    -- Boosted  hjkl navigation

    -- Normal mode
    { "J", "6j", desc = "Move 6 lines down", mode = "n" },
    { "K", "6k", desc = "Move 6 lines up", mode = "n" },
    { "H", "^", desc = "Go to start of line", mode = "n" },
    { "L", "$", desc = "Go to end of line", mode = "n" },

    -- Visual mode
    { "J", "6j", desc = "Move 6 lines down", mode = "v" },
    { "K", "6k", desc = "Move 6 lines up", mode = "v" },
    { "H", "^", desc = "Go to start of line", mode = "v" },
    { "L", "$", desc = "Go to end of line", mode = "v" },

    --------------------------------------------------------
    -- Indentation

    { "<S-Left>", "<<", desc = "Decrease indentation", mode = "n" },
    { "<S-Right>", ">>", desc = "Increase indentation", mode = "n" },
    { "<S-Left>", "<gv", desc = "Decrease indentation", mode = "v" },
    { "<S-Right>", ">gv", desc = "Increase indentation", mode = "v" },

    ---------------------------------------------------------
    -- Move line up/down while keeping indentation

    { "<S-Up>", ":move-2<CR>==", desc = "Move line up", mode = "n" },
    { "<S-Down>", ":move+<CR>==", desc = "Move line down", mode = "n" },
    { "<S-Up>", ":m '<-2<CR>gv=gv", desc = "Move selection up", mode = "v" },
    { "<S-Down>", ":m '>+1<CR>gv=gv", desc = "Move selection down", mode = "v" },

    ---------------------------------------------------------
}
