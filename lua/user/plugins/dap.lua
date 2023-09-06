local dap_status_ok, dap = pcall(require, "dap")
if not dap_status_ok then
  return
end
vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticSignError", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointCondition", { text = "", texthl = "DiagnosticSignError", linehl = "", numhl = "" })
vim.fn.sign_define("DapLogPoint", { text = "", texthl = "DiagnosticSignInfo", linehl = "", numhl = "" })

local dap_ui_status_ok, dapui = pcall(require, "dapui")
if not dap_ui_status_ok then
  return
end
dapui.setup {
  expand_lines = true,
  icons = { expanded = "", collapsed = "", circular = "" },
  mappings = {
    -- Use a table to apply multiple mappings
    expand = { "<CR>", "<2-LeftMouse>" },
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
    toggle = "t",
  },
  layouts = {
    {
      elements = {
        { id = "scopes",      size = 0.33 },
        { id = "breakpoints", size = 0.17 },
        { id = "stacks",      size = 0.25 },
        { id = "watches",     size = 0.25 },
      },
      size = 0.33,
      position = "right",
    },
    {
      elements = {
        { id = "repl",    size = 0.45 },
        { id = "console", size = 0.55 },
      },
      size = 0.27,
      position = "bottom",
    },
  },
  controls = {
    enabled = false,
  },
  floating = {
    max_height = 0.9,
    max_width = 0.5,             -- Floats will be treated as percentage of your screen.
    border = vim.g.border_chars, -- Border style. Can be 'single', 'double' or 'rounded'
    mappings = {
      close = { "q", "<Esc>" },
    },
  },
}
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end

dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end

dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

local tele_status_ok, telescope = pcall(require, "telescope")
if not tele_status_ok then
  return
end

telescope.load_extension "dap"

local keymap = vim.keymap.set

keymap("n", "<leader>db", "<cmd>DapToggleBreakpoint<cr>", { desc = "Toggle Breakpoint" })
keymap(
  "n",
  "<leader>dB",
  "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint Condition: '))<cr>",
  { desc = "Conditional breakpoint" }
)
keymap('n', '<leader>dp', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end , {desc = "Logpoint"})
keymap("n", "<leader>dc", "<cmd>DapContinue<cr>", { desc = "Continue" })
keymap("n", "<leader>di", "<cmd>DapStepInto<cr>", { desc = "Step Into" })
keymap("n", "<leader>do", "<cmd>DapStepOver<cr>", { desc = "Step Over" })
keymap("n", "<leader>dO", "<cmd>DapStepOut<cr>", { desc = "Step Out" })
keymap("n", "<leader>dr", "<cmd>DapToggleRepl<cr>", { desc = "Toggle Repl" })
keymap("n", "<leader>dt", "<cmd>DapTerminate<cr>", { desc = "Terminate" })
keymap("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>", { desc = "Run Last" })
keymap("n", "<leader>du", "<cmd>lua require'dapui'.toggle()<cr>", { desc = "Toggle UI" })
