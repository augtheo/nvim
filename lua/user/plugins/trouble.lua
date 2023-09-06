local status_ok, Trouble = pcall(require, "trouble")
if not status_ok then
  return
end

Trouble.setup {
  padding = true,
}
