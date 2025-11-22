

local map = vim.keymap.set  
map({'n', 'i', "v"}, '<C-q>', "<cmd>bd!<CR>", { desc = "Quit buffer" })  
map({'n', 'i', "v"}, '<A-q>', "<cmd>q!<CR>", { desc = "Force Quit" })

return {

  { "<leader>q", group = "Quit" },
  { "<leader>qq", "<cmd>q<cr>",   desc = "Quit" },
  { "<leader>qf", "<cmd>q!<cr>",  desc = "Quit (force)" },
  { "<leader>qs", "<cmd>wq<cr>",  desc = "Quit (save)" },
  { "<leader>qb", group = "Buffer" },
  { "<leader>qbb", "<cmd>bd<cr>",      desc = "Close buffer" },
  { "<leader>qbs", "<cmd>w | bd<cr>",  desc = "Save & close buffer" },
  { "<leader>qbf", "<cmd>bd!<cr>",     desc = "Force close buffer" },

}
