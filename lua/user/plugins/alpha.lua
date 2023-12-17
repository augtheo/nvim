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
  dashboard.button("SPC f f", " " .. " Files", [[:lua require("user.plugins.telescope").find_files() <cr>]]),
  dashboard.button("SPC f o", " " .. " Recent", [[:lua require("user.plugins.telescope").oldfiles() <cr>]]),
  dashboard.button("SPC s g", " " .. " Find text", [[:lua require("user.plugins.telescope").live_grep() <cr>]]),
  dashboard.button("SPC q s", " " .. " Restore Session", [[:lua require("persistence").load() <cr>]]),
  dashboard.button("SPC q q", " " .. " Quit", "<cmd>qa<cr>"),
  dashboard.button("e", " " .. " New file", "<cmd>ene <BAR> startinsert <cr>"),
  dashboard.button("c", " " .. " Configuration", "<cmd>e $MYVIMRC <cr>"),
}
local function footer()
  return ""
end

dashboard.section.footer.val = footer()
alpha.setup(dashboard.opts)
