local ok, pckg = pcall(require, 'treesj')
if not ok then
  packer_missing('TreeSJ')
  return
end

vim.keymap.set('n', '<leader>l', require('treesj').toggle, { desc = 'toggle list shape'})

pckg.setup({
  use_default_keymaps = false,
})
