-- Shorten function name
local keymap = vim.keymap.set
-- Silent keymap option
-- local opts{}= { silent = true }

local opts = function(description)
  return {
    silent = true,
    desc = description,
  }
end

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts {})
vim.g.mapleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal ----------------------------------------------------------
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts "Go to left window")
keymap("n", "<C-j>", "<C-w>j", opts "Go to lower window")
keymap("n", "<C-k>", "<C-w>k", opts "Go to upper window")
keymap("n", "<C-l>", "<C-w>l", opts "Go to right window")

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts "Horizontal resize Decrease")
keymap("n", "<C-Down>", ":resize +2<CR>", opts "Horizontal resize Increase")
keymap("n", "<C-Left>", ":vertical resize +2<CR>", opts "Vertical resize Increase")
keymap("n", "<C-Right>", ":vertical resize -2<CR>", opts "Vertical resize Decrease")

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts "Next buffer")
keymap("n", "<S-h>", ":bprevious<CR>", opts "Prev buffer")

-- Close buffers
keymap("n", "<S-q>", "<cmd>bdelete!<CR>", opts "Quit")

-- Better scroll
keymap("n", "<C-d>", "<C-d>zz", opts {})
keymap("n", "<C-u>", "<C-u>zz", opts {})

-- Move text up and down
keymap("n", "<A-j>", ":m .+1<CR>==", opts {})
keymap("n", "<A-k>", ":m .-2<CR>==", opts {})

-- Insert ---------------------------------------------------------
-- Press jk fast to enter
keymap("i", "jk", "<ESC>", opts {})

keymap("i", "<A-j>", "<Esc>:m .+1<CR>==gi", opts {})
keymap("i", "<A-k>", "<Esc>:m .-2<CR>==gi", opts {})

-- Visual ---------------------------------------------------------
-- Better paste
keymap("v", "p", '"_dP', opts {})

-- Stay in indent mode
keymap("v", "<", "<gv", opts {})
keymap("v", ">", ">gv", opts {})

-- Move text up and down
keymap("v", "<A-j>", ":m '>+1<CR>gv=gv", opts {})
keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", opts {})

-- Git
keymap("n", "g[", "<cmd>diffget //2<CR>", opts "Accept Left")
keymap("n", "g]", "<cmd>diffget //3<CR>", opts "Accept Right")

-- tabs
keymap("n", "<leader><tab>l", "<cmd>tablast<cr>", opts "Last Tab")
keymap("n", "<leader><tab>f", "<cmd>tabfirst<cr>", opts "First Tab")
keymap("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", opts "New Tab")
keymap("n", "<leader><tab>]", "<cmd>tabnext<cr>", opts "Next Tab")
keymap("n", "<leader><tab>d", "<cmd>tabclose<cr>", opts "Close Tab")
keymap("n", "<leader><tab>[", "<cmd>tabprevious<cr>", opts "Previous Tab")

-- Neotest
--
keymap("n", "<leader>mr", "<cmd>lua require('neotest').run.run()<cr>", { desc = "Test Method" })
keymap("n", "<leader>md", "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>", { desc = "Test Method DAP" })
keymap("n", "<leader>mf", "<cmd>lua require('neotest').run.run({vim.fn.expand('%')})<cr>", { desc = "Test Class" })

keymap(
  "n",
  "<leader>mF",
  "<cmd>lua require('neotest').run.run({vim.fn.expand('%'), strategy = 'dap'})<cr>",
  { desc = "Test Class DAP" }
)
keymap("n", "<leader>ms", "<cmd>lua require('neotest').summary.toggle()<cr>", { desc = "Test Summary" })

-- ui
keymap("n", "<leader>uh", "<cmd>nohlsearch<cr>", { desc = "Stop Highlights" })
keymap("n", "<leader>un", "<cmd>NoiceDismiss<cr>", { desc = "Dismiss Noice" })

-- persistence
keymap("n", "<leader>qq", "<cmd>q!<CR>", { desc = "Quit" })
keymap("n", "<leader>qs", "<cmd>lua require('persistence').load()<cr>", { desc = "Restore Session" })
keymap(
  "n",
  "<leader>ql",
  "<cmd>lua require('persistence').load({ last = true })<cr>",
  { desc = "Restore Last Session" }
)
keymap("n", "<leader>qd", "<cmd>lua require('persistence').stop()<cr>", { desc = "Don't Save Current Session" })
