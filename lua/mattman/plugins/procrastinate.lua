
vim.keymap.set("n", "<leader>tt", "<cmd>InsertTodo<CR>", { desc = "Insert todo" })

return {
    "masamerc/procrastinate.nvim",
    config = function ()
        require('procrastinate').setup()
    end
}
