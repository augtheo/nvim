local icons = {
  git = require("user.icons").git,
  diagnostics = require("user.icons").diagnostics,
}

local function on_attach(bufnr)
  local api = require "nvim-tree.api"

  api.events.subscribe(api.events.Event.TreeOpen, function()
    vim.cmd "hi! link NormalNC Normal"
  end)

  api.events.subscribe(api.events.Event.TreeClose, function()
    vim.cmd "hi! link NormalNC NvimTreeNormal"
  end)

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  api.config.mappings.default_on_attach(bufnr)

  -- Mappings migrated from view.mappings.list
  --
  -- You will need to insert "your code goes here" for any mappings with a custom action_cb
  vim.keymap.set("n", "l", api.node.open.edit, opts "Open")
  vim.keymap.set("n", "<CR>", api.node.open.edit, opts "Open")
  vim.keymap.set("n", "o", api.node.open.edit, opts "Open")
  vim.keymap.set("n", "h", api.node.navigate.parent_close, opts "Close Directory")
  vim.keymap.set("n", "v", api.node.open.vertical, opts "Open: Vertical Split")
end

require("nvim-tree").setup {
  actions = { open_file = { quit_on_open = true } },
  on_attach = on_attach,
  hijack_cursor = true,
  hijack_unnamed_buffer_when_opening = true,
  update_focused_file = {
    enable = true,
    update_cwd = true,
  },
  renderer = {
    group_empty = true,
    root_folder_modifier = ":t",
    icons = {
      git_placement = "after",
      diagnostics_placement = "after",
      glyphs = {
        git = {
          unstaged = icons.git.Unstage,
          staged = icons.git.Stage,
          unmerged = icons.git.Unmerge,
          renamed = icons.git.Rename,
          untracked = icons.git.Untrack,
          deleted = icons.git.Remove,
          ignored = icons.git.Ignore,
        },
      },
    },
    indent_markers = {
      enable = false,
    },
  },
  diagnostics = {
    enable = true,
    show_on_dirs = true,
    icons = {
      hint = icons.diagnostics.Hint,
      info = icons.diagnostics.Info,
      warning = icons.diagnostics.Warn,
      error = icons.diagnostics.Error,
    },
  },
  view = {
    width = 40,
    side = "left",
  },
}

_GROUP_BY_TOGGLE_STATE = true
function _NVIM_TREE_TOGGLE_GROUP_BY()
  _GROUP_BY_TOGGLE_STATE = not _GROUP_BY_TOGGLE_STATE
  require("nvim-tree").setup { renderer = { group_empty = _GROUP_BY_TOGGLE_STATE } }
end

local function close_nvim_ide_panels()
  if pcall(require, "ide") then
    local ws = require("ide.workspaces.workspace_registry").get_workspace(vim.api.nvim_get_current_tabpage())
    if ws ~= nil then
      ws.close_panel(require("ide.panels.panel").PANEL_POS_LEFT)
    end
  end
end

local nvim_tree_toggle = function()
  require("dapui").close()
  close_nvim_ide_panels()
  require("nvim-tree.api").tree.toggle()
end

-- vim.keymap.set("n", "<leader>e", nvim_tree_toggle, { desc = "explorer" })
-- vim.cmd "command! NvimTreeToggleGroupEmpty lua _NVIM_TREE_TOGGLE_GROUP_BY()"
