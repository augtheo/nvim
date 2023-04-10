-- require("github-theme").setup ({ transparent = true, theme_style="dimmed" })
require('catppuccin').setup {
  transparent_background = true
}

local colorscheme = "catppuccin" -- github_dimmed
local status_ok, _ = pcall(vim.cmd.colorscheme, colorscheme)
if not status_ok then
  return
end

