local alpha = require "alpha"

local icons = {
  ui = require("user.icons").ui,
}

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
  dashboard.button(
    "SPC f f",
    icons.ui.Search .. " Find Files",
    [[:lua require("user.plugins.telescope").find_files() <cr>]]
  ),
  dashboard.button(
    "SPC f o",
    icons.ui.Recent .. " Find Recent",
    [[:lua require("user.plugins.telescope").oldfiles() <cr>]]
  ),
  dashboard.button("SPC s g", " " .. " Find Text", [[:lua require("user.plugins.telescope").live_grep() <cr>]]),
  dashboard.button("SPC q s", " " .. " Restore Session", [[:lua require("persistence").load() <cr>]]),
  dashboard.button("SPC q q", " " .. " Quit Nvim", "<cmd>qa<cr>"),
}
local function footer()
  return ""
end

dashboard.section.footer.val = footer()
alpha.setup(dashboard.opts)
