local alpha = require "alpha"

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
  dashboard.button("f", " " .. " Files", [[:lua require("user.plugins.telescope").find_files() <cr>]]),
  dashboard.button("e", " " .. " New file", "<cmd>ene <BAR> startinsert <cr>"),
  dashboard.button("r", " " .. " Recent files", [[:lua require("user.plugins.telescope").oldfiles() <cr>]]),
  dashboard.button("t", " " .. " Find text", [[:lua require("user.plugins.telescope").live_grep() <cr>]]),
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
