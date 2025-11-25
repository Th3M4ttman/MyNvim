-- SESSION COMMANDS  ---------------------------------------------------------
-- Persistence

	
	



return {
	----------------------------------------------------------------------------
	-- ROOT GROUP
	----------------------------------------------------------------------------
	{ "<leader>q", group = "Session / Quit" },

	----------------------------------------------------------------------------
	-- SESSION MANAGEMENT (Unified)
	----------------------------------------------------------------------------
	{ "<leader>ql", ":lua require('persistence').load()<CR>",  desc = "Load session" },
    
	{ "<leader>qL", ":lua require('persistence').load({ last = true })<CR>", desc = "Load last session" },
	{ "<leader>qd", ":lua require('persistence').stop()<CR>", desc = "Stop persistence" },

	-- Bufstates submenu
	{ "<leader>qb", group = "Bufstates" },
	{ "<leader>qbd", "<cmd>BufstateDelete<cr>", desc = "Delete session" },
	{ "<leader>qbs", "<cmd>BufstateSave<cr>", desc = "Save session" },
	{ "<leader>qbl", "<cmd>BufstateLoad<cr>", desc = "Load session" },
	{ "<leader>qbS", "<cmd>BufstateSaveAs<cr>", desc = "Save session as" },
	{ "<leader>qbn", "<cmd>BufstateNew<cr>", desc = "New session" },

}
