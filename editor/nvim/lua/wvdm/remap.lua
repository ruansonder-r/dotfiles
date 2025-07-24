vim.g.mapleader = " "
vim.keymap.set("n", "<leader>i", "gg=G<C-o>zz", { silent = true, noremap = true, desc = 'Lint File' })
vim.keymap.set("n", "<leader>e", vim.cmd.Ex, { desc = 'Explore' })

-- random
vim.keymap.set('n', '<leader>T', ':FetchTip<CR>', { desc = 'Tip', noremap = true, silent = true })

-- productivity
vim.keymap.set({ "n", "v" }, "<leader>t", ':!', { desc = 'terminal' })
vim.keymap.set({ "n", "v" }, "<leader>b", ':e #<cr>', { silent = true, desc = 'previous file' })

-- quit
vim.keymap.set({ "n", "v" }, "<C-q>", ':q<cr>', { desc = 'Quit' })

-- copy
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { noremap = true, silent = true, desc = 'copy text' })
vim.keymap.set("n", "<leader>Y", [[gg"+yG]], { noremap = true, silent = true, desc = 'copy file' })

-- searching
vim.keymap.set('n', '<leader>fc', 'g#<cr>', { silent = true, noremap = true, desc = 'current word' })
vim.keymap.set('n', '<leader>ff', ':%s/', { noremap = true, desc = 'search file' })
vim.keymap.set('n', '<leader>fq', ':noh<cr>', { silent = true, noremap = true, desc = 'quit highlights' })
vim.keymap.set('v', '<leader>ff', ":s/", { noremap = true, desc = 'search block' })

-- nav
vim.keymap.set('n', '<leader>w', '', { silent = true, noremap = true, desc = 'window resize' })
vim.keymap.set('n', '<leader>wj', ':resize +1<CR>', { silent = true, noremap = true, desc = 'down' })
vim.keymap.set('n', '<leader>wk', ':resize -1<CR>', { silent = true, noremap = true, desc = 'up' })
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- file
vim.keymap.set("n", "<C-s>", ":w<CR>", { silent = true })

-- Remap pane navigation to Ctrl + arrow keys
vim.keymap.set('n', '<C-h>', '<C-w>h', { noremap = true, silent = true })  -- Move left
vim.keymap.set('n', '<C-j>', '<C-w>j', { noremap = true, silent = true })  -- Move down
vim.keymap.set('n', '<C-k>', '<C-w>k', { noremap = true, silent = true })  -- Move up
vim.keymap.set('n', '<C-l>', '<C-w>l', { noremap = true, silent = true })  -- Move right
