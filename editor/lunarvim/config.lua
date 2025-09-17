-- LunarVim Configuration
-- Based on previous Neovim setup with modern enhancements

-- Set LunarVim colorscheme
lvim.colorscheme = "catppuccin-mocha"

-- Leader key (default is space)
lvim.leader = "space"

-- Format on save
lvim.format_on_save.enabled = true

-- General settings
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"

-- Treesitter configuration
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "tsx",
  "css",
  "rust",
  "java",
  "yaml",
  "ruby",
  "go",
  "html",
  "markdown",
  "vim",
}

-- LSP settings
lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enable = true

-- Custom keymaps
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["<leader>w"] = ":w<cr>"
lvim.keys.normal_mode["<leader>q"] = ":q<cr>"

-- Git integration
lvim.builtin.gitsigns.active = true

-- Telescope configuration
lvim.builtin.telescope.on_config_done = function(telescope)
  pcall(telescope.load_extension, "fzf")
end

-- Additional plugins
lvim.plugins = {
  -- Catppuccin theme
  {
    "catppuccin/nvim",
    name = "catppuccin",
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        background = {
          light = "latte",
          dark = "mocha",
        },
        integrations = {
          telescope = true,
          nvimtree = true,
          gitsigns = true,
          treesitter = true,
        },
      })
    end,
  },
  
  -- Git integration
  {
    "tpope/vim-fugitive",
  },
  
  -- Enhanced f/F/t/T motions
  {
    "justinmk/vim-sneak",
    config = function()
      vim.g["sneak#label"] = 1
    end,
  },
  
  -- Auto pairs
  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup({})
    end,
  },
  
  -- Comment toggle
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  },
  
  -- Undo tree
  {
    "mbbill/undotree",
    config = function()
      vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
    end,
  },
  
  -- Harpoon for quick file navigation
  {
    "ThePrimeagen/harpoon",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local mark = require("harpoon.mark")
      local ui = require("harpoon.ui")
      
      vim.keymap.set("n", "<leader>a", mark.add_file)
      vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)
      
      vim.keymap.set("n", "<C-h>", function() ui.nav_file(1) end)
      vim.keymap.set("n", "<C-t>", function() ui.nav_file(2) end)
      vim.keymap.set("n", "<C-n>", function() ui.nav_file(3) end)
      vim.keymap.set("n", "<C-s>", function() ui.nav_file(4) end)
    end,
  },
  
  -- Better notifications
  {
    "rcarriga/nvim-notify",
    config = function()
      require("notify").setup({
        background_colour = "#000000",
      })
      vim.notify = require("notify")
    end,
  },
}

-- Auto commands
vim.api.nvim_create_autocmd("BufRead", {
  callback = function()
    vim.api.nvim_create_autocmd("BufWinEnter", {
      once = true,
      callback = function()
        local ft = vim.bo.filetype
        local last_known_line = vim.api.nvim_buf_get_mark(0, '"')[1]
        if
          not (ft:match("commit") and ft:match("rebase"))
          and last_known_line > 1
          and last_known_line <= vim.api.nvim_buf_line_count(0)
        then
          vim.api.nvim_feedkeys([[g`"]], "nx", false)
        end
      end,
    })
  end,
})

-- Set up better defaults for Ruby development
lvim.builtin.which_key.mappings["r"] = {
  name = "Ruby",
  r = { "<cmd>!bundle exec rspec %<cr>", "Run current spec file" },
  R = { "<cmd>!bundle exec rspec<cr>", "Run all specs" },
  t = { "<cmd>!bundle exec test %<cr>", "Run current test file" },
  T = { "<cmd>!bundle exec test<cr>", "Run all tests" },
}

-- VSCode compatibility (if running in VSCode)
if vim.g.vscode then
  -- VSCode extension specific settings
  lvim.plugins = {}
end
