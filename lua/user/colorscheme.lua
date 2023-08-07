require("catppuccin").setup {
  integrations = {
    mason = true,
    mini = true,
    noice = true,
    notify = true,
    neotest = true,
    telescope = {
      style = "nvchad",
    },
    treesitter_context = true,
    treesitter = true,
    illuminate = true,
    which_key = true,
    -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
  },
  custom_highlights = function(colors)
    return {
      Pmenu = { bg = border and colors.none or colors.mantle },
    }
  end,
  -- transparent_background = true,
}

local colorscheme = "catppuccin"

local status_ok, _ = pcall(vim.cmd.colorscheme, colorscheme)
if not status_ok then
  return
end
