local notify_ok, notify = pcall(require, "notify")
if not notify_ok then
  packer_missing('notify')
  return
end

vim.notify = notify.setup({
  background_colour = "FloatShadow",
  stages = "static",
  timeout = 2000
})

vim.keymap.set('n', '<leader>n', ':Telescope notify<CR>', { noremap = true, silent = true, desc = 'Notifications' })
