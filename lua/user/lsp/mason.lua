require("mason").setup()

local servers = {
  "bashls",
  "lua_ls",
  "jsonls",
  "yamlls",
  "clangd",
  "rust_analyzer",
  "gopls",
  "pyright",
  "html",
  "cssls",
  "tsserver",
}

local lspconfig = require "lspconfig"

for _, server in pairs(servers) do
  local opts = {
    on_attach = require("user.lsp.handlers").on_attach,
    capabilities = require("user.lsp.handlers").capabilities,
  }
  local require_ok, conf_opts = pcall(require, "user.lsp.settings." .. server)
  if require_ok then
    opts = vim.tbl_deep_extend("force", conf_opts, opts)
  end

  lspconfig[server].setup(opts)
end
