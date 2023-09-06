local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
  return
end

toggleterm.setup {
  size = 20,
  open_mapping = [[<c-\>]],
  hide_numbers = true,
  shade_terminals = true,
  shading_factor = 2,
  start_in_insert = true,
  insert_mappings = true,
  persist_size = true,
  direction = "float",
  close_on_exit = true,
  shell = vim.o.shell,
  float_opts = {
    -- border = "curved",
  },
}

function _G.set_terminal_keymaps()
  local opts = { noremap = true }
  -- vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
  vim.api.nvim_buf_set_keymap(0, "t", "<C-h>", [[<C-\><C-n><C-W>h]], opts)
  vim.api.nvim_buf_set_keymap(0, "t", "<C-j>", [[<C-\><C-n><C-W>j]], opts)
  vim.api.nvim_buf_set_keymap(0, "t", "<C-k>", [[<C-\><C-n><C-W>k]], opts)
  vim.api.nvim_buf_set_keymap(0, "t", "<C-l>", [[<C-\><C-n><C-W>l]], opts)
end

vim.cmd "autocmd! TermOpen term://* lua set_terminal_keymaps()"

local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new { cmd = "lazygit", hidden = true }
local lazydocker = Terminal:new { cmd = "lazydocker", hidden = true }
local python = Terminal:new { cmd = "python", hidden = true }

function _LAZYGIT_TOGGLE()
  lazygit:toggle()
end

function _LAZYDOCKER_TOGGLE()
  lazydocker:toggle()
end

function _PYTHON_TOGGLE()
  python:toggle()
end

-- Shorten function name
local keymap = vim.keymap.set

keymap("n", "<leader>\\s", "<cmd>TermSelect<CR>", { desc = "Term Select" })
keymap("n", "<leader>\\f", "<cmd>ToggleTerm direction=float<cr>", { desc = "Float" })
keymap("n", "<leader>\\p", "<cmd>lua _PYTHON_TOGGLE()<cr>", { desc = "Python" })
keymap("n", "<leader>\\h", "<cmd>ToggleTerm size=10 direction=horizontal<cr>", { desc = "Horizontal" })
keymap("n", "<leader>\\v", "<cmd>ToggleTerm size=80 direction=vertical<cr>", { desc = "Vertical" })
keymap("n", "<leader>\\d", "<cmd>lua _LAZYDOCKER_TOGGLE()<cr>", { desc = "Lazydocker" })
keymap("n", "<leader>\\g", "<cmd>lua _LAZYGIT_TOGGLE()<cr>", { desc = "Lazygit" })
