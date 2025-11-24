

local map = vim.keymap.set  
map({'n', 'i', "v"}, '<C-q>', "<cmd>bd!<CR>", { desc = "Quit buffer" })  
map({'n', 'i', "v"}, '<A-q>', "<cmd>q!<CR>", { desc = "Force Quit" })

return {

  { "<leader>Q", group = "Quit" },
  { "<leader>Qq", "<cmd>q<cr>",   desc = "Quit" },
  { "<leader>Qf", "<cmd>q!<cr>",  desc = "Quit (force)" },
  { "<leader>Qs", "<cmd>wq<cr>",  desc = "Quit (save)" },
  { "<leader>Qb", group = "Buffer" },
  { "<leader>Qbb", "<cmd>bd<cr>",      desc = "Close buffer" },
  { "<leader>Qbs", "<cmd>w | bd<cr>",  desc = "Save & close buffer" },
  { "<leader>Qbf", "<cmd>bd!<cr>",     desc = "Force close buffer" },

}
