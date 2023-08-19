local stages = require "notify.stages.slide" "top_down"
local notify = require "notify"

notify.setup {
  render = "minimal",
  stages = {
    function(...)
      local opts = stages[1](...)
      if opts then
        opts.border = "single"
      end
      return opts
    end,
    unpack(stages, 2),
  },
  timeout = 2000,
}
