vim.loader.enable()
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require "user.autocommands"
require "user.options"
require "user.keymaps"
require "user.lazy-bootstrap"
require "user.plugins"

require "user.colorscheme"
