vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "qf", "help", "man", "lspinfo", "spectre_panel" },
  callback = function()
    vim.cmd [[
      nnoremap <silent> <buffer> q :close<CR>
      set nobuflisted
    ]]
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})
-- Automatically close tab/vim when nvim-tree is the last window in the tab
-- vim.cmd "autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif"

vim.api.nvim_create_autocmd({ "VimResized" }, {
  callback = function()
    vim.cmd "tabdo wincmd ="
  end,
})

vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  callback = function()
    vim.highlight.on_yank { higroup = "Visual", timeout = 200 }
  end,
})

vim.api.nvim_create_autocmd("Colorscheme", {
  callback = function()
    local colors = vim.g.colors_name
    if vim.startswith(colors, "catppuccin") then
      colors = "catppuccin"
    end
    local require_ok, opts = pcall(require, "user.plugins.colors." .. colors)
    if not require_ok then
      vim.schedule(function()
        require("lualine").setup {
          options = {
            theme = "auto",
          },
        }
      end)
    end
    vim.cmd "hi! link PmenuSel lualine_a_insert"
    vim.cmd "hi! link NormalNC NvimTreeNormal"
    vim.cmd "hi! link NvimTreeWinSeparator TelescopeBorder"
    vim.cmd "hi! link NvimTreeWindowPicker lualine_a_command"
    vim.cmd "hi! link FloatBorder Normal"
  end,
})

vim.cmd [[autocmd User TelescopeFindPre hi! link NormalNC Normal]]
vim.api.nvim_create_autocmd({ "BufLeave", "BufWinLeave" }, {
  callback = function(event)
    if vim.bo[event.buf].filetype == "TelescopePrompt" then
      vim.cmd "hi! link NormalNC NvimTreeNormal"
    end
  end,
})

vim.cmd [[autocmd User AlphaReady set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2]]
