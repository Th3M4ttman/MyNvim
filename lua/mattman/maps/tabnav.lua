
local map = vim.keymap.set

-- Switch to previous tab
--
map("n", "<A-Left>", "gT", { desc = "Go to previous tab" })

-- Switch to next tab
map("n", "<A-Right>", "gt", { desc = "Go to next tab" })

--
map("n", "<C-Left>", ":bprev<cr>", { desc = "Go to previous tab" })

-- Switch to next tab
map("n", "<C-Right>", ":bnext<cr>", { desc = "Go to next tab" })


return {
  
}
