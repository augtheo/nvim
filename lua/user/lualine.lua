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

local function get_java()
  if vim.bo.filetype == "java" and vim.g.JAVA_VERSION then
    return "[java:" .. vim.g.JAVA_VERSION .. "]"
  else
    return ""
  end
end

function getFileName(path)
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
  return "%#lualine_a_inactive#" .. chars[index] .. "%*"
end

local lualine_theme = function()
  return os.getenv "NVIM_COLORSCHEME" or "catppuccin"
end

lualine.setup {
  options = {
    globalstatus = true,
    icons_enabled = true,
    theme = lualine_theme(),
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = { "alpha", "dashboard" },
    always_divide_middle = true,
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch" },
    lualine_c = { diff },
    lualine_x = { diagnostics, get_java, get_venv, spaces, "encoding" },
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
