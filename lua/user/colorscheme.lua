require("catppuccin").setup {
  integrations = {
    alpha = true,
    cmp = true,
    gitsigns = true,
    nvimtree = true,
    treesitter = true,
    notify = true,
    telescope = {
      enabled = true,
      style = "nvchad",
    },
    which_key = true,
    illuminate = true,
    mason = true,
    noice = true,
    dap = {
      enabled = true,
      enable_ui = true, -- enable nvim-dap-ui
    },
    neotest = true,
    -- mini = false,
    -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
  },
  -- transparent_background = true,
}

local colorscheme = "catppuccin"

local status_ok, _ = pcall(vim.cmd.colorscheme, colorscheme)
if not status_ok then
  return
end
