

vim.keymap.set("n", "<leader>ccq", function()
	local input = vim.fn.input("Quick Chat: ")
	if input ~= "" then
		require("CopilotChat").ask(input, {
			selection = require("CopilotChat.select").buffer,
		})
	end
end, { desc = "CopilotChat - Quick chat" })

vim.keymap.set("v", "<A-c>", function()
	local input = vim.fn.input("Quick Chat (with selection): ")
	if input ~= "" then
		require("CopilotChat").ask(input, {
			selection = require("CopilotChat.select").visual,
		})
	end
end, { desc = "CopilotChat - Quick chat with selection" })

vim.keymap.set("n", "<leader>cca", function()
	local input = vim.fn.input("Quick Chat (with buffer): ")
	if input ~= "" then
		require("CopilotChat").ask(input, {
			selection = require("CopilotChat.select").buffer,
		})
	end
end, { desc = "CopilotChat - AI Assistant" })

return {
	{
		"github/copilot.vim",
		enabled = true,
		commit = "da369d9", -- LAST GOOD VERSION BEFORE BROKEN LANGUAGE SERVER
		init = function()
			-- Prevent Copilot from binding <Tab>
			vim.g.copilot_no_tab_map = true
		end,
	},
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		dependencies = {
			{ "nvim-lua/plenary.nvim", branch = "master" },
			{ "github/copilot.vim", commit = "da369d9" },
		},
		build = "make tiktoken",
		opts = {
		},
	},
}
