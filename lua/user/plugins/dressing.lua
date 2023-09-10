require("dressing").setup {
  input = {
    -- These are passed to nvim_open_win
    border = "single",
  },
  select = {
    -- Options for nui Menu
    nui = {
      border = {
        style = "single",
      },
    },

    -- Options for built-in selector
    builtin = {
      -- Display numbers for options and set up keymaps
      show_numbers = true,
      -- These are passed to nvim_open_win
      border = "single",
    },
  },
}
