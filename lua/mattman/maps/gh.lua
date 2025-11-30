
-- Create a new issue in the current repo
vim.api.nvim_create_user_command("NewGHIssue", function()
  local git_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
  if not git_root or git_root == "" then
    print("Not inside a git repository!")
    return
  end

  local remote_url = vim.fn.systemlist("git config --get remote.origin.url")[1]
  if not remote_url or remote_url == "" then
    print("No origin remote found!")
    return
  end

  local owner_repo = remote_url
    :gsub("^git@github.com:", "")
    :gsub("^https://github.com/", "")
    :gsub("%.git$", "")

  local title = vim.fn.input("Issue title: ")
  if title == "" then
    print("Cancelled: empty title")
    return
  end

  local body = vim.fn.input("Issue body: ")

  local cmd = {"gh", "issue", "create", "--repo", owner_repo, "--title", title}
  if body ~= "" then
    table.insert(cmd, "--body")
    table.insert(cmd, body)
  end

  local result = vim.fn.system(cmd)
  print(result)
end, {})

-- Create a new issue with file/line reference
vim.api.nvim_create_user_command("NewGHIssueHere", function()
  local git_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
  if not git_root or git_root == "" then
    print("Not inside a git repository!")
    return
  end

  local remote_url = vim.fn.systemlist("git config --get remote.origin.url")[1]
  if not remote_url or remote_url == "" then
    print("No origin remote found!")
    return
  end

  local owner_repo = remote_url
    :gsub("^git@github.com:", "")
    :gsub("^https://github.com/", "")
    :gsub("%.git$", "")

  local branch = vim.fn.systemlist("git rev-parse --abbrev-ref HEAD")[1]
  if not branch or branch == "" then branch = "main" end

  local file = vim.fn.expand("%")
  local line = vim.fn.line(".")
  local rel_path = vim.fn.fnamemodify(file, ":.")

  local github_url = string.format("https://github.com/%s/blob/%s/%s#L%d", owner_repo, branch, rel_path, line)

  local title = vim.fn.input("Issue title: ")
  if title == "" then
    print("Cancelled: empty title")
    return
  end

  local body = vim.fn.input("Issue body: ")
  if body ~= "" then
    body = body .. "\n\n"
  end
  body = body .. "File reference: " .. github_url

  local cmd = {"gh", "issue", "create", "--repo", owner_repo, "--title", title, "--body", body}
  local result = vim.fn.system(cmd)
  print(result)
end, {})





return  {
    { '<leader>g', group = 'Git' },
    { '<leader>gh', group = 'Github' },
    { '<leader>ghc', group = 'Commits' },
-- Leader key bindings (single lines)
{"<leader>ghic", ":NewGHIssue<CR>", desc = "Create GitHub Issue" },
{"<leader>ghih", ":NewGHIssueHere<CR>",  desc = "Create GitHub Issue with file/line link" },


    { '<leader>gn', '<cmd>Neogit<cr>', desc = 'Neogit' },
    { '<leader>ghcc', '<cmd>GHCloseCommit<cr>', desc = 'Close' },
    { '<leader>ghce', '<cmd>GHExpandCommit<cr>', desc = 'Expand' },
    { '<leader>ghco', '<cmd>GHOpenToCommit<cr>', desc = 'Open To' },
    { '<leader>ghcp', '<cmd>GHPopOutCommit<cr>', desc = 'Pop Out' },
    { '<leader>ghcz', '<cmd>GHCollapseCommit<cr>', desc = 'Collapse' },
    { '<leader>ghi', group = 'Issues' },
    { '<leader>ghio', '<cmd>GHOpenIssue<cr>', desc = 'Open issues' },
    { '<leader>ghl', group = 'Litee' },
    { '<leader>ghlt', '<cmd>LTPanel<cr>', desc = 'Toggle Panel' },
    { '<leader>ghp', group = 'Pull Request' },
    { '<leader>ghpc', '<cmd>GHClosePR<cr>', desc = 'Close' },
    { '<leader>ghpd', '<cmd>GHPRDetails<cr>', desc = 'Details' },
    { '<leader>ghpe', '<cmd>GHExpandPR<cr>', desc = 'Expand' },
    { '<leader>ghpo', '<cmd>GHOpenPR<cr>', desc = 'Open' },
    { '<leader>ghpp', '<cmd>GHPopOutPR<cr>', desc = 'PopOut' },
    { '<leader>ghpr', '<cmd>GHRefreshPR<cr>', desc = 'Refresh' },
    { '<leader>ghpt', '<cmd>GHOpenToPR<cr>', desc = 'Open To' },
    { '<leader>ghpz', '<cmd>GHCollapsePR<cr>', desc = 'Collapse' },
    { '<leader>ghr', group = 'Review' },
    { '<leader>ghrb', '<cmd>GHStartReview<cr>', desc = 'Begin' },
    { '<leader>ghrc', '<cmd>GHCloseReview<cr>', desc = 'Close' },
    { '<leader>ghrd', '<cmd>GHDeleteReview<cr>', desc = 'Delete' },
    { '<leader>ghre', '<cmd>GHExpandReview<cr>', desc = 'Expand' },
    { '<leader>ghrs', '<cmd>GHSubmitReview<cr>', desc = 'Submit' },
    { '<leader>ghrz', '<cmd>GHCollapseReview<cr>', desc = 'Collapse' },
    { '<leader>ght', group = 'Threads' },
    { '<leader>ghtc', '<cmd>GHCreateThread<cr>', desc = 'Create' },
    { '<leader>ghtn', '<cmd>GHNextThread<cr>', desc = 'Next' },
    { '<leader>ghtt', '<cmd>GHToggleThread<cr>', desc = 'Toggle' } 
}
