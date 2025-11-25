return {
	{
		lazy = false,
		"mbbill/undotree",
		cmd = "UndotreeToggle",
		keys = {
			{ "<leader>ut", "<cmd>UndotreeToggle<CR>", desc = "Undo Tree" },
		},
		config = function()
			-- Optional UI tweaks (you can remove or edit these)
			vim.g.undotree_WindowLayout = 2 -- Diff panel under tree
			vim.g.undotree_ShortIndicators = 1 -- Shorter indicators
			vim.g.undotree_SetFocusWhenToggle = 1 -- Jump to the tree when opened
		end,
	},
}
