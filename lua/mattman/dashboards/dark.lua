local dashboard = require'alpha.themes.dashboard'

dashboard.section.header.val = {
    "██╗  ██╗ █████╗ ██████╗ ",
    "██║ ██╔╝██╔══██╗██╔══██╗",
    "█████╔╝ ███████║██████╔╝",
}


dashboard.section.buttons.val = {
dashboard.button("o", "  Open", ":Oil " .. vim.loop.cwd() .. "<CR>"),
dashboard.button("f", "  Find File", ":DashboardFindFile<CR>"),
dashboard.button("r", "  Recent Files", ":DashboardRecentFiles<CR>"),
dashboard.button("n", "  New File", ":ene <BAR> startinsert<CR>"),
dashboard.button("t", "  Toggle Theme", ":CycleTheme<CR>"),
dashboard.button("L", "󰒲  Lazy", ":Lazy<CR>"),
dashboard.button("c", "  Open Config", ":Oil ~/.config/nvim<CR>"),
dashboard.button("q", "  Quit", ":q!<CR>")
}

return dashboard.config
