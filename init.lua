vim.loader.enable()
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require "user.options"
require "user.autocommands"
require "user.plugins"
require "user.keymaps"

-- TODO: Move custom setup outside of init.lua
require "user.colorscheme"
require "user.cmp"
require "user.autopairs"
require "user.lsp"
require "user.which-key"
require "user.utils"
