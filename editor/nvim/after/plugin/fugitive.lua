if not check_vimscript("vim-fugitive") then
  return
end
if not check_vimscript("vim-rhubarb") then
  return
end

vim.keymap.set("n", "<leader>g", '', { desc = 'git' })
vim.keymap.set("n", "<leader>gs", ':Git status<CR>', { desc = 'status' });
vim.keymap.set("n", "<leader>gb", ':Git blame<cr>', { desc = 'blame' })
vim.keymap.set("n", "<leader>gd", ':Git diff<cr>', { desc = 'diff' })
vim.keymap.set("n", "<leader>gl", ':Git log<cr>', { desc = 'log' })
vim.keymap.set("n", "<leader>gb", ':GBrowse<cr>', { desc = 'browse' })
