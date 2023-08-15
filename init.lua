vim.loader.enable()
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require "user.options"
require "user.autocommands"
require "user.plugins"
require "user.keymaps"

-- TODO: Move custom setup outside of init.lua
require "user.dressing"
require "user.colorscheme"
require "user.lualine"
require "user.cmp"
require "user.telescope"
require "user.treesitter"
require "user.autopairs"
require "user.nvim-tree"
require "user.toggleterm"
require "user.project"
require "user.illuminate"
require "user.alpha"
require "user.lsp"
require "user.dap"
require "user.notify"
require "user.which-key"
require "user.todo"
require "user.trouble"
require "user.noice"
require "user.utils"
