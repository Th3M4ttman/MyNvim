


local function smart_save()
    if vim.bo.modified == false then
        print("Nothing to save")
        return
    end

    if vim.fn.bufname("") == "" then  
        local fname = vim.fn.input("Filename: ")  
        if fname ~= "" then  
            vim.cmd("w " .. fname)  
            print("Saved as " .. fname)  
        end
    else  
        vim.cmd("w")  
        print("Saved")  
    end
end

local function save_as()
    local fname = vim.fn.input("Save as: ")
    if fname ~= "" then
        vim.cmd("w " .. fname)
        print("Saved as " .. fname)
    end
end

local function save_all()
    vim.cmd("wall")
    print("Saved all buffers")
end

local function save_backup()
    local fname = vim.fn.expand("%")
    if fname == "" then fname = vim.fn.input("Filename: ") end
    local backup = fname .. ".bak"
    vim.cmd("w " .. backup)
    print("Saved backup: " .. backup)
end

local function save_timestamp()
    local fname = vim.fn.input("Base filename: ")
    if fname ~= "" then
        local ts = os.date("%Y%m%d-%H%M%S")
        vim.cmd("w " .. fname .. "-" .. ts)
        print("Saved as " .. fname .. "-" .. ts)
    end
end



local autosave = false

local function toggle_autosave()
    autosave = not autosave
    if autosave then
        -- Use a named augroup so we can remove it cleanly
        vim.cmd([[
            augroup AutoSave
                autocmd!
                autocmd BufLeave,TextChanged,TextChangedI * silent! wall
            augroup END
        ]])
        print("Auto-save enabled")
    else
        vim.cmd("au! AutoSave")
        print("Auto-save disabled")
    end
end


return {
    -- Group
    { "<leader>S", group = "Save", mode = {"n", "v", "i"} },

    -- Smart save
  { "<leader>Ss", smart_save, desc = "Save", mode = {"n", "v"} },
    { "<C-s>",      smart_save, desc = "Save", mode = {"n", "v", "i"} },

    -- Save As
    { "<leader>SA", save_as, desc = "Save As", mode = {"n", "v"} },

    -- Save & Quit
    { "<leader>Sq", function() vim.cmd("wq") end, desc = "Save and quit", mode = {"n","v"} },
    { "<leader>SQ", function() vim.cmd("wq!") end, desc = "Save and quit (force)", mode = {"n","v"} },

    -- Save all buffers
    
    -- Save backup
    { "<leader>Sb", save_backup, desc = "Save backup", mode = {"n","v"} },

    -- Save with timestamp
    
    -- Toggle auto-save
    { "<leader>St", toggle_autosave, desc = "Toggle auto-save", mode = {"n","v"} },


    { "<leader>Sa", group = "All", mode = {"n", "v"} },
    { "<leader>SaA", save_all, desc = "Save all buffers", mode = {"n","v"} },

    { "<leader>ST", group = "Timestamp", mode = {"n", "v", "i"} },
    { "<leader>STs", save_timestamp, desc = "Save with timestamp", mode = {"n","v"} },
}
