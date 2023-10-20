local colors = vim.env.NVIM_COLORSCHEME or "catppuccin"
require("user.plugins.colors." .. colors)
vim.cmd.colorscheme(colors)
