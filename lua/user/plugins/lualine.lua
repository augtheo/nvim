local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
  return
end

local hide_in_width = function()
  return vim.fn.winwidth(0) > 80
end

local colored = true

local diagnostics = {
  "diagnostics",
  sources = { "nvim_diagnostic" },
  sections = { "error", "warn" },
  symbols = { error = " ", warn = " " },
  colored = colored,
  always_visible = true,
}

local diff = {
  "diff",
  colored = colored,
  symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
  cond = hide_in_width,
}

local filetype = {
  "filetype",
  icons_enabled = colored,
  icon_only = true,
}

local relative_filename = {
  "filename",
  path = 1,
}

local function show_macro_recording()
  local recording_register = vim.fn.reg_recording()
  if recording_register == "" then
    return ""
  else
    return "Recording @" .. recording_register
  end
end

local function get_java()
  if vim.bo.filetype == "java" and vim.g.JAVA_VERSION then
    return "[java:" .. vim.g.JAVA_VERSION .. "]"
  else
    return ""
  end
end

local function getFileName(path)
  return path:match "^.+/(.+)$"
end

local function get_venv()
  local venv = vim.env.VIRTUAL_ENV
  if venv then
    local params = getFileName(venv)
    return "(env:" .. params .. ")"
  else
    return ""
  end
end

local location = {
  "location",
  padding = 1,
}

local spaces = function()
  return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
end

local progress = function()
  local current_line = vim.fn.line "."
  local total_lines = vim.fn.line "$"
  local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
  local line_ratio = current_line / total_lines
  local index = math.ceil(line_ratio * #chars)
  local text = "%#lualine_a_inactive#" .. chars[index] .. "%*"
  text = (current_line == 1 and "Top") or text
  text = (current_line == total_lines and "Bot") or text
  return text
end

-- Override 'encoding': Don't display if encoding is UTF-8.
local encoding = function()
  local ret, _ = (vim.bo.fenc or vim.go.enc):gsub("^utf%-8$", "")
  return ret
end
-- fileformat: Don't display if &ff is unix.
fileformat = function()
  local ret, _ = vim.bo.fileformat:gsub("^unix$", "")
  return ret
end

local lualine_theme = "catppuccin"

lualine.setup {
  options = {
    globalstatus = true,
    icons_enabled = true,
    theme = lualine_theme,
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = { "alpha", "dashboard" },
    always_divide_middle = true,
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch" },
    lualine_c = { diff },
    lualine_x = {
      -- {
      --   require("noice").api.status.command.get,
      --   cond = require("noice").api.status.command.has,
      -- },
      {
        require("noice").api.status.mode.get,
        cond = require("noice").api.status.mode.has,
      },
      diagnostics, get_java, get_venv, encoding ,
    },
    lualine_y = { location },
    lualine_z = { progress },
  },
  tabline = {
    lualine_a = { "buffers" },
    lualine_z = { "tabs" },
  },
  extensions = { "nvim-tree", "trouble", "toggleterm", "nvim-dap-ui", "fugitive", "quickfix" },
  -- TODO: Remove winbar from nvimtree, dap-ui and use that instead of tabline.
  -- winbar = {
  --   lualine_b = {},
  --   lualine_c = { "buffers" },
  -- },
  -- inactive_winbar = {
  --   lualine_b = { relative_filename },
  -- },
}
