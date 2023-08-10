local status_ok, Trouble = pcall(require, "trouble")
if not status_ok then
  return
end

-- jump to the next item, skipping the groups
function _TROUBLE_NEXT()
  Trouble.next { skip_groups = true, jump = true }
end

-- jump to the previous item, skipping the groups
function _TROUBLE_PREVIOUS()
  Trouble.previous { skip_groups = true, jump = true }
end

Trouble.setup {
  padding = true,
}
-- -- jump to the first item, skipping the groups
-- require("trouble").first({skip_groups = true, jump = true});
--
-- -- jump to the last item, skipping the groups
-- require("trouble").last({skip_groups = true, jump = true});
