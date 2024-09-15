require("colorful-winsep").setup {
  symbols = { "▁", "▏", "▁", " ", "🭼", "▏" },
  hi = {
    fg = string.format("#%06x", vim.api.nvim_get_hl_by_name("lualine_a_visual", true)["background"]),
    bg = string.format("#%06x", vim.api.nvim_get_hl_by_name("lualine_a_visual", true)["foreground"]),
  },
}
