local dap = require "dap"

local icons = {
  dap = require("user.icons").dap,
}

for name, sign in pairs(icons.dap) do
  vim.fn.sign_define("Dap" .. name, { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = "", numhl = "" })
end

local dapui = require "dapui"

dapui.setup {
  expand_lines = false,
  controls = {
    enabled = false,
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

require("telescope").load_extension "dap"

local keymap = vim.keymap.set


-- stylua: ignore start
keymap("n", "<leader>db", "<cmd>DapToggleBreakpoint<cr>",                                                            { desc = "Toggle Breakpoint" })
keymap("n", "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input "Breakpoint Condition: ") end,       { desc = "Conditional breakpoint" })
keymap("n", "<leader>dl", function() require("dap").set_breakpoint(nil, nil, vim.fn.input "Log point message: ") end,{ desc = "Logpoint" })
keymap("n", "<leader>dc", "<cmd>DapContinue<cr>",                                                                    { desc = "Continue" })
keymap("n", "<leader>dC", function() require("dap").run_to_cursor() end,                                             { desc = "Run to Cursor" })
keymap("n", "<leader>dp", function() require("dap").pause() end,                                                     { desc = "Pause" })
keymap("n", "<leader>di", "<cmd>DapStepInto<cr>",                                                                    { desc = "Step Into" })
keymap("n", "<leader>do", "<cmd>DapStepOver<cr>",                                                                    { desc = "Step Over" })
keymap("n", "<leader>dO", "<cmd>DapStepOut<cr>",                                                                     { desc = "Step Out" })
keymap("n", "<leader>dr", "<cmd>DapToggleRepl<cr>",                                                                  { desc = "Toggle Repl" })
keymap("n", "<leader>dt", "<cmd>DapTerminate<cr>",                                                                   { desc = "Terminate" })
keymap("n", "<leader>dL", "<cmd>lua require'dap'.run_last()<cr>",                                                    { desc = "Run Last" })
keymap("n", "<leader>du", "<cmd>lua require'dapui'.toggle()<cr>",                                                    { desc = "Toggle UI" })

-- telescope
keymap("n", "<leader>sB", "<cmd>Telescope dap list_breakpoints path_display={'smart'} show_line=false<CR>",          { desc = "Breakpoints" })
-- stylua: ignore end
