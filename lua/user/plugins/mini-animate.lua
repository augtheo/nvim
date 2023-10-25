require("mini.animate").setup {
  cursor = {
    enable = false,
  },
}

vim.keymap.set(
  "n",
  "<C-d>",
  [[<Cmd>lua vim.cmd('normal! <C-d>'); MiniAnimate.execute_after('scroll', 'normal! zvzz')<CR>]]
)

vim.keymap.set(
  "n",
  "<C-u>",
  [[<Cmd>lua vim.cmd('normal! <C-u>'); MiniAnimate.execute_after('scroll', 'normal! zvzz')<CR>]]
)
