local dashboard = require("alpha.themes.dashboard")
local ascii = require("ascii")
local fortune = require("fortune").get_fortune()


-- Helper function to center a line horizontally
local function center_line(line)
	local width = vim.o.columns
	local line_width = vim.fn.strdisplaywidth(line)
	local pad = math.floor((width - line_width) / 2)
	if pad < 0 then
		pad = 0
	end
	return string.rep(" ", pad) .. line
end

-- ----------------------------
-- HEADER
-- ----------------------------
dashboard.section.header.val = ascii.art.anime.naruto.SasukeMangekyo
dashboard.section.header.opts = { position = "center" }

-- ----------------------------
-- FOOTER
-- ----------------------------
local footer_lines = {}

-- Center load info
local load_line = "  Neovim loaded " .. vim.fn.strftime("%H:%M") .. " on " .. vim.fn.strftime("%d/%m/%Y") .. " '"
table.insert(footer_lines, center_line(load_line))

-- Center fortune lines
for _, line in ipairs(fortune) do
	table.insert(footer_lines, center_line(line))
end

dashboard.section.footer.val = footer_lines

-- ----------------------------
-- BUTTONS
-- ----------------------------

dashboard.section.buttons.val = {
	dashboard.button("o", "  Open", ":Oil " .. vim.loop.cwd() .. "<CR>"),
	dashboard.button("f", "  Find File", ":DashboardFindFile<CR>"),
	dashboard.button("r", "  Recent Files", ":DashboardRecentFiles<CR>"),
	dashboard.button("n", "  New File", ":ene <BAR> startinsert<CR>"),
	dashboard.button("t", "  Toggle Theme", ":CycleTheme<CR>"),
	dashboard.button("L", "󰒲  Lazy", ":Lazy<CR>"),
	dashboard.button("c", "  Open Config", ":Oil ~/.config/nvim<CR>"),
	dashboard.button("z", "  Zoxide", ":Telescope zoxide list<CR>"),
	dashboard.button("l", "  Last Session", ":lua require('persistence').load({ last = true })<CR>"),
	dashboard.button("q", "  Quit", ":q!<CR>"),
}
dashboard.section.buttons.opts = { spacing = 1 }

-- ----------------------------
-- RETURN CONFIG
-- ----------------------------
return dashboard.config
