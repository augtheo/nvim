require("pywal").setup()

local pywal_colors = require("pywal.core").get_colors()
vim.schedule(function()
  require("lualine").setup {
    options = {
      theme = "pywal-nvim",
    },
  }
end)
