require("git-worktree").setup {}
-- require("telescope").load_extension "git_worktree"
local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end
telescope.load_extension "git_worktree"
