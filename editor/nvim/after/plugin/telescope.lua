local name = "telescope.builtin"
local ok, builtin = pcall(require, name)
if not ok then
  packer_missing(name)
  return
end

vim.keymap.set('n', '<leader>f', '', { desc = 'find...' })
vim.keymap.set('n', '<leader>fp', builtin.find_files, { desc = 'files'})
vim.keymap.set('n', '<leader>fa', function()
  builtin.find_files({ hidden = true })
end, { desc = 'hidden files' })
vim.keymap.set('n', '<leader>fg', builtin.git_files, { desc = 'git files' })
vim.keymap.set('n', '<leader>fs', function()
  builtin.grep_string({ search = vim.fn.input("Grep > ") });
end, { desc = 'search string' })

