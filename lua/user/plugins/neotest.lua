local neotest_ok, neotest = pcall(require, "neotest")

if not neotest_ok then
  return
end

neotest.setup {
  floating = {
    border = "single",
  },
}
