require("neotest").setup {
  adapters = {
    require "neotest-python" {
      -- Extra arguments for nvim-dap configuration
      -- See https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for values
      dap = {
        justMyCode = false,
        console = "integratedTerminal",
      },
      args = { "--log-level", "DEBUG", "--quiet" },
      runner = "pytest",
    },
  },
}

require("swenv").setup {
  -- Should return a list of tables with a `name` and a `path` entry each.
  -- Gets the argument `venvs_path` set below.
  -- By default just lists the entries in `venvs_path`.
  get_venvs = function(venvs_path)
    return require("swenv.api").get_venvs(venvs_path)
  end,
  -- Path passed to `get_venvs`.
  venvs_path = vim.fn.expand "~/envs",
  -- Something to do after setting an environment, for example call vim.cmd.LspRestart
  post_set_venv = function()
    vim.cmd "LspRestart"
  end,
}

local home = os.getenv "HOME"

require("dap-python").setup(home .. "/.local/share/nvim/mason/packages/debugpy/venv/bin/python")

-- python specific which key mappings
local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end
--
local opts = {
  mode = "n", -- NORMAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
  L = {
    name = "python 🐍",
    C = {
      "<cmd>lua require('swenv.api').pick_venv()<cr>",
      "Choose Env",
    },
    t = {
      name = "Test",
      m = {
        "<cmd>lua require('neotest').run.run()<cr>",
        "Test Method",
      },
      M = { "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>", "Test Method DAP" },
      f = {
        "<cmd>lua require('neotest').run.run({vim.fn.expand('%')})<cr>",
        "Test Class",
      },
      F = {
        "<cmd>lua require('neotest').run.run({vim.fn.expand('%'), strategy = 'dap'})<cr>",
        "Test Class DAP",
      },
      S = { "<cmd>lua require('neotest').summary.toggle()<cr>", "Test Summary" },
    },
  },
}

-- TODO: Move generic neotest keybindings outside

which_key.register(mappings, opts)
which_key.register(vmappings, vopts)
--
