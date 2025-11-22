local function new_term_tab()
    local bufname = vim.api.nvim_buf_get_name(0)
    local dir, dirname

    if bufname ~= "" then
        dir = vim.fn.fnamemodify(bufname, ":p:h")
        dirname = vim.fn.fnamemodify(dir, ":t")
    else
        dir = "~/"
        dirname = "home"
    end

    -- Open new tab
    vim.cmd("enew")
    -- Change directory
    vim.cmd("lcd " .. dir)
    -- Open terminal
    vim.cmd("terminal")

    -- Set a friendly buffer name for the terminal
    local term_buf = vim.api.nvim_get_current_buf()
    vim.api.nvim_buf_set_name(term_buf, dirname .. " terminal")
end



return {
    { "<leader>n", group = "New" },
    {'<leader>nt',  '<cmd>tabnew<cr>', desc = "New tab" },
    {'<leader>nb',  '<cmd>enew<cr>', desc = "New empty buffer" },
    { '<leader>no', function() require("oil").open(vim.loop.cwd()) end, desc = "New tab (Oil)" },
    { '<leader>nT', '<cmd>tabnew | terminal<cr>', desc = "New terminal" },
    { '<leader>nT', new_term_tab, desc = "New terminal (Buffer Dir)" },

}
