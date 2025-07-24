local ok, pckg = pcall(require, 'spider')
if not ok then
  packer_missing('Spider')
  return
end

vim.keymap.set({ "n", "o", "x" }, "W", "<cmd>lua require('spider').motion('w')<CR>", { desc = "Spider-w" })
vim.keymap.set({ "n", "o", "x" }, "E", "<cmd>lua require('spider').motion('e')<CR>", { desc = "Spider-e" })
vim.keymap.set({ "n", "o", "x" }, "b", "<cmd>lua require('spider').motion('b')<CR>", { desc = "Spider-b" })

-- default values
pckg.setup {
  skipInsignificantPunctuation = true,
  consistentOperatorPending = false, -- see "Consistent Operator-pending Mode" in the README
  subwordMovement = true,
  customPatterns = {}, -- check "Custom Movement Patterns" in the README for details
}
