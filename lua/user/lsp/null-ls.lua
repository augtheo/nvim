local null_ls = require "null-ls"

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

-- https://github.com/prettier-solidity/prettier-plugin-solidity
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
null_ls.setup {
  debug = false,
  sources = {
    formatting.prettierd,

    -- lua
    formatting.stylua,

    -- java
    formatting.google_java_format,

    -- python
    formatting.black.with { extra_args = { "--fast" } },
    formatting.isort,
    diagnostics.flake8.with { extra_args = { "--max-line-length", "88" } },

    -- cpp
    -- diagnostics.cpplint,
  },
  on_attach = function(client, bufnr)
    if client.supports_method "textDocument/formatting" then
      vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format { async = false }
        end,
      })
    end
  end,
}

-- required for cpplint https://github.com/jose-elias-alvarez/null-ls.nvim/issues/428
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities.offsetEncoding = { "utf-16" }
-- require("lspconfig").clangd.setup { capabilities = capabilities }
