
-- =========================
-- Functions to move visual selection safely
-- =========================
local function move_selection(direction)
    local start_line = vim.fn.line("'<")
    local end_line = vim.fn.line("'>")
    local last_line = vim.fn.line("$")

    local target
    if direction == "up" then
        if start_line == 1 then return end
        target = start_line - 2
    else
        -- If at the bottom, add blank lines
        if end_line == last_line then
            local lines_to_add = end_line - start_line + 1
            vim.cmd(string.format("normal! %dGo<CR>", lines_to_add))
            last_line = vim.fn.line("$")
        end
        target = end_line + 1
    end

    -- Move the lines
    vim.cmd(string.format("%d,%dmove %d", start_line, end_line, target))

    -- Restore visual selection and re-indent
    vim.cmd("normal! gv=gv")
end
-- Create Vim commands for which-key mappings
vim.api.nvim_create_user_command("MoveSelectionUp", function()
    move_selection("up")
end, { range = true })

vim.api.nvim_create_user_command("MoveSelectionDown", function()
    move_selection("down")
end, { range = true })

-- =========================
-- Key mappings
-- =========================
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

    -- Normal mode line moves
    { "<S-Up>", ":move-2<CR>==", desc = "Move line up", mode = "n" },
    { "<S-Down>", ":move+<CR>==", desc = "Move line down", mode = "n" },

    -- Visual mode selection moves (call the safe commands)
    { "<S-Up>", ":MoveSelectionUp<CR>",   desc = "Move selection up",   mode = "v" },
    { "<S-Down>", ":MoveSelectionDown<CR>", desc = "Move selection down", mode = "v" },
}
