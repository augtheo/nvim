local M = {}

local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_cmp_ok then
  return
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities = cmp_nvim_lsp.default_capabilities(M.capabilities)
M.capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}
M.setup = function()
  local signs = {

    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignHint", text = "" },
    { name = "DiagnosticSignInfo", text = "" },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end

  local config = {
    virtual_text = {
      severity = { min = vim.diagnostic.severity.WARN },
    },
    signs = {
      active = signs, -- show signs
    },
    update_in_insert = true,
    underline = true,
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
end

local function lsp_keymaps(bufnr)
  local opts = function(description)
    return { noremap = true, silent = true, desc = description }
  end
  local keymap = vim.api.nvim_buf_set_keymap
  --lsp navigation
  keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts "Go to declaration")
  keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts "Go to definition")
  keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts "Hover")
  keymap(bufnr, "n", "gI", "<cmd>Telescope lsp_implementations<cr>", opts "Implementations")
  keymap(bufnr, "n", "gr", "<cmd>Telescope lsp_references<cr>", opts "References")
  keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts "Diagnostics")
  keymap(bufnr, "n", "gt", "<cmd>Telescope lsp_type_definitions<cr>", opts "Goto Type Definition")
  --lsp capabilities
  keymap(bufnr, "n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts "Code Actions")
  keymap(bufnr, "n", "<leader>ll", "<cmd>lua vim.lsp.codelens.run()<cr>", opts "CodeLens")
  keymap(bufnr, "n", "<leader>lf", "<cmd>lua vim.lsp.buf.format{async=true}<cr>", opts "Format")
  keymap(bufnr, "n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts "Signature Help")
  keymap(bufnr, "n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", opts "Rename")
end

M.on_attach = function(client, bufnr)
  if client.name == "tsserver" then
    client.server_capabilities.documentFormattingProvider = false
  end

  lsp_keymaps(bufnr)
  local status_ok, illuminate = pcall(require, "illuminate")
  if not status_ok then
    return
  end
  illuminate.on_attach(client)
end

return M
