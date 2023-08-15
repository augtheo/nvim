local status_ok, indent_blankline = pcall(require, "indent_blankline")
if not status_ok then
  return
end

indent_blankline.setup {
  char = "▏",
  context_char = "▏",
  show_trailing_blankline_indent = false,
  use_treesitter = true,
  show_current_context = true,
}
