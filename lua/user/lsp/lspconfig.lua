require "user.lsp.diagnostic"

local servers = {
  "bashls",
  "clangd",
  "cssls",
  "gopls",
  "html",
  "jsonls",
  "lua_ls",
  "pyright",
  "rust_analyzer",
  "tsserver",
  "yamlls",
}

require("lspconfig.ui.windows").default_options = { border = "single" }
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Folding
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}

for _, server in pairs(servers) do
  local opts = {
    on_attach = require("user.lsp.handlers").on_attach,
    capabilities = capabilities,
  }
  local require_ok, conf_opts = pcall(require, "user.lsp.settings." .. server)
  if require_ok then
    opts = vim.tbl_deep_extend("force", conf_opts, opts)
  end

  require("lspconfig")[server].setup(opts)
end
