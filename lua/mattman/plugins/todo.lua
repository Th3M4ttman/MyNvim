return {
	{
		"folke/todo-comments.nvim",
		dependencies = "nvim-lua/plenary.nvim",
		event = "BufReadPost", -- lazy-load on file open
		config = function()
			require("todo-comments").setup({
				keywords = {
					FIX = { icon = " ", color = "error", alt = { "FIXME", "BUG", "ISSUE" } },
					TODO = { icon = " ", color = "info" },
					HACK = { icon = " ", color = "warning" },
					WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
					NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
					PERF = { icon = " ", alt = { "OPTIM" } },
					TEST = { icon = "ﭧ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
				},
			})

			local opts = { noremap = true, silent = true }

			-- Jump to next/previous todo comment
			vim.keymap.set("n", "]t", function()
				require("todo-comments").jump_next()
			end, opts)
			vim.keymap.set("n", "[t", function()
				require("todo-comments").jump_prev()
			end, opts)

			-- Search todos with telescope
			vim.keymap.set("n", "<leader>st", function()
				require("todo-comments").search()
			end, opts)
		end,
	},
}
