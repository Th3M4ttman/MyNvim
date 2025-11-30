return {
	"alec-gibson/nvim-tetris",
	cmd = "Tetris", -- lazy-load only when the command is used
	keys = {
		{ "<leader>Gt", ":Tetris<CR>", desc = "Play Tetris" },
	},
	config = function()
		-- no extra setup needed
	end,
}
