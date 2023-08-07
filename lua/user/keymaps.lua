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
keymap("n", "<C-h>", "<C-w>h", opts {})
keymap("n", "<C-j>", "<C-w>j", opts {})
keymap("n", "<C-k>", "<C-w>k", opts {})
keymap("n", "<C-l>", "<C-w>l", opts {})

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts "Horizontal resize Decrease")
keymap("n", "<C-Down>", ":resize +2<CR>", opts "Horizontal resize Increase")
keymap("n", "<C-Left>", ":vertical resize +2<CR>", opts "Vertical resize Increase")
keymap("n", "<C-Right>", ":vertical resize -2<CR>", opts "Vertical resize Decrease")

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts {})
keymap("n", "<S-h>", ":bprevious<CR>", opts {})

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
-- Plugins --
-- UFO
-- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
-- keymap('n', 'zR', "<cmd>lua require('ufo').openAllFolds<CR>" , opts{}) keymap('n', 'zM', "<cmd>lua require('ufo').closeAllFolds<CR>" , opts)
--
