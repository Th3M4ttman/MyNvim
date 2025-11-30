return {
	"rktjmp/playtime.nvim",
	-- no extra dependencies needed
	cmd = "Playtime",
	keys = {
		{ "<leader>Gp", ":Playtime<CR>", desc = "Play Card Games" },
	},

	config = function()
		require("playtime").setup({
			-- default settings; configure fps, window position, etc. if desired
			-- e.g. fps = 60,
			-- window_position = "center",
		})
	end,
}
