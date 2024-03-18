local dap = require "dap"
dap.adapters.cppdbg = {
  id = "cppdbg",
  type = "executable",
  -- command = vim.fn.expand "$MASON/packages/cpptools/extension/debugAdapters/bin/OpenDebugAD7",
  command = "OpenDebugAD7",
}
dap.configurations.cpp = {
  {
    name = "Launch file",
    type = "cppdbg",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopAtEntry = true,
  },
  {
    name = "Attach to gdbserver :1234",
    type = "cppdbg",
    request = "launch",
    MIMode = "gdb",
    miDebuggerServerAddress = "localhost:1234",
    -- miDebuggerPath = "/usr/bin/gdb",
    miDebuggerPath = "gdb",
    cwd = "${workspaceFolder}",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
  },
}
