local fn = vim.fn
local cmd = vim.cmd

-- Automatically install packer.nvim
local install_path = fn.stdpath 'data' .. '/site/pack/packer/opt/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  cmd('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer itself
  use { 'wbthomason/packer.nvim', opt = true }

  -- colorscheme
  use({
    'folke/tokyonight.nvim',
    config = function()
      require('core.plugins.colorscheme').set_theme()
    end,
  })

  use({
    'kyazdani42/nvim-web-devicons',
    after = 'tokyonight.nvim',
  })

  -- Fuzzy finding
  use {
    'nvim-telescope/telescope.nvim',
    config = function()
      require 'core.plugins.telescope'
    end,
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-lua/popup.nvim',

      -- FZF sorter for Telescope
      { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
    },
  }

  use({
    'williamboman/nvim-lsp-installer',
    requires = {
      'neovim/nvim-lspconfig',
      'ray-x/lsp_signature.nvim',
    },
    config = function()
      require 'core.plugins.lsp'
      -- require('config.plugins.lsp')
    end,
  })

  use({
    'hrsh7th/nvim-cmp',
    config = function()
      require 'core.plugins.cmp'
    end,
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/nvim-cmp',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'windwp/nvim-autopairs',
      'onsails/lspkind-nvim',
    },
  })

  use({
    'nvim-treesitter/nvim-treesitter',
    requires = {
      'windwp/nvim-ts-autotag',
      'nvim-treesitter/nvim-treesitter-refactor',
    },
    run = ':TSUpdate',
    config = function()
      require 'core.plugins.treesitter'
    end,
  })

  use({
    'vim-test/vim-test',
    requires = {
      'tpope/vim-dispatch',
    },
  })

  use({
    'tpope/vim-fugitive',
    opt = true,
    cmd = 'Git',
  })

  use ({
    'nvim-lualine/lualine.nvim',
    config = function()
      require 'core.plugins.lualine'
    end,
  })

end)