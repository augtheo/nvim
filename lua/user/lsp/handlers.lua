local M = {}

local lsp_keymaps = function(bufnr)
  local opts = function(description)
    return { noremap = true, silent = true, desc = description }
  end
  local keymap = vim.api.nvim_buf_set_keymap

  -- stylua: ignore start
  --
  --lsp navigation
  keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts "Go to declaration")
  keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts "Go to definition")
  keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts "Hover")
  keymap(bufnr, "n", "gI", "<cmd>Telescope lsp_implementations path_display={'smart'} show_line=false<cr>", opts "Implementations" )
  keymap(bufnr, "n", "gr", "<cmd>Telescope lsp_references path_display={'smart'} show_line=false<cr>", opts "References" )
  keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float({border='single'})<CR>", opts "Diagnostics")
  keymap(bufnr, "n", "gt", "<cmd>Telescope lsp_type_definitions<cr>", opts "Goto Type Definition")
  --lsp capabilities
  keymap(bufnr, "n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts "Code Actions")
  keymap(bufnr, "n", "<leader>ll", "<cmd>lua vim.lsp.codelens.run()<cr>", opts "CodeLens")
  keymap(bufnr, "n", "<leader>lf", "<cmd>lua vim.lsp.buf.format{async=true}<cr>", opts "Format")
  keymap(bufnr, "n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts "Signature Help")
  keymap(bufnr, "n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", opts "Rename")
  --lsp workspaces
  keymap(bufnr, "n", "<leader>lwa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>", opts "Add Workspace folder")
  keymap(bufnr, "n", "<leader>lwr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>", opts "Remove Workspace folder" )
  keymap(bufnr, "n", "<leader>lwl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders())) <cr>", opts "List Workspace folders")

  -- stylua: ignore end

  local which_key_opts = {
    mode = "n", -- NORMAL mode
    prefix = "<leader>",
    buffer = bufnr, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true, -- use `nowait` when creating keymaps
  }
  local mappings = {
    ["l"] = "+lsp",
    ["lw"] = "+workspace",
  }

  require("which-key").register(mappings, which_key_opts)
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
