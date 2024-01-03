require("pywal").setup()

vim.schedule(function()
  require("lualine").setup {
    options = {
      theme = "pywal-nvim",
    },
  }
end)
