local alpha = require "alpha"

local icons = {
  ui = require("user.icons").ui,
}

local theme = require "alpha.themes.theta"
local dashboard = require "alpha.themes.dashboard"
local buttons = {
  type = "group",
  val = {
    { type = "text", val = "Quick links", opts = { hl = "SpecialComment", position = "center" } },
    { type = "padding", val = 1 },
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
  },
  position = "center",
}

theme.config.layout[6] = buttons

local function footer()
  return ""
end

dashboard.section.footer.val = footer()
alpha.setup(theme.config)
