local M = {}

-- ==============================
-- Project root (per buffer)
-- ==============================
local function project_root(bufnr)
    bufnr = bufnr or vim.api.nvim_get_current_buf()
    local folders = {}

    -- LSP workspace folders for current buffer
    local clients = vim.lsp.get_active_clients({bufnr = bufnr})
    for _, client in ipairs(clients) do
        local ok, ws = pcall(client.workspace_folders)
        if ok and type(ws) == "table" then
            for _, f in ipairs(ws) do
                table.insert(folders, f)
            end
        end
    end

    if #folders > 0 then
        return folders[1]
    end

    -- Fallback to git root relative to buffer
    local file_path = vim.api.nvim_buf_get_name(bufnr)
    local file_dir = vim.fn.fnamemodify(file_path, ":p:h")
    local git_root = vim.fn.systemlist("git -C " .. vim.fn.shellescape(file_dir) .. " rev-parse --show-toplevel")[1]
    if git_root and vim.v.shell_error == 0 and git_root ~= "" then
        return git_root
    end

    -- Fallback to buffer directory
    return file_dir ~= "" and file_dir or vim.fn.getcwd()
end

-- ==============================
-- Terminal split helper
-- ==============================
local function open_terminal_split(cmdline, cwd)
    cwd = cwd or project_root(0)
    vim.cmd("belowright split")
    vim.cmd("resize 15")
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_win_set_buf(0, buf)
    vim.fn.termopen(cmdline, { cwd = cwd })
    vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")
    vim.api.nvim_buf_set_option(buf, "filetype", "terminal")

    -- <Esc> closes the terminal buffer
    local close_cmd = "<Cmd>bd!<CR>"
    vim.api.nvim_buf_set_keymap(buf, "t", "<Esc>", "<C-\\><C-n>" .. close_cmd, { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(buf, "n", "<Esc>", close_cmd, { noremap = true, silent = true })
end

-- ==============================
-- RustRunArgs
-- ==============================
function M.RustRunArgs()
    vim.ui.input({ prompt = "cargo run args: " }, function(args)
        if args == nil then return end
        args = vim.trim(args)
        local cmd = args == "" and "cargo run" or "cargo run -- " .. args
        open_terminal_split(cmd, project_root(0))
    end)
end

-- ==============================
-- Collect build targets
-- ==============================
local function collect_targets(cwd)
    local output = vim.fn.systemlist({ "cargo", "metadata", "--format-version", "1", "--no-deps" }, cwd)
    if vim.v.shell_error ~= 0 then
        vim.notify("Failed to run cargo metadata", vim.log.levels.ERROR)
        return {}
    end

    local ok, metadata = pcall(vim.fn.json_decode, table.concat(output, "\n"))
    if not ok or not metadata or not metadata.packages then
        vim.notify("Failed to parse cargo metadata", vim.log.levels.ERROR)
        return {}
    end

    local targets = {}
    for _, pkg in ipairs(metadata.packages) do
        for _, t in ipairs(pkg.targets or {}) do
            table.insert(targets, { pkg = pkg.name, target = t.name, kind = table.concat(t.kind, ",") })
        end
    end
    return targets
end

-- ==============================
-- RustBuild
-- ==============================
function M.RustBuild()
    local cwd = project_root(0)
    local targets = collect_targets(cwd)
    if #targets == 0 then
        vim.notify("No build targets found", vim.log.levels.WARN)
        return
    end

    -- Build display list and mapping to commands (Debug & Release)
    local display = {}
    local cmd_map = {}

    for _, t in ipairs(targets) do
        local kinds = t.kind:lower()
        local base_cmd
        if string.find(kinds, "bin") then
            base_cmd = string.format("cargo build --package %s --bin %s", t.pkg, t.target)
        elseif string.find(kinds, "example") then
            base_cmd = string.format("cargo build --example %s", t.target)
        elseif string.find(kinds, "test") then
            base_cmd = string.format("cargo test --no-run --package %s --test %s", t.pkg, t.target)
        else
            base_cmd = string.format("cargo build --package %s", t.pkg)
        end

        -- Debug
        local debug_label = string.format("%s : %s (%s) [Debug]", t.pkg, t.target, t.kind)
        table.insert(display, debug_label)
        cmd_map[debug_label] = base_cmd

        -- Release
        local release_label = string.format("%s : %s (%s) [Release]", t.pkg, t.target, t.kind)
        table.insert(display, release_label)
        cmd_map[release_label] = base_cmd .. " --release"
    end

    -- Pick target
    local function pick_target(idx)
        local label = display[idx]
        if not label then return end
        local cmd = cmd_map[label]
        if cmd then
            open_terminal_split(cmd, project_root(0))
        end
    end

    -- Telescope picker or fallback
    if pcall(require, "telescope") then
        local pickers = require("telescope.pickers")
        local finders = require("telescope.finders")
        local conf = require("telescope.config").values
        local actions = require("telescope.actions")
        local action_state = require("telescope.actions.state")

        pickers.new({}, {
            prompt_title = "Cargo build targets",
            finder = finders.new_table({ results = display }),
            sorter = conf.generic_sorter({}),
            attach_mappings = function(prompt_bufnr)
                actions.select_default:replace(function()
                    local selection = action_state.get_selected_entry()
                    local idx = selection.index
                    actions.close(prompt_bufnr)
                    pick_target(idx)
                end)
                return true
            end,
        }):find()
    else
        vim.ui.select(display, { prompt = "Cargo build targets" }, function(_, idx)
            pick_target(idx)
        end)
    end
end

-- ==============================
-- Register Neovim commands
-- ==============================
vim.api.nvim_create_user_command("RustRunArgs", M.RustRunArgs, {})
vim.api.nvim_create_user_command("RustBuild", M.RustBuild, {})

return M
