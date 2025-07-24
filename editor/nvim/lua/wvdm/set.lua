-- Line Numbers
vim.opt.nu = true
vim.opt.relativenumber = true
vim.cmd([[autocmd FileType netrw setlocal number]])
vim.cmd([[autocmd FileType netrw setlocal relativenumber]])

-- text/whitespace formatting
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true              -- replace tab with spaces
vim.opt.shiftwidth = 2                -- indents with >> or <
vim.opt.smartindent = true            -- indents on whitespace + syntax
vim.opt.wrap = false
vim.opt.list = true                   -- Enable displaying listchars.
vim.opt.listchars = "tab:>-,trail:x"
vim.opt.shiftround = false            -- moving tabs goes to round spaces

-- tree sitter folds
vim.opt.foldmethod = "expr"           -- Use an expression to define folds.
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()" -- Use Tree-sitter's folding expression.
vim.opt.foldenable = false            -- Start with all folds open.

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- Status bar
vim.opt.laststatus = 3

-- vim.opt.hlsearch = false
vim.opt.incsearch = true              -- Show results as you type

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"

vim.opt.updatetime = 50

-- vim.opt.colorcolumn = "120"

