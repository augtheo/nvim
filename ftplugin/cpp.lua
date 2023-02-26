-- TODO: Fix instant run currently compiled
-- local Terminal = require("toggleterm.terminal").Terminal
-- local cur = Terminal:new { cmd = "%:r"  }
--
-- function _RUN_CURRENT_TOGGLE()
--   cur:toggle()
-- end

local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end

local opts = {
  mode = "n", -- NORMAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
  L = {
    name = "CPP ",
    c = {
      "<Cmd>!g++ % -o %:r <CR>" , "Compile"
    },
    b = {
      "<Cmd>!g++ -Wall -Wextra -pedantic -std=c++17 -O2 -Wshadow -Wformat=2 -Wfloat-equal -Wconversion -Wlogical-op -Wshift-overflow=2 -Wduplicated-cond -Wcast-qual -Wcast-align -D_GLIBCXX_DEBUG -D_GLIBCXX_DEBUG_PEDANTIC -D_FORTIFY_SOURCE=2 -fsanitize=address -fsanitize=undefined -fno-sanitize-recover -fstack-protector %  -o %:r <CR>",
      "Check & Compile",
    }, -- https://codeforces.com/blog/entry/15547
    -- r = { "<cmd> lua _RUN_CURRENT_TOGGLE() <CR>" , "Run"},
    i = { "<Cmd>!%:r < input.txt > output.txt <CR>", "Run with input" },
    d = { "<Cmd>! diff output.txt expected.txt<CR>", "Compare" },
  }
}

which_key.register(mappings, opts)
