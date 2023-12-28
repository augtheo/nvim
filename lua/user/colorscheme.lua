local colors = vim.env.NVIM_COLORSCHEME or "catppuccin"

local require_ok, opts = pcall(require, "user.plugins.colors." .. colors)
vim.cmd.colorscheme(colors)

vim.cmd "hi! link PmenuSel lualine_a_insert"
vim.cmd "hi! link NormalNC NvimTreeNormal"
vim.cmd "hi! link NvimTreeWindowPicker lualine_a_command"
vim.cmd "hi! link FloatBorder Normal"
