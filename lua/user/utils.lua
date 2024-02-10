local function substitute(cmd)
  cmd = cmd:gsub("%%", vim.fn.expand "%")
  cmd = cmd:gsub("$fileBase", vim.fn.expand "%:r")
  cmd = cmd:gsub("$filePath", vim.fn.expand "%:p")
  cmd = cmd:gsub("$file", vim.fn.expand "%")
  cmd = cmd:gsub("$dir", vim.fn.expand "%:p:h")
  cmd = cmd:gsub(
    "$moduleName",
    vim.fn.substitute(vim.fn.substitute(vim.fn.fnamemodify(vim.fn.expand "%:r", ":~:."), "/", ".", "g"), "\\", ".", "g")
  )
  cmd = cmd:gsub("#", vim.fn.expand "#")
  cmd = cmd:gsub("$altFile", vim.fn.expand "#")

  return cmd
end

local M = {}

M.toggle = function(option, silent, values)
  if values then
    if vim.opt_local[option]:get() == values[1] then
      vim.opt_local[option] = values[2]
    else
      vim.opt_local[option] = values[1]
    end
    vim.notify("Set " .. option .. " to " .. vim.opt_local[option]:get(), vim.log.levels.INFO, { title = "Option" })
  end
  vim.opt_local[option] = not vim.opt_local[option]:get()
  if not silent then
    if vim.opt_local[option]:get() then
      vim.notify("Enabled " .. option, vim.log.levels.INFO, { title = "Option" })
    else
      vim.notify("Disabled " .. option, vim.log.levels.WARN, { title = "Option" })
    end
  end
end

M.run_code = function()
  local fileExtension = vim.fn.expand "%:e"
  local selectedCmd = ""
  local options = "bot 10 new | term "
  local supportedFiletypes = {
    c = {
      default = "gcc % -o $fileBase && $fileBase",
    },
    cpp = {
      compile_and_run_interactively = "g++ -std=c++20 -DLOCAL % -o $fileBase && $fileBase",
      compile_and_run_with_input = "g++ -std=c++20 -DLOCAL % -o $fileBase && $fileBase < input.txt | tee output.txt",
      compile_with_warning_flags = "g++ -Wall -Wextra -pedantic -std=c++20 -O2 -Wshadow -Wformat=2 -Wfloat-equal -Wconversion -Wlogical-op -Wshift-overflow=2 -Wduplicated-cond -Wcast-qual -Wcast-align -D_GLIBCXX_DEBUG -D_GLIBCXX_DEBUG_PEDANTIC -D_FORTIFY_SOURCE=2 -fsanitize=address -fsanitize=undefined -fno-sanitize-recover -fstack-protector -DLOCAL %  -o $fileBase",
      compile_with_debug_info = "g++ -g % -o $fileBase",
      diff_output_with_expected = "diff expected.txt output.txt",
    },
    py = {
      default = "python %",
      interactive = "python -i %",
    },
    go = {
      default = "go run %",
    },
    java = {
      default = "java %",
    },
    js = {
      default = "node %",
      debug = "node --inspect %",
    },
    rs = {
      default = "rustc % && $fileBase",
    },
    tex = {
      default = "pdflatex % > /dev/null 2>&1",
    },
  }

  if supportedFiletypes[fileExtension] then
    local choices = {}
    for choice, _ in pairs(supportedFiletypes[fileExtension]) do
      table.insert(choices, choice)
    end

    if #choices == 0 then
      vim.notify(
        "A run configuration doesn't exist for the current filetype",
        vim.log.levels.WARN,
        { title = "Code Runner" }
      )
    elseif #choices == 1 then
      selectedCmd = supportedFiletypes[fileExtension][choices[1]]
      vim.cmd(options .. substitute(selectedCmd))
    else
      vim.ui.select(choices, { prompt = "Choose" }, function(choice)
        selectedCmd = supportedFiletypes[fileExtension][choice]
        if selectedCmd then
          vim.cmd(options .. substitute(selectedCmd))
        end
      end)
    end
  else
    vim.notify(
      "A run configuration doesn't exist for the current filetype",
      vim.log.levels.WARN,
      { title = "Code Runner" }
    )
  end
end

local diagnostics_enabled = true
M.toggle_diagnostics = function()
  diagnostics_enabled = not diagnostics_enabled
  if diagnostics_enabled then
    vim.diagnostic.enable()
    vim.notify("Enabled diagnostics", vim.log.levels.INFO, { title = "Diagnostics" })
  else
    vim.diagnostic.disable()
    vim.notify("Disabled diagnostics", vim.log.levels.WARN, { title = "Diagnostics" })
  end
end

return M
