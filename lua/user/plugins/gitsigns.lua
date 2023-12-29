local gitsigns = require "gitsigns"

gitsigns.setup {
  -- stylua: ignore start
  signs = {
    add          = { hl   = "GitSignsAdd",    text = "│",  numhl = "GitSignsAddNr",    linehl = "GitSignsAddLn"    },
    change       = { hl   = "GitSignsChange", text = "│",  numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
    delete       = { hl   = "GitSignsDelete", text = "契", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
    topdelete    = { hl   = "GitSignsDelete", text = "契", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
    changedelete = { hl   = "GitSignsChange", text = "│",  numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
    untracked    = { text = "│" },
    -- stylua: ignore end
  },
  preview_config = {
    -- Options passed to nvim_open_win
    border = "single",
    style = "minimal",
    relative = "cursor",
    row = 0,
    col = 1,
  },
}

local keymap = vim.keymap.set
-- stylua: ignore start
keymap("n", "]g", "<cmd>lua require 'gitsigns'.next_hunk()<cr>",               { desc = "Next Hunk" })
keymap("n", "[g", "<cmd>lua require 'gitsigns'.prev_hunk()<cr>",               { desc = "Prev Hunk" })
keymap("n", "<leader>gl", "<cmd>lua require 'gitsigns'.blame_line()<cr>",      { desc = "Blame" })
keymap("n", "<leader>gp", "<cmd>lua require 'gitsigns'.preview_hunk()<cr>",    { desc = "Preview Hunk" })
keymap("n", "<leader>gr", "<cmd>lua require 'gitsigns'.reset_hunk()<cr>",      { desc = "Reset Hunk" })
keymap("n", "<leader>gR", "<cmd>lua require 'gitsigns'.reset_buffer()<cr>",    { desc = "Reset Buffer" })
keymap("n", "<leader>gs", "<cmd>lua require 'gitsigns'.stage_hunk()<cr>",      { desc = "Stage Hunk" })
keymap("n", "<leader>gu", "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", { desc = "Undo Stage Hunk" })
keymap("n", "<leader>gd", "<cmd>Gitsigns diffthis HEAD<cr>",                   { desc = "Diff" })
-- stylua: ignore end
