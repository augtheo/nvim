local which_key = require "which-key"

which_key.setup {
  preset = "helix",
  win = {
    border = "single",
  },
}
which_key.add {
  {
    "<leader>m",
    group = "buffers",
    expand = function()
      return require("which-key.extras").expand.buf()
    end,
  },
  { "<leader><tab>", group = "tabs", nowait = true, remap = false },
  { "<leader>\\", group = "terminal", nowait = true, remap = false },
  { "<leader>d", group = "debug", nowait = true, remap = false },
  { "<leader>f", group = "find", nowait = true, remap = false },
  { "<leader>g", group = "git", nowait = true, remap = false },
  { "<leader>gw", group = "worktrees", nowait = true, remap = false },
  { "<leader>q", group = "quit/session", nowait = true, remap = false },
  { "<leader>s", group = "search", nowait = true, remap = false },
  { "<leader>t", group = "test", nowait = true, remap = false },
  { "<leader>u", group = "ui", nowait = true, remap = false },
}
