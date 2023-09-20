local icons = {
  diagnostics = require("user.icons").diagnostics,
}
local signs = {

  { name = "DiagnosticSignError", text = icons.diagnostics.Error },
  { name = "DiagnosticSignWarn", text = icons.diagnostics.Warn },
  { name = "DiagnosticSignHint", text = icons.diagnostics.Hint },
  { name = "DiagnosticSignInfo", text = icons.diagnostics.Info },
}

for _, sign in ipairs(signs) do
  vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end

local config = {
  virtual_text = {
    severity = { min = vim.diagnostic.severity.WARN },
  },
  signs = {
    active = signs,
  },
  update_in_insert = true,
  underline = false,
  severity_sort = true,
  float = {
    focusable = true,
    style = "minimal",
    source = "always",
    header = "",
    prefix = "",
  },
}

vim.diagnostic.config(config)
