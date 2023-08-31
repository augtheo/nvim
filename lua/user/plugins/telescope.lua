local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

local actions = require "telescope.actions"
telescope.setup {
  border = false,
  defaults = {
    layout_strategy = "horizontal",
    layout_config = {
      horizontal = {
        preview_width = 0.55,
        results_width = 0.8,
      },
    },

    find_command = { "fd", "-t=f", "-a" },
    path_display = { "absolute" },
    wrap_results = true,
    prompt_prefix = "   ",
    selection_caret = "  ",
    -- path_display = { "smart" },
    file_ignore_patterns = { ".git/", "node_modules" },

    mappings = {
      i = {
        ["<C-n>"] = actions.cycle_history_next,
        ["<C-p>"] = actions.cycle_history_prev,
      },
    },
  },
}

telescope.load_extension "undo"

-- begin define custom opts for pretty file picker
local telescopeUtilities = require "telescope.utils"
local telescopeMakeEntryModule = require "telescope.make_entry"
local plenaryStrings = require "plenary.strings"
local devIcons = require "nvim-web-devicons"
local telescopeEntryDisplayModule = require "telescope.pickers.entry_display"
local fileTypeIconWidth = plenaryStrings.strdisplaywidth(devIcons.get_icon("fname", { default = true }))

local function getPathAndTail(fileName)
  local bufferNameTail = telescopeUtilities.path_tail(fileName)
  local pathWithoutTail = require("plenary.strings").truncate(fileName, #fileName - #bufferNameTail, "")
  local pathToDisplay = telescopeUtilities.transform_path({
    path_display = { "truncate" },
  }, pathWithoutTail)
  return bufferNameTail, pathToDisplay
end

local customFilePickerOpts = {
  entry_maker = function(line)
    local originalEntryMaker = telescopeMakeEntryModule.gen_from_file {}
    local originalEntryTable = originalEntryMaker(line)

    local displayer = telescopeEntryDisplayModule.create {
      separator = " ",
      items = {
        { width = fileTypeIconWidth },
        { width = nil },
        { remaining = true },
      },
    }

    originalEntryTable.display = function(entry)
      local tail, pathToDisplay = getPathAndTail(entry.value)
      local tailForDisplay = tail .. " "
      local icon, iconHighlight = telescopeUtilities.get_devicons(tail)
      return displayer {
        { icon, iconHighlight },
        tailForDisplay,
        { pathToDisplay, "TelescopeResultsComment" },
      }
    end
    return originalEntryTable
  end,
}
-- end define custom opts for pretty file picker

-- Shorten function name
local keymap = vim.keymap.set

-- quick
-- keymap("n", "<leader>b", "<cmd>Telescope buffers theme=dropdown previewer=false<cr>", { desc = "Switch Buffer" })
-- keymap("n", "<leader>f", "<cmd>Telescope find_files theme=dropdown previewer=false<cr>", { desc = "Find Files" })
keymap("n", "<leader>/", "<cmd>Telescope live_grep<cr>", { desc = "Grep" })
keymap("n", "<leader>:", "<cmd>Telescope command_history<cr>", { desc = "Command History" })
keymap("n", "<leader>P", "<cmd>Telescope projects<cr>", { desc = "Projects" })

-- find
keymap("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find Buffers" })
keymap("n", "<leader>ff", function()
  require("telescope.builtin").find_files(customFilePickerOpts)
end, { desc = "Find Files" })
keymap("n", "<leader>fr", function()
  require("telescope.builtin").oldfiles(customFilePickerOpts)
end, { desc = "Find Recent" })
-- keymap("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Recent" })

-- git
keymap("n", "<leader>gc", "<cmd>Telescope git_commits<CR>", { desc = "Commits" })
keymap("n", "<leader>gb", "<cmd>Telescope git_branches<CR>", { desc = "Branches" })
keymap("n", "<leader>gs", "<cmd>Telescope git_status<CR>", { desc = "Status" })

-- search
keymap("n", '<leader>s"', "<cmd>Telescope registers<cr>", { desc = "Registers" })
keymap("n", "<leader>sa", "<cmd>Telescope autocommands<cr>", { desc = "Auto Commands" })
keymap("n", "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", { desc = "Buffer" })
keymap("n", "<leader>sc", "<cmd>Telescope command_history<cr>", { desc = "Command History" })
keymap("n", "<leader>sC", "<cmd>Telescope commands<cr>", { desc = "Commands" })
keymap("n", "<leader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>", { desc = "Document diagnostics" })
keymap("n", "<leader>sD", "<cmd>Telescope diagnostics<cr>", { desc = "Workspace diagnostics" })
keymap("n", "<leader>sh", "<cmd>Telescope help_tags<cr>", { desc = "Help Pages" })
keymap("n", "<leader>sH", "<cmd>Telescope highlights<cr>", { desc = "Search Highlight Groups" })
keymap("n", "<leader>sk", "<cmd>Telescope keymaps<cr>", { desc = "Key Maps" })
keymap("n", "<leader>sM", "<cmd>Telescope man_pages<cr>", { desc = "Man Pages" })
keymap("n", "<leader>sm", "<cmd>Telescope marks<cr>", { desc = "Jump to Mark" })
keymap("n", "<leader>so", "<cmd>Telescope vim_options<cr>", { desc = "Options" })
keymap("n", "<leader>sR", "<cmd>Telescope resume<cr>", { desc = "Resume" })
keymap("n", "<leader>sw", "<cmd>Telescope grep_string<cr>", { desc = "Word" })

-- lsp
keymap("n", "<leader>ss", "<cmd>Telescope lsp_document_symbols<cr>", { desc = "Document Symbols" })
keymap("n", "<leader>sS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", { desc = "Workspace Symbols" })
