require("noice").setup {
  views = {
    cmdline_popup = {
      border = {
        style = "none",
        padding = { 1, 1 },
      },
      filter_options = {},
      win_options = {
        winhighlight = {
          Normal = "NormalFloat",
          FloatBorder = "NormalFloatBorder",
        },
      },
    },
    -- popup = {
    --   border = {
    --     style = "single",
    --   },
    -- },
  },
  lsp = {
    signature = { enabled = true },
    hover = { enabled = true },
    documentation = {
      opts = {
        border = { style = "single" },
        relative = "cursor",
        position = {
          row = 2,
        },
        win_options = {
          concealcursor = "n",
          conceallevel = 3,
          winhighlight = {
            Normal = "Normal",
            FloatBorder = "FloatBorder",
          },
        },
      },
    },
    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true,
    },
  },
  -- you can enable a preset for easier configuration
  presets = {
    bottom_search = true, -- use a classic bottom cmdline for search
    command_palette = false, -- position the cmdline and popupmenu together
    long_message_to_split = true, -- long messages will be sent to a split
    inc_rename = false, -- enables an input dialog for inc-rename.nvim
    lsp_doc_border = false, -- add a border to hover docs and signature help
  },
  routes = {
    {
      filter = {
        event = "msg_show",
        kind = "",
        find = "written",
      },
      opts = { skip = true },
    },
  },
}

local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

telescope.load_extension "noice"
