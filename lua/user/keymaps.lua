local keymap = vim.keymap.set -- Shorten function name

local opts = function(description)
  return {
    silent = true,
    desc = description,
  }
end
-- Modes
-- normal_mode       = "n",
-- insert_mode       = "i",
-- visual_mode       = "v",
-- visual_block_mode = "x",
-- term_mode         = "t",
-- command_mode      = "c",

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts "")
vim.g.mapleader = " "

-- Resize Windows
keymap("n", "<M-o>", ":vertical resize +10<CR>", opts "Vertical resize Increase")
keymap("n", "<M-i>", ":vertical resize -10<CR>", opts "Vertical resize Decrease")

-- Close buffers
keymap("n", "<S-q>", "<cmd>bdelete!<CR>", opts "Quit")

-- Better scroll
keymap("n", "<C-d>", "<C-d>zz", opts "")
keymap("n", "<C-u>", "<C-u>zz", opts "")
keymap("n", "n", "nzz", opts "")
keymap("n", "N", "Nzz", opts "")
keymap("n", "*", "*zz", opts "")
keymap("n", "#", "#zz", opts "")
keymap("n", "g*", "g*zz", opts "")
keymap("n", "g#", "g#zz", opts "")

-- Move text up and down
keymap("n", "<A-j>", ":m .+1<CR>==", opts "")
keymap("n", "<A-k>", ":m .-2<CR>==", opts "")

-- Press jk fast to enter
keymap("i", "jk", "<ESC>", opts "")

keymap("i", "<A-j>", "<Esc>:m .+1<CR>==gi", opts "")
keymap("i", "<A-k>", "<Esc>:m .-2<CR>==gi", opts "")

-- Better paste
keymap("v", "p", '"_dP', opts "")

-- Stay in indent mode
keymap("v", "<", "<gv", opts "")
keymap("v", ">", ">gv", opts "")

-- Move text up and down
keymap("v", "<A-j>", ":m '>+1<CR>gv=gv", opts "")
keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", opts "")

-- Git
keymap("n", "g[", "<cmd>diffget //2<CR>", opts "Accept Left")
keymap("n", "g]", "<cmd>diffget //3<CR>", opts "Accept Right")

-- Neotest
--
keymap("n", "<leader>tr", "<cmd>lua require('neotest').run.run()<cr>", opts "Test Method")
keymap("n", "<leader>td", "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>", opts "Test Method DAP")
keymap("n", "<leader>tf", "<cmd>lua require('neotest').run.run({vim.fn.expand('%')})<cr>", opts "Test Class")

keymap(
  "n",
  "<leader>tF",
  "<cmd>lua require('neotest').run.run({vim.fn.expand('%'),strategy = 'dap'})<cr>",
  opts "Test Class DAP"
)
keymap("n", "<leader>ts", "<cmd>lua require('neotest').summary.toggle()<cr>", opts "Test Summary")

-- ui
keymap("n", "<leader>uh", "<cmd>nohlsearch<cr>", opts "Stop Highlights")
keymap("n", "<leader>un", "<cmd>NoiceDismiss<cr>", opts "Dismiss Noice")
keymap("n", "<leader>ud", require("user.utils").toggle_diagnostics, opts "Toggle Diagnostics")
keymap("n", "<leader>us", function()
  require("user.utils").toggle "spell"
end, opts "Toggle Spelling")
keymap("n", "<leader>uc", function()
  require("telescope.builtin").colorscheme()
end, opts "Switch Colorscheme")
keymap("n", "<leader>uw", function()
  require("user.utils").toggle "wrap"
end, opts "Toggle Word Wrap")

-- persistence
keymap("n", "<leader>qo", "<cmd>%bd!|e#<cr>", opts "Close all other Buffers")
keymap("n", "<leader>qq", "<cmd>confirm q<CR>", opts "Quit")
keymap("n", "<leader>qa", "<cmd>confirm qa<CR>", opts "Quit all")
keymap("n", "<leader>qs", "<cmd>lua require('persistence').load()<cr>", opts "Restore Session")
keymap("n", "<leader>ql", "<cmd>lua require('persistence').load({ last = true })<cr>", opts "Restore Last Session")
keymap("n", "<leader>qd", "<cmd>lua require('persistence').stop()<cr>", opts "Don't Save Current Session")

keymap("n", "<leader>a", "<cmd>Alpha<cr>", opts "alpha")
-- keymap("n", "<leader>w",          "<cmd>w!<CR>",                                                                    opts "save")
-- keymap("c", "w!!",                "w !sudo tee > /dev/null %",                                                      opts "Write as Sudo")
keymap("n", "<leader>x", "<cmd>lua require 'user.utils'.run_code() <CR>", opts "exec")
