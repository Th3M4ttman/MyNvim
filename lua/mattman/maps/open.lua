

local ok, telescope = pcall(require, "telescope.builtin")  
  
local function fuzzy_open()
    if ok then
        telescope.find_files()  
    else  
        local fname = vim.fn.input("Open file: ")  
        if fname ~= "" then  
            vim.cmd("edit " .. fname)  
        end  
    end  
end

local function open_recent()
    if ok then
        telescope.oldfiles({
            path_display =  {"smart"}
        })
    else
        local hist = vim.v.oldfiles
        if #hist == 0 then
            print("No recent files")
            return
        end

        print("Recent files:")
        for i, f in ipairs(hist) do
            print(i .. ": " .. f)
            if i == 10 then break end
        end

        local choice = tonumber(vim.fn.input("Pick number: "))
        if choice and hist[choice] then
            vim.cmd("edit " .. hist[choice])
        end
    end
end

local function open_buffers()
    if ok then
        telescope.buffers()
    else
        vim.cmd("ls")
        local num = tonumber(vim.fn.input("Buffer #: "))
        if num then vim.cmd("buffer " .. num) end
    end
end

local function open_project_root()
    local root = vim.fn.getcwd()
    vim.cmd("tabnew")
    vim.cmd("Oil " .. root)
end

local function open_config()
    vim.cmd("tabnew")
    vim.cmd("Oil ~/.config/nvim")
end

local function open_under_cursor()
    local path = vim.fn.expand("<cfile>")
    if path ~= "" then vim.cmd("edit " .. path) end
end

local function open_parent_dir()
    local dir = vim.fn.expand("%:p:h:h")
    vim.cmd("Oil " .. dir)
end

local last_closed = nil

vim.api.nvim_create_autocmd("BufDelete", {
    callback = function(args)
        last_closed = args.file
    end
})

local function reopen_last_closed()
    if last_closed then
        vim.cmd("edit " .. last_closed)
    else
        print("No recently closed file")
    end
end

return {
    { "<leader>o", group = "Open", mode = {"n", "v"} },
    {"<leader>of", fuzzy_open, desc = "Fuzzy Open File" },
    {"<C-o>", fuzzy_open, desc = "Fuzzy Open File", mode = {"n", "i", "v"} },
    {"<leader>od", "<cmd>Oil<CR>", desc = "Open Directory (oil)" },
    {"<A-o>", "<cmd>Oil<CR>", desc = "Open Directory (oil)" },
    {"<leader>or", open_recent, desc = "Open Recent File" },
    {"<leader>ob", open_buffers, desc = "Open Buffer list" },
    {"<leader>op", open_project_root, desc = "Open Project Root (oil)" },
    {"<leader>oc", open_config, desc = "Open Neovim Config (oil)" },
    {"<leader>ou", open_under_cursor, desc = "Open File Under Cursor" },
    {"<leader>o.", open_parent_dir, desc = "Open Parent Directory (oil)" },
    {"<leader>ol", reopen_last_closed, desc = "Reopen Last Closed File" },
    {"<leader>oa", ":Alpha<CR>", desc = "Open Alpha" },   

}
