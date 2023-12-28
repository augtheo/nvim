local single_border = {
  style = "single",
  padding = { 0, 0 },
}

require("noice").setup {
  views = {
    cmdline_popup = {
      position = {
        row = 5,
        col = "50%",
      },
      size = {
        width = 60,
        height = "auto",
      },
      border = single_border,
    },
    popupmenu = {
      border = single_border,
      position = {
        row = 8,
        col = "50%",
      },
      size = {
        width = 60,
        max_height = 10,
      },
      win_options = {
        winhighlight = "Normal:Normal,FloatBorder:NoiceCmdlinePopupBorder,CursorLine:PmenuSel,Search:None", -- NOTE: https://github.com/hrsh7th/nvim-cmp/issues/1100
      },
    },
    confirm = {
      border = single_border,
    },
    popup = {
      border = single_border,
    },
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

require("telescope").load_extension "noice"
