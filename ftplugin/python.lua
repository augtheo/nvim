-- python specific which key mappings
local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end
--
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
    name = "python 🐍",
    c = {
      "<Cmd>!python % <CR>",
      "Exec",
    },
  },
}

local home = os.getenv "HOME"

require("dap-python").setup(home .. "/.local/share/nvim/mason/packages/debugpy/venv/bin/python")

which_key.register(mappings, opts)
which_key.register(vmappings, vopts)
--
