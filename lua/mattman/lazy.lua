-- ~/.config/nvim/lua/mattman/lazy.lua
vim.g.mapleader = " "
vim.g.maplocalleader = ","


local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("mattman.plugins")
require("mattman.rustcommands")

vim.api.nvim_create_user_command("NewGHIssue", function()
  local cwd = vim.fn.getcwd()
  local git_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
  if git_root == nil or git_root == "" then
    print("Not inside a git repository!")
    return
  end

  -- Get remote URL
  local remote_url = vim.fn.systemlist("git config --get remote.origin.url")[1]
  if not remote_url or remote_url == "" then
    print("No origin remote found!")
    return
  end

  -- Convert git@github.com:owner/repo.git or https://github.com/owner/repo.git -> owner/repo
  local owner_repo = remote_url
    :gsub("^git@github.com:", "")
    :gsub("^https://github.com/", "")
    :gsub("%.git$", "")

  -- Prompt user for issue title/body
  local title = vim.fn.input("Issue title: ")
  if title == "" then
    print("Cancelled: empty title")
    return
  end
  local body = vim.fn.input("Issue body: ")

  -- Run gh issue create
  local cmd = {"gh", "issue", "create", "--repo", owner_repo, "--title", title}
  if body ~= "" then
    table.insert(cmd, "--body")
    table.insert(cmd, body)
  end

  local result = vim.fn.system(cmd)
  print(result)
end, {})
