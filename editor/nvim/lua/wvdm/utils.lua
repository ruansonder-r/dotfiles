-- Custom notification functions to highlight missing plugins
function _G.packer_missing(package_name)
  -- Error message
  local message = package_name .. " plugin not found!"

  -- Check if 'notify' is available and use it
  local notify_available, notify = pcall(require, "notify")
  if notify_available then
    -- If notify is available, use it to show the message
    notify(message, "error", { title = "Packer Plugin Missing" })
  else
    -- If notify is not available, fall back to print.
    vim.notify(message)
  end
end

local notify_ok, notify = pcall(require, "notify")
if not notify_ok then
  packer_missing('notify')
  return
end

function _G.check_vimscript(plugin_name)
  local plugin_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/" .. plugin_name

  if vim.fn.isdirectory(plugin_path) == 0 then
    packer_missing(plugin_name)
    return false
  end

  return true
end

local job_ok, Job = pcall(require, "plenary.job")
if not job_ok then
  packer_missing('plenary')
  return
end

-- Function to fetch and display a tip asynchronously
local function fetch_tip()
  Job:new({
    command = "curl",
    args = { "-s", "-m", "3", "https://vtip.43z.one" },
    on_exit = function(job, return_val)
      if return_val == 0 then
        local result = table.concat(job:result(), "\n")
        -- Trim any whitespace
        result = result:gsub("^%s*(.-)%s*$", "%1")
        -- Display the result using notify
        notify(result, "info", { timeout = 4999, stages = "minimal", title = "Tip of the Day" })
      else
        notify("Failed to fetch tip.", "error", { title = "Error" })
      end
    end,
  }):start()
end

vim.api.nvim_create_user_command("FetchTip", fetch_tip, {})
