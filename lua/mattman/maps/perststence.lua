-- SESSION COMMANDS  ---------------------------------------------------------
-- Persistence
vim.api.nvim_create_user_command("SessionLoad", function()
	require("persistence").load()
end, {})

vim.api.nvim_create_user_command("SessionSelect", function()
	require("persistence").select()
end, {})

vim.api.nvim_create_user_command("SessionLoadLast", function()
	require("persistence").load({ last = true })
end, {})

vim.api.nvim_create_user_command("SessionStop", function()
	require("persistence").stop()
end, {})


return {
	----------------------------------------------------------------------------
	-- ROOT GROUP
	----------------------------------------------------------------------------
	{ "<leader>q", group = "Session / Quit" },

	----------------------------------------------------------------------------
	-- SESSION MANAGEMENT (Unified)
	----------------------------------------------------------------------------
	{ "<leader>qs", "<cmd>SessionLoad<cr>", desc = "Load session" },
	{ "<leader>qS", "<cmd>SessionSelect<cr>", desc = "Select session" },
	{ "<leader>ql", "<cmd>SessionLoadLast<cr>", desc = "Load last session" },
	{ "<leader>qd", "<cmd>SessionStop<cr>", desc = "Stop persistence" },

	-- Bufstates submenu
	{ "<leader>qb", group = "Bufstates" },
	{ "<leader>qbd", "<cmd>BufstateDelete<cr>", desc = "Delete session" },
	{ "<leader>qbs", "<cmd>BufstateSave<cr>", desc = "Save session" },
	{ "<leader>qbl", "<cmd>BufstateLoad<cr>", desc = "Load session" },
	{ "<leader>qbS", "<cmd>BufstateSaveAs<cr>", desc = "Save session as" },
	{ "<leader>qbn", "<cmd>BufstateNew<cr>", desc = "New session" },

}
