return {
  dap = {
    BreakpointCondition = { " ", "DiagnosticError" },
    Breakpoint = { " ", "DiagnosticError" },
    BreakpointRejected = { " ", "DiagnosticError" },
    LogPoint = { "✪ ", "DiagnosticError" },
    Stopped = { " ", "DiagnosticWarn", "DapStoppedLine" },
  },
  git = {
    Add = " ",
    Branch = " ",
    Conflict = " ",
    Diff = " ",
    Git = "󰊢 ",
    Ignore = " ",
    Mod = " ",
    Octoface = " ",
    Remove = " ",
    Rename = " ",
    Repo = " ",
    Stage = " ",
    Unmerge = " ",
    Unstage = " ",
    Untrack = "󰞋 ",
  },

  diagnostics = {
    Error = " ",
    Hint = "󰌵",
    Info = " ",
    Warn = " ",
  },
  ui = {
    Search = " ",
    Recent = " ",
  },
}
