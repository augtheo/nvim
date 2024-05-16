local which_key = require "which-key"

local setup = {
  layout = {
    align = "center", -- align columns left, center or right
  },
}

local opts = {
  mode = "n", -- NORMAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
  ["<tab>"] = { name = "+tabs" },
  ["s"] = { name = "+search" },
  ["\\"] = { name = "+terminal" },
  ["u"] = { name = "+ui" },
  ["f"] = { name = "+find" },
  ["t"] = { name = "+test" },
  ["q"] = { name = "+quit/session" },
  ["d"] = { name = "+debug" },
  ["g"] = { name = "+git" },
  ["gw"] = { name = "+worktrees" },
}

which_key.setup(setup)
which_key.register(mappings, opts)
