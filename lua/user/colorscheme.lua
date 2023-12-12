local colors = vim.env.NVIM_COLORSCHEME or "catppuccin"

local require_ok, opts = pcall(require, "user.plugins.colors." .. colors)
vim.cmd.colorscheme(colors)
