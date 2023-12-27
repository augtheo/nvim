local telescope = require "telescope"

local actions = require "telescope.actions"
telescope.setup {
  defaults = {
    borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
    layout_strategy = "horizontal",
    layout_config = {
      horizontal = {
        preview_width = 0.55,
        results_width = 0.8,
      },
    },

    find_command = { "fd", "-t=f", "-a" },
    -- path_display = { "absolute" },
    wrap_results = true,
    prompt_prefix = "   ",
    selection_caret = " ",
    path_display = { "smart" },
    file_ignore_patterns = { ".git/", "node_modules" },

    mappings = {
      i = {
        ["<C-n>"] = actions.cycle_history_next,
        ["<C-p>"] = actions.cycle_history_prev,
      },
    },
  },
  pickers = {
    colorscheme = { enable_preview = true },
    buffers = {
      previewer = false,
      initial_mode = "normal",
      sort_mru = true,
      mappings = {
        i = {
          ["<C-d>"] = actions.delete_buffer,
        },
        n = {
          ["dd"] = actions.delete_buffer,
        },
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

local customDropDownOpts = require("telescope.themes").get_dropdown {
  borderchars = {
    preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
    prompt = { "─", "│", " ", "│", "┌", "┐", "│", "│" },
    results = { "─", "│", "─", "│", "├", "┤", "┘", "└" },
  },
}
-- end define custom opts for pretty pickers
--
local M = {}
M.find_files = function()
  require("telescope.builtin").find_files(customFilePickerOpts)
end

M.oldfiles = function()
  require("telescope.builtin").oldfiles(customFilePickerOpts)
end

M.live_grep = function()
  require("telescope.builtin").live_grep(customGrepPickerOpts)
end

M.buffers = function()
  require("telescope.builtin").buffers(customDropDownOpts)
end

M.find_in_dirs = function()
  require("telescope.builtin").find_files(
    vim.tbl_deep_extend("force", customFilePickerOpts, { cwd = vim.fn.input "Directory: " })
  )
end

M.find_files_with_word = function()
  require("telescope.builtin").find_files(
    vim.tbl_deep_extend("force", customFilePickerOpts, { search_file = vim.fn.expand "<cword>" })
  )
end

M.grep = function()
  require("telescope.builtin").grep_string(
    vim.tbl_deep_extend("force", customGrepPickerOpts, { search = vim.fn.input "Search: " })
  )
end
-- stylua: ignore start
local keymap = vim.keymap.set


-- find
keymap("n", "<leader>fb", M.buffers                                                                                                , { desc = "Buffers" } )
keymap("n", "<leader>fc", "<cmd>Telescope commands<cr>"                                                                            , { desc = "Commands" })
keymap("n", "<leader>f:", "<cmd>Telescope command_history<cr>"                                                                     , { desc = "History" })
keymap("n", "<leader>f\"", "<cmd>Telescope registers<cr>"                                                                          , { desc = "Registers" })
keymap("n", "<leader>fd", M.find_in_dirs                                                                                           , { desc = "Files in Directory" })
keymap("n", "<leader>ff", M.find_files                                                                                             , { desc = "Files" })
keymap("n", "<leader>fh", "<cmd>Telescope help_tags<cr>"                                                                           , { desc = "Help Pages" })
keymap("n", "<leader>fk", "<cmd>Telescope keymaps<cr>"                                                                             , { desc = "Key Maps" })
keymap("n", "<leader>fM", "<cmd>Telescope man_pages<cr>"                                                                           , { desc = "Man Pages" })
keymap("n", "<leader>fm", "<cmd>Telescope marks<cr>"                                                                               , { desc = "Marks" })
keymap("n", "<leader>fO", "<cmd>Telescope vim_options<cr>"                                                                         , { desc = "Options" })
keymap("n", "<leader>fo", M.oldfiles                                                                                               , { desc = "Recent" })
keymap("n", "<leader>fr", "<cmd>Telescope resume<cr>"                                                                              , { desc = "Resume" })


-- git
keymap("n", "<leader>gc", "<cmd>Telescope git_commits<CR>"                                                                         , { desc = "Commits" })
keymap("n", "<leader>gC", "<cmd>Telescope git_bcommits<CR>"                                                                        , { desc = "Commits(Buffer)" })
keymap("n", "<leader>gb", "<cmd>Telescope git_branches<CR>"                                                                        , { desc = "Branches" })
keymap("n", "<leader>gs", "<cmd>Telescope git_status<CR>"                                                                          , { desc = "Status" })

-- search
keymap("n", "<leader>sg", function() require("telescope.builtin").live_grep(customGrepPickerOpts) end                              , { desc = "Live Grep" })
keymap("n", "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>"                                                           , { desc = "Buffer" })
keymap("n", "<leader>s/", M.grep                                                                                                   , { desc = "Grep" })
keymap("n", "<leader>sw", function() require("telescope.builtin").grep_string(customGrepPickerOpts) end                            , { desc = "Cursor Word" })
keymap("n", "<leader>sf", M.find_files_with_word                                                                                   , { desc = "Cursor Files" })

-- stylua: ignore end

return M
