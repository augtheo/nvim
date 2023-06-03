-- LaTeX specific which key mappings
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
    name = "LaTex",
    c = {
      "<Cmd>!pdflatex % > /dev/null 2>&1 <CR>" , "Compile"
    },
  },
}


which_key.register(mappings, opts)
which_key.register(vmappings, vopts)
--

