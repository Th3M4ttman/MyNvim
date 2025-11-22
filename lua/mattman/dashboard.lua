local alpha = require'alpha'
local vim_fn = vim.fn
local Path = vim.fn.stdpath("config") .. "/lua/mattman/dashboards/"
local state_file = vim_fn.stdpath("data") .. "/mattman_last_dashboard.txt"

local M = {}

-- get all Lua files in dashboards folder
local function get_themes()
    local files = vim_fn.glob(Path .. "*.lua", 0, 1)
    local themes = {}
    for _, f in ipairs(files) do
        local name = f:match(".*/(.*)%.lua$")
        table.insert(themes, name)
    end
    return themes
end

local themes = get_themes()

-- try to read last used theme from state file
local current = 1
if vim_fn.filereadable(state_file) == 1 then
    local content = vim_fn.readfile(state_file)[1]
    current = tonumber(content) or 1
    if current > #themes then current = 1 end
end

local function save_current_theme()
    vim_fn.writefile({tostring(current)}, state_file)
end

local function load_theme(index)
    local module_name = "mattman.dashboards." .. themes[index]

    -- force reload
    package.loaded[module_name] = nil

    -- attempt to require the theme
    local ok, config_or_err = pcall(require, module_name)
    if not ok then
        vim.notify(
            "Failed to require theme '" .. module_name .. "':\n" .. config_or_err,
            vim.log.levels.ERROR
        )
        return
    end

    -- check the return value
    if type(config_or_err) ~= "table" then
        vim.notify(
            "Theme '" .. module_name .. "' did not return a table, got: " .. type(config_or_err),
            vim.log.levels.ERROR
        )
        return
    end

    -- attempt to set up alpha
    local alpha_ok, alpha_err = pcall(require("alpha").setup, config_or_err)
    if not alpha_ok then
        vim.notify(
            "Error running alpha.setup for theme '" .. module_name .. "':\n" .. alpha_err,
            vim.log.levels.ERROR
        )
        return
    end

    current = index
    save_current_theme()
    print("Loaded theme:", themes[index])
end

-- cycle theme
function M.cycle_theme()
    local next_index = current + 1
    if next_index > #themes then next_index = 1 end
    load_theme(next_index)

    -- refresh Alpha to show the new theme
    local ok, alpha = pcall(require, "alpha")
    if ok then
        -- close then reopen Alpha
        vim.cmd("Alpha")
        vim.cmd("Alpha")
    end
end

-- define Vim command so we can use it in dashboard buttons
vim.api.nvim_create_user_command("CycleTheme", function()
    M.cycle_theme()
end, {})-- load default theme



if #themes > 0 then
    load_theme(current)
end




vim.api.nvim_create_user_command("DashboardFindFile", function()
    local ok, telescope = pcall(require, "telescope.builtin")
    if ok then
        telescope.find_files({ path_display = { "smart" } })
    else
        local fname = vim.fn.input("Open file: ")
        if fname ~= "" then
            vim.cmd("edit " .. fname)
        end
    end
end, {})

vim.api.nvim_create_user_command("DashboardRecentFiles", function()
    local ok, telescope = pcall(require, "telescope.builtin")
    if ok then
        telescope.oldfiles({ path_display = { "smart" } })
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
end, {})






return M
