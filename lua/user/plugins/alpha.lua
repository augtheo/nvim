local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
  return
end

local dashboard = require "alpha.themes.dashboard"
dashboard.section.header.val = {
  [[                                                 ]],
  [[                                                 ]],
  [[                                                 ]],
  [[                                                 ]],
  [[                                                 ]],
  [[                               __                ]],
  [[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
  [[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
  [[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
  [[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
  [[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
  [[                                                 ]],
  [[                                                 ]],
}
dashboard.section.buttons.val = {
  dashboard.button("f", " " .. " Find file", "<cmd>Telescope find_files <cr>"),
  dashboard.button("e", " " .. " New file", "<cmd>ene <BAR> startinsert <cr>"),
  dashboard.button("d", " " .. " Create Git Worktree", "<cmd>Telescope git_worktree create_git_worktree<CR>"),
  dashboard.button("g", " " .. " Switch Git Worktree", "<cmd>Telescope git_worktree git_worktrees<cr>"),
  dashboard.button("r", " " .. " Recently used files", "<cmd>Telescope oldfiles <cr>"),
  dashboard.button("t", " " .. " Find text", "<cmd>Telescope live_grep <cr>"),
  dashboard.button("s", " " .. " Restore Session", [[:lua require("persistence").load() <cr>]]),
  dashboard.button("c", " " .. " Configuration", "<cmd>e $MYVIMRC <cr>"),
  dashboard.button("q", " " .. " Quit", "<cmd>qa<cr>"),
}
local function footer()
  return ""
end

dashboard.section.footer.val = footer()

dashboard.section.footer.opts.hl = "Type"
dashboard.section.header.opts.hl = "Include"
dashboard.section.buttons.opts.hl = "Keyword"

dashboard.opts.opts.noautocmd = true
alpha.setup(dashboard.opts)
