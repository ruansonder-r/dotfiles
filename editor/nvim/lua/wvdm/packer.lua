-- Automatically install packer.nvim if not installed
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

-- Use a protected call to avoid errors on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Initialize packer.nvim
packer.startup(function(use)
  use 'wbthomason/packer.nvim' -- Packer can manage itself

  -- LSP
  use { 'VonHeikemen/lsp-zero.nvim', branch = 'v4.x' }
  use('hrsh7th/cmp-nvim-lsp')
  use('neovim/nvim-lspconfig')
  use('hrsh7th/nvim-cmp')
  use('williamboman/mason.nvim')

  -- Git
  use('tpope/vim-fugitive')
  use('tpope/vim-rhubarb')
  use('lewis6991/gitsigns.nvim')

  -- Nav
  use { 'nvim-telescope/telescope.nvim', tag = '0.1.8' }
  use('theprimeagen/harpoon')
  use('hedyhli/outline.nvim')
  use('nvimdev/dashboard-nvim')
  use('chrisgrieser/nvim-spider')
  use('justinmk/vim-sneak')
  use('2kabhishek/markit.nvim')

  -- Training Wheels
--  use('m4xshen/hardtime.nvim')
  use('doctorfree/cheatsheet.nvim')

  -- Utilities
  use('mbbill/undotree')
  use('windwp/nvim-autopairs')
  use('RRethy/nvim-treesitter-endwise')
  use('wakatime/vim-wakatime')
  use('numToStr/Comment.nvim')
  use('Wansmer/treesj')
  use {
    "aserowy/tmux.nvim",
    config = function() return require("tmux").setup() end
  }

  -- Flavour
  use('folke/which-key.nvim')
  use('feline-nvim/feline.nvim')
  use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
  use('nvim-treesitter/nvim-treesitter-context')
  use('folke/noice.nvim')
  use "lukas-reineke/indent-blankline.nvim"
  use { 'rcarriga/nvim-notify', tag = 'v3.14.1' } -- v3.15 breaks with telescope
  use {
    'mawkler/modicator.nvim',
    setup = function()
      vim.o.cursorline = true
      vim.o.number = true
    end
  }
  use { "catppuccin/nvim", as = "catppuccin" }

  -- Dependencies
  use('echasnovski/mini.icons')
  use('nvim-tree/nvim-web-devicons')
  use('nvim-lua/popup.nvim')
  use('nvim-lua/plenary.nvim')
  use('MunifTanjim/nui.nvim')

  -- Automatically set up your configuration after cloning packer.nvim
  if packer_bootstrap then
    require('packer').sync()
  end
end)

