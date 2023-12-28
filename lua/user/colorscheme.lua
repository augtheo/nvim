local colors = vim.env.NVIM_COLORSCHEME or "catppuccin"

local require_ok, opts = pcall(require, "user.plugins.colors." .. colors)
vim.cmd.colorscheme(colors)

vim.cmd "hi! link PmenuSel lualine_a_insert"
