require("git-worktree").setup {}
local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end
telescope.load_extension "git_worktree"

local keymap = vim.keymap.set

keymap("n", "<leader>gwc", "<cmd>Telescope git_worktree create_git_worktree<CR>", { desc = "Create worktree" })
keymap("n", "<leader>gws", "<cmd>Telescope git_worktree git_worktrees<CR>", { desc = "Switch worktree" })
