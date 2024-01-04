local M = {}

local lsp_keymaps = function(bufnr)
  local opts = function(description)
    return { noremap = true, silent = true, desc = description, buffer = bufnr }
  end
  local keymap = vim.keymap.set
  -- stylua: ignore start
  --
  --lsp navigation
  keymap("n"      , "gD",          "<cmd>lua vim.lsp.buf.declaration()<CR>",                                        opts "Go to declaration")
  keymap("n"      , "gd",          "<cmd>lua vim.lsp.buf.definition()<CR>",                                         opts "Go to definition")
  keymap("n"      , "K",           "<cmd>lua vim.lsp.buf.hover()<CR>",                                              opts "Hover")
  keymap("n"      , "gI",          "<cmd>Telescope lsp_implementations path_display={'smart'} show_line=false<cr>", opts "Implementations" )
  keymap("n"      , "gr",          "<cmd>Telescope lsp_references path_display={'smart'} show_line=false<cr>",      opts "References" )
  keymap("n"      , "gl",          "<cmd>lua vim.diagnostic.open_float({border='single'})<CR>",                     opts "Diagnostics")
  keymap("n"      , "gp",          "<cmd>Telescope lsp_type_definitions<cr>",                                       opts "Goto Type Definition")
  --lsp capabilities
  keymap("n"      , "<leader>la",  "<cmd>lua vim.lsp.buf.code_action()<cr>",                                        opts "Code Actions")
  keymap("n"      , "<leader>ll",  "<cmd>lua vim.lsp.codelens.run()<cr>",                                           opts "CodeLens")
  keymap({"n","v"}, "<leader>lf",  "<cmd>lua vim.lsp.buf.format{async=true}<cr>",                                   opts "Format")
  keymap("n"      , "<leader>lh",  "<cmd>lua vim.lsp.buf.signature_help()<cr>",                                     opts "Signature Help")
  keymap("n"      , "<leader>lr",  "<cmd>lua vim.lsp.buf.rename()<cr>",                                             opts "Rename")
  keymap("n"      , "<leader>ls",  "<cmd>Telescope lsp_document_symbols<cr>",                                       opts "Document Symbols")
  keymap("n"      , "<leader>lS",  "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",                              opts "Workspace Symbols")
  -- diagnostics
  keymap("n"      , "<leader>ld",  "<cmd>Telescope diagnostics bufnr=0<cr>",                                        opts "Document Diagnostics")
  keymap("n"      , "<leader>lD",  "<cmd>Telescope diagnostics<cr>",                                                opts "Workspace Diagnostics")
  --lsp workspaces
  keymap("n"      , "<leader>lwa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>",                               opts "Add Workspace folder")
  keymap("n"      , "<leader>lwr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>",                            opts "Remove Workspace folder" )
  keymap("n"      , "<leader>lwl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders())) <cr>",        opts "List Workspace folders")

  -- stylua: ignore end

  vim.schedule(function()
    local which_key_opts = {
      mode = "n",
      prefix = "<leader>",
      buffer = bufnr,
    }
    local mappings = {
      ["l"] = "+lsp",
      ["lw"] = "+workspace",
    }
    require("which-key").register(mappings, which_key_opts)
    local which_key_opts_v = {
      mode = "v",
      prefix = "<leader>",
      buffer = bufnr,
    }
    local mappings_v = {
      ["l"] = "+lsp",
    }
    require("which-key").register(mappings_v, which_key_opts_v)
  end)
end

M.on_attach = function(client, bufnr)
  -- NOTE: Server formatting is disabled only for servers that support formatting
  if client.name == "tsserver" then
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  elseif client.name == "lua_ls" then
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  elseif client.supports_method "textDocument/formatting" then
    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
    vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format { async = false }
      end,
    })
  end

  lsp_keymaps(bufnr)
end

return M
