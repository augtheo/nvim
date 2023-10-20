local lualine = require "lualine"

local hide_in_width = function()
  return vim.fn.winwidth(0) > 80
end

local icons = {
  git = require("user.icons").git,
  diagnostics = require("user.icons").diagnostics,
}
local colored = true

local diagnostics = {
  "diagnostics",
  always_visible = false,
  colored = colored,
  cond = hide_in_width,
  sections = { "error", "warn" },
  sources = { "nvim_diagnostic" },
  symbols = { error = icons.diagnostics.Error .. " ", warn = icons.diagnostics.Warn .. " " },
}

local diff = {
  "diff",
  colored = colored,
  cond = hide_in_width,
  padding = { left = 1, right = 1 },
  symbols = { added = icons.git.Add .. " ", modified = icons.git.Mod .. " ", removed = icons.git.Remove .. " " },
}

local function contains(t, value)
  for _, v in pairs(t) do
    if v == value then
      return true
    end
  end
  return false
end

local language_servers = nil

local language_server = {
  function()
    local buf_ft = vim.bo.filetype
    local ui_filetypes = {
      "help",
      "packer",
      "neogitstatus",
      "NvimTree",
      "Trouble",
      "lir",
      "Outline",
      "spectre_panel",
      "toggleterm",
      "DressingSelect",
      "TelescopePrompt",
      "lspinfo",
      "lsp-installer",
      "",
    }

    if contains(ui_filetypes, buf_ft) then
      if language_servers == nil then
        return ""
      else
        return language_servers
      end
    end

    local clients = vim.lsp.buf_get_clients()
    local client_names = {}
    -- local copilot_active = false

    -- add client
    for _, client in pairs(clients) do
      if client.name ~= "null-ls" then
        table.insert(client_names, client.name)
      end
    end

    -- add formatter
    local s = require "null-ls.sources"
    local available_sources = s.get_available(buf_ft)
    local registered = {}
    for _, source in ipairs(available_sources) do
      for method in pairs(source.methods) do
        registered[method] = registered[method] or {}
        table.insert(registered[method], source.name)
      end
    end

    local formatter = registered["NULL_LS_FORMATTING"]
    local linter = registered["NULL_LS_DIAGNOSTICS"]
    if formatter ~= nil then
      vim.list_extend(client_names, formatter)
    end
    if linter ~= nil then
      vim.list_extend(client_names, linter)
    end

    -- join client names with commas
    local client_names_str = table.concat(client_names, ", ")

    -- check client_names_str if empty
    language_servers = ""
    local client_names_str_len = #client_names_str
    if client_names_str_len ~= 0 then
      language_servers = client_names_str
    end
    return language_servers:gsub(", anonymous source", "")
  end,
  padding = 1,
  cond = hide_in_width,
  separator = "%#SLSeparator#" .. " │" .. "%*",
}

local function getFileName(path)
  return path:match "^.+/(.+)$"
end

local python_env = {
  function()
    local venv = vim.env.VIRTUAL_ENV
    if venv then
      local params = getFileName(venv)
      return "(" .. params .. ")"
    else
      return ""
    end
  end,
  padding = { right = 0, left = 1 },
}

local location = {
  "location",
  padding = 1,
}

local spaces = function()
  return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
end

-- Override 'encoding': Don't display if encoding is UTF-8.
local encoding = function()
  local ret, _ = (vim.bo.fenc or vim.go.enc):gsub("^utf%-8$", "")
  return ret
end

local dap_status = function()
  local dap_ok, dap = pcall(require, "dap")
  if not dap_ok then
    return ""
  end
  return dap.status()
end

lualine.setup {
  options = {
    globalstatus = true,
    icons_enabled = true,
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
      { dap_status },
      {
        require("noice").api.status.mode.get,
        cond = require("noice").api.status.mode.has,
      },
      diagnostics,
      spaces,
      encoding,
    },
    lualine_y = {
      python_env,
      language_server,
    },
    lualine_z = {
      location,
    },
  },
  tabline = {
    lualine_a = { "buffers" },
    lualine_z = { "tabs" },
  },
  extensions = { "nvim-tree", "trouble", "toggleterm", "nvim-dap-ui", "fugitive", "quickfix" },
}
