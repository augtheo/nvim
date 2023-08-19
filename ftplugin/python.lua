local neotest_setup = function()
  require("neotest").setup {
    floating = {
      border = "single",
    },
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
end

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
    neotest_setup()
  end,
}

neotest_setup()

vim.keymap.set("n", "<leader>LC", "<cmd>lua require('swenv.api').pick_venv()<cr>", { desc = "Choose Env" })
