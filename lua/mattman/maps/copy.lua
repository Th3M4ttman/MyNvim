

return {
  { "<leader>c", group = "Copy/Cut/Paste", mode = {"n", "v", "i"} },
  { "<leader>cc", '"+y', desc = "Copy", mode = "v"},
  { "<leader>cc", '"+yy', desc = "Copy", mode = "n"},
  { "<leader>cx", '"+d', desc = "Cut", mode = "v"},
  { "<leader>cx", '"+dd', desc = "Cut", mode = "n"},
  { "<leader>cv", '"+p', desc = "Paste", mode = {"n", "v"}},
  
 {"<C-v>", '"+p', desc = "Paste", mode = {"n", "v"} },
 {"<C-v>", '<esc>"+pi', desc = "Paste", mode = "i" },

  {"<C-c>", '"+yy', desc = "Copy", mode = "n" },
  {"<C-c>", '<esc>"+yyi', desc = "Copy", mode = "i" },
  {"<C-c>", '"+y', desc = "Copy", mode = "v" },
  {"<C-x>", '"+dd', desc = "Cut", mode = "n" },
  {"<C-x>", '<esc>"+ddi', desc = "Cut", mode = "i" },
  {"<C-x>", '"+d', desc = "Cut", mode = "v" },
}



