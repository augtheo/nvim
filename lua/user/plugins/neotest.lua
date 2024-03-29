require("neotest").setup {
  floating = {
    border = "single",
  },
  adapters = {
    require "neotest-java",
    require "neotest-python" {
      dap = {
        justMyCode = false,
        console = "integratedTerminal",
      },
      args = { "--log-level", "DEBUG", "--quiet" },
      runner = "pytest",
    },
  },
}
