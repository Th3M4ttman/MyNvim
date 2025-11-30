return {
	"stevearc/overseer.nvim",
	---@module 'overseer'
	---@type overseer.SetupOpts
	opts = {},
	keys = {
		{
			"<leader>to",
			function()
				require("overseer").toggle()
			end,
			desc = "Overseer: Toggle",
		},
		{
			"<leader>tr",
			function()
				require("overseer").run_template()
			end,
			desc = "Overseer: Run Template",
		},
	},
}
