local colorscheme = os.getenv "NVIM_COLORSCHEME" or "catppuccin"
if colorscheme == "catppuccin" then
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
      lsp_trouble = true,
      treesitter_context = true,
      treesitter = true,
      illuminate = true,
      which_key = true,
      -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
    },
    custom_highlights = function(colors)
      local custom_color = colors.surface0
      return {
        Pmenu = { bg = colors.mantle },
        NvimTreeWinSeparator = { fg = custom_color },
        NvimTreeWindowPicker = { bg = colors.blue, fg = colors.mantle, style = { "bold" } },
        VertSplit = { fg = custom_color },
        HorizSplit = { fg = custom_color },
      }
    end,
    -- transparent_background = true,
  }
  local status_ok, _ = pcall(vim.cmd.colorscheme, colorscheme)
  if not status_ok then
    return
  end
elseif colorscheme == "pywal" then
  require("pywal").setup()
  local pywal_colors = require("pywal.core").get_colors()
  vim.cmd "highlight StatusLine   cterm=none ctermfg=white ctermbg=black guifg=red"
  vim.cmd "highlight StatusLineNC cterm=none ctermfg=white ctermbg=black guifg=green"
  vim.cmd "highlight link NvimTreeWinSeparator Normal"
  vim.cmd "highlight link WinSeparator Normal"
end
