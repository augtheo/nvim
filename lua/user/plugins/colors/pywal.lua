require("pywal").setup()

vim.g.LUALINE_THEME = "pywal-nvim"
local pywal_colors = require("pywal.core").get_colors()
vim.cmd "highlight StatusLine   cterm=none ctermfg=white ctermbg=black guifg=red"
vim.cmd "highlight StatusLine   cterm=none ctermfg=white ctermbg=black guifg=red"
-- vim.cmd "highlight NvimTreeStatusLineNC cterm=none ctermfg=white ctermbg=black guifg=green"
-- vim.cmd "highlight NvimTreeStatusLineNC cterm=none ctermfg=white ctermbg=black guifg=green"
vim.cmd "highlight link NvimTreeWinSeparator Normal"
vim.cmd "highlight link WinSeparator Normal"
