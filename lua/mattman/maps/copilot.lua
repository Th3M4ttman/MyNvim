
vim.keymap.set("i", "<C-y>", 'copilot#Accept("<CR>")', {  
    silent = true,  
    expr = true,  
    replace_keycodes = false,  
})  


vim.keymap.set("i", "<A-y>", 'copilot#Accept("<CR>")', {  
    silent = true,  
    expr = true,  
    replace_keycodes = false,  
})  



local cop

return {  
    ---------------------------------------------------------  
    -- GitHub Copilot  

    -- Insert mode  
    { "<C-n>",     'copilot#Next()',         desc = "Copilot: Next suggestion", mode = "i", expr = true, silent = true },  
    { "<C-p>",     'copilot#Previous()',     desc = "Copilot: Previous suggestion", mode = "i", expr = true, silent = true },  
    { "<C-\\>",     'copilot#Dismiss()',      desc = "Copilot: Dismiss suggestion", mode = "i", expr = true, silent = true },  
}  

