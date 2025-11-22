-----------------------------------------------------------
-- RESET & REFRESH UTILITIES
-----------------------------------------------------------

-- Clear search highlight
local function reset_search()
    vim.cmd("nohlsearch")
    print("Search highlight cleared")
end

-- Reset indent guides, treesitter highlights, etc.
local function reset_syntax()
    vim.cmd("syntax sync fromstart")
    vim.cmd("edit")  -- reload buffer highlights
    print("Syntax highlighting refreshed")
end

-- Reset all folds (UFO / manual folds / treesitter folds)
local function reset_folds()
    vim.cmd("normal! zE")   -- wipe all folds
    vim.cmd("normal! zx")   -- rebuild folds
    print("Folds reset")
end

-- Clear diagnostics (LSP virtual text, signs, underlines)
local function reset_diagnostics()
    vim.diagnostic.reset()
    print("Diagnostics cleared")
end

-- Restart LSP client (full reset)
local function reset_lsp()
    vim.cmd("LspRestart")
    print("LSP restarted")
end

-- Refresh treesitter parsing
local function reset_treesitter()
    vim.cmd("TSBufDisable highlight")
    vim.cmd("TSBufEnable highlight")
    print("Treesitter refreshed")
end

-- Reload the current file from disk
local function reload_file()
    vim.cmd("edit!")
    print("File reloaded")
end

-- Reset buffer local options to defaults
local function reset_buffer_options()
    vim.cmd("setlocal formatoptions=tcqj")
    vim.cmd("setlocal foldmethod=indent")
    vim.cmd("setlocal nocursorline")
    vim.cmd("setlocal nocursorcolumn")
    print("Buffer options reset")
end

-- Reset tabline and statusline (good for plugins misbehaving)
local function reset_ui()
    vim.cmd("redrawstatus!")
    vim.cmd("redrawtabline")
    vim.cmd("redraw!")
    print("UI redrawn")
end

-- Reload init.lua (full partial restart)
local function reload_config()
    vim.cmd("source $MYVIMRC")
    print("Neovim config reloaded")
end

-- Garbage collect and free memory
local function purge_memory()
    collectgarbage("collect")
    print("Lua garbage collected")
end

local function reload_maps()
    -- Clear cached `mattman.maps*` modules
    for name, _ in pairs(package.loaded) do
        if name:match("^mattman%.maps") then
            package.loaded[name] = nil
        end
    end

    -- Re-require maps
    local ok, mod = pcall(require, "mattman.maps")

    if not ok then
        vim.notify("Failed to reload maps: " .. tostring(mod), vim.log.levels.ERROR)
        return
    end

    -- If module exports a loader, call it
    if type(mod) == "table" and type(mod.load) == "function" then
        mod.load()
    elseif type(mod) ~= "table" then
        vim.notify("mattman.maps returned a non-table (" .. type(mod) .. ")", vim.log.levels.ERROR)
        return
    end

    -- Refresh which-key
    local ok_wk, wk = pcall(require, "which-key")
    if ok_wk then
        wk.setup()
    end

    print("Keymaps reloaded")
end

local function test()
    print("Test function executed")
end
-----------------------------------------------------------
-- RETURN WHICH-KEY MAP DEFINITIONS
-----------------------------------------------------------

return {
    { "<leader>r", group = "Reset", mode = { "n", "v" } },

    { "<leader>rh", reset_search,       desc = "Reset search highlight" },
    { "<leader>rs", reset_syntax,       desc = "Reset syntax / highlight" },
    { "<leader>rf", reset_folds,        desc = "Reset folds" },
    { "<leader>rd", reset_diagnostics,  desc = "Reset LSP diagnostics" },
    { "<leader>rl", reset_lsp,          desc = "Restart LSP" },
    { "<leader>rt", reset_treesitter,   desc = "Refresh Treesitter" },
    { "<leader>rb", reset_buffer_options, desc = "Reset buffer options" },
    { "<leader>ru", reset_ui,           desc = "Redraw UI" },
    { "<leader>rc", reload_config,      desc = "Reload init.lua" },
    { "<leader>rr", reload_file,        desc = "Reload file from disk" },
    { "<leader>rm", purge_memory,       desc = "Collect garbage" },
    { "<leader>rK", reload_maps,        desc = "Reload keymaps" },
    --{ "<leader>Rt", test,               desc = "Test function" },
}
