require("dressing").setup {
  input = {
    -- These are passed to nvim_open_win
    border = "single",
  },
  select = {
    telescope = require("user.plugins.telescope").customDropDownOpts,
    -- Options for built-in selector
    builtin = {
      -- Display numbers for options and set up keymaps
      show_numbers = true,
      -- These are passed to nvim_open_win
      border = "single",
    },
  },
}
