local stages = require "notify.stages.fade_in_slide_out" "top_down"
local notify = require "notify"
local MAX_NOTIFICATIONS = 3

notify.setup {
  render = "minimal",
  fps = 60,
  stages = vim.list_extend({
    function(state)
      if #state.open_windows >= MAX_NOTIFICATIONS then
        return nil
      end
      local opts = stages[1](state)
      if opts then
        opts.border = "single"
      end
      return opts
    end,
  }, vim.list_slice(stages, 2, #stages)),
  timeout = 2000,
}
