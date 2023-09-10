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

telescope.load_extension "fzf"
telescope.load_extension "undo"

-- begin define custom opts for pretty pickers
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
        { width = nil },
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
        tail,
        { pathToDisplay, "TelescopeResultsComment" },
      }
    end
    return originalEntryTable
  end,
}

local customGrepPickerOpts = {
  entry_maker = function(line)
    local originalEntryMaker = telescopeMakeEntryModule.gen_from_vimgrep {}
    local originalEntryTable = originalEntryMaker(line)

    local displayer = telescopeEntryDisplayModule.create {
      separator = " ", -- Telescope will use this separator between each entry item
      items = {
        { width = nil },
        { width = nil },
        { width = nil }, -- Maximum path size, keep it short
        { remaining = true },
      },
    }

    originalEntryTable.display = function(entry)
      local tail, pathToDisplay = getPathAndTail(entry.filename)
      local icon, iconHighlight = telescopeUtilities.get_devicons(tail)
      local coordinates = ""
      if true then
        if entry.lnum then
          if entry.col then
            coordinates = string.format("%s:%s", entry.lnum, entry.col)
          else
            coordinates = string.format("%s", entry.lnum)
          end
        end
      end

      return displayer {
        { icon, iconHighlight },
        tail,
        { coordinates, "TelescopeResultsLineNr" },
        { pathToDisplay, "TelescopeResultsComment" },
      }
    end

    return originalEntryTable
  end,
}

-- end define custom opts for pretty pickers

-- Shorten function name
local keymap = vim.keymap.set

-- quick
keymap("n", "<leader>/", function()
  require("telescope.builtin").live_grep(customGrepPickerOpts)
end, { desc = "grep" })
keymap("n", "<leader>:", "<cmd>Telescope command_history<cr>", { desc = "history" })

-- find
keymap("n", "<leader>fb", "<cmd>Telescope buffers theme=dropdown previewer=false<cr>", { desc = "Buffers" })
keymap("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find Buffers" })
keymap("n", "<leader>ff", function()
  require("telescope.builtin").find_files(customFilePickerOpts)
end, { desc = "Files" })
keymap("n", "<leader>fr", function()
  require("telescope.builtin").oldfiles(customFilePickerOpts)
end, { desc = "Recent" })
keymap(
  "n",
  "<leader>fg",
  ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>",
  { desc = "With Args" }
)

keymap("n", "<leader>fp", function()
  require("telescope.builtin").find_files(
    vim.tbl_deep_extend("force", customFilePickerOpts, { cwd = vim.fn.input "Module: " })
  )
end, { desc = "Find within project" })

-- git
keymap("n", "<leader>gc", "<cmd>Telescope git_commits<CR>", { desc = "Commits" })
keymap("n", "<leader>gb", "<cmd>Telescope git_branches<CR>", { desc = "Branches" })
keymap("n", "<leader>gs", "<cmd>Telescope git_status<CR>", { desc = "Status" })

-- search
keymap("n", '<leader>s"', "<cmd>Telescope registers<cr>", { desc = "Registers" })
keymap("n", "<leader>sa", "<cmd>Telescope autocommands<cr>", { desc = "Auto Commands" })
keymap("n", "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", { desc = "Buffer" })
keymap("n", "<leader>sc", "<cmd>Telescope commands<cr>", { desc = "Commands" })
keymap("n", "<leader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>", { desc = "Document diagnostics" })
keymap("n", "<leader>sD", "<cmd>Telescope diagnostics<cr>", { desc = "Workspace diagnostics" })
keymap("n", "<leader>sh", "<cmd>Telescope help_tags<cr>", { desc = "Help Pages" })
keymap("n", "<leader>sH", "<cmd>Telescope highlights<cr>", { desc = "Search Highlight Groups" })
keymap("n", "<leader>sk", "<cmd>Telescope keymaps<cr>", { desc = "Key Maps" })
keymap("n", "<leader>sM", "<cmd>Telescope man_pages<cr>", { desc = "Man Pages" })
keymap("n", "<leader>sm", "<cmd>Telescope marks<cr>", { desc = "Jump to Mark" })
keymap("n", "<leader>so", "<cmd>Telescope vim_options<cr>", { desc = "Options" })
keymap("n", "<leader>sR", "<cmd>Telescope resume<cr>", { desc = "Resume" })

keymap("n", "<leader>s/", function()
  require("telescope.builtin").grep_string(
    vim.tbl_deep_extend("force", customGrepPickerOpts, { search = vim.fn.input "Search: " })
  )
end, { desc = "Search Word" })

keymap("n", "<leader>sw", function()
  require("telescope.builtin").grep_string(customGrepPickerOpts)
end, { desc = "Cursor Word" })
-- lsp
keymap("n", "<leader>ss", "<cmd>Telescope lsp_document_symbols<cr>", { desc = "Document Symbols" })
keymap("n", "<leader>sS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", { desc = "Workspace Symbols" })
