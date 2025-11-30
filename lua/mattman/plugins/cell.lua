return {
	"Eandrju/cellular-automaton.nvim",
	cmd = "CellularAutomaton", -- lazy-load when command is used
	keys = {
		{ "<leader>Gr", "<cmd>CellularAutomaton make_it_rain<CR>", desc = "Make it rain" },
		{ "<leader>Gl", "<cmd>CellularAutomaton game_of_life<CR>", desc = "Game of Life" },
		{ "<leader>Gs", "<cmd>CellularAutomaton scramble<CR>", desc = "Scramble" },
	},
	config = function()
		-- Optional: set default FPS or custom config here if needed
		-- require("cellular-automaton").setup({ fps = 50 })
	end,
}
