require("mini.files").setup()
local minifiles_toggle = function(...)
  if not MiniFiles.close() then
    MiniFiles.open(...)
  end
end

vim.keymap.set("n", "<leader>ee", minifiles_toggle, { desc = "Open in current working directory" })

vim.keymap.set("n", "<leader>ef", function()
  local path = vim.bo.buftype ~= "nofile" and vim.api.nvim_buf_get_name(0) or nil
  minifiles_toggle(path)
end, { desc = "Open in directory of current file" })

local map_split = function(buf_id, lhs, direction)
  local rhs = function()
    -- Make new window and set it as target
    local new_target_window
    vim.api.nvim_win_call(MiniFiles.get_target_window(), function()
      vim.cmd(direction .. " split")
      new_target_window = vim.api.nvim_get_current_win()
    end)

    -- vim.defer_fn(function()
    MiniFiles.set_target_window(new_target_window)
    MiniFiles.go_in()
    MiniFiles.close()
    -- end, 30)

    -- MiniFiles.set_target_window(new_target_window)
  end

  -- Adding `desc` will result into `show_help` entries
  local desc = "Split " .. direction
  vim.keymap.set("n", lhs, rhs, { buffer = buf_id, desc = desc })
end

local run_system = function()
  local path = MiniFiles.get_fs_entry().path
  vim.fn.jobstart({ "xdg-open", path }, { detach = true })
end

vim.api.nvim_create_autocmd("User", {
  pattern = "MiniFilesBufferCreate",
  callback = function(args)
    local buf_id = args.data.buf_id
    -- Tweak keys to your liking
    map_split(buf_id, "<C-s>", "belowright horizontal")
    map_split(buf_id, "<C-v>", "belowright vertical")
    vim.keymap.set("n", "<C-o>", run_system , {buffer = buf_id , desc = "Open with System Viewer"})
  end,
})
