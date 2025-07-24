local name = "harpoon"
local ok, _ = pcall(require, name)
if not ok then
  packer_missing(name)
  return
end

local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>h", '', { desc = 'harpoon' })
vim.keymap.set("n", "<leader>hh", mark.add_file, { desc = 'add' })
vim.keymap.set("n", "<leader>hl", ui.toggle_quick_menu, { desc = 'list' })

vim.keymap.set("n", "<leader>ha", function() ui.nav_file(1) end, { desc = '1' })
vim.keymap.set("n", "<leader>hs", function() ui.nav_file(2) end, { desc = '2' })
vim.keymap.set("n", "<leader>hd", function() ui.nav_file(3) end, { desc = '3' })
vim.keymap.set("n", "<leader>hf", function() ui.nav_file(4) end, { desc = '4' })

