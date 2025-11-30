-- Define the command
vim.api.nvim_create_user_command("PythonFormat", function()
    local file = vim.api.nvim_buf_get_name(0)
    vim.cmd("!black " .. vim.fn.shellescape(file))
    vim.cmd("edit")  -- reload buffer to see changes
end, { desc = "Format current Python file with Black" })

-- Return the which-key binding
return {

    { "<leader>P", group = "Python" },
    { "<leader>Pf", ":PythonFormat<CR>", desc = "Format (black)" }
}
